# Air Flow Mission Web App

เว็บแอปฝึกวาดเส้นการเคลื่อนที่ของอากาศ 5 ด่าน พร้อม Supabase

## ไฟล์
- `index.html` หน้าใช้งานของนักเรียน
- `admin.html` หน้าครูสำหรับดูผลงาน ให้คะแนน ลบ และส่งออก CSV
- `config.js` ใส่ Supabase URL / anon key / รหัสครู
- `supabase.sql` รันสร้างฐานข้อมูลและ Storage

## วิธีติดตั้ง
1. สร้าง Project ใน Supabase
2. เปิด SQL Editor
3. วางโค้ดใน `supabase.sql` แล้ว Run
4. ไปที่ Project Settings > API
5. คัดลอก Project URL และ anon public key
6. เปิด `config.js` แล้วใส่ค่าแทนที่
7. อัปโหลดไฟล์ทั้งหมดขึ้น GitHub Repository
8. เปิด GitHub Pages

## หน้าใช้งาน
- นักเรียน: `index.html`
- ครู: `admin.html`

## หมายเหตุ
ชุดนี้ตั้งค่า RLS แบบใช้งานง่ายสำหรับห้องเรียนและ GitHub Pages หากใช้กับข้อมูลจริงที่อ่อนไหว ควรเพิ่มระบบ Login/Auth ภายหลัง


## แก้ไขล่าสุด
- แก้ปัญหา Supabase Storage `Invalid key` โดยเปลี่ยนชื่อไฟล์ภาพที่อัปโหลดให้เป็นอังกฤษ/ตัวเลขเท่านั้น
- ชื่อ-สกุลนักเรียนภาษาไทยยังบันทึกในตาราง `submissions` ได้ตามปกติ แต่ไม่นำไปใช้เป็นชื่อไฟล์ภาพใน Storage
