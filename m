Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Nov 2004 03:18:37 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:64754 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225202AbUKMDSb>; Sat, 13 Nov 2004 03:18:31 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAD3ITdh029143;
	Fri, 12 Nov 2004 19:18:29 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAD3ISLo029141;
	Fri, 12 Nov 2004 19:18:28 -0800
Date: Fri, 12 Nov 2004 19:18:28 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Support for backplane on the Toshiba 4400 board
Message-ID: <20041113031828.GA29134@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf

Attached patch implements support for backplane on the TX4927 based board. Tested
using PCI and IDE on the backplane. Please review ...

Thanks
Manish Lachwani



--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_toshiba_backplane_MR9019.patch"

Source: MontaVista Software, Inc. | http://www.mvista.com | Manish Lachwani <mlachwani@mvista.com>
Type: Enhancement
Disposition: Submitted to Linux-MIPS
Description:
	Support for Backplane on the Toshiba 4400. Tested using
	PCI and IDE on the backplane

Index: linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
===================================================================
--- linux.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -337,7 +337,6 @@
 	return (sw_irq);
 }
 
-//#define TOSHIBA_RBTX4927_PIC_ACTION(s) { no_action, 0, CPU_MASK_NONE, s, NULL, NULL }
 #define TOSHIBA_RBTX4927_PIC_ACTION(s) { no_action, SA_SHIRQ, CPU_MASK_NONE, s, NULL, NULL }
 static struct irqaction toshiba_rbtx4927_irq_ioc_action =
 TOSHIBA_RBTX4927_PIC_ACTION(TOSHIBA_RBTX4927_IOC_NAME);
@@ -513,7 +512,7 @@
 
 
 #ifdef CONFIG_TOSHIBA_FPCIB0
-static void __init toshiba_rbtx4927_irq_isa_init(void)
+void toshiba_rbtx4927_irq_isa_init(void)
 {
 	int i;
 
@@ -675,13 +674,6 @@
 
 	tx4927_irq_init();
 	toshiba_rbtx4927_irq_ioc_init();
-#ifdef CONFIG_TOSHIBA_FPCIB0
-	{
-		if (tx4927_using_backplane) {
-			toshiba_rbtx4927_irq_isa_init();
-		}
-	}
-#endif
 
 	wbflush();
 
Index: linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
===================================================================
--- linux.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -242,6 +242,16 @@
 EARLY_PCI_OP(write, word, u16)
 EARLY_PCI_OP(write, dword, u32)
 
+#ifdef CONFIG_TOSHIBA_FPCIB0
+extern void toshiba_rbtx4927_irq_isa_init();
+#endif
+
+/*
+ * tx4927_pcibios_init is now an arch_initcall and no longer
+ * called from pci_setup(). As a result, we can determine whether
+ * the board has a backplane or not only after tx4927_pcibios_init
+ * is done.
+ */
 static int __init tx4927_pcibios_init(void)
 {
 	unsigned int id;
@@ -345,6 +355,9 @@
 			     s);
 		}
 
+		/*
+		 * This is IDE on the backplane
+		 */
 		if (id == 0x91301055) {
 			u8 v08_04;
 			u8 v08_09;
@@ -481,6 +494,74 @@
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCIBIOS,
 				       "+\n");
 
+	/* Backplane */
+	early_read_config_dword(hose, busno, busno, 0x90,
+				PCI_VENDOR_ID, &id);
+
+	/* Check backplane */
+	if (id == 0x94601055) {
+		tx4927_using_backplane = 1;
+		printk("backplane board IS installed\n");
+	}
+	else
+		printk("No Backplane \n");
+
+#ifdef CONFIG_TOSHIBA_FPCIB0
+{
+	if (tx4927_using_backplane) {
+		TOSHIBA_RBTX4927_SETUP_DPRINTK
+			(TOSHIBA_RBTX4927_SETUP_SETUP,
+			":fpcibo=yes\n");
+                                                                                          
+		TOSHIBA_RBTX4927_SETUP_DPRINTK
+			(TOSHIBA_RBTX4927_SETUP_SETUP,
+			":smsc_fdc37m81x_init()\n");
+		smsc_fdc37m81x_init(0x3f0);
+                                                                                          
+		TOSHIBA_RBTX4927_SETUP_DPRINTK
+			(TOSHIBA_RBTX4927_SETUP_SETUP,
+			":smsc_fdc37m81x_config_beg()\n");
+		smsc_fdc37m81x_config_beg();
+                                                                                         
+		TOSHIBA_RBTX4927_SETUP_DPRINTK
+			(TOSHIBA_RBTX4927_SETUP_SETUP,
+			":smsc_fdc37m81x_config_set(KBD)\n");
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_DNUM,
+			SMSC_FDC37M81X_KBD);
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT, 1);
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT2, 12);
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_ACTIVE,
+			1);
+                                                                                          
+		smsc_fdc37m81x_config_end();
+		TOSHIBA_RBTX4927_SETUP_DPRINTK
+			(TOSHIBA_RBTX4927_SETUP_SETUP,
+			":smsc_fdc37m81x_config_end()\n");
+	} else {
+		TOSHIBA_RBTX4927_SETUP_DPRINTK
+			(TOSHIBA_RBTX4927_SETUP_SETUP,
+			":fpcibo=not_found\n");
+	}
+}
+#else
+	{
+		TOSHIBA_RBTX4927_SETUP_DPRINTK
+			(TOSHIBA_RBTX4927_SETUP_SETUP, ":fpcibo=no\n");	
+	}
+#endif
+
+#ifdef CONFIG_TOSHIBA_FPCIB0
+	if (tx4927_using_backplane) {
+		/*
+		 * This function below does a critical job of allocating
+		 * IRQ for IDE. Since at the time arch_init_irq() calls this
+		 * the PCI is not initialized and we dont know whether 
+		 * there is backplane or not. Hence, we do this here
+		 */
+		toshiba_rbtx4927_irq_isa_init();
+	}
+#endif
+
 	return 0;
 }
 
@@ -869,56 +950,6 @@
 #endif
 
 	tx4927_pci_setup();
-	if (tx4927_using_backplane == 1)
-		printk("backplane board IS installed\n");
-	else
-		printk("No Backplane \n");
-
-	/* this is on ISA bus behind PCI bus, so need PCI up first */
-#ifdef CONFIG_TOSHIBA_FPCIB0
-	{
-		if (tx4927_using_backplane) {
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":fpcibo=yes\n");
-
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":smsc_fdc37m81x_init()\n");
-			smsc_fdc37m81x_init(0x3f0);
-
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":smsc_fdc37m81x_config_beg()\n");
-			smsc_fdc37m81x_config_beg();
-
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":smsc_fdc37m81x_config_set(KBD)\n");
-			smsc_fdc37m81x_config_set(SMSC_FDC37M81X_DNUM,
-						  SMSC_FDC37M81X_KBD);
-			smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT, 1);
-			smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT2, 12);
-			smsc_fdc37m81x_config_set(SMSC_FDC37M81X_ACTIVE,
-						  1);
-
-			smsc_fdc37m81x_config_end();
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":smsc_fdc37m81x_config_end()\n");
-		} else {
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":fpcibo=not_found\n");
-		}
-	}
-#else
-	{
-		TOSHIBA_RBTX4927_SETUP_DPRINTK
-		    (TOSHIBA_RBTX4927_SETUP_SETUP, ":fpcibo=no\n");
-	}
-#endif
-
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE

--WIyZ46R2i8wDzkSu--
