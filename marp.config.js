const { Marp } = require('@marp-team/marp-core')

module.exports = {
    engine: opts => {
      const marp = new Marp(opts)
      marp.markdown.use(require('markdown-it-plantuml'), {
        openMarker: '```plantuml',
        closeMarker: '```',
          // Wrap in <p> for better rendering in some built-in themes
          render: (...args) =>
            `<p>${marp.markdown.renderer.rules.image(...args)}</p>`,
      })
      return marp
    }
}
