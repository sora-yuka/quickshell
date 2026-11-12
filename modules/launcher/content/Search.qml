pragma Singleton
import QtQuick
import Quickshell

Singleton {
    property string terminal: "ghostty"
    property string searchUrl: "https://google.com/search?q="
    property int maxApps: 5

    function fuzzy(q, s) {
        s = s.toLowerCase()
        let qi = 0, score = 0, last = -1
        for (let i = 0; i < s.length && qi < q.length; i++) {
            if (s[i] == q[qi]) {
                score += (last  === i - 1) ? 5 : 1
                if (i === 0) score += 5
                last = i
                qi++
            }
        }
        return qi === q.length ? score : -1
    }

    function build(text) {
        const q = text.toLowerCase().trim()
        if (q === "") return []

        const apps = DesktopEntries.applications.values
            .filter(e => !e.noDisplay)
            .map(e => ({ e: e, score: fuzzy(q, e.name) }))
            .filter(x => x.score >= 0)
            .sort((a, b) => b.score - a.score)
            .slice(0, maxApps)
            .map(x => ({ kind: "app", label: x.e.name, icon: x.e.icon, entry: x.e }))

        return apps.concat([
            { kind: "web", label: "Search web for: " + text.trim(), icon: "" },
            { kind: "term", label: "Execute in terminal: " + text.trim(), icon: "" }
        ])
    }

    function run(item, text) {
        if (!item) return
        const t = text.trim()
        if (item.kind === "app")
            item.entry.execute()
        else if (item.kind === "web")
            Quickshell.execDetached(["xdg-open", searchUrl + encodeURIComponent(t)])
        else if (item.kind === "terminal")
            Quickshell.execDetached([terminal, "-e", "sh", "-c", t])
    }
}
