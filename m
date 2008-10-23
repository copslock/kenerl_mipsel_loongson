Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 15:16:17 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:57327 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22213712AbYJWOQL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2008 15:16:11 +0100
Received: from localhost (p4025-ipad307funabasi.chiba.ocn.ne.jp [123.217.182.25])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 68165AA8A; Thu, 23 Oct 2008 23:16:01 +0900 (JST)
Date:	Thu, 23 Oct 2008 23:16:18 +0900 (JST)
Message-Id: <20081023.231618.126142426.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <49007E37.5080605@ru.mvista.com>
References: <20081023.011646.51867355.anemo@mba.ocn.ne.jp>
	<49007E37.5080605@ru.mvista.com>
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
X-archive-position: 20853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 23 Oct 2008 17:37:59 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Thanks.  Here is v3 patch with just two comment changes.

------------------------------------------------------
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] TXx9: Add TX4938 ATA support (v3)

Add a helper routine to register tx4938ide driver and use it on
RBTX4938 board.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Change since v2:
* better comment wordings

 arch/mips/include/asm/txx9/tx4938.h   |   13 +++++++++
 arch/mips/txx9/generic/setup_tx4938.c |   47 +++++++++++++++++++++++++++++++++
 arch/mips/txx9/rbtx4938/setup.c       |    1 +
 3 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/txx9/tx4938.h b/arch/mips/include/asm/txx9/tx4938.h
index 989e775..0b06815 100644
--- a/arch/mips/include/asm/txx9/tx4938.h
+++ b/arch/mips/include/asm/txx9/tx4938.h
@@ -292,4 +292,17 @@ void tx4938_setup_pcierr_irq(void);
 void tx4938_irq_init(void);
 void tx4938_mtd_init(int ch);
 
+struct tx4938ide_platform_info {
+	/*
+	 * I/O port shift, for platforms with ports that are
+	 * constantly spaced and need larger than the 1-byte
+	 * spacing used by ata_std_ports().
+	 */
+	unsigned int ioport_shift;
+	unsigned int gbus_clock;	/*  0 means no PIO mode tuning. */
+	unsigned int ebus_ch;
+};
+
+void tx4938_ata_init(unsigned int irq, unsigned int shift, int tune);
+
 #endif
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index af724e5..25819ff 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -16,6 +16,7 @@
 #include <linux/param.h>
 #include <linux/ptrace.h>
 #include <linux/mtd/physmap.h>
+#include <linux/platform_device.h>
 #include <asm/reboot.h>
 #include <asm/traps.h>
 #include <asm/txx9irq.h>
@@ -335,6 +336,52 @@ void __init tx4938_mtd_init(int ch)
 	txx9_physmap_flash_init(ch, start, size, &pdata);
 }
 
+void __init tx4938_ata_init(unsigned int irq, unsigned int shift, int tune)
+{
+	struct platform_device *pdev;
+	struct resource res[] = {
+		{
+			/* .start and .end are filled in later */
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	struct tx4938ide_platform_info pdata = {
+		.ioport_shift = shift,
+		/*
+		 * The IDE driver should not change bus timings if other ISA
+		 * devices existed.
+		 */
+		.gbus_clock = tune ? txx9_gbus_clock : 0,
+	};
+	u64 ebccr;
+	int i;
+
+	if ((__raw_readq(&tx4938_ccfgptr->pcfg) &
+	     (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL))
+	    != TX4938_PCFG_ATA_SEL)
+		return;
+	for (i = 0; i < 8; i++) {
+		/* check EBCCRn.ISA, EBCCRn.BSZ, EBCCRn.ME */
+		ebccr = __raw_readq(&tx4938_ebuscptr->cr[i]);
+		if ((ebccr & 0x00f00008) == 0x00e00008)
+			break;
+	}
+	if (i == 8)
+		return;
+	pdata.ebus_ch = i;
+	res[0].start = ((ebccr >> 48) << 20) + 0x10000;
+	res[0].end = res[0].start + 0x20000 - 1;
+	pdev = platform_device_alloc("tx4938ide", -1);
+	if (!pdev ||
+	    platform_device_add_resources(pdev, res, ARRAY_SIZE(res)) ||
+	    platform_device_add_data(pdev, &pdata, sizeof(pdata)) ||
+	    platform_device_add(pdev))
+		platform_device_put(pdev);
+}
+
 static void __init tx4938_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index e077cc4..547ff29 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -352,6 +352,7 @@ static void __init rbtx4938_device_init(void)
 	rbtx4938_ne_init();
 	tx4938_wdt_init();
 	rbtx4938_mtd_init();
+	tx4938_ata_init(RBTX4938_IRQ_IOC_ATA, 0, 1);
 	txx9_iocled_init(RBTX4938_LED_ADDR - IO_BASE, -1, 8, 1, "green", NULL);
 }
 
-- 
1.5.6.3
