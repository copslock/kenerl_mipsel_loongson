Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2007 03:19:20 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:26764 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S28575941AbXASDTQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Jan 2007 03:19:16 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 19 Jan 2007 12:19:14 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4585341D08;
	Fri, 19 Jan 2007 12:19:12 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 311CA41A5B;
	Fri, 19 Jan 2007 12:19:12 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l0J3JBW0076303;
	Fri, 19 Jan 2007 12:19:11 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 19 Jan 2007 12:19:10 +0900 (JST)
Message-Id: <20070119.121910.96686038.nemoto@toshiba-tops.co.jp>
To:	akpm@osdl.org
Cc:	ralf@linux-mips.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070118135326.c0238873.akpm@osdl.org>
References: <20070119.002346.74752797.anemo@mba.ocn.ne.jp>
	<20070118160338.GA6343@linux-mips.org>
	<20070118135326.c0238873.akpm@osdl.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 18 Jan 2007 13:53:26 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > Patch looks technically ok to me, so feel free to add my Acked-by: line.
> > 
> > The grief I have with this sort of patch is that this kind of detailed
> > technical knowledge should not be required by a mortal configuring the
> > Linux kernel.
> > 
> 
> Yes, it does rater suck.  A boot option/module parameter would be better.

OK, here is a revised patch which uses pci= option instead of config
parameters.


Subject: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable

CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
might result in allocation failure for the reserving itself on some
platforms (for example typical 32bit MIPS).  Make it (and
CARDBUS_IO_SIZE too) customizable by "pci=" option for such platforms.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 Documentation/kernel-parameters.txt |    6 ++++++
 drivers/pci/pci.c                   |    6 ++++++
 drivers/pci/setup-bus.c             |   27 +++++++++++++++------------
 include/linux/pci.h                 |    3 +++
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 25d2985..ace7a9a 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1259,6 +1259,12 @@ and is between 256 and 4096 characters. 
 				This sorting is done to get a device
 				order compatible with older (<= 2.4) kernels.
 		nobfsort	Don't sort PCI devices into breadth-first order.
+		cbiosize=nn[KMG]	A fixed amount of bus space is
+				reserved for CardBus bridges.
+				The default value is 256 bytes.
+		cbmemsize=nn[KMG]	A fixed amount of bus space is
+				reserved for CardBus bridges.
+				The default value is 64 megabytes.
 
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 206c834..639069a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1168,6 +1168,12 @@ static int __devinit pci_setup(char *str
 		if (*str && (str = pcibios_setup(str)) && *str) {
 			if (!strcmp(str, "nomsi")) {
 				pci_no_msi();
+			} else if (!strncmp(str, "cbiosize=", 9)) {
+				pci_cardbus_io_size =
+					memparse(str + 9, &str);
+			} else if (!strncmp(str, "cbmemsize=", 10)) {
+				pci_cardbus_mem_size =
+					memparse(str + 10, &str);
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 89f3036..1dfc288 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -40,8 +40,11 @@ #define ROUND_UP(x, a)		(((x) + (a) - 1)
  * FIXME: IO should be max 256 bytes.  However, since we may
  * have a P2P bridge below a cardbus bridge, we need 4K.
  */
-#define CARDBUS_IO_SIZE		(256)
-#define CARDBUS_MEM_SIZE	(64*1024*1024)
+#define DEFAULT_CARDBUS_IO_SIZE		(256)
+#define DEFAULT_CARDBUS_MEM_SIZE	(64*1024*1024)
+/* pci=cbmemsize=nnM,cbiosize=nn can override this */
+unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
+unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 
 static void __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)
@@ -415,12 +418,12 @@ pci_bus_size_cardbus(struct pci_bus *bus
 	 * Reserve some resources for CardBus.  We reserve
 	 * a fixed amount of bus space for CardBus bridges.
 	 */
-	b_res[0].start = CARDBUS_IO_SIZE;
-	b_res[0].end = b_res[0].start + CARDBUS_IO_SIZE - 1;
+	b_res[0].start = pci_cardbus_io_size;
+	b_res[0].end = b_res[0].start + pci_cardbus_io_size - 1;
 	b_res[0].flags |= IORESOURCE_IO;
 
-	b_res[1].start = CARDBUS_IO_SIZE;
-	b_res[1].end = b_res[1].start + CARDBUS_IO_SIZE - 1;
+	b_res[1].start = pci_cardbus_io_size;
+	b_res[1].end = b_res[1].start + pci_cardbus_io_size - 1;
 	b_res[1].flags |= IORESOURCE_IO;
 
 	/*
@@ -440,16 +443,16 @@ pci_bus_size_cardbus(struct pci_bus *bus
 	 * twice the size.
 	 */
 	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0) {
-		b_res[2].start = CARDBUS_MEM_SIZE;
-		b_res[2].end = b_res[2].start + CARDBUS_MEM_SIZE - 1;
+		b_res[2].start = pci_cardbus_mem_size;
+		b_res[2].end = b_res[2].start + pci_cardbus_mem_size - 1;
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
 
-		b_res[3].start = CARDBUS_MEM_SIZE;
-		b_res[3].end = b_res[3].start + CARDBUS_MEM_SIZE - 1;
+		b_res[3].start = pci_cardbus_mem_size;
+		b_res[3].end = b_res[3].start + pci_cardbus_mem_size - 1;
 		b_res[3].flags |= IORESOURCE_MEM;
 	} else {
-		b_res[3].start = CARDBUS_MEM_SIZE * 2;
-		b_res[3].end = b_res[3].start + CARDBUS_MEM_SIZE * 2 - 1;
+		b_res[3].start = pci_cardbus_mem_size * 2;
+		b_res[3].end = b_res[3].start + pci_cardbus_mem_size * 2 - 1;
 		b_res[3].flags |= IORESOURCE_MEM;
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f3c617e..ff04c69 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -837,5 +837,8 @@ #define PCIPCI_VSFX		16
 #define PCIPCI_ALIMAGIK		32	/* Need low latency setting */
 #define PCIAGP_FAIL		64	/* No PCI to AGP DMA */
 
+extern unsigned long pci_cardbus_io_size;
+extern unsigned long pci_cardbus_mem_size;
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
