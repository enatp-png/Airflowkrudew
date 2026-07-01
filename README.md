# Air Flow Mission Web App - Fixed

แก้ไขแล้ว:
- เอาข้อความที่เฉลยทิศทางออกจากด่าน 1 ให้นักเรียนคิดเองมากขึ้น
- แก้ชื่อไฟล์ Supabase Storage ให้เป็นอังกฤษ/ตัวเลข ป้องกัน Invalid key
- เพิ่ม GRANT permission ใน supabase.sql แก้ปัญหา permission denied for table submissions

วิธีอัปเดต:
1. อัปโหลดไฟล์ index.html, admin.html, config.js ทับของเดิมใน GitHub
2. เปิด Supabase > SQL Editor
3. รันไฟล์ supabase.sql ใหม่ 1 รอบ
4. กลับไปทดสอบส่งงานอีกครั้ง
