# Air Flow Mission Modern

เว็บแอปวาดเส้นการเคลื่อนที่ของอากาศ 5 ด่าน  
ใช้ GitHub Pages + Supabase

## ไฟล์
- `index.html` หน้าใช้งานนักเรียน
- `admin.html` หน้าครู
- `config.js` ตั้งค่า Supabase
- `supabase.sql` สร้างฐานข้อมูล / Storage / Policy

## วิธีติดตั้ง
1. เข้า Supabase > SQL Editor
2. วางโค้ดจาก `supabase.sql` แล้ว Run
3. อัปโหลด `index.html`, `admin.html`, `config.js` ขึ้น GitHub
4. เปิด GitHub Pages
5. ครูเข้า `admin.html`
6. เพิ่มกลุ่ม / เพิ่มรายชื่อนักเรียน
7. นักเรียนเข้า `index.html` เลือกกลุ่ม แล้วระบบจะแสดงรายชื่อในกลุ่มนั้น

## หน้า Admin
รหัสเริ่มต้น: `1234`  
แก้ได้ในไฟล์ `config.js`

## หมายเหตุ
- ชื่อไฟล์ภาพใน Supabase Storage ใช้ภาษาอังกฤษ/ตัวเลข เพื่อเลี่ยง Invalid key
- ระบบปลดล็อกด่านถัดไปหลังส่งงานสำเร็จ
- ด่าน 5 นักเรียนสามารถอัปโหลดแผนที่อากาศจริงแล้ววาดเส้นทับได้
