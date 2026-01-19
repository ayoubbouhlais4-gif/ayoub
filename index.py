import asyncio  # استخدم asyncio وليس _asyncio

async def task(n):
    print(f"start{n}")
    await asyncio.sleep(3)  # توقف لمدة 3 ثواني بشكل غير متزامن
    print(f"end {n}")

async def main():
    # تشغيل المهام في نفس الوقت
    await asyncio.gather(task(1), task(2))

# تشغيل الـ Event Loop
asyncio.run(main())
