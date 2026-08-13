(function () {
  const URL = window.SUPABASE_URL;
  const KEY = window.SUPABASE_PUBLISHABLE_KEY;
  if (!URL || !KEY) return;

  async function loadWorkshopPrices() {
    try {
      const res = await fetch(
        URL + '/rest/v1/workshop_prices?select=course_key,current_price,old_price',
        {
          headers: {
            apikey: KEY,
            Authorization: 'Bearer ' + KEY
          },
          cache: 'no-store'
        }
      );
      if (!res.ok) return;
      const rows = await res.json();

      rows.forEach(function (row) {
        const key = row.course_key;
        const current = Number(row.current_price).toLocaleString('ar-EG');
        const old = Number(row.old_price).toLocaleString('ar-EG');

        document.querySelectorAll('[data-current-price="' + key + '"]').forEach(function (el) {
          el.textContent = current;
        });
        document.querySelectorAll('[data-old-price="' + key + '"]').forEach(function (el) {
          el.textContent = old + ' جنيه';
        });
      });
    } catch (_) {
      // Keep the built-in fallback prices when Supabase is unavailable.
    }
  }

  loadWorkshopPrices();
})();
