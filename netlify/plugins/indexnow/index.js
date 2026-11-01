/**
 * Plugin de build de Netlify: avisa a IndexNow (Bing, Yandex, Seznam…)
 * en cada deploy de producción exitoso.
 *
 * Google NO usa IndexNow: para Google va Search Console (ver PENDIENTES-SEO.md).
 */
const HOST = "cachyos-chile.netlify.app";
const SITE = `https://${HOST}`;
const KEY = "4ac291d7c370106abaa06b0edf277790";

const URLS = [
  `${SITE}/`,
  `${SITE}/guias/`,
  `${SITE}/como-instalar-cachyos/`,
  `${SITE}/linux-vs-windows/`,
  `${SITE}/revivir-pc-viejo-con-linux/`,
  `${SITE}/sitemap.xml`,
];

module.exports = {
  onSuccess: async ({ constants, utils }) => {
    // Solo en producción (no en deploy previews / branch deploys).
    // En Netlify Constants.CONTEXT vale "production"; en builds locales
    // puede venir undefined, y ahí también avisamos.
    const ctx = constants && constants.CONTEXT;
    if (ctx && ctx !== "production") {
      console.log(`IndexNow: contexto "${ctx}", no se avisa.`);
      return;
    }
    try {
      const res = await fetch("https://api.indexnow.org/indexnow", {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify({
          host: HOST,
          key: KEY,
          keyLocation: `${SITE}/${KEY}.txt`,
          urlList: URLS,
        }),
      });
      console.log(`IndexNow: aviso enviado (HTTP ${res.status}) — ${URLS.length} URLs`);
    } catch (e) {
      // No romper el deploy si falla el aviso.
      console.log(`IndexNow: no se pudo avisar — ${e.message}`);
    }
  },
};
