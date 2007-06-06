Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 01:49:14 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:39889 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022005AbXFFAtK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 01:49:10 +0100
Received: (qmail 29051 invoked by uid 101); 6 Jun 2007 00:49:03 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 6 Jun 2007 00:49:03 -0000
Received: from pasqua.pmc-sierra.bc.ca (pasqua.pmc-sierra.bc.ca [134.87.183.161])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l560n22R024713;
	Tue, 5 Jun 2007 17:49:02 -0700
From:	Marc St-Jean <stjeanma@pmc-sierra.com>
Received: (from stjeanma@localhost)
	by pasqua.pmc-sierra.bc.ca (8.13.4/8.12.11) id l560moU4007288;
	Tue, 5 Jun 2007 18:48:50 -0600
Date:	Tue, 5 Jun 2007 18:48:50 -0600
Message-Id: <200706060048.l560moU4007288@pasqua.pmc-sierra.bc.ca>
To:	gregkh@suse.de
Subject: [PATCH 11/12] drivers: PMC MSP71xx USB driver
Cc:	akpm@linux-foundation.org, dbrownell@users.sourceforge.net,
	linux-mips@linux-mips.org, linux-usb-devel@lists.sourceforge.net
Return-Path: <stjeanma@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stjeanma@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

[PATCH 11/12] drivers: PMC MSP71xx USB driver

Patch to add an USB driver for the PMC-Sierra MSP71xx devices.

Patches 1 through 10 were posted to linux-mips@linux-mips.org as well
as other sub-system lists/maintainers as appropriate. This patch has
some dependencies on the first few patches in the set. If you would
like to receive these or the entire set, please email me.

Thanks,
Marc

Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
---
Re-posting patch with recommended changes:
- Dropping gadget code until host patch accepted.
- Changed overcurrent fixes in host/hub.c and ehci-hub.c to apply to all hubs.

 Kconfig            |    1 
 core/hub.c         |   27 ++-
 host/Kconfig       |   32 +++
 host/ehci-dbg.c    |   92 +++++------
 host/ehci-hcd.c    |   18 +-
 host/ehci-hub.c    |    6 
 host/ehci-mem.c    |    6 
 host/ehci-pmcmsp.c |  434 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 host/ehci-q.c      |   48 ++---
 host/ehci-sched.c  |  105 ++++++------
 host/ehci.h        |  204 ++++++++++++++++++++----
 11 files changed, 806 insertions(+), 167 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 9980a4d..bb97a0b 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -37,6 +37,7 @@ config USB_ARCH_HAS_OHCI
 # some non-PCI hcds implement EHCI
 config USB_ARCH_HAS_EHCI
 	boolean
+	default y if PMC_MSP7120_GW || PMC_MSP7120_EVAL || PMC_MSP7120_FPGA
 	default y if PPC_83xx
 	default y if SOC_AU1200
 	default PCI
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b89a98e..e93399c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2749,12 +2749,33 @@ static void hub_events(void)
 			}
 			
 			if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
-				dev_err (hub_dev,
-					"over-current change on port %d\n",
-					i);
+				/* clear OCC bit */
 				clear_port_feature(hdev, i,
 					USB_PORT_FEAT_C_OVER_CURRENT);
+
+				/*
+				 * This step is required to toggle the
+				 * PP bit to 0 and 1 (by hub_power_on)
+				 * in order the CSC bit to be transitioned
+				 * properly for device hotplug.
+				 */
+				/* clear PP bit */
+				clear_port_feature(hdev, i,
+						USB_PORT_FEAT_POWER);
+
+				/* resume power */
 				hub_power_on(hub);
+
+				udelay(100);
+
+				/* read OCA bit */
+				if (portstatus &
+				    (1 << USB_PORT_FEAT_OVER_CURRENT)) {
+					/* declare overcurrent */
+					dev_err(hub_dev,
+						"over-current change "
+						"on port %d\n", i);
+				}
 			}
 
 			if (portchange & USB_PORT_STAT_C_RESET) {
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 6271187..902e059 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -72,6 +72,38 @@ config USB_EHCI_BIG_ENDIAN_MMIO
 	depends on USB_EHCI_HCD
 	default n
 
+config USB_EHCI_HCD_PMC_MSP
+	bool "EHCI support for on-chip PMC MSP USB controller"
+	depends on USB_EHCI_HCD && (PMC_MSP7120_GW || PMC_MSP7120_EVAL || \
+					PMC_MSP7120_FPGA)
+	default y if (PMC_MSP7120_GW || PMC_MSP7120_EVAL || PMC_MSP7120_FPGA)
+	select USB_EHCI_BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_MMIO
+	---help---
+	  Enables support for the onchip USB controller on the PMC_MSP7120_GW 
+	  or PMC_MSP7120_EVAL or PMC_MSP7120_FPGA processor chip.
+	  If unsure, say N.
+
+config USB_EHCI_HCD_PCI
+	bool "EHCI support for PCI-bus USB controllers"
+	depends on USB_EHCI_HCD && PCI && !USB_EHCI_HCD_PMC_MSP
+	default n if USB_EHCI_HCD_PMC_MSP
+	select USB_EHCI_LITTLE_ENDIAN
+	---help---
+	  Enables support for PCI-bus plug-in USB controller cards.
+	  If unsure, say Y.
+
+config USB_EHCI_BIG_ENDIAN
+	bool
+	depends on USB_EHCI_HCD
+	default n
+
+config USB_EHCI_LITTLE_ENDIAN
+	bool
+	depends on USB_EHCI_HCD
+	default n if USB_EHCI_HCD_PMC_MSP
+	default y
+
 config USB_ISP116X_HCD
 	tristate "ISP116X HCD support"
 	depends on USB
diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
index 43eddae..68f8868 100644
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -119,16 +119,16 @@ static void __attribute__((__unused__))
 dbg_qtd (const char *label, struct ehci_hcd *ehci, struct ehci_qtd *qtd)
 {
 	ehci_dbg (ehci, "%s td %p n%08x %08x t%08x p0=%08x\n", label, qtd,
-		le32_to_cpup (&qtd->hw_next),
-		le32_to_cpup (&qtd->hw_alt_next),
-		le32_to_cpup (&qtd->hw_token),
-		le32_to_cpup (&qtd->hw_buf [0]));
+		ehci32_to_cpup (&qtd->hw_next),
+		ehci32_to_cpup (&qtd->hw_alt_next),
+		ehci32_to_cpup (&qtd->hw_token),
+		ehci32_to_cpup (&qtd->hw_buf [0]));
 	if (qtd->hw_buf [1])
 		ehci_dbg (ehci, "  p1=%08x p2=%08x p3=%08x p4=%08x\n",
-			le32_to_cpup (&qtd->hw_buf [1]),
-			le32_to_cpup (&qtd->hw_buf [2]),
-			le32_to_cpup (&qtd->hw_buf [3]),
-			le32_to_cpup (&qtd->hw_buf [4]));
+			ehci32_to_cpup (&qtd->hw_buf [1]),
+			ehci32_to_cpup (&qtd->hw_buf [2]),
+			ehci32_to_cpup (&qtd->hw_buf [3]),
+			ehci32_to_cpup (&qtd->hw_buf [4]));
 }
 
 static void __attribute__((__unused__))
@@ -144,26 +144,27 @@ static void __attribute__((__unused__))
 dbg_itd (const char *label, struct ehci_hcd *ehci, struct ehci_itd *itd)
 {
 	ehci_dbg (ehci, "%s [%d] itd %p, next %08x, urb %p\n",
-		label, itd->frame, itd, le32_to_cpu(itd->hw_next), itd->urb);
+		label, itd->frame, itd, ehci32_to_cpu(itd->hw_next),
+		itd->urb);
 	ehci_dbg (ehci,
 		"  trans: %08x %08x %08x %08x %08x %08x %08x %08x\n",
-		le32_to_cpu(itd->hw_transaction[0]),
-		le32_to_cpu(itd->hw_transaction[1]),
-		le32_to_cpu(itd->hw_transaction[2]),
-		le32_to_cpu(itd->hw_transaction[3]),
-		le32_to_cpu(itd->hw_transaction[4]),
-		le32_to_cpu(itd->hw_transaction[5]),
-		le32_to_cpu(itd->hw_transaction[6]),
-		le32_to_cpu(itd->hw_transaction[7]));
+		ehci32_to_cpu(itd->hw_transaction[0]),
+		ehci32_to_cpu(itd->hw_transaction[1]),
+		ehci32_to_cpu(itd->hw_transaction[2]),
+		ehci32_to_cpu(itd->hw_transaction[3]),
+		ehci32_to_cpu(itd->hw_transaction[4]),
+		ehci32_to_cpu(itd->hw_transaction[5]),
+		ehci32_to_cpu(itd->hw_transaction[6]),
+		ehci32_to_cpu(itd->hw_transaction[7]));
 	ehci_dbg (ehci,
 		"  buf:   %08x %08x %08x %08x %08x %08x %08x\n",
-		le32_to_cpu(itd->hw_bufp[0]),
-		le32_to_cpu(itd->hw_bufp[1]),
-		le32_to_cpu(itd->hw_bufp[2]),
-		le32_to_cpu(itd->hw_bufp[3]),
-		le32_to_cpu(itd->hw_bufp[4]),
-		le32_to_cpu(itd->hw_bufp[5]),
-		le32_to_cpu(itd->hw_bufp[6]));
+		ehci32_to_cpu(itd->hw_bufp[0]),
+		ehci32_to_cpu(itd->hw_bufp[1]),
+		ehci32_to_cpu(itd->hw_bufp[2]),
+		ehci32_to_cpu(itd->hw_bufp[3]),
+		ehci32_to_cpu(itd->hw_bufp[4]),
+		ehci32_to_cpu(itd->hw_bufp[5]),
+		ehci32_to_cpu(itd->hw_bufp[6]));
 	ehci_dbg (ehci, "  index: %d %d %d %d %d %d %d %d\n",
 		itd->index[0], itd->index[1], itd->index[2],
 		itd->index[3], itd->index[4], itd->index[5],
@@ -174,14 +175,15 @@ static void __attribute__((__unused__))
 dbg_sitd (const char *label, struct ehci_hcd *ehci, struct ehci_sitd *sitd)
 {
 	ehci_dbg (ehci, "%s [%d] sitd %p, next %08x, urb %p\n",
-		label, sitd->frame, sitd, le32_to_cpu(sitd->hw_next), sitd->urb);
+		label, sitd->frame, sitd, ehci32_to_cpu(sitd->hw_next),
+		sitd->urb);
 	ehci_dbg (ehci,
 		"  addr %08x sched %04x result %08x buf %08x %08x\n",
-		le32_to_cpu(sitd->hw_fullspeed_ep),
-		le32_to_cpu(sitd->hw_uframe),
-		le32_to_cpu(sitd->hw_results),
-		le32_to_cpu(sitd->hw_buf [0]),
-		le32_to_cpu(sitd->hw_buf [1]));
+		ehci32_to_cpu(sitd->hw_fullspeed_ep),
+		ehci32_to_cpu(sitd->hw_uframe),
+		ehci32_to_cpu(sitd->hw_results),
+		ehci32_to_cpu(sitd->hw_buf [0]),
+		ehci32_to_cpu(sitd->hw_buf [1]));
 }
 
 static int __attribute__((__unused__))
@@ -332,9 +334,9 @@ static inline void remove_debug_files (struct ehci_hcd *bus) { }
 		default: tmp = '?'; break; \
 		}; tmp; })
 
-static inline char token_mark (__le32 token)
+static inline char token_mark (__ehci32 token)
 {
-	__u32 v = le32_to_cpu (token);
+	__u32 v = ehci32_to_cpu (token);
 	if (v & QTD_STS_ACTIVE)
 		return '*';
 	if (v & QTD_STS_HALT)
@@ -372,29 +374,29 @@ static void qh_lines (
 			mark = '.';	/* use hw_qtd_next */
 		/* else alt_next points to some other qtd */
 	}
-	scratch = le32_to_cpup (&qh->hw_info1);
-	hw_curr = (mark == '*') ? le32_to_cpup (&qh->hw_current) : 0;
+	scratch = ehci32_to_cpup (&qh->hw_info1);
+	hw_curr = (mark == '*') ? ehci32_to_cpup (&qh->hw_current) : 0;
 	temp = scnprintf (next, size,
 			"qh/%p dev%d %cs ep%d %08x %08x (%08x%c %s nak%d)",
 			qh, scratch & 0x007f,
 			speed_char (scratch),
 			(scratch >> 8) & 0x000f,
-			scratch, le32_to_cpup (&qh->hw_info2),
-			le32_to_cpup (&qh->hw_token), mark,
-			(__constant_cpu_to_le32 (QTD_TOGGLE) & qh->hw_token)
+			scratch, ehci32_to_cpup (&qh->hw_info2),
+			ehci32_to_cpup (&qh->hw_token), mark,
+			(__constant_cpu_to_ehci32 (QTD_TOGGLE) & qh->hw_token)
 				? "data1" : "data0",
-			(le32_to_cpup (&qh->hw_alt_next) >> 1) & 0x0f);
+			(ehci32_to_cpup (&qh->hw_alt_next) >> 1) & 0x0f);
 	size -= temp;
 	next += temp;
 
 	/* hc may be modifying the list as we read it ... */
 	list_for_each (entry, &qh->qtd_list) {
 		td = list_entry (entry, struct ehci_qtd, qtd_list);
-		scratch = le32_to_cpup (&td->hw_token);
+		scratch = ehci32_to_cpup (&td->hw_token);
 		mark = ' ';
 		if (hw_curr == td->qtd_dma)
 			mark = '*';
-		else if (qh->hw_qtd_next == cpu_to_le32(td->qtd_dma))
+		else if (qh->hw_qtd_next == cpu_to_ehci32(td->qtd_dma))
 			mark = '+';
 		else if (QTD_LENGTH (scratch)) {
 			if (td->hw_alt_next == ehci->async->hw_alt_next)
@@ -490,7 +492,7 @@ show_periodic (struct class_device *class_dev, char *buf)
 	unsigned		temp, size, seen_count;
 	char			*next;
 	unsigned		i;
-	__le32			tag;
+	__ehci32		tag;
 
 	if (!(seen = kmalloc (DBG_SCHED_LIMIT * sizeof *seen, GFP_ATOMIC)))
 		return 0;
@@ -525,7 +527,7 @@ show_periodic (struct class_device *class_dev, char *buf)
 			case Q_TYPE_QH:
 				temp = scnprintf (next, size, " qh%d-%04x/%p",
 						p.qh->period,
-						le32_to_cpup (&p.qh->hw_info2)
+						ehci32_to_cpup(&p.qh->hw_info2)
 							/* uframe masks */
 							& (QH_CMASK | QH_SMASK),
 						p.qh);
@@ -543,7 +545,7 @@ show_periodic (struct class_device *class_dev, char *buf)
 				}
 				/* show more info the first time around */
 				if (temp == seen_count && p.ptr) {
-					u32	scratch = le32_to_cpup (
+					u32	scratch = ehci32_to_cpup (
 							&p.qh->hw_info1);
 					struct ehci_qtd	*qtd;
 					char		*type = "";
@@ -554,7 +556,7 @@ show_periodic (struct class_device *class_dev, char *buf)
 							&p.qh->qtd_list,
 							qtd_list) {
 						temp++;
-						switch (0x03 & (le32_to_cpu (
+						switch (0x03 & (ehci32_to_cpu (
 							qtd->hw_token) >> 8)) {
 						case 0: type = "out"; continue;
 						case 1: type = "in"; continue;
@@ -597,7 +599,7 @@ show_periodic (struct class_device *class_dev, char *buf)
 				temp = scnprintf (next, size,
 					" sitd%d-%04x/%p",
 					p.sitd->stream->interval,
-					le32_to_cpup (&p.sitd->hw_uframe)
+					ehci32_to_cpup (&p.sitd->hw_uframe)
 						& 0x0000ffff,
 					p.sitd);
 				tag = Q_NEXT_TYPE (p.sitd->hw_next);
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index c7458f7..6fbf9d3 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -141,6 +141,12 @@ MODULE_PARM_DESC (ignore_oc, "ignore bogus hardware overcurrent indications");
 #include "ehci.h"
 #include "ehci-dbg.c"
 
+#ifdef CONFIG_USB_EHCI_HCD_PMC_MSP
+extern void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci);
+#else
+#define usb_hcd_tdi_set_mode(ehci)	do { } while (0)
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -206,6 +212,9 @@ static void tdi_reset (struct ehci_hcd *ehci)
 	tmp = ehci_readl(ehci, reg_ptr);
 	tmp |= 0x3;
 	ehci_writel(ehci, tmp, reg_ptr);
+
+	/* set controller to host mode */
+	usb_hcd_tdi_set_mode(ehci);
 }
 
 /* reset a non-running (STS_HALT == 1) controller */
@@ -472,8 +481,8 @@ static int ehci_init(struct usb_hcd *hcd)
 	 */
 	ehci->async->qh_next.qh = NULL;
 	ehci->async->hw_next = QH_NEXT(ehci->async->qh_dma);
-	ehci->async->hw_info1 = cpu_to_le32(QH_HEAD);
-	ehci->async->hw_token = cpu_to_le32(QTD_STS_HALT);
+	ehci->async->hw_info1 = cpu_to_ehci32(QH_HEAD);
+	ehci->async->hw_token = cpu_to_ehci32(QTD_STS_HALT);
 	ehci->async->hw_qtd_next = EHCI_LIST_END;
 	ehci->async->qh_state = QH_STATE_LINKED;
 	ehci->async->hw_alt_next = QTD_NEXT(ehci->async->dummy->qtd_dma);
@@ -936,6 +945,11 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
 #endif
 
+#ifdef CONFIG_USB_EHCI_HCD_PMC_MSP
+#include "ehci-pmcmsp.c"
+#define	PLATFORM_DRIVER		ehci_hcd_msp_driver
+#endif
+
 #ifdef CONFIG_PPC_PS3
 #include "ehci-ps3.c"
 #define	PS3_SYSTEM_BUS_DRIVER	ps3_ehci_sb_driver
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 1813b7c..0d57f62 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -552,9 +552,13 @@ static int ehci_hub_control (
 			status |= 1 << USB_PORT_FEAT_C_CONNECTION;
 		if (temp & PORT_PEC)
 			status |= 1 << USB_PORT_FEAT_C_ENABLE;
-		if ((temp & PORT_OCC) && !ignore_oc)
+		if ((temp & PORT_OCC) && !ignore_oc) {
 			status |= 1 << USB_PORT_FEAT_C_OVER_CURRENT;
 
+			if (temp & PORT_OC)
+				status |= 1 << USB_PORT_FEAT_OVER_CURRENT;
+		}
+
 		/* whoever resumes must GetPortStatus to complete it!! */
 		if (temp & PORT_RESUME) {
 
diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index a8ba2e1..1134b55 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -39,7 +39,7 @@ static inline void ehci_qtd_init (struct ehci_qtd *qtd, dma_addr_t dma)
 {
 	memset (qtd, 0, sizeof *qtd);
 	qtd->qtd_dma = dma;
-	qtd->hw_token = cpu_to_le32 (QTD_STS_HALT);
+	qtd->hw_token = cpu_to_ehci32 (QTD_STS_HALT);
 	qtd->hw_next = EHCI_LIST_END;
 	qtd->hw_alt_next = EHCI_LIST_END;
 	INIT_LIST_HEAD (&qtd->qtd_list);
@@ -209,9 +209,9 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 	}
 
 	/* Hardware periodic table */
-	ehci->periodic = (__le32 *)
+	ehci->periodic = (__ehci32 *)
 		dma_alloc_coherent (ehci_to_hcd(ehci)->self.controller,
-			ehci->periodic_size * sizeof(__le32),
+			ehci->periodic_size * sizeof(__ehci32),
 			&ehci->periodic_dma, 0);
 	if (ehci->periodic == NULL) {
 		goto fail;
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index e7fbbd0..b87344d 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -50,8 +50,8 @@ qtd_fill (struct ehci_qtd *qtd, dma_addr_t buf, size_t len,
 	u64	addr = buf;
 
 	/* one buffer entry per 4K ... first might be short or unaligned */
-	qtd->hw_buf [0] = cpu_to_le32 ((u32)addr);
-	qtd->hw_buf_hi [0] = cpu_to_le32 ((u32)(addr >> 32));
+	qtd->hw_buf [0] = cpu_to_ehci32 ((u32)addr);
+	qtd->hw_buf_hi [0] = cpu_to_ehci32 ((u32)(addr >> 32));
 	count = 0x1000 - (buf & 0x0fff);	/* rest of that page */
 	if (likely (len < count))		/* ... iff needed */
 		count = len;
@@ -62,8 +62,8 @@ qtd_fill (struct ehci_qtd *qtd, dma_addr_t buf, size_t len,
 		/* per-qtd limit: from 16K to 20K (best alignment) */
 		for (i = 1; count < len && i < 5; i++) {
 			addr = buf;
-			qtd->hw_buf [i] = cpu_to_le32 ((u32)addr);
-			qtd->hw_buf_hi [i] = cpu_to_le32 ((u32)(addr >> 32));
+			qtd->hw_buf [i] = cpu_to_ehci32 ((u32)addr);
+			qtd->hw_buf_hi [i] = cpu_to_ehci32 ((u32)(addr >> 32));
 			buf += 0x1000;
 			if ((count + 0x1000) < len)
 				count += 0x1000;
@@ -75,7 +75,7 @@ qtd_fill (struct ehci_qtd *qtd, dma_addr_t buf, size_t len,
 		if (count != len)
 			count -= (count % maxpacket);
 	}
-	qtd->hw_token = cpu_to_le32 ((count << 16) | token);
+	qtd->hw_token = cpu_to_ehci32 ((count << 16) | token);
 	qtd->length = count;
 
 	return count;
@@ -97,20 +97,20 @@ qh_update (struct ehci_hcd *ehci, struct ehci_qh *qh, struct ehci_qtd *qtd)
 	 * and set the pseudo-toggle in udev. Only usb_clear_halt() will
 	 * ever clear it.
 	 */
-	if (!(qh->hw_info1 & cpu_to_le32(1 << 14))) {
+	if (!(qh->hw_info1 & cpu_to_ehci32(1 << 14))) {
 		unsigned	is_out, epnum;
 
-		is_out = !(qtd->hw_token & cpu_to_le32(1 << 8));
-		epnum = (le32_to_cpup(&qh->hw_info1) >> 8) & 0x0f;
+		is_out = !(qtd->hw_token & cpu_to_ehci32(1 << 8));
+		epnum = (ehci32_to_cpup(&qh->hw_info1) >> 8) & 0x0f;
 		if (unlikely (!usb_gettoggle (qh->dev, epnum, is_out))) {
-			qh->hw_token &= ~__constant_cpu_to_le32 (QTD_TOGGLE);
+			qh->hw_token &= ~__constant_cpu_to_ehci32 (QTD_TOGGLE);
 			usb_settoggle (qh->dev, epnum, is_out, 1);
 		}
 	}
 
 	/* HC must see latest qtd and qh data before we clear ACTIVE+HALT */
 	wmb ();
-	qh->hw_token &= __constant_cpu_to_le32 (QTD_TOGGLE | QTD_STS_PING);
+	qh->hw_token &= __constant_cpu_to_ehci32 (QTD_TOGGLE | QTD_STS_PING);
 }
 
 /* if it weren't for a common silicon quirk (writing the dummy into the qh
@@ -128,7 +128,7 @@ qh_refresh (struct ehci_hcd *ehci, struct ehci_qh *qh)
 		qtd = list_entry (qh->qtd_list.next,
 				struct ehci_qtd, qtd_list);
 		/* first qtd may already be partially processed */
-		if (cpu_to_le32 (qtd->qtd_dma) == qh->hw_current)
+		if (cpu_to_ehci32 (qtd->qtd_dma) == qh->hw_current)
 			qtd = NULL;
 	}
 
@@ -222,7 +222,7 @@ __acquires(ehci->lock)
 		struct ehci_qh	*qh = (struct ehci_qh *) urb->hcpriv;
 
 		/* S-mask in a QH means it's an interrupt urb */
-		if ((qh->hw_info2 & __constant_cpu_to_le32 (QH_SMASK)) != 0) {
+		if ((qh->hw_info2 & __constant_cpu_to_ehci32 (QH_SMASK)) != 0) {
 
 			/* ... update hc-wide periodic stats (for usbfs) */
 			ehci_to_hcd(ehci)->self.bandwidth_int_reqs--;
@@ -277,7 +277,7 @@ static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh);
  * Chases up to qh->hw_current.  Returns number of completions called,
  * indicating how much "real" work we did.
  */
-#define HALT_BIT __constant_cpu_to_le32(QTD_STS_HALT)
+#define HALT_BIT __constant_cpu_to_ehci32(QTD_STS_HALT)
 static unsigned
 qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
@@ -330,7 +330,7 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 		/* hardware copies qtd out of qh overlay */
 		rmb ();
-		token = le32_to_cpu (qtd->hw_token);
+		token = ehci32_to_cpu (qtd->hw_token);
 
 		/* always clean up qtds the hc de-activated */
 		if ((token & QTD_STS_ACTIVE) == 0) {
@@ -374,9 +374,9 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 			/* token in overlay may be most current */
 			if (state == QH_STATE_IDLE
-					&& cpu_to_le32 (qtd->qtd_dma)
+					&& cpu_to_ehci32 (qtd->qtd_dma)
 						== qh->hw_current)
-				token = le32_to_cpu (qh->hw_token);
+				token = ehci32_to_cpu (qh->hw_token);
 
 			/* force halt for unlinked or blocked qh, so we'll
 			 * patch the qh later and so that completions can't
@@ -428,7 +428,7 @@ halt:
 			/* should be rare for periodic transfers,
 			 * except maybe high bandwidth ...
 			 */
-			if ((__constant_cpu_to_le32 (QH_SMASK)
+			if ((__constant_cpu_to_ehci32 (QH_SMASK)
 					& qh->hw_info2) != 0) {
 				intr_deschedule (ehci, qh);
 				(void) qh_schedule (ehci, qh);
@@ -600,7 +600,7 @@ qh_urb_transaction (
 
 	/* by default, enable interrupt on urb completion */
 	if (likely (!(urb->transfer_flags & URB_NO_INTERRUPT)))
-		qtd->hw_token |= __constant_cpu_to_le32 (QTD_IOC);
+		qtd->hw_token |= __constant_cpu_to_ehci32 (QTD_IOC);
 	return head;
 
 cleanup:
@@ -769,8 +769,8 @@ done:
 
 	/* init as live, toggle clear, advance to dummy */
 	qh->qh_state = QH_STATE_IDLE;
-	qh->hw_info1 = cpu_to_le32 (info1);
-	qh->hw_info2 = cpu_to_le32 (info2);
+	qh->hw_info1 = cpu_to_ehci32 (info1);
+	qh->hw_info2 = cpu_to_ehci32 (info2);
 	usb_settoggle (urb->dev, usb_pipeendpoint (urb->pipe), !is_input, 1);
 	qh_refresh (ehci, qh);
 	return qh;
@@ -782,7 +782,7 @@ done:
 
 static void qh_link_async (struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
-	__le32		dma = QH_NEXT (qh->qh_dma);
+	__ehci32	dma = QH_NEXT (qh->qh_dma);
 	struct ehci_qh	*head;
 
 	/* (re)start the async schedule? */
@@ -820,7 +820,7 @@ static void qh_link_async (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 /*-------------------------------------------------------------------------*/
 
-#define	QH_ADDR_MASK	__constant_cpu_to_le32(0x7f)
+#define	QH_ADDR_MASK	__constant_cpu_to_ehci32(0x7f)
 
 /*
  * For control/bulk/interrupt, return QH with these TDs appended.
@@ -867,7 +867,7 @@ static struct ehci_qh *qh_append_tds (
 		if (likely (qtd != NULL)) {
 			struct ehci_qtd		*dummy;
 			dma_addr_t		dma;
-			__le32			token;
+			__ehci32		token;
 
 			/* to avoid racing the HC, use the dummy td instead of
 			 * the first td of our list (becomes new dummy).  both
@@ -970,7 +970,7 @@ static void end_unlink_async (struct ehci_hcd *ehci)
 
 	timer_action_done (ehci, TIMER_IAA_WATCHDOG);
 
-	// qh->hw_next = cpu_to_le32 (qh->qh_dma);
+	/* qh->hw_next = cpu_to_ehci32 (qh->qh_dma); */
 	qh->qh_state = QH_STATE_IDLE;
 	qh->qh_next.qh = NULL;
 	qh_put (qh);			// refcount from reclaim
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 7b5ae71..6427de0 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -44,7 +44,7 @@ static int ehci_get_frame (struct usb_hcd *hcd);
  * @tag: hardware tag for type of this record
  */
 static union ehci_shadow *
-periodic_next_shadow (union ehci_shadow *periodic, __le32 tag)
+periodic_next_shadow (union ehci_shadow *periodic, __ehci32 tag)
 {
 	switch (tag) {
 	case Q_TYPE_QH:
@@ -63,7 +63,7 @@ periodic_next_shadow (union ehci_shadow *periodic, __le32 tag)
 static void periodic_unlink (struct ehci_hcd *ehci, unsigned frame, void *ptr)
 {
 	union ehci_shadow	*prev_p = &ehci->pshadow [frame];
-	__le32			*hw_p = &ehci->periodic [frame];
+	__ehci32		*hw_p = &ehci->periodic [frame];
 	union ehci_shadow	here = *prev_p;
 
 	/* find predecessor of "ptr"; hw and shadow lists are in sync */
@@ -87,7 +87,7 @@ static void periodic_unlink (struct ehci_hcd *ehci, unsigned frame, void *ptr)
 static unsigned short
 periodic_usecs (struct ehci_hcd *ehci, unsigned frame, unsigned uframe)
 {
-	__le32			*hw_p = &ehci->periodic [frame];
+	__ehci32		*hw_p = &ehci->periodic [frame];
 	union ehci_shadow	*q = &ehci->pshadow [frame];
 	unsigned		usecs = 0;
 
@@ -95,10 +95,11 @@ periodic_usecs (struct ehci_hcd *ehci, unsigned frame, unsigned uframe)
 		switch (Q_NEXT_TYPE (*hw_p)) {
 		case Q_TYPE_QH:
 			/* is it in the S-mask? */
-			if (q->qh->hw_info2 & cpu_to_le32 (1 << uframe))
+			if (q->qh->hw_info2 & cpu_to_ehci32 (1 << uframe))
 				usecs += q->qh->usecs;
 			/* ... or C-mask? */
-			if (q->qh->hw_info2 & cpu_to_le32 (1 << (8 + uframe)))
+			if (q->qh->hw_info2 &
+			    cpu_to_ehci32 (1 << (8 + uframe)))
 				usecs += q->qh->c_usecs;
 			hw_p = &q->qh->hw_next;
 			q = &q->qh->qh_next;
@@ -121,9 +122,10 @@ periodic_usecs (struct ehci_hcd *ehci, unsigned frame, unsigned uframe)
 			break;
 		case Q_TYPE_SITD:
 			/* is it in the S-mask?  (count SPLIT, DATA) */
-			if (q->sitd->hw_uframe & cpu_to_le32 (1 << uframe)) {
+			if (q->sitd->hw_uframe &
+			    cpu_to_ehci32 (1 << uframe)) {
 				if (q->sitd->hw_fullspeed_ep &
-						__constant_cpu_to_le32 (1<<31))
+				    __constant_cpu_to_ehci32 (1<<31))
 					usecs += q->sitd->stream->usecs;
 				else	/* worst case for OUT start-split */
 					usecs += HS_USECS_ISO (188);
@@ -131,7 +133,7 @@ periodic_usecs (struct ehci_hcd *ehci, unsigned frame, unsigned uframe)
 
 			/* ... C-mask?  (count CSPLIT, DATA) */
 			if (q->sitd->hw_uframe &
-					cpu_to_le32 (1 << (8 + uframe))) {
+					cpu_to_ehci32 (1 << (8 + uframe))) {
 				/* worst case for IN complete-split */
 				usecs += q->sitd->stream->c_usecs;
 			}
@@ -173,9 +175,10 @@ static int same_tt (struct usb_device *dev1, struct usb_device *dev2)
  * will cause a transfer in "B-frame" uframe 0.  "B-frames" lag
  * "H-frames" by 1 uframe.  See the EHCI spec sec 4.5 and figure 4.7.
  */
-static inline unsigned char tt_start_uframe(struct ehci_hcd *ehci, __le32 mask)
+static inline unsigned char tt_start_uframe(struct ehci_hcd *ehci,
+					    __ehci32 mask)
 {
-	unsigned char smask = QH_SMASK & le32_to_cpu(mask);
+	unsigned char smask = QH_SMASK & ehci32_to_cpu(mask);
 	if (!smask) {
 		ehci_err(ehci, "invalid empty smask!\n");
 		/* uframe 7 can't have bw so this will indicate failure */
@@ -217,7 +220,7 @@ periodic_tt_usecs (
 	unsigned short tt_usecs[8]
 )
 {
-	__le32			*hw_p = &ehci->periodic [frame];
+	__ehci32		*hw_p = &ehci->periodic [frame];
 	union ehci_shadow	*q = &ehci->pshadow [frame];
 	unsigned char		uf;
 
@@ -368,7 +371,7 @@ static int tt_no_collision (
 	 */
 	for (; frame < ehci->periodic_size; frame += period) {
 		union ehci_shadow	here;
-		__le32			type;
+		__ehci32		type;
 
 		here = ehci->pshadow [frame];
 		type = Q_NEXT_TYPE (ehci->periodic [frame]);
@@ -382,7 +385,8 @@ static int tt_no_collision (
 				if (same_tt (dev, here.qh->dev)) {
 					u32		mask;
 
-					mask = le32_to_cpu (here.qh->hw_info2);
+					mask = ehci32_to_cpu(
+							here.qh->hw_info2);
 					/* "knows" no gap is needed */
 					mask |= mask >> 8;
 					if (mask & uf_mask)
@@ -395,7 +399,7 @@ static int tt_no_collision (
 				if (same_tt (dev, here.sitd->urb->dev)) {
 					u16		mask;
 
-					mask = le32_to_cpu (here.sitd
+					mask = ehci32_to_cpu (here.sitd
 								->hw_uframe);
 					/* FIXME assumes no gap for IN! */
 					mask |= mask >> 8;
@@ -487,7 +491,7 @@ static int qh_link_periodic (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 	dev_dbg (&qh->dev->dev,
 		"link qh%d-%04x/%p start %d [%d/%d us]\n",
-		period, le32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
+		period, ehci32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
 		qh, qh->start, qh->usecs, qh->c_usecs);
 
 	/* high bandwidth, or otherwise every microframe */
@@ -496,9 +500,9 @@ static int qh_link_periodic (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 	for (i = qh->start; i < ehci->periodic_size; i += period) {
 		union ehci_shadow	*prev = &ehci->pshadow [i];
-		__le32			*hw_p = &ehci->periodic [i];
+		__ehci32		*hw_p = &ehci->periodic [i];
 		union ehci_shadow	here = *prev;
-		__le32			type = 0;
+		__ehci32		type = 0;
 
 		/* skip the iso nodes at list head */
 		while (here.ptr) {
@@ -555,7 +559,7 @@ static void qh_unlink_periodic (struct ehci_hcd *ehci, struct ehci_qh *qh)
 	//   and this qh is active in the current uframe
 	//   (and overlay token SplitXstate is false?)
 	// THEN
-	//   qh->hw_info1 |= __constant_cpu_to_le32 (1 << 7 /* "ignore" */);
+	//   qh->hw_info1 |= __constant_cpu_to_ehci32 (1 << 7 /* "ignore" */);
 
 	/* high bandwidth, or otherwise part of every microframe */
 	if ((period = qh->period) == 0)
@@ -572,7 +576,7 @@ static void qh_unlink_periodic (struct ehci_hcd *ehci, struct ehci_qh *qh)
 	dev_dbg (&qh->dev->dev,
 		"unlink qh%d-%04x/%p start %d [%d/%d us]\n",
 		qh->period,
-		le32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
+		ehci32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
 		qh, qh->start, qh->usecs, qh->c_usecs);
 
 	/* qh->qh_next still "live" to HC */
@@ -598,7 +602,7 @@ static void intr_deschedule (struct ehci_hcd *ehci, struct ehci_qh *qh)
 	 * active high speed queues may need bigger delays...
 	 */
 	if (list_empty (&qh->qtd_list)
-			|| (__constant_cpu_to_le32 (QH_CMASK)
+			|| (__constant_cpu_to_ehci32 (QH_CMASK)
 					& qh->hw_info2) != 0)
 		wait = 2;
 	else
@@ -663,7 +667,7 @@ static int check_intr_schedule (
 	unsigned		frame,
 	unsigned		uframe,
 	const struct ehci_qh	*qh,
-	__le32			*c_maskp
+	__ehci32		*c_maskp
 )
 {
 	int		retval = -ENOSPC;
@@ -695,7 +699,7 @@ static int check_intr_schedule (
 
 		retval = 0;
 
-		*c_maskp = cpu_to_le32 (mask << 8);
+		*c_maskp = cpu_to_ehci32 (mask << 8);
 	}
 #else
 	/* Make sure this tt's buffer is also available for CSPLITs.
@@ -706,7 +710,7 @@ static int check_intr_schedule (
 	 * one smart pass...
 	 */
 	mask = 0x03 << (uframe + qh->gap_uf);
-	*c_maskp = cpu_to_le32 (mask << 8);
+	*c_maskp = cpu_to_ehci32 (mask << 8);
 
 	mask |= 1 << uframe;
 	if (tt_no_collision (ehci, qh->period, qh->dev, frame, mask)) {
@@ -730,7 +734,7 @@ static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
 	int		status;
 	unsigned	uframe;
-	__le32		c_mask;
+	__ehci32	c_mask;
 	unsigned	frame;		/* 0..(qh->period - 1), or NO_FRAME */
 
 	qh_refresh(ehci, qh);
@@ -739,7 +743,7 @@ static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 	/* reuse the previous schedule slots, if we can */
 	if (frame < qh->period) {
-		uframe = ffs (le32_to_cpup (&qh->hw_info2) & QH_SMASK);
+		uframe = ffs (ehci32_to_cpup (&qh->hw_info2) & QH_SMASK);
 		status = check_intr_schedule (ehci, frame, --uframe,
 				qh, &c_mask);
 	} else {
@@ -775,10 +779,11 @@ static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh)
 		qh->start = frame;
 
 		/* reset S-frame and (maybe) C-frame masks */
-		qh->hw_info2 &= __constant_cpu_to_le32(~(QH_CMASK | QH_SMASK));
+		qh->hw_info2 &= __constant_cpu_to_ehci32(
+					~(QH_CMASK | QH_SMASK));
 		qh->hw_info2 |= qh->period
-			? cpu_to_le32 (1 << uframe)
-			: __constant_cpu_to_le32 (QH_SMASK);
+			? cpu_to_ehci32 (1 << uframe)
+			: __constant_cpu_to_ehci32 (QH_SMASK);
 		qh->hw_info2 |= c_mask;
 	} else
 		ehci_dbg (ehci, "reused qh %p schedule\n", qh);
@@ -898,9 +903,9 @@ iso_stream_init (
 		buf1 |= maxp;
 		maxp *= multi;
 
-		stream->buf0 = cpu_to_le32 ((epnum << 8) | dev->devnum);
-		stream->buf1 = cpu_to_le32 (buf1);
-		stream->buf2 = cpu_to_le32 (multi);
+		stream->buf0 = cpu_to_ehci32 ((epnum << 8) | dev->devnum);
+		stream->buf1 = cpu_to_ehci32 (buf1);
+		stream->buf2 = cpu_to_ehci32 (multi);
 
 		/* usbfs wants to report the average usecs per frame tied up
 		 * when transfers on this endpoint are scheduled ...
@@ -943,7 +948,7 @@ iso_stream_init (
 		bandwidth /= 1 << (interval + 2);
 
 		/* stream->splits gets created from raw_mask later */
-		stream->address = cpu_to_le32 (addr);
+		stream->address = cpu_to_ehci32 (addr);
 	}
 	stream->bandwidth = bandwidth;
 
@@ -1107,7 +1112,7 @@ itd_sched_init (
 				&& !(urb->transfer_flags & URB_NO_INTERRUPT))
 			trans |= EHCI_ITD_IOC;
 		trans |= length << 16;
-		uframe->transaction = cpu_to_le32 (trans);
+		uframe->transaction = cpu_to_ehci32 (trans);
 
 		/* might need to cross a buffer page within a uframe */
 		uframe->bufp = (buf & ~(u64)0x0fff);
@@ -1294,7 +1299,7 @@ sitd_slot_ok (
 		uframe += period_uframes;
 	} while (uframe < mod);
 
-	stream->splits = cpu_to_le32(stream->raw_mask << (uframe & 7));
+	stream->splits = cpu_to_ehci32(stream->raw_mask << (uframe & 7));
 	return 1;
 }
 
@@ -1448,16 +1453,16 @@ itd_patch (
 	itd->index [uframe] = index;
 
 	itd->hw_transaction [uframe] = uf->transaction;
-	itd->hw_transaction [uframe] |= cpu_to_le32 (pg << 12);
-	itd->hw_bufp [pg] |= cpu_to_le32 (uf->bufp & ~(u32)0);
-	itd->hw_bufp_hi [pg] |= cpu_to_le32 ((u32)(uf->bufp >> 32));
+	itd->hw_transaction [uframe] |= cpu_to_ehci32 (pg << 12);
+	itd->hw_bufp [pg] |= cpu_to_ehci32 (uf->bufp & ~(u32)0);
+	itd->hw_bufp_hi [pg] |= cpu_to_ehci32 ((u32)(uf->bufp >> 32));
 
 	/* iso_frame_desc[].offset must be strictly increasing */
 	if (unlikely (uf->cross)) {
 		u64	bufp = uf->bufp + 4096;
 		itd->pg = ++pg;
-		itd->hw_bufp [pg] |= cpu_to_le32 (bufp & ~(u32)0);
-		itd->hw_bufp_hi [pg] |= cpu_to_le32 ((u32)(bufp >> 32));
+		itd->hw_bufp [pg] |= cpu_to_ehci32 (bufp & ~(u32)0);
+		itd->hw_bufp_hi [pg] |= cpu_to_ehci32 ((u32)(bufp >> 32));
 	}
 }
 
@@ -1470,7 +1475,7 @@ itd_link (struct ehci_hcd *ehci, unsigned frame, struct ehci_itd *itd)
 	ehci->pshadow [frame].itd = itd;
 	itd->frame = frame;
 	wmb ();
-	ehci->periodic [frame] = cpu_to_le32 (itd->itd_dma) | Q_TYPE_ITD;
+	ehci->periodic [frame] = cpu_to_ehci32 (itd->itd_dma) | Q_TYPE_ITD;
 }
 
 /* fit urb's itds into the selected schedule slot; activate as needed */
@@ -1570,7 +1575,7 @@ itd_complete (
 		urb_index = itd->index[uframe];
 		desc = &urb->iso_frame_desc [urb_index];
 
-		t = le32_to_cpup (&itd->hw_transaction [uframe]);
+		t = ehci32_to_cpup (&itd->hw_transaction [uframe]);
 		itd->hw_transaction [uframe] = 0;
 		stream->depth -= stream->interval;
 
@@ -1729,7 +1734,7 @@ sitd_sched_init (
 				&& !(urb->transfer_flags & URB_NO_INTERRUPT))
 			trans |= SITD_IOC;
 		trans |= length << 16;
-		packet->transaction = cpu_to_le32 (trans);
+		packet->transaction = cpu_to_ehci32 (trans);
 
 		/* might need to cross a buffer page within a td */
 		packet->bufp = buf;
@@ -1834,13 +1839,13 @@ sitd_patch (
 	sitd->hw_backpointer = EHCI_LIST_END;
 
 	bufp = uf->bufp;
-	sitd->hw_buf [0] = cpu_to_le32 (bufp);
-	sitd->hw_buf_hi [0] = cpu_to_le32 (bufp >> 32);
+	sitd->hw_buf [0] = cpu_to_ehci32 (bufp);
+	sitd->hw_buf_hi [0] = cpu_to_ehci32 (bufp >> 32);
 
-	sitd->hw_buf [1] = cpu_to_le32 (uf->buf1);
+	sitd->hw_buf [1] = cpu_to_ehci32 (uf->buf1);
 	if (uf->cross)
 		bufp += 4096;
-	sitd->hw_buf_hi [1] = cpu_to_le32 (bufp >> 32);
+	sitd->hw_buf_hi [1] = cpu_to_ehci32 (bufp >> 32);
 	sitd->index = index;
 }
 
@@ -1853,7 +1858,7 @@ sitd_link (struct ehci_hcd *ehci, unsigned frame, struct ehci_sitd *sitd)
 	ehci->pshadow [frame].sitd = sitd;
 	sitd->frame = frame;
 	wmb ();
-	ehci->periodic [frame] = cpu_to_le32 (sitd->sitd_dma) | Q_TYPE_SITD;
+	ehci->periodic [frame] = cpu_to_ehci32 (sitd->sitd_dma) | Q_TYPE_SITD;
 }
 
 /* fit urb's sitds into the selected schedule slot; activate as needed */
@@ -1881,7 +1886,7 @@ sitd_link_urb (
 			urb->dev->devpath, stream->bEndpointAddress & 0x0f,
 			(stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out",
 			(next_uframe >> 3) % ehci->periodic_size,
-			stream->interval, le32_to_cpu (stream->splits));
+			stream->interval, ehci32_to_cpu (stream->splits));
 		stream->start = jiffies;
 	}
 	ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs++;
@@ -1940,7 +1945,7 @@ sitd_complete (
 
 	urb_index = sitd->index;
 	desc = &urb->iso_frame_desc [urb_index];
-	t = le32_to_cpup (&sitd->hw_results);
+	t = ehci32_to_cpup (&sitd->hw_results);
 
 	/* report transfer status */
 	if (t & SITD_ERRS) {
@@ -2095,7 +2100,7 @@ scan_periodic (struct ehci_hcd *ehci)
 
 	for (;;) {
 		union ehci_shadow	q, *q_p;
-		__le32			type, *hw_p;
+		__ehci32		type, *hw_p;
 		unsigned		uframes;
 
 		/* don't scan past the live uframe */
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 46fa57a..b5de2cf 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -21,6 +21,99 @@
 
 /* definitions used for the EHCI driver */
 
+/*
+ * __ehci32 and __ehci16 are "EHCI Host Controller" types, they may be
+ * equivalent to __leXX (normally) or __beXX (given EHCI_BIG_ENDIAN),
+ * depending on the host controller implementation.
+ */
+typedef __u32 __bitwise __ehci32;
+typedef __u16 __bitwise __ehci16;
+
+/* cpu to ehci */
+static inline __ehci16 cpu_to_ehci16 (const u16 x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return (__force __ehci16)cpu_to_be16(x);
+#else
+	return (__force __ehci16)cpu_to_le16(x);
+#endif
+}
+
+static inline __ehci16 cpu_to_ehci16p (const u16 *x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return cpu_to_be16p(x);
+#else
+	return cpu_to_le16p(x);
+#endif
+}
+
+static inline __ehci32 cpu_to_ehci32 (const u32 x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return (__force __ehci32)cpu_to_be32(x);
+#else
+	return (__force __ehci32)cpu_to_le32(x);
+#endif
+}
+
+static inline __ehci32 cpu_to_ehci32p (const u32 *x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return cpu_to_be32p(x);
+#else
+	return cpu_to_le32p(x);
+#endif
+}
+
+/* ehci to cpu */
+static inline u16 ehci16_to_cpu (const __ehci16 x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return be16_to_cpu((__force __be16)x);
+#else
+	return le16_to_cpu((__force __le16)x);
+#endif
+}
+
+static inline u16 ehci16_to_cpup (const __ehci16 *x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return be16_to_cpup((__force __be16 *)x);
+#else
+	return le16_to_cpup((__force __le16 *)x);
+#endif
+}
+
+static inline u32 ehci32_to_cpu (const __ehci32 x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return be32_to_cpu((__force __be32)x);
+#else
+	return le32_to_cpu((__force __le32)x);
+#endif
+}
+
+static inline u32 ehci32_to_cpup (const __ehci32 *x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return be32_to_cpup((__force __be32 *)x);
+#else
+	return le32_to_cpup((__force __le32 *)x);
+#endif
+}
+
+static inline u32 __constant_cpu_to_ehci32(const __ehci32 x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return __constant_cpu_to_be32((__force __be32)x);
+#else
+	return __constant_cpu_to_le32((__force __le32 )x);
+#endif
+}
+
+/*-------------------------------------------------------------------------*/
+
 /* statistics can be kept for for tuning/monitoring */
 struct ehci_stats {
 	/* irq usage */
@@ -64,7 +157,7 @@ struct ehci_hcd {			/* one per controller */
 	/* periodic schedule support */
 #define	DEFAULT_I_TDPS		1024		/* some HCs can do less */
 	unsigned		periodic_size;
-	__le32			*periodic;	/* hw periodic table */
+	__ehci32		*periodic;	/* hw periodic table */
 	dma_addr_t		periodic_dma;
 	unsigned		i_thresh;	/* uframes HC might cache */
 
@@ -303,7 +396,7 @@ struct ehci_dbg_port {
 
 /*-------------------------------------------------------------------------*/
 
-#define	QTD_NEXT(dma)	cpu_to_le32((u32)dma)
+#define	QTD_NEXT(dma)	cpu_to_ehci32((u32)dma)
 
 /*
  * EHCI Specification 0.95 Section 3.5
@@ -315,9 +408,9 @@ struct ehci_dbg_port {
  */
 struct ehci_qtd {
 	/* first part defined by EHCI spec */
-	__le32			hw_next;	  /* see EHCI 3.5.1 */
-	__le32			hw_alt_next;      /* see EHCI 3.5.2 */
-	__le32			hw_token;         /* see EHCI 3.5.3 */
+	__ehci32		hw_next;	  /* see EHCI 3.5.1 */
+	__ehci32		hw_alt_next;	  /* see EHCI 3.5.2 */
+	__ehci32		hw_token;	  /* see EHCI 3.5.3 */
 #define	QTD_TOGGLE	(1 << 31)	/* data toggle */
 #define	QTD_LENGTH(tok)	(((tok)>>16) & 0x7fff)
 #define	QTD_IOC		(1 << 15)	/* interrupt on complete */
@@ -331,8 +424,8 @@ struct ehci_qtd {
 #define	QTD_STS_MMF	(1 << 2)	/* incomplete split transaction */
 #define	QTD_STS_STS	(1 << 1)	/* split transaction state */
 #define	QTD_STS_PING	(1 << 0)	/* issue PING? */
-	__le32			hw_buf [5];        /* see EHCI 3.5.4 */
-	__le32			hw_buf_hi [5];        /* Appendix B */
+	__ehci32		hw_buf [5];        /* see EHCI 3.5.4 */
+	__ehci32		hw_buf_hi [5];        /* Appendix B */
 
 	/* the rest is HCD-private */
 	dma_addr_t		qtd_dma;		/* qtd address */
@@ -342,26 +435,45 @@ struct ehci_qtd {
 } __attribute__ ((aligned (32)));
 
 /* mask NakCnt+T in qh->hw_alt_next */
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define QTD_MASK __constant_cpu_to_be32 (~0x1f)
+#else
 #define QTD_MASK __constant_cpu_to_le32 (~0x1f)
+#endif
 
 #define IS_SHORT_READ(token) (QTD_LENGTH (token) != 0 && QTD_PID (token) == 1)
 
 /*-------------------------------------------------------------------------*/
 
 /* type tag from {qh,itd,sitd,fstn}->hw_next */
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define Q_NEXT_TYPE(dma) ((dma) & __constant_cpu_to_be32 (3 << 1))
+#else
 #define Q_NEXT_TYPE(dma) ((dma) & __constant_cpu_to_le32 (3 << 1))
+#endif
 
 /* values for that type tag */
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define Q_TYPE_ITD	__constant_cpu_to_be32 (0 << 1)
+#define Q_TYPE_QH	__constant_cpu_to_be32 (1 << 1)
+#define Q_TYPE_SITD	__constant_cpu_to_be32 (2 << 1)
+#define Q_TYPE_FSTN	__constant_cpu_to_be32 (3 << 1)
+#else
 #define Q_TYPE_ITD	__constant_cpu_to_le32 (0 << 1)
 #define Q_TYPE_QH	__constant_cpu_to_le32 (1 << 1)
 #define Q_TYPE_SITD	__constant_cpu_to_le32 (2 << 1)
 #define Q_TYPE_FSTN	__constant_cpu_to_le32 (3 << 1)
+#endif
 
 /* next async queue entry, or pointer to interrupt/periodic QH */
-#define	QH_NEXT(dma)	(cpu_to_le32(((u32)dma)&~0x01f)|Q_TYPE_QH)
+#define	QH_NEXT(dma)	(cpu_to_ehci32(((u32)dma)&~0x01f)|Q_TYPE_QH)
 
 /* for periodic/async schedules and qtd lists, mark end of list */
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define	EHCI_LIST_END	__constant_cpu_to_be32(1) /* "null pointer" to hw */
+#else
 #define	EHCI_LIST_END	__constant_cpu_to_le32(1) /* "null pointer" to hw */
+#endif
 
 /*
  * Entries in periodic shadow table are pointers to one of four kinds
@@ -376,7 +488,7 @@ union ehci_shadow {
 	struct ehci_itd		*itd;		/* Q_TYPE_ITD */
 	struct ehci_sitd	*sitd;		/* Q_TYPE_SITD */
 	struct ehci_fstn	*fstn;		/* Q_TYPE_FSTN */
-	__le32			*hw_next;	/* (all types) */
+	__ehci32		*hw_next;	/* (all types) */
 	void			*ptr;
 };
 
@@ -392,23 +504,23 @@ union ehci_shadow {
 
 struct ehci_qh {
 	/* first part defined by EHCI spec */
-	__le32			hw_next;	 /* see EHCI 3.6.1 */
-	__le32			hw_info1;        /* see EHCI 3.6.2 */
+	__ehci32		hw_next;	 /* see EHCI 3.6.1 */
+	__ehci32		hw_info1;	 /* see EHCI 3.6.2 */
 #define	QH_HEAD		0x00008000
-	__le32			hw_info2;        /* see EHCI 3.6.2 */
+	__ehci32		hw_info2;	 /* see EHCI 3.6.2 */
 #define	QH_SMASK	0x000000ff
 #define	QH_CMASK	0x0000ff00
 #define	QH_HUBADDR	0x007f0000
 #define	QH_HUBPORT	0x3f800000
 #define	QH_MULT		0xc0000000
-	__le32			hw_current;	 /* qtd list - see EHCI 3.6.4 */
+	__ehci32		hw_current;	 /* qtd list - see EHCI 3.6.4 */
 
 	/* qtd overlay (hardware parts of a struct ehci_qtd) */
-	__le32			hw_qtd_next;
-	__le32			hw_alt_next;
-	__le32			hw_token;
-	__le32			hw_buf [5];
-	__le32			hw_buf_hi [5];
+	__ehci32		hw_qtd_next;
+	__ehci32		hw_alt_next;
+	__ehci32		hw_token;
+	__ehci32		hw_buf [5];
+	__ehci32		hw_buf_hi [5];
 
 	/* the rest is HCD-private */
 	dma_addr_t		qh_dma;		/* address of qh */
@@ -445,7 +557,7 @@ struct ehci_qh {
 struct ehci_iso_packet {
 	/* These will be copied to iTD when scheduling */
 	u64			bufp;		/* itd->hw_bufp{,_hi}[pg] |= */
-	__le32			transaction;	/* itd->hw_transaction[i] |= */
+	__ehci32		transaction;	/* itd->hw_transaction[i] |= */
 	u8			cross;		/* buf crosses pages */
 	/* for full speed OUT splits */
 	u32			buf1;
@@ -467,8 +579,8 @@ struct ehci_iso_sched {
  */
 struct ehci_iso_stream {
 	/* first two fields match QH, but info1 == 0 */
-	__le32			hw_next;
-	__le32			hw_info1;
+	__ehci32		hw_next;
+	__ehci32		hw_info1;
 
 	u32			refcount;
 	u8			bEndpointAddress;
@@ -483,7 +595,7 @@ struct ehci_iso_stream {
 	unsigned long		start;		/* jiffies */
 	unsigned long		rescheduled;
 	int			next_uframe;
-	__le32			splits;
+	__ehci32		splits;
 
 	/* the rest is derived from the endpoint descriptor,
 	 * trusting urb->interval == f(epdesc->bInterval) and
@@ -497,12 +609,12 @@ struct ehci_iso_stream {
 	unsigned		bandwidth;
 
 	/* This is used to initialize iTD's hw_bufp fields */
-	__le32			buf0;
-	__le32			buf1;
-	__le32			buf2;
+	__ehci32		buf0;
+	__ehci32		buf1;
+	__ehci32		buf2;
 
 	/* this is used to initialize sITD's tt info */
-	__le32			address;
+	__ehci32		address;
 };
 
 /*-------------------------------------------------------------------------*/
@@ -515,8 +627,8 @@ struct ehci_iso_stream {
  */
 struct ehci_itd {
 	/* first part defined by EHCI spec */
-	__le32			hw_next;           /* see EHCI 3.3.1 */
-	__le32			hw_transaction [8]; /* see EHCI 3.3.2 */
+	__ehci32		hw_next;       /* see EHCI 3.3.1 */
+	__ehci32		hw_transaction [8]; /* see EHCI 3.3.2 */
 #define EHCI_ISOC_ACTIVE        (1<<31)        /* activate transfer this slot */
 #define EHCI_ISOC_BUF_ERR       (1<<30)        /* Data buffer error */
 #define EHCI_ISOC_BABBLE        (1<<29)        /* babble detected */
@@ -524,10 +636,14 @@ struct ehci_itd {
 #define	EHCI_ITD_LENGTH(tok)	(((tok)>>16) & 0x0fff)
 #define	EHCI_ITD_IOC		(1 << 15)	/* interrupt on complete */
 
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define ITD_ACTIVE	__constant_cpu_to_be32(EHCI_ISOC_ACTIVE)
+#else
 #define ITD_ACTIVE	__constant_cpu_to_le32(EHCI_ISOC_ACTIVE)
+#endif
 
-	__le32			hw_bufp [7];	/* see EHCI 3.3.3 */
-	__le32			hw_bufp_hi [7];	/* Appendix B */
+	__ehci32		hw_bufp [7];	/* see EHCI 3.3.3 */
+	__ehci32		hw_bufp_hi [7];	/* Appendix B */
 
 	/* the rest is HCD-private */
 	dma_addr_t		itd_dma;	/* for this itd */
@@ -554,11 +670,11 @@ struct ehci_itd {
  */
 struct ehci_sitd {
 	/* first part defined by EHCI spec */
-	__le32			hw_next;
+	__ehci32		hw_next;
 /* uses bit field macros above - see EHCI 0.95 Table 3-8 */
-	__le32			hw_fullspeed_ep;	/* EHCI table 3-9 */
-	__le32			hw_uframe;		/* EHCI table 3-10 */
-	__le32			hw_results;		/* EHCI table 3-11 */
+	__ehci32		hw_fullspeed_ep;	/* EHCI table 3-9 */
+	__ehci32		hw_uframe;		/* EHCI table 3-10 */
+	__ehci32		hw_results;		/* EHCI table 3-11 */
 #define	SITD_IOC	(1 << 31)	/* interrupt on completion */
 #define	SITD_PAGE	(1 << 30)	/* buffer 0/1 */
 #define	SITD_LENGTH(x)	(0x3ff & ((x)>>16))
@@ -570,11 +686,15 @@ struct ehci_sitd {
 #define	SITD_STS_MMF	(1 << 2)	/* incomplete split transaction */
 #define	SITD_STS_STS	(1 << 1)	/* split transaction state */
 
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define SITD_ACTIVE	__constant_cpu_to_be32(SITD_STS_ACTIVE)
+#else
 #define SITD_ACTIVE	__constant_cpu_to_le32(SITD_STS_ACTIVE)
+#endif
 
-	__le32			hw_buf [2];		/* EHCI table 3-12 */
-	__le32			hw_backpointer;		/* EHCI table 3-13 */
-	__le32			hw_buf_hi [2];		/* Appendix B */
+	__ehci32		hw_buf [2];		/* EHCI table 3-12 */
+	__ehci32		hw_backpointer;		/* EHCI table 3-13 */
+	__ehci32		hw_buf_hi [2];		/* Appendix B */
 
 	/* the rest is HCD-private */
 	dma_addr_t		sitd_dma;
@@ -599,8 +719,8 @@ struct ehci_sitd {
  * it hits a "restore" FSTN; then it returns to finish other uframe 0/1 work.
  */
 struct ehci_fstn {
-	__le32			hw_next;	/* any periodic q entry */
-	__le32			hw_prev;	/* qh or EHCI_LIST_END */
+	__ehci32		hw_next;	/* any periodic q entry */
+	__ehci32		hw_prev;	/* qh or EHCI_LIST_END */
 
 	/* the rest is HCD-private */
 	dma_addr_t		fstn_dma;
@@ -672,6 +792,12 @@ ehci_port_speed(struct ehci_hcd *ehci, unsigned int portsc)
 #define ehci_big_endian_mmio(e)		0
 #endif
 
+#if defined(CONFIG_USB_EHCI_BIG_ENDIAN) && \
+    defined(CONFIG_USB_EHCI_BIG_ENDIAN_MMIO)
+#define readl_be(addr)			__raw_readl((addr))
+#define writel_be(val, addr)		__raw_writel((val), (addr))
+#endif
+
 static inline unsigned int ehci_readl (const struct ehci_hcd *ehci,
 				       __u32 __iomem * regs)
 {
diff --git a/drivers/usb/host/ehci-pmcmsp.c b/drivers/usb/host/ehci-pmcmsp.c
new file mode 100644
index 0000000..18aa74d
--- /dev/null
+++ b/drivers/usb/host/ehci-pmcmsp.c
@@ -0,0 +1,434 @@
+/*
+ * PMC MSP EHCI (Host Controller Driver) for USB.
+ *
+ * (C) Copyright 2006-2007 PMC-Sierra Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/platform_device.h>
+
+#ifdef CONFIG_PMCTWILED
+#include "msp_led_macros.h"
+#endif
+
+/* includes */
+#define USB_CTRL_MODE_HOST		0x3	   /* host mode */
+#define USB_CTRL_MODE_BIG_ENDIAN	0x4	   /* big endian */
+#define USB_CTRL_MODE_STREAM_DISABLE	0x10	   /* stream disable*/
+#define USB_CTRL_FIFO_THRESH		0x00300000 /* thresh hold */
+#define USB_EHCI_REG_USB_MODE		0x68	   /* reg offset usb mode */
+#define USB_EHCI_REG_USB_FIFO		0x24	   /* reg offset usb fifo */
+#define USB_EHCI_REG_USB_STATUS		0x44	   /* reg offset usb status*/
+#define USB_EHCI_REG_BIT_STAT_STS	(1<<29)	   /* serial/parallel xcvr */
+
+extern int usb_disabled(void);
+extern void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci);
+
+void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci)
+{
+	u8 *base;
+	u8 *statreg;
+	u8 *fiforeg;
+	u32 val;
+
+	/* get register base */
+	base = (u8 *)ehci->regs + USB_EHCI_REG_USB_MODE;
+	statreg = (u8 *)ehci->regs + USB_EHCI_REG_USB_STATUS;
+	fiforeg = (u8 *)ehci->regs + USB_EHCI_REG_USB_FIFO;
+
+	/* set the controller to host mode and BIG ENDIAN */
+	ehci_writel(ehci, (USB_CTRL_MODE_HOST | USB_CTRL_MODE_BIG_ENDIAN |
+			USB_CTRL_MODE_STREAM_DISABLE), (u32 *)base);
+
+	/* clear STS to select parallel transceiver interface */
+	val = ehci_readl(ehci, (u32 *)statreg);
+	val = val & ~USB_EHCI_REG_BIT_STAT_STS;
+	ehci_writel(ehci, val, (u32 *)statreg);
+
+	/* write to set the proper fifo threshold */
+	ehci_writel(ehci, USB_CTRL_FIFO_THRESH, (u32 *)fiforeg);
+
+#ifdef CONFIG_PMCTWILED
+	/* set TWI GPIO USB_HOST_DEV pin to active high */
+	msp_led_pin_hi(MSP_PIN_USB_HOST_DEV);
+#endif
+}
+
+/* called after powerup, by probe or system-pm "wakeup" */
+static int ehci_msp_reinit(struct ehci_hcd *ehci)
+{
+	ehci_port_power(ehci, 0);
+
+	return 0;
+}
+
+/* called during probe() after chip reset completes */
+static int ehci_msp_setup(struct usb_hcd *hcd)
+{
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	u32		temp;
+	int		retval;
+
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN_MMIO
+	ehci->big_endian_mmio = 1;
+#endif
+
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs + HC_LENGTH(
+			ehci_readl(ehci, &ehci->caps->hc_capbase));
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+
+	ehci->is_tdi_rh_tt = 1;
+	tdi_reset(ehci);
+
+	ehci_reset(ehci);
+
+	retval = ehci_halt(ehci);
+	if (retval)
+		return retval;
+
+	/* data structure init */
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
+	temp = HCS_N_CC(ehci->hcs_params) * HCS_N_PCC(ehci->hcs_params);
+	temp &= 0x0f;
+	if (temp && HCS_N_PORTS(ehci->hcs_params) > temp) {
+		ehci_dbg(ehci, "bogus port configuration: "
+			"cc=%d x pcc=%d < ports=%d\n",
+			HCS_N_CC(ehci->hcs_params),
+			HCS_N_PCC(ehci->hcs_params),
+			HCS_N_PORTS(ehci->hcs_params));
+	}
+
+	retval = ehci_msp_reinit(ehci);
+
+	return retval;
+}
+
+/*-------------------------------------------------------------------------*/
+
+#ifdef	CONFIG_PM
+/* suspend/resume, section 4.3 */
+
+/*
+ * These routines rely on the bus glue
+ * to handle powerdown and wakeup, and currently also on
+ * transceivers that don't need any software attention to set up
+ * the right sort of wakeup.
+ * Also they depend on separate root hub suspend/resume.
+ */
+
+static int ehci_msp_suspend(struct usb_hcd *hcd, pm_message_t message)
+{
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	unsigned long	flags;
+	int		rc = 0;
+
+	if (time_before(jiffies, ehci->next_statechange))
+		msleep(10);
+
+	/*
+	 * Root hub was already suspended. Disable irq emission and
+	 * mark HW unaccessible, bail out if RH has been resumed. Use
+	 * the spinlock to properly synchronize with possible pending
+	 * RH suspend or resume activity.
+	 *
+	 * This is still racy as hcd->state is manipulated outside of
+	 * any locks =P But that will be a different fix.
+	 */
+	spin_lock_irqsave(&ehci->lock, flags);
+	if (hcd->state != HC_STATE_SUSPENDED) {
+		rc = -EINVAL;
+		goto bail;
+	}
+	ehci_writel(ehci, 0, &ehci->regs->intr_enable);
+	(void)ehci_readl(ehci, &ehci->regs->intr_enable);
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
+ bail:
+	spin_unlock_irqrestore(&ehci->lock, flags);
+
+	/*
+	 * could save FLADJ in case of Vaux power loss
+	 * ... we'd only use it to handle clock skew
+	 */
+	return rc;
+}
+
+static int ehci_msp_resume(struct usb_hcd *hcd)
+{
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
+	unsigned		port;
+	struct usb_device	*root = hcd->self.root_hub;
+	int			retval = -EINVAL;
+
+	/* maybe restore FLADJ */
+
+	if (time_before(jiffies, ehci->next_statechange))
+		msleep(100);
+
+	/* Mark hardware accessible again as we are out of D3 state by now */
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
+	/* If CF is clear, we lost PCI Vaux power and need to restart. */
+	if (ehci_readl(ehci, &ehci->regs->configured_flag) != FLAG_CF)
+		goto restart;
+
+	/*
+	 * If any port is suspended (or owned by the companion),
+	 * we know we can/must resume the HC (and mustn't reset it).
+	 * We just defer that to the root hub code.
+	 */
+	for (port = HCS_N_PORTS(ehci->hcs_params); port > 0; ) {
+		u32	status;
+		port--;
+		status = ehci_readl(ehci, &ehci->regs->port_status [port]);
+		if (!(status & PORT_POWER))
+			continue;
+		if (status & (PORT_SUSPEND | PORT_RESUME | PORT_OWNER)) {
+			usb_hcd_resume_root_hub(hcd);
+			return 0;
+		}
+	}
+
+restart:
+	ehci_dbg(ehci, "lost power, restarting\n");
+	for (port = HCS_N_PORTS(ehci->hcs_params); port > 0; ) {
+		port--;
+		if (!root->children [port])
+			continue;
+		usb_set_device_state(root->children[port],
+					USB_STATE_NOTATTACHED);
+	}
+
+	/*
+	 * Else reset, to cope with power loss or flush-to-storage
+	 * style "resume" having let BIOS kick in during reboot.
+	 */
+	(void) ehci_halt(ehci);
+	(void) ehci_reset(ehci);
+	(void) ehci_msp_reinit(ehci, pdev);
+
+	/* emptying the schedule aborts any urbs */
+	spin_lock_irq(&ehci->lock);
+	if (ehci->reclaim)
+		ehci->reclaim_ready = 1;
+	ehci_work(ehci, NULL);
+	spin_unlock_irq(&ehci->lock);
+
+	/* restart; khubd will disconnect devices */
+	retval = ehci_run(hcd);
+
+	/* here we "know" root ports should always stay powered */
+	ehci_port_power(ehci, 1);
+
+	return retval;
+}
+#endif
+
+/*-------------------------------------------------------------------------*/
+
+static void msp_start_hc(struct platform_device *dev)
+{
+	printk(KERN_DEBUG __FILE__
+		": starting PMC MSP EHCI USB Controller\n");
+
+	/*
+	 * Now, carefully enable the USB clock, and take
+	 * the USB host controller out of reset.
+	 */
+
+	printk(KERN_DEBUG __FILE__
+		": Clock to USB host has been enabled \n");
+}
+
+static void msp_stop_hc(struct platform_device *dev)
+{
+	printk(KERN_DEBUG __FILE__
+		": stopping PMC MSP EHCI USB Controller\n");
+}
+
+
+/*-------------------------------------------------------------------------*/
+
+/* configure so an HC device and id are always provided */
+/* always called with process context; sleeping is OK */
+
+
+/*
+ * usb_hcd_msp_probe - initialize PMC MSP-based HCDs
+ * Context: !in_interrupt()
+ *
+ * Allocates basic resources for this USB host controller, and
+ * then invokes the start() method for the HCD associated with it
+ * through the hotplug entry's driver_data.
+ */
+int usb_hcd_msp_probe(const struct hc_driver *driver,
+			struct platform_device *dev)
+{
+	int retval;
+	struct usb_hcd *hcd;
+
+	if (dev->resource[1].flags != IORESOURCE_IRQ) {
+		pr_debug("resource[1] is not IORESOURCE_IRQ");
+		return -ENOMEM;
+	}
+
+	hcd = usb_create_hcd(driver, &dev->dev, "pmcmsp");
+	if (!hcd)
+		return -ENOMEM;
+	hcd->rsrc_start = dev->resource[0].start;
+	hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_debug("request_mem_region failed");
+		retval = -EBUSY;
+		goto err1;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_debug("ioremap failed");
+		retval = -ENOMEM;
+		goto err2;
+	}
+
+	msp_start_hc(dev);
+
+	retval = usb_add_hcd(hcd, dev->resource[1].start, 0);
+	if (retval == 0)
+		return retval;
+
+	msp_stop_hc(dev);
+	iounmap(hcd->regs);
+
+ err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+ err1:
+	usb_put_hcd(hcd);
+
+	return retval;
+}
+
+/* may be called without controller electrically present */
+/* may be called with controller, bus, and devices active */
+
+/*
+ * usb_hcd_msp_remove - shutdown processing for PMC MSP-based HCDs
+ * @dev: USB Host Controller being removed
+ * Context: !in_interrupt()
+ *
+ * Reverses the effect of usb_hcd_msp_probe(), first invoking
+ * the HCD's stop() method. It is always called from a thread
+ * context, normally "rmmod", "apmd", or something similar.
+ */
+void usb_hcd_msp_remove(struct usb_hcd *hcd, struct platform_device *dev)
+{
+	usb_remove_hcd(hcd);
+	msp_stop_hc(dev);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+}
+
+/*-------------------------------------------------------------------------*/
+
+static const struct hc_driver ehci_msp_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"PMC MSP EHCI",
+	.hcd_priv_size =	sizeof(struct ehci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq =			ehci_irq,
+	.flags =		HCD_MEMORY | HCD_USB2,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.reset =		ehci_msp_setup,
+	.start =		ehci_run,
+#ifdef	CONFIG_PM
+	.suspend =		ehci_msp_suspend,
+	.resume =		ehci_msp_resume,
+#endif /*CONFIG_PM*/
+	.stop =			ehci_stop,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue =		ehci_urb_enqueue,
+	.urb_dequeue =		ehci_urb_dequeue,
+	.endpoint_disable =	ehci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number =	ehci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data =	ehci_hub_status_data,
+	.hub_control =		ehci_hub_control,
+};
+
+/*-------------------------------------------------------------------------*/
+
+static int ehci_hcd_msp_drv_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pr_debug("In ehci_hcd_msp_drv_probe");
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	ret = usb_hcd_msp_probe(&ehci_msp_hc_driver, pdev);
+
+	return ret;
+}
+
+static int ehci_hcd_msp_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_hcd_msp_remove(hcd, pdev);
+
+	return 0;
+}
+
+MODULE_ALIAS("pmcmsp-ehci");
+static struct platform_driver ehci_hcd_msp_driver = {
+	.probe		= ehci_hcd_msp_drv_probe,
+	.remove		= ehci_hcd_msp_drv_remove,
+	.driver		= {
+		.name	= "pmcmsp-ehci",
+	},
+};
