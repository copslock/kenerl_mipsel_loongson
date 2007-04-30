Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2007 17:49:26 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:13281 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022533AbXD3QtV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Apr 2007 17:49:21 +0100
Received: from localhost (p4067-ipad203funabasi.chiba.ocn.ne.jp [222.146.83.67])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C9255AE33; Tue,  1 May 2007 01:49:16 +0900 (JST)
Date:	Tue, 01 May 2007 01:49:20 +0900 (JST)
Message-Id: <20070501.014920.126761214.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, akpm@linux-foundation.org
Subject: [PATCH] MIPS: Make resources for ds1742 "static __initdata"
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
X-archive-position: 14954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

We can make resources for platform_device_register_simple() "static
__initdata".

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/jmr3927/rbhma3100/setup.c                |    2 +-
 .../toshiba_rbtx4927/toshiba_rbtx4927_setup.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index d1ef289..8303001 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -434,7 +434,7 @@ EXPORT_SYMBOL(__swizzle_addr_b);
 
 static int __init jmr3927_rtc_init(void)
 {
-	struct resource res = {
+	static struct resource __initdata res = {
 		.start	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE,
 		.end	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE + 0x800 - 1,
 		.flags	= IORESOURCE_MEM,
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index 0f7576d..5aa786d 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -1039,7 +1039,7 @@ void __init toshiba_rbtx4927_timer_setup(struct irqaction *irq)
 
 static int __init toshiba_rbtx4927_rtc_init(void)
 {
-	struct resource res = {
+	static struct resource __initdata res = {
 		.start	= 0x1c010000,
 		.end	= 0x1c010000 + 0x800 - 1,
 		.flags	= IORESOURCE_MEM,
