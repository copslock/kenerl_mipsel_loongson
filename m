Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 14:35:02 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:22782 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031381AbYHZNe7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 14:34:59 +0100
Received: from localhost (p1241-ipad305funabasi.chiba.ocn.ne.jp [123.217.163.241])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B85EDAAAD; Tue, 26 Aug 2008 22:34:55 +0900 (JST)
Date:	Tue, 26 Aug 2008 22:34:57 +0900 (JST)
Message-Id: <20080826.223457.41872931.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Probe initrd header only if explicitly specified
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Currently init_initrd() probes initrd header at the last page of
kernel image, but it is valid only if addinitrd was used.  If
addinitrd was not used, the area contains garbage so probing there
might misdetect initrd header (magic number is not strictly robust).

This patch introduces CONFIG_PROBE_INITRD_HEADER to enable this
probing explicitly.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
revised with spell-check.

 arch/mips/Kconfig        |    9 +++++++++
 arch/mips/kernel/setup.c |   35 +++++++++++++++++++----------------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4da736e..49896a2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1886,6 +1886,15 @@ config STACKTRACE_SUPPORT
 
 source "init/Kconfig"
 
+config PROBE_INITRD_HEADER
+	bool "Probe initrd header created by addinitrd"
+	depends on BLK_DEV_INITRD
+	help
+	  Probe initrd header at the last page of kernel image.
+	  Say Y here if you are using arch/mips/boot/addinitrd.c to
+	  add initrd or initramfs image to the kernel image.
+	  Otherwise, say N.
+
 menu "Bus options (PCI, PCMCIA, EISA, ISA, TC)"
 
 config HW_HAS_EISA
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2aae76b..16f8edf 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -160,30 +160,33 @@ early_param("rd_size", rd_size_early);
 static unsigned long __init init_initrd(void)
 {
 	unsigned long end;
-	u32 *initrd_header;
 
 	/*
 	 * Board specific code or command line parser should have
 	 * already set up initrd_start and initrd_end. In these cases
 	 * perfom sanity checks and use them if all looks good.
 	 */
-	if (initrd_start && initrd_end > initrd_start)
-		goto sanitize;
+	if (!initrd_start || initrd_end <= initrd_start) {
+#ifdef CONFIG_PROBE_INITRD_HEADER
+		u32 *initrd_header;
 
-	/*
-	 * See if initrd has been added to the kernel image by
-	 * arch/mips/boot/addinitrd.c. In that case a header is
-	 * prepended to initrd and is made up by 8 bytes. The fisrt
-	 * word is a magic number and the second one is the size of
-	 * initrd.  Initrd start must be page aligned in any cases.
-	 */
-	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + 8)) - 8;
-	if (initrd_header[0] != 0x494E5244)
+		/*
+		 * See if initrd has been added to the kernel image by
+		 * arch/mips/boot/addinitrd.c. In that case a header is
+		 * prepended to initrd and is made up by 8 bytes. The first
+		 * word is a magic number and the second one is the size of
+		 * initrd.  Initrd start must be page aligned in any cases.
+		 */
+		initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + 8)) - 8;
+		if (initrd_header[0] != 0x494E5244)
+			goto disable;
+		initrd_start = (unsigned long)(initrd_header + 2);
+		initrd_end = initrd_start + initrd_header[1];
+#else
 		goto disable;
-	initrd_start = (unsigned long)(initrd_header + 2);
-	initrd_end = initrd_start + initrd_header[1];
+#endif
+	}
 
-sanitize:
 	if (initrd_start & ~PAGE_MASK) {
 		pr_err("initrd start must be page aligned\n");
 		goto disable;
