Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2008 17:16:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:10441 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28776308AbYECQPt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 May 2008 17:15:49 +0100
Received: from localhost (p2071-ipad306funabasi.chiba.ocn.ne.jp [123.217.172.71])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 30A21ADBC; Sun,  4 May 2008 01:15:41 +0900 (JST)
Date:	Sun, 04 May 2008 01:16:47 +0900 (JST)
Message-Id: <20080504.011647.93019265.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	tsbogend@alpha.franken.de, linux-mips@linux-mips.org
Subject: Re: Breakage in arch/mips/kernel/traps.c for 64bit
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080502101113.GA24408@linux-mips.org>
References: <20080501163314.GA9955@alpha.franken.de>
	<20080502101113.GA24408@linux-mips.org>
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
X-archive-position: 19086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 2 May 2008 11:11:13 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> It came as part of 39b8d5254246ac56342b72f812255c8f7a74dca9 which is a
> patch amalgated from several other patches.  Below is the original patch
> it came with.  I think the idea of the patch is valid but the idea needs a
> bit of mending.

Then how about this fix?

---------------------------------------------------------------------
Subject: [PATCH] Fix detection of kernel segment on 64-bit

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cb8b0e2..7893bb3 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -78,6 +78,19 @@ void (*board_nmi_handler_setup)(void);
 void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 
+static inline int kernel_unmapped_seg(void *addr)
+{
+	unsigned long a = (unsigned long)addr;
+
+#ifdef CONFIG_32BIT
+	/* KSEG0 or KSEG1 */
+	return (a & 0xc0000000) == KSEG0;
+#else
+	/* CKSEG0, CKSEG1 or XKPHYS  */
+	return ((a & 0xffffffffc0000000L) == CKSEG0) ||
+		((a & 0xc000000000000000L) == XKPHYS);
+#endif
+}
 
 static void show_raw_backtrace(unsigned long reg29)
 {
@@ -88,8 +101,7 @@ static void show_raw_backtrace(unsigned long reg29)
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
-#define IS_KVA01(a) ((((unsigned int)a) & 0xc0000000) == 0x80000000)
-	if (IS_KVA01(sp)) {
+	if (kernel_unmapped_seg(sp)) {
 		while (!kstack_end(sp)) {
 			addr = *sp++;
 			if (__kernel_text_address(addr))
