Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2003 17:53:04 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:45559 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225393AbTIIQxB>;
	Tue, 9 Sep 2003 17:53:01 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA15723
	for <linux-mips@linux-mips.org>; Tue, 9 Sep 2003 09:52:54 -0700
Message-ID: <3F5E0566.4E0DD26C@mvista.com>
Date: Tue, 09 Sep 2003 10:52:54 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: PATCH:2.4:tx4927 updates (mostly minor)
Content-Type: multipart/mixed;
 boundary="------------D759BFACE4A59D5E54858F16"
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips


This is a multi-part message in MIME format.
--------------D759BFACE4A59D5E54858F16
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Please apply the attached patch.  I'll be making a 2.6
version as soon as I can get to it.  

Summary:

Index: arch/mips/config-shared.in
dummy keyboard needed for some .configs

Index: arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
Index: arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
added prom_getcmdline() and changed the default command line setup

Index: drivers/char/Config.in
put the tx stuff together and in sort order

Index: drivers/char/serial_txx9.c
fixed compile problem when CONFIG_SERIAL_TXX9_CONSOLE=n,
fixed up some devfs issues, and changed the raw output
routine a bit.
--------------D759BFACE4A59D5E54858F16
Content-Type: text/plain; charset=us-ascii;
 name="cvsd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cvsd"

Index: arch/mips/config-shared.in
===================================================================
RCS file: /home/cvs/linux/arch/mips/Attic/config-shared.in,v
retrieving revision 1.1.2.85
diff -u -r1.1.2.85 config-shared.in
--- arch/mips/config-shared.in	8 Sep 2003 00:05:42 -0000	1.1.2.85
+++ arch/mips/config-shared.in	9 Sep 2003 16:22:48 -0000
@@ -647,6 +647,7 @@
    define_bool CONFIG_SWAP_IO_SPACE_L y
    define_bool CONFIG_ISA y
    define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_DUMMY_KEYB y
 fi
 if [ "$CONFIG_VICTOR_MPC30X" = "y" ]; then
    define_bool CONFIG_IRQ_CPU y
Index: arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 toshiba_rbtx4927_prom.c
--- arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c	16 Jul 2003 01:08:24 -0000	1.1.2.2
+++ arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c	9 Sep 2003 16:22:48 -0000
@@ -36,11 +36,7 @@
 #include <asm/cpu.h>
 #include <asm/tx4927/tx4927.h>
 
-#ifndef COMMAND_LINE_SIZE
-#define COMMAND_LINE_SIZE CL_SIZE
-#endif
-
-char arcs_cmdline[COMMAND_LINE_SIZE] = "console=ttyS0,38400 ip=any root=nfs rw";
+char arcs_cmdline[CL_SIZE] = "";
 
 void __init prom_init_cmdline(int argc, char **argv)
 {
@@ -63,7 +59,7 @@
 {
 	extern int tx4927_get_mem_size(void);
 	int msize;
-        char* toshiba_name_list[] = GROUP_TOSHIBA_NAMES;
+        const char* toshiba_name_list[] = GROUP_TOSHIBA_NAMES;
         extern char* toshiba_name;
 
 	prom_init_cmdline(argc, argv);
@@ -79,6 +75,11 @@
 
 	msize = tx4927_get_mem_size();
 	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
+}
+
+char * __init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
 }
 
 void __init prom_free_prom_memory(void)
Index: arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 toshiba_rbtx4927_setup.c
--- arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	25 Aug 2003 16:14:53 -0000	1.1.2.5
+++ arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	9 Sep 2003 16:22:48 -0000
@@ -141,6 +141,8 @@
 
 extern void gt64120_time_init(void);
 extern void toshiba_rbtx4927_irq_setup(void);
+extern char *prom_getcmdline(void);
+
 
 #ifdef CONFIG_PCI
 #define CONFIG_TX4927BUG_WORKAROUND
@@ -257,7 +259,7 @@
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_PCI
-#ifdef  TX4927_SUPPORT_PCI_66
+#ifdef TX4927_SUPPORT_PCI_66
 void tx4927_pci66_setup(void)
 {
 	int pciclk, pciclkin = 1;
@@ -866,7 +868,6 @@
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2, "+\n");
 }
-
 #endif /* CONFIG_PCI */
 
 void toshiba_rbtx4927_restart(char *command)
@@ -910,6 +911,8 @@
 void __init toshiba_rbtx4927_setup(void)
 {
 	vu32 cp0_config;
+	char *argptr;
+	u32 backplane_id = 0;
 
 	printk("CPU is %s\n", toshiba_name);
 
@@ -997,7 +1000,6 @@
 
 
 #ifdef CONFIG_PCI
-
 	/* PCIC */
 	/*
 	   * ASSUMPTION: PCIDIVMODE is configured for PCI 33MHz or 66MHz.
@@ -1059,16 +1061,13 @@
 	tx4927_pci_setup();
 
 
-	{
-		u32 id = 0;
-		early_read_config_dword(&mips_pci_channels[0], 0, 0, 0x90,
-					PCI_VENDOR_ID, &id);
-		if (id == 0x94601055) {
-			tx4927_using_backplane = 1;
-			printk("backplane board IS installed\n");
-		} else {
-			printk("backplane board NOT installed\n");
-		}
+	early_read_config_dword(&mips_pci_channels[0], 0, 0, 0x90,
+			PCI_VENDOR_ID, &backplane_id);
+	if (backplane_id == 0x94601055) {
+		tx4927_using_backplane = 1;
+		printk("backplane board IS installed\n");
+	} else {
+		printk("backplane board NOT installed\n");
 	}
 #endif
 
@@ -1141,6 +1140,38 @@
 	}
 #endif
 
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+	argptr = prom_getcmdline();
+	if (strstr(argptr, "console=") == NULL) {
+#ifdef CONFIG_DEVFS_FS
+		strcat(argptr, " console=tts/0,38400");
+#else
+		strcat(argptr, " console=ttyS0,38400");
+#endif
+	}
+#endif
+
+#ifdef CONFIG_NE2000
+	/* with the ne_eth= patch to ne.c this enables built-in 8019 */
+	argptr = prom_getcmdline();
+	if (strstr(argptr, "ne_eth=") == NULL) {
+		strcat(argptr, " ne_eth=0x6020280,29");
+	}
+#endif
+
+#ifdef CONFIG_IP_PNP
+	argptr = prom_getcmdline();
+	if (strstr(argptr, "ip=") == NULL) {
+		strcat(argptr, " ip=any");
+	}
+#endif
+
+#ifdef CONFIG_ROOT_NFS
+	argptr = prom_getcmdline();
+	if (strstr(argptr, "root=") == NULL) {
+		strcat(argptr, " root=/dev/nfs rw");
+	}
+#endif
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
 				       "+\n");
Index: drivers/char/Config.in
===================================================================
RCS file: /home/cvs/linux/drivers/char/Attic/Config.in,v
retrieving revision 1.72.2.34
diff -u -r1.72.2.34 Config.in
--- drivers/char/Config.in	13 Aug 2003 17:19:16 -0000	1.72.2.34
+++ drivers/char/Config.in	9 Sep 2003 16:22:49 -0000
@@ -82,10 +82,12 @@
      fi
    fi
    if [ "$CONFIG_MIPS" = "y" ]; then
-      bool '  TX3912/PR31700 serial port support' CONFIG_SERIAL_TX3912
-      dep_bool '     Console on TX3912/PR31700 serial port' CONFIG_SERIAL_TX3912_CONSOLE $CONFIG_SERIAL_TX3912
       bool '  TMPTX39XX/49XX serial port support' CONFIG_SERIAL_TXX9
       dep_bool '     Console on TMPTX39XX/49XX serial port' CONFIG_SERIAL_TXX9_CONSOLE $CONFIG_SERIAL_TXX9
+      bool '  TX3912/PR31700 serial port support' CONFIG_SERIAL_TX3912
+      dep_bool '     Console on TX3912/PR31700 serial port' CONFIG_SERIAL_TX3912_CONSOLE $CONFIG_SERIAL_TX3912
+      bool '  TXx927 SIO support' CONFIG_TXX927_SERIAL 
+      dep_bool '    TXx927 SIO Console support' CONFIG_TXX927_SERIAL_CONSOLE $CONFIG_TXX927_SERIAL
       if [ "$CONFIG_SOC_AU1X00" = "y" ]; then
 	 bool '  Enable Au1x00 UART Support' CONFIG_AU1X00_UART
 	 if [ "$CONFIG_AU1X00_UART" = "y" ]; then
@@ -100,10 +102,6 @@
 		 define_bool CONFIG_AU1X00_USB_DEVICE y
 	    fi
       fi
-      bool '  TXx927 SIO support' CONFIG_TXX927_SERIAL 
-      if [ "$CONFIG_TXX927_SERIAL" = "y" ]; then
-         bool '    TXx927 SIO Console support' CONFIG_TXX927_SERIAL_CONSOLE  
-      fi                             
       if [ "$CONFIG_SIBYTE_SB1xxx_SOC" = "y" ]; then
          bool '  Support for BCM1xxx onchip DUART' CONFIG_SIBYTE_SB1250_DUART
          if [ "$CONFIG_SIBYTE_SB1250_DUART" = "y" ]; then
Index: drivers/char/serial_txx9.c
===================================================================
RCS file: /home/cvs/linux/drivers/char/serial_txx9.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 serial_txx9.c
--- drivers/char/serial_txx9.c	11 Apr 2003 17:26:21 -0000	1.1.2.1
+++ drivers/char/serial_txx9.c	9 Sep 2003 16:22:49 -0000
@@ -52,6 +52,7 @@
 #ifdef CONFIG_SERIAL
 /* "ttyS","cua" is used for standard serial driver */
 #define TXX9_TTY_NAME "ttyTX"
+#define TXX9_TTY_DEVFS_NAME_SHORT "tts/TX"
 #define TXX9_TTY_DEVFS_NAME "tts/TX%d"
 #define TXX9_TTY_MINOR_START	(64 + 64)	/* ttyTX0(128), ttyTX1(129) */
 #define TXX9_CU_NAME "cuatx"
@@ -59,6 +60,7 @@
 #else
 /* acts like standard serial driver */
 #define TXX9_TTY_NAME "ttyS"
+#define TXX9_TTY_DEVFS_NAME_SHORT "tts/"
 #define TXX9_TTY_DEVFS_NAME "tts/%d"
 #define TXX9_TTY_MINOR_START	64
 #define TXX9_CU_NAME "cua"
@@ -1248,7 +1250,12 @@
 {
 	unsigned long flags;
 
-	if (port - &rs_ports[0] != sercons.index) {
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+#define EXPR_1 port - &rs_ports[0] != sercons.index
+#else
+#define EXPR_1 1
+#endif
+	if (EXPR_1) {
 		local_irq_save(flags);
 		/*
 		 * Reset the UART.
@@ -1311,9 +1318,15 @@
 
 	txx9_config(port);
 
+#if defined(CONFIG_DEVFS_FS)
+	printk(KERN_INFO
+		"%s%d at 0x%08lx (irq = %d) is a TX39/49 SIO\n",
+		TXX9_TTY_DEVFS_NAME_SHORT, i, port->base, port->irq);
+#else
 	printk(KERN_INFO
 		"%s%d at 0x%08lx (irq = %d) is a TX39/49 SIO\n",
 		TXX9_TTY_NAME, i, port->base, port->irq);
+#endif
 	return 0;
 }
 
@@ -1395,9 +1408,15 @@
 				continue;
 		}
 		txx9_config(port);
+#if defined(CONFIG_DEVFS_FS)
+		printk(KERN_INFO
+		       "%s%d at 0x%08lx (irq = %d) is a TX39/49 SIO\n",
+		       TXX9_TTY_DEVFS_NAME_SHORT, i, port->base, port->irq);
+#else
 		printk(KERN_INFO
 		       "%s%d at 0x%08lx (irq = %d) is a TX39/49 SIO\n",
 		       TXX9_TTY_NAME, i, port->base, port->irq);
+#endif
 	}
 
 	/* Note: I didn't do anything to enable the second UART */
@@ -1637,7 +1656,11 @@
 }
 
 static struct console sercons = {
+#if defined(CONFIG_DEVFS_FS)
+	name:		TXX9_TTY_DEVFS_NAME_SHORT,
+#else
 	name:		TXX9_TTY_NAME,
+#endif
 	write:		serial_console_write,
 	device:		serial_console_device,
 	setup:		serial_console_setup,
@@ -1754,7 +1777,8 @@
 /* END: KDBG Routines                                                         */
 /******************************************************************************/
 
-void txx9_raw_output(char c)
+#if defined(CONFIG_RAW_PRINTK_OUTPUT) && defined(CONFIG_SERIAL_TXX9_CONSOLE)
+void emit_log_char(char c)
 {
 	struct rs_port *port = &rs_ports[0];
 	if ( c == '\n' )
@@ -1766,3 +1790,4 @@
 	wait_for_xmitr(port);
 	return;
 }
+#endif

--------------D759BFACE4A59D5E54858F16--
