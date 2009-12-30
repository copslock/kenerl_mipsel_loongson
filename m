Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Dec 2009 13:32:10 +0100 (CET)
Received: from mail-yw0-f182.google.com ([209.85.211.182]:42942 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492492AbZL3McG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Dec 2009 13:32:06 +0100
Received: by ywh12 with SMTP id 12so12768956ywh.21
        for <linux-mips@linux-mips.org>; Wed, 30 Dec 2009 04:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=05dt1AZ+QeyZYSwBgKdGOdxVYeLnxT2d2OpwnArDTlo=;
        b=vD7CVxJ2vtzlhAXhHIW4XICWCiycuoZT49jGofrenO/qCvOCxLrtEPuyngIX2q3but
         Va7B/y3hjGkdrZ7WDwgphQmmv0OS4FBFaGk9BF+2fJb+NdIGin7FsSnHZ9kCv8ejg23D
         pSWn9Qbiq7xsXYVoaZhK5GLQn4yxslxuUDT6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qP1sCLuL0u8GhEaVUCujS9ITrNuS1FS/yVYgvti6uRoufy/ZXrJzoFreR10gowyOLl
         qPFjbbkV3rywjt+TGtF0EWT48TCwORR6GCqYJ4zF/7/a4qo9A4A1oMUii2ByO4aIbKVt
         OXxjulFKtbwCdQjM4PAz1n/w1FFGsU22uR7Ec=
MIME-Version: 1.0
Received: by 10.90.9.5 with SMTP id 5mr7080552agi.48.1262176318442; Wed, 30 
        Dec 2009 04:31:58 -0800 (PST)
Date:   Wed, 30 Dec 2009 20:31:58 +0800
Message-ID: <e997b7420912300431n196c6296y46f7e0c6461fa3e4@mail.gmail.com>
Subject: [PATCH] MIPS: kexec mips64 XLR 732 support
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Though xlr family is not supported in kernel tree, this patch is
released in the hope that it might be help for some people using xlr.

This patch works on mips64 xlr732 , which has 8 cores up to 32 threads.
derived from Maxim Syrchin's patch at
http://lists.infradead.org/pipermail/kexec/2008-June/001909.html

Notice:
(I)
 In my code,xlr kernel needs to call functions in bootloader when booting,
 so xlr bootloader is supposed to determin whether in first booting or second.
(II)
 As xlr kernel choosed CPU0 for special purpose when booting,I simply
bind kexec on CPU0.
(III)
 Becasue non-zero CPUs have different kernel entry with respect to
CPU0,they wait util CPU0 set flags at 0xa6000000.


Signed-off-by: wilbur <chen.yu10 at zte.com.cn>

--- machine_kexec.c 2007-08-05 00:11:13.000000000 +0800
+++ patch.machine_kexec.c 2009-12-29 14:31:32.000000000 +0800
@@ -13,12 +13,28 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>

+#ifdef CONFIG_RMI_PHOENIX
+#define KEXEC_FLAG_VAL  184790
+#define KEXEC_FLAG_POS   0xa6000000
+#define KEXEC_SECONDFUNC_POS   0xa6000004
+#define  V_CPUS                   31
+#endif
 extern const unsigned char relocate_new_kernel[];
+#ifdef CONFIG_RMI_PHOENIX
+extern const unsigned char kexec_smp_wait[];
+#endif
 extern const unsigned int relocate_new_kernel_size;

 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;

+#ifdef CONFIG_RMI_PHOENIX
+extern unsigned long kexec_fw_arg0;
+extern unsigned long kexec_fw_arg1;
+extern unsigned long kexec_fw_arg2;
+extern unsigned long kexec_fw_arg3;
+extern unsigned long fw_arg0,fw_arg1,fw_arg2,fw_arg3;
+#endif
 int
 machine_kexec_prepare(struct kimage *kimage)
 {
@@ -33,7 +49,70 @@
 void
 machine_shutdown(void)
 {
+ #ifdef CONFIG_RMI_PHOENIX
+ default_machine_kexec_shutdown();
+ #endif
 }
+#ifdef CONFIG_RMI_PHOENIX
+unsigned long relocated_kexec_smp_wait;
+atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
+int main_cpu = -1;
+static cpumask_t cpus_in_kexec = CPU_MASK_NONE;
+void machine_shutdown_secondary(void *ignore)
+{
+    int cpu = smp_processor_id();
+
+       if (!cpu_online(cpu))
+       return;
+
+ local_irq_disable();
+ uint64_t eimr=0;
+ write_64bit_cp0_eimr(eimr);
+
+
+
+ /*
+  * clear flags and secondary funtion before wait
+  */
+ *(unsigned long*)KEXEC_FLAG_POS =0;
+ *(unsigned long*)KEXEC_SECONDFUNC_POS =0;
+
+    cpu_set(cpu, cpus_in_kexec);
+
+   while(!atomic_read(&kexec_ready_to_reboot)) {
+        cpu_relax();
+    }
+
+ ((void (*)(void)) relocated_kexec_smp_wait)();
+    /* NOTREACHED */
+}
+static void machine_kexec_prepare_cpus(void)
+{
+
+    unsigned int msecs;
+    smp_call_function (machine_shutdown_secondary, NULL, 0, 0);
+    smp_wmb();
+    /*
+     * FIXME: Until we will have the way to stop other CPUSs reliabally,
+     * the crash CPU will send an IPI and wait for other CPUs to
+     * respond.
+     * Delay of at least 10 seconds.
+     */
+
+    msecs = 10000;
+    while ((cpus_weight(cpus_in_kexec) < V_CPUS) && (--msecs > 0)) {
+        cpu_relax();
+        mdelay(1);
+    }
+
+}
+void default_machine_kexec_shutdown()
+{
+ machine_kexec_prepare_cpus();
+}
+
+#endif

 void
 machine_crash_shutdown(struct pt_regs *regs)
@@ -50,7 +129,13 @@
 reboot_code_buffer =
   (unsigned long)page_address(image->control_code_page);

- kexec_start_address = image->start;
+ kexec_start_address = (unsigned long) phys_to_virt(image->start);
+ #ifdef CONFIG_RMI_PHOENIX
+  kexec_fw_arg0 = fw_arg0;
+  kexec_fw_arg1 = fw_arg1;
+  kexec_fw_arg2 = fw_arg2;
+  kexec_fw_arg3 = fw_arg3;
+ #endif
 kexec_indirection_page = phys_to_virt(image->head & PAGE_MASK);

 memcpy((void*)reboot_code_buffer, relocate_new_kernel,
@@ -75,10 +160,23 @@
  */
 local_irq_disable();

- flush_icache_range(reboot_code_buffer,
-      reboot_code_buffer + KEXEC_CONTROL_CODE_SIZE);

- printk("Will call new kernel at %08x\n", image->start);
+
+ #ifdef CONFIG_RMI_PHOENIX
+ pic_and_control(0xfffffbff);
+    /* All secondary cpus now may jump to kexec_wait cycle */
+    relocated_kexec_smp_wait = reboot_code_buffer +
+        (kexec_smp_wait - relocate_new_kernel);
+    smp_wmb();
+    atomic_set(&kexec_ready_to_reboot,1);
+ pic_irt_timer_maskall();
+ pic_irt_uart0_0_and(0x0);
+ pic_irt_uart0_1_and(0x0);
+ uart_int_and(0x0);
+  uint64_t eimr=0;
+ write_64bit_cp0_eimr(eimr);
+ #endif
+ printk("Will call new kernel at %08x\n", kexec_start_address);
 printk("Bye ...\n");
 flush_cache_all();
 ((void (*)(void))reboot_code_buffer)();

--- relocate_kernel.S 2007-08-05 00:11:13.000000000 +0800
+++ patch.relocate_kernel.S 2009-12-29 14:25:27.873991800 +0800
@@ -14,12 +14,21 @@
 #include <asm/stackframe.h>
 #include <asm/addrspace.h>

+#ifdef CONFIG_RMI_PHOENIX
+#define KEXEC_FLAG_POS   0xa6000000
+#define KEXEC_SECONDFUNC_POS   0xa6000004
+#endif
 .globl relocate_new_kernel
 relocate_new_kernel:

 PTR_L s0, kexec_indirection_page
 PTR_L s1, kexec_start_address
-
+#ifdef CONFIG_RMI_PHOENIX
+ PTR_L t0, kexec_fw_arg0
+ PTR_L t1, kexec_fw_arg1
+ PTR_L t2, kexec_fw_arg2
+ PTR_L t3, kexec_fw_arg3
+#endif
 process_entry:
 PTR_L s2, (s0)
 PTR_ADD s0, s0, SZREG
@@ -62,9 +71,39 @@
 b process_entry

 done:
+#ifdef CONFIG_RMI_PHOENIX
+ move      a0,  t0
+ move      a1,  t1
+ move      a2,  t2
+ move      a3,  t3
 /* jump to kexec_start_address */
- j s1
+ jr     s1
+#endif
+
+

+#ifdef CONFIG_RMI_PHOENIX
+ .globl kexec_smp_wait
+kexec_smp_wait:
+ /*
+  * wait util CPU0 set  flag at 0xa6000000, then jump to
secondary_function stored in 0xa6000004
+  *
+  */
+
+ /*
+  * FIXME
+  */
+20: li             s2,KEXEC_FLAG_POS
+ REG_L  s5, (s2)
+ beqz  s5, 20b
+
+ /*
+  * ok , we can jump to second kernel
+  */
+ li             s2,KEXEC_SECONDFUNC_POS
+ REG_L  s6, (s2)
+ jr            s6
+#endif
 .globl kexec_start_address
 kexec_start_address:
 .long 0x0
@@ -73,6 +112,25 @@
 kexec_indirection_page:
 .long 0x0

+#ifdef CONFIG_RMI_PHOENIX
+ .globl kexec_fw_arg0
+kexec_fw_arg0:
+ .long 0x0
+
+
+ .globl kexec_fw_arg1
+kexec_fw_arg1:
+ .long 0x0
+
+ .globl kexec_fw_arg2
+kexec_fw_arg2:
+ .long 0x0
+
+ .globl kexec_fw_arg3
+kexec_fw_arg3:
+ .long 0x0
+
+#endif
 relocate_new_kernel_end:

 .globl relocate_new_kernel_size
