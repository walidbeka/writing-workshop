# حماية لوحة الأسعار — Supabase

لا تستخدم كلمة مرور ثابتة في JavaScript.

1. أنشئ مشروع Supabase.
2. فعّل Authentication > Email.
3. أنشئ جدول `prices`:
   - `id` bigint primary key
   - `course` text unique
   - `price` numeric
   - `old_price` numeric
4. أنشئ جدول `admins`:
   - `user_id` uuid primary key references auth.users(id)
5. فعّل RLS.
6. اسمح SELECT على prices للمستخدمين المسجلين.
7. اسمح UPDATE فقط عندما `auth.uid()` موجود في admins.
8. اربط admin.js بمكتبة Supabase JS وبـ Supabase URL + anon key.
9. لا تضع service_role key في الموقع.
10. اجعل بريدك أنت فقط موجودًا في admins.

ملاحظة: إذا أردت تغيير الأسعار من لوحة الإدارة، صفحات الأسعار العامة يجب أن تقرأها من endpoint عام/جدول prices، بينما التعديل محمي بـ RLS.
