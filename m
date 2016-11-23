Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 14:48:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10974 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993060AbcKWNoKGuxsG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 14:44:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C7D9FA15910C8;
        Wed, 23 Nov 2016 13:43:57 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 23 Nov 2016 13:44:00 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 06/10] MIPS: relocate: optionally relocate the DTB
Date:   Wed, 23 Nov 2016 14:43:48 +0100
Message-ID: <1479908632-30392-7-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

If the DTB is located in the target memory area for the relocated kernel
it needs to be relocated as well before kernel relocation takes place.

After copying the DTB use the new plat_fdt_relocated() API from the
relocated kernel to ensure the relocated kernel updates any information
that it may have cached about the location of the DTB.

plat_fdt_relocated is declared as a weak symbol so that platforms that
do not require it do not need to implement the method.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/relocate.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index 1958910..76108e5 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -31,6 +31,8 @@ extern u32 _relocation_end[];	/* End relocation table */
 extern long __start___ex_table;	/* Start exception table */
 extern long __stop___ex_table;	/* End exception table */
 
+extern void __weak plat_fdt_relocated(void *new_location);
+
 static inline u32 __init get_synci_step(void)
 {
 	u32 res;
@@ -291,12 +293,14 @@ void *__init relocate_kernel(void)
 	int res = 1;
 	/* Default to original kernel entry point */
 	void *kernel_entry = start_kernel;
+	void *fdt = NULL;
 
 	/* Get the command line */
 	fw_init_cmdline();
 #if defined(CONFIG_USE_OF)
 	/* Deal with the device tree */
-	early_init_dt_scan(plat_get_fdt());
+	fdt = plat_get_fdt();
+	early_init_dt_scan(fdt);
 	if (boot_command_line[0]) {
 		/* Boot command line was passed in device tree */
 		strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
@@ -316,6 +320,29 @@ void *__init relocate_kernel(void)
 	arcs_cmdline[0] = '\0';
 
 	if (offset) {
+		void (*fdt_relocated_)(void *) = NULL;
+#if defined(CONFIG_USE_OF)
+		unsigned long fdt_phys = virt_to_phys(fdt);
+
+		/*
+		 * If built-in dtb is used then it will have been relocated
+		 * during kernel _text relocation. If appended DTB is used
+		 * then it will not be relocated, but it should remain
+		 * intact in the original location. If dtb is loaded by
+		 * the bootloader then it may need to be moved if it crosses
+		 * the target memory area
+		 */
+
+		if (fdt_phys >= virt_to_phys(RELOCATED(&_text)) &&
+			fdt_phys <= virt_to_phys(RELOCATED(&_end))) {
+			void *fdt_relocated =
+				RELOCATED(ALIGN((long)&_end, PAGE_SIZE));
+			memcpy(fdt_relocated, fdt, fdt_totalsize(fdt));
+			fdt = fdt_relocated;
+			fdt_relocated_ = RELOCATED(&plat_fdt_relocated);
+		}
+#endif /* CONFIG_USE_OF */
+
 		/* Copy the kernel to it's new location */
 		memcpy(loc_new, &_text, kernel_length);
 
@@ -338,6 +365,14 @@ void *__init relocate_kernel(void)
 		 */
 		memcpy(RELOCATED(&__bss_start), &__bss_start, bss_length);
 
+		/*
+		 * If fdt was stored outside of the kernel image and
+		 * had to be moved then update platform's state data
+		 * with the new fdt location
+		 */
+		if (fdt_relocated_)
+			fdt_relocated_(fdt);
+
 		/* The current thread is now within the relocated image */
 		__current_thread_info = RELOCATED(&init_thread_union);
 
-- 
2.7.4
