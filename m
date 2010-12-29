Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Dec 2010 00:18:51 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:60431 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491043Ab0L2XSs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Dec 2010 00:18:48 +0100
Received: by iwn38 with SMTP id 38so11504876iwn.36
        for <multiple recipients>; Wed, 29 Dec 2010 15:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=1xYB5RXh9rvrPZtoSQUg0gtGxovUPfmDBoehdNW2db8=;
        b=FnYd/XQpICm7soLZeUDCL3gpx8hbfnGl7zD4FSKtSpEJ4Qui/Vwbdx5rsDQtZrIHRA
         GwHhRDU3BmUmIT2HgHo94LQYKu8VkI53k24utG2Hv4hkC8BBfNjGVHPnl3Vf/4m+2Iam
         ldpf0FfjMQDzTNtmqC7O+RuXObtZi5z04ETIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gOoEdpRIt5dv5kx1A2fh1mgkj7U2/UoYVad6JbZZPQm2/WVVQVSsuzMg49/xQi0PgV
         lM9L3VazlvHbAhBpkXodEeKJqIaeIuN93ApFqHFryaEk8AO1pNEryYBAWMfhZIuJqZ3d
         5Zhj3ykvIVXuVXCsJL6oOduFzXX8f8d6nuAAo=
MIME-Version: 1.0
Received: by 10.231.174.71 with SMTP id s7mr15305065ibz.56.1293664726801; Wed,
 29 Dec 2010 15:18:46 -0800 (PST)
Received: by 10.231.161.84 with HTTP; Wed, 29 Dec 2010 15:18:46 -0800 (PST)
In-Reply-To: <4D1B9D03.1090109@mvista.com>
References: <AANLkTi=_2aqFiB4Qgez8f-tiiqv19+VHDzX2TJ7jZ2Ha@mail.gmail.com>
        <4D1B9D03.1090109@mvista.com>
Date:   Wed, 29 Dec 2010 15:18:46 -0800
Message-ID: <AANLkTim9qyTM17KAQrvdsUz+N63mrYPqPd-XjjibjnwM@mail.gmail.com>
Subject: [PATCH RESEND] MIPS: Add local_flush_tlb_all_mm to clear all mm
 contexts on calling cpu
From:   Maksim Rayskiy <maksim.rayskiy@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <maksim.rayskiy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksim.rayskiy@gmail.com
Precedence: bulk
X-list: linux-mips

When hotplug removing a cpu, all mm context TLB entries must be cleared
to avoid ASID conflict when cpu is restarted.
New functions local_flush_tlb_all_mm() and all-cpu version
flush_tlb_all_mm() are added.
To function properly, local_flush_tlb_all_mm() must be called when
mm_cpumask for all
mm context on given cpu is cleared.

Signed-off-by: Maksim Rayskiy <maksim.rayskiy@gmail.com>
---
 arch/mips/include/asm/tlbflush.h |    4 ++++
 arch/mips/kernel/smp.c           |   10 ++++++++++
 arch/mips/mm/tlb-r4k.c           |   13 +++++++++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/tlbflush.h b/arch/mips/include/asm/tlbflush.h
index 86b21de..d7b75e6 100644
--- a/arch/mips/include/asm/tlbflush.h
+++ b/arch/mips/include/asm/tlbflush.h
@@ -8,12 +8,14 @@
  *
  *  - flush_tlb_all() flushes all processes TLB entries
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB entries
+ *  - flush_tlb_all_mm() flushes all mm context TLB entries
  *  - flush_tlb_page(vma, vmaddr) flushes one page
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  */
 extern void local_flush_tlb_all(void);
 extern void local_flush_tlb_mm(struct mm_struct *mm);
+extern void local_flush_tlb_all_mm(void);
 extern void local_flush_tlb_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end);
 extern void local_flush_tlb_kernel_range(unsigned long start,
@@ -26,6 +28,7 @@ extern void local_flush_tlb_one(unsigned long vaddr);

 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *);
+extern void flush_tlb_all_mm(void);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long,
 	unsigned long);
 extern void flush_tlb_kernel_range(unsigned long, unsigned long);
@@ -36,6 +39,7 @@ extern void flush_tlb_one(unsigned long vaddr);

 #define flush_tlb_all()			local_flush_tlb_all()
 #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
+#define flush_tlb_all_mm()		local_flush_tlb_all_mm()
 #define flush_tlb_range(vma, vmaddr, end)	local_flush_tlb_range(vma,
vmaddr, end)
 #define flush_tlb_kernel_range(vmaddr,end) \
 	local_flush_tlb_kernel_range(vmaddr, end)
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 383aeb9..535231f 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -242,6 +242,16 @@ void flush_tlb_all(void)
 	on_each_cpu(flush_tlb_all_ipi, NULL, 1);
 }

+static void flush_tlb_all_mm_ipi(void *info)
+{
+	local_flush_tlb_all_mm();
+}
+
+void flush_tlb_all_mm(void)
+{
+	on_each_cpu(flush_tlb_all_mm_ipi, NULL, 1);
+}
+
 static void flush_tlb_mm_ipi(void *mm)
 {
 	local_flush_tlb_mm((struct mm_struct *)mm);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index c618eed..05f0d2e 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -66,6 +66,19 @@ extern void build_tlb_refill_handler(void);

 #endif

+/* This function will clear all mm contexts on calling cpu
+ * To produce desired effect it must be called
+ * when mm_cpumask for all mm contexts is cleared
+ */
+void local_flush_tlb_all_mm(void)
+{
+	struct task_struct *p;
+
+	for_each_process(p)
+		if (p->mm)
+			local_flush_tlb_mm(p->mm);
+}
+
 void local_flush_tlb_all(void)
 {
 	unsigned long flags;
-- 
1.7.0.4
