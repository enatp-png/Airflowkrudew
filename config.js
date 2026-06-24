// config.js
// 1) Supabase > Project Settings > API
// 2) ใส่ Project URL และ anon public key
// 3) ห้ามใช้ service_role key ในหน้าเว็บ
window.APP_CONFIG = {
  SUPABASE_URL: "https://YOUR-PROJECT.supabase.co",
  SUPABASE_ANON_KEY: "YOUR-ANON-PUBLIC-KEY",
  STORAGE_BUCKET: "airflow-images",
  TEACHER_PIN: "1234"
};
