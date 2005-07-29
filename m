Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2005 13:57:40 +0100 (BST)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:40227
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8224986AbVG2M5Y>; Fri, 29 Jul 2005 13:57:24 +0100
Received: from localhost.localdomain (oreo.jp.mvista.com [10.200.16.31])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id j6TD06S5007006;
	Fri, 29 Jul 2005 22:00:07 +0900
Date:	Fri, 29 Jul 2005 22:03:03 +0900
From:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: [PATCH 1/1] TX4938: small fix for Toshiba RBHMA4500(TX4938)
Message-Id: <20050729220303.0145ae70.Hiroshi_DOYU@montavista.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <Hiroshi_DOYU@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Hiroshi_DOYU@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hello,

This patch is against latest cvs.
Could you review it?

	Hiroshi DOYU

----
- Added Big endian suport in Kconfig.
- global variable zeroed initialization was handled correctly.
- A customized private function was replaced by a common
  utility function, "fls()".

Signed-off-by: Hiroshi DOYU <hdoyu@mvista.com>

 Kconfig                         |    1 +
 tx4938/toshiba_rbtx4938/irq.c   |   15 +--------------
 tx4938/toshiba_rbtx4938/setup.c |    6 +++---
 3 files changed, 5 insertions(+), 17 deletions(-)

Index: mipslinux/arch/mips/Kconfig
===================================================================
--- mipslinux.orig/arch/mips/Kconfig
+++ mipslinux/arch/mips/Kconfig
@@ -669,6 +669,7 @@
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_BIG_ENDIAN
 	select TOSHIBA_BOARDS
 	help
 	  This Toshiba board is based on the TX4938 processor. Say Y here to
Index: mipslinux/arch/mips/tx4938/toshiba_rbtx4938/setup.c
===================================================================
--- mipslinux.orig/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ mipslinux/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -50,10 +50,10 @@
 
 unsigned long rbtx4938_ce_base[8];
 unsigned long rbtx4938_ce_size[8];
-int txboard_pci66_mode = 0;
+int txboard_pci66_mode;
+static int tx4938_pcic_trdyto;	/* default: disabled */
+static int tx4938_pcic_retryto;	/* default: disabled */
 static int tx4938_ccfg_toeon = 1;
-static int tx4938_pcic_trdyto = 0;	/* default: disabled */
-static int tx4938_pcic_retryto = 0;	/* default: disabled */
 
 struct tx4938_pcic_reg *pcicptrs[4] = {
        tx4938_pcicptr  /* default setting for TX4938 */
Index: mipslinux/arch/mips/tx4938/toshiba_rbtx4938/irq.c
===================================================================
--- mipslinux.orig/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ mipslinux/arch/mips/tx4938/toshiba_rbtx4938/irq.c
@@ -114,19 +114,6 @@
 #define TOSHIBA_RBTX4938_IOC_INTR_ENAB 0xb7f02000
 #define TOSHIBA_RBTX4938_IOC_INTR_STAT 0xb7f0200a
 
-u8
-last_bit2num(u8 num)
-{
-	u8 i = ((sizeof(num)*8)-1);
-
-	do {
-		if (num & (1<<i))
-			break;
-	} while ( --i );
-
-	return i;
-}
-
 int
 toshiba_rbtx4938_irq_nested(int sw_irq)
 {
@@ -135,7 +122,7 @@
 	level3 = reg_rd08(TOSHIBA_RBTX4938_IOC_INTR_STAT) & 0xff;
 	if (level3) {
                 /* must use last_bit2num so onboard ATA has priority */
-		sw_irq = TOSHIBA_RBTX4938_IRQ_IOC_BEG + last_bit2num(level3);
+		sw_irq = TOSHIBA_RBTX4938_IRQ_IOC_BEG + fls(level3) - 1;
 	}
 
 	wbflush();
