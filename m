Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2003 22:36:38 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:4350 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224939AbTBMWgh>;
	Thu, 13 Feb 2003 22:36:37 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1DMaYo23304;
	Thu, 13 Feb 2003 14:36:34 -0800
Date: Thu, 13 Feb 2003 14:36:34 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] malta kgdb, defconfig update
Message-ID: <20030213143634.Y7466@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This patch mainly makes Malta work with kgdb.  Some minor
defconfig improvement as well.

Don't expect any objections, but I'd like to run a check here ...

Jun

--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030213.b-2.4-malta-kgdb-defconfig-update.patch"

diff -Nru linux/arch/mips/mips-boards/malta/malta_setup.c.orig linux/arch/mips/mips-boards/malta/malta_setup.c
--- linux/arch/mips/mips-boards/malta/malta_setup.c.orig	Mon Aug  5 16:53:34 2002
+++ linux/arch/mips/mips-boards/malta/malta_setup.c	Thu Feb 13 13:59:21 2003
@@ -51,10 +51,8 @@
 #endif
 
 #ifdef CONFIG_REMOTE_DEBUG
-extern void set_debug_traps(void);
 extern void rs_kgdb_hook(int);
-extern void breakpoint(void);
-static int remote_debug = 0;
+int remote_debug = 0;
 #endif
 
 extern struct ide_ops std_ide_ops;
@@ -64,9 +62,6 @@
 
 extern void mips_reboot_setup(void);
 
-extern void (*board_time_init)(void);
-extern void (*board_timer_setup)(struct irqaction *irq);
-extern unsigned long (*rtc_get_time)(void);
 extern void mips_time_init(void);
 extern void mips_timer_setup(struct irqaction *irq);
 extern unsigned long mips_rtc_get_time(void);
@@ -94,8 +89,8 @@
 #ifdef CONFIG_REMOTE_DEBUG
 	int rs_putDebugChar(char);
 	char rs_getDebugChar(void);
-	extern int (*putDebugChar)(char);
-	extern char (*getDebugChar)(void);
+	extern int (*generic_putDebugChar)(char);
+	extern char (*generic_getDebugChar)(void);
 #endif
 	char *argptr;
 	int i;
@@ -130,8 +125,8 @@
 		       line ? 1 : 0);
 
 		rs_kgdb_hook(line);
-		putDebugChar = rs_putDebugChar;
-		getDebugChar = rs_getDebugChar;
+		generic_putDebugChar = rs_putDebugChar;
+		generic_getDebugChar = rs_getDebugChar;
 
 		prom_printf("KGDB: Using serial line /dev/ttyS%d for session, "
 			    "please connect your debugger\n", line ? 1 : 0);
diff -Nru linux/arch/mips/mips-boards/malta/malta_int.c.orig linux/arch/mips/mips-boards/malta/malta_int.c
--- linux/arch/mips/mips-boards/malta/malta_int.c.orig	Thu Dec 12 10:35:07 2002
+++ linux/arch/mips/mips-boards/malta/malta_int.c	Thu Feb 13 14:03:00 2003
@@ -43,6 +43,12 @@
 extern void init_i8259_irqs (void);
 extern int mips_pcibios_iack(void);
 
+#ifdef CONFIG_REMOTE_DEBUG
+extern void breakpoint(void);
+extern void set_debug_traps(void);
+extern int remote_debug;
+#endif
+
 static spinlock_t mips_irq_lock = SPIN_LOCK_UNLOCKED;
 
 static inline int get_int(int *irq)
diff -Nru linux/arch/mips/defconfig-malta.orig linux/arch/mips/defconfig-malta
--- linux/arch/mips/defconfig-malta.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-malta	Thu Feb 13 12:15:15 2003
@@ -13,7 +13,9 @@
 #
 # Loadable module support
 #
-# CONFIG_MODULES is not set
+CONFIG_MODULES=y
+# CONFIG_MODVERSIONS is not set
+CONFIG_KMOD=y
 
 #
 # Machine selection
@@ -187,8 +189,8 @@
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-# CONFIG_IP_PNP_BOOTP is not set
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
@@ -567,13 +569,14 @@
 # CONFIG_CODA_FS is not set
 # CONFIG_INTERMEZZO_FS is not set
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-# CONFIG_NFSD is not set
-# CONFIG_NFSD_V3 is not set
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
 # CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_NCPFS_PACKET_SIGNING is not set
diff -Nru linux/arch/mips64/defconfig-malta.orig linux/arch/mips64/defconfig-malta
--- linux/arch/mips64/defconfig-malta.orig	Thu Feb  6 13:24:02 2003
+++ linux/arch/mips64/defconfig-malta	Thu Feb 13 14:22:51 2003
@@ -13,7 +13,9 @@
 #
 # Loadable module support
 #
-# CONFIG_MODULES is not set
+CONFIG_MODULES=y
+# CONFIG_MODVERSIONS is not set
+CONFIG_KMOD=y
 
 #
 # Machine selection
@@ -185,8 +187,8 @@
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-# CONFIG_IP_PNP_BOOTP is not set
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
@@ -533,13 +535,14 @@
 # CONFIG_CODA_FS is not set
 # CONFIG_INTERMEZZO_FS is not set
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-# CONFIG_NFSD is not set
-# CONFIG_NFSD_V3 is not set
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
 # CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_NCPFS_PACKET_SIGNING is not set
@@ -585,6 +588,8 @@
 #
 CONFIG_CROSSCOMPILE=y
 # CONFIG_DEBUG is not set
+# CONFIG_REMOTE_DEBUG is not set
+# CONFIG_GDB_CONSOLE is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 

--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030213.b-2.5-malta-kgdb-defconfig-update.patch"

diff -Nru linux/arch/mips/mips-boards/malta/malta_setup.c.orig linux/arch/mips/mips-boards/malta/malta_setup.c
--- linux/arch/mips/mips-boards/malta/malta_setup.c.orig	Thu Oct 31 04:27:31 2002
+++ linux/arch/mips/mips-boards/malta/malta_setup.c	Thu Feb 13 14:25:07 2003
@@ -48,10 +48,8 @@
 #endif
 
 #ifdef CONFIG_REMOTE_DEBUG
-extern void set_debug_traps(void);
 extern void rs_kgdb_hook(int);
-extern void breakpoint(void);
-static int remote_debug = 0;
+int remote_debug = 0;
 #endif
 
 extern struct ide_ops std_ide_ops;
@@ -61,9 +59,6 @@
 
 extern void mips_reboot_setup(void);
 
-extern void (*board_time_init)(void);
-extern void (*board_timer_setup)(struct irqaction *irq);
-extern unsigned long (*rtc_get_time)(void);
 extern void mips_time_init(void);
 extern void mips_timer_setup(struct irqaction *irq);
 extern unsigned long mips_rtc_get_time(void);
@@ -91,8 +86,8 @@
 #ifdef CONFIG_REMOTE_DEBUG
 	int rs_putDebugChar(char);
 	char rs_getDebugChar(void);
-	extern int (*putDebugChar)(char);
-	extern char (*getDebugChar)(void);
+	extern int (*generic_putDebugChar)(char);
+	extern char (*generic_getDebugChar)(void);
 #endif
 	char *argptr;
 	int i;
@@ -127,8 +122,8 @@
 		       line ? 1 : 0);
 
 		rs_kgdb_hook(line);
-		putDebugChar = rs_putDebugChar;
-		getDebugChar = rs_getDebugChar;
+		generic_putDebugChar = rs_putDebugChar;
+		generic_getDebugChar = rs_getDebugChar;
 
 		prom_printf("KGDB: Using serial line /dev/ttyS%d for session, "
 			    "please connect your debugger\n", line ? 1 : 0);
diff -Nru linux/arch/mips/mips-boards/malta/malta_int.c.orig linux/arch/mips/mips-boards/malta/malta_int.c
--- linux/arch/mips/mips-boards/malta/malta_int.c.orig	Thu Dec 12 13:58:26 2002
+++ linux/arch/mips/mips-boards/malta/malta_int.c	Thu Feb 13 14:25:07 2003
@@ -43,6 +43,12 @@
 extern void init_i8259_irqs (void);
 extern int mips_pcibios_iack(void);
 
+#ifdef CONFIG_REMOTE_DEBUG
+extern void breakpoint(void);
+extern void set_debug_traps(void);
+extern int remote_debug;
+#endif
+
 static spinlock_t mips_irq_lock = SPIN_LOCK_UNLOCKED;
 
 static inline int get_int(int *irq)
diff -Nru linux/arch/mips/defconfig-malta.orig linux/arch/mips/defconfig-malta
--- linux/arch/mips/defconfig-malta.orig	Thu Dec 12 13:58:25 2002
+++ linux/arch/mips/defconfig-malta	Thu Feb 13 14:27:02 2003
@@ -21,7 +21,9 @@
 #
 # Loadable module support
 #
-# CONFIG_MODULES is not set
+CONFIG_MODULES=y
+# CONFIG_MODVERSIONS is not set
+CONFIG_KMOD=y
 
 #
 # Machine selection
@@ -243,8 +245,8 @@
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-# CONFIG_IP_PNP_BOOTP is not set
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
@@ -519,13 +521,17 @@
 # CONFIG_CODA_FS is not set
 # CONFIG_INTERMEZZO_FS is not set
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
 # CONFIG_NFS_V4 is not set
 CONFIG_ROOT_NFS=y
-# CONFIG_NFSD is not set
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V4 is not set
+# CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
-# CONFIG_EXPORTFS is not set
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
 # CONFIG_CIFS is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
diff -Nru linux/arch/mips64/defconfig-malta.orig linux/arch/mips64/defconfig-malta
--- linux/arch/mips64/defconfig-malta.orig	Thu Feb 13 11:37:35 2003
+++ linux/arch/mips64/defconfig-malta	Thu Feb 13 14:29:10 2003
@@ -21,7 +21,9 @@
 #
 # Loadable module support
 #
-# CONFIG_MODULES is not set
+CONFIG_MODULES=y
+# CONFIG_MODVERSIONS is not set
+CONFIG_KMOD=y
 
 #
 # Machine selection
@@ -239,8 +241,8 @@
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-# CONFIG_IP_PNP_BOOTP is not set
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
@@ -498,13 +500,17 @@
 # CONFIG_CODA_FS is not set
 # CONFIG_INTERMEZZO_FS is not set
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
 # CONFIG_NFS_V4 is not set
 CONFIG_ROOT_NFS=y
-# CONFIG_NFSD is not set
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V4 is not set
+# CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
-# CONFIG_EXPORTFS is not set
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
 # CONFIG_CIFS is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set

--iFRdW5/EC4oqxDHL--
