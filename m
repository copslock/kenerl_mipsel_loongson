Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2003 22:04:39 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:64555
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8224802AbTFTVEh>; Fri, 20 Jun 2003 22:04:37 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 19TT3b-00074n-00; Fri, 20 Jun 2003 23:04:27 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.5] lasat updates
Cc: linux-mips@linux-mips.org
Message-Id: <E19TT3b-00074n-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Fri, 20 Jun 2003 23:04:27 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
This patch fixes up the Lasat code so it works as well as 
before the latest chain of updates (which is not quite).
The patch to the PCI code is necessary because I stupidly
copied the code from the mips-boards code which also has the
same problem (writes of full 32 bit words are ignored). 
The people who made pci-sb1250.c seem to have 
made the same error too...

/Brian

Index: arch/mips/lasat/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/Makefile,v
retrieving revision 1.7
diff -u -r1.7 Makefile
--- arch/mips/lasat/Makefile	2 Jun 2003 10:48:37 -0000	1.7
+++ arch/mips/lasat/Makefile	20 Jun 2003 17:04:45 -0000
@@ -12,7 +12,5 @@
 obj-$(CONFIG_PICVUE) += picvue.o
 obj-$(CONFIG_PICVUE_PROC) += picvue_proc.o
 
-obj-$(CONFIG_PCI) += pci.o
-
 clean:
 	make -C image clean
Index: arch/mips/lasat/lasat_board.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/lasat_board.c,v
retrieving revision 1.3
diff -u -r1.3 lasat_board.c
--- arch/mips/lasat/lasat_board.c	25 Feb 2003 22:39:02 -0000	1.3
+++ arch/mips/lasat/lasat_board.c	20 Jun 2003 19:04:15 -0000
@@ -24,6 +24,7 @@
  * Routines specific to the LASAT boards
  */
 #include <linux/types.h>
+#include <linux/crc32.h>
 #include <asm/lasat/lasat.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -33,9 +34,11 @@
 #include "at93c.h"
 /* New model description table */
 #include "lasat_models.h"
+
+#define EEPROM_CRC(data, len) (~0 ^ crc32(~0, data, len))
+
 struct lasat_info lasat_board_info;
 
-unsigned long crc32(unsigned long, unsigned char *, int);
 void update_bcastaddr(void);
 
 int EEPROMRead(unsigned int pos, unsigned char *data, int len)
@@ -109,7 +112,7 @@
 		   sizeof(struct lasat_eeprom_struct));
 
 	/* Check the CRC */
-	crc = crc32(0x0, (unsigned char *)(&lasat_board_info.li_eeprom_info),
+	crc = EEPROM_CRC((unsigned char *)(&lasat_board_info.li_eeprom_info),
 		    sizeof(struct lasat_eeprom_struct) - 4);
 
 	if (crc != lasat_board_info.li_eeprom_info.crc32) {
@@ -268,7 +271,7 @@
 	unsigned long crc;
 
 	/* Generate the CRC */
-	crc = crc32(0x0, (unsigned char *)(&lasat_board_info.li_eeprom_info),
+	crc = EEPROM_CRC((unsigned char *)(&lasat_board_info.li_eeprom_info),
 		    sizeof(struct lasat_eeprom_struct) - 4);
 	lasat_board_info.li_eeprom_info.crc32 = crc;
 
Index: arch/mips/lasat/image/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/image/Makefile,v
retrieving revision 1.5
diff -u -r1.5 Makefile
--- arch/mips/lasat/image/Makefile	25 Feb 2003 22:39:02 -0000	1.5
+++ arch/mips/lasat/image/Makefile	20 Jun 2003 20:55:59 -0000
@@ -27,15 +27,17 @@
 
 obj-y = head.o kImage.o
 
-rom.sw:	rom.bin
+rom.sw:	$(obj)/rom.sw
+
+$(obj)/rom.sw:	$(obj)/rom.bin
 	$(MKLASATIMG) -o $@ -k $^ -m $(MKLASATIMG_ARCH)
 
-rom.bin: $(obj)/rom
-	$(OBJCOPY) -O binary -S rom rom.bin
+$(obj)/rom.bin: $(obj)/rom
+	$(OBJCOPY) -O binary -S $^ $@
 
 # Rule to make the bootloader
 $(obj)/rom: $(addprefix $(obj)/,$(obj-y))
-	$(LD) $(LDFLAGS) $(LDSCRIPT) -o rom $^
+	$(LD) $(LDFLAGS) $(LDSCRIPT) -o $@ $^
 
 $(obj)/%.o: $(obj)/%.gz
 	$(LD) -r -o $@ -b binary $<
Index: arch/mips/pci/pci-lasat.c
===================================================================
RCS file: /cvs/linux/arch/mips/pci/pci-lasat.c,v
retrieving revision 1.2
diff -u -r1.2 pci-lasat.c
--- arch/mips/pci/pci-lasat.c	13 Jun 2003 14:19:56 -0000	1.2
+++ arch/mips/pci/pci-lasat.c	20 Jun 2003 20:50:36 -0000
@@ -152,7 +152,7 @@
 		/* Error occured */
 #ifdef DEBUG_PCI
 		printk("\terror %x at adr %x\n", err,
-		       vrc_pciregs[LO(PCIERR)]);
+		       vrc_pciregs[LO(NILE4_PCIERR)]);
 #endif
 		return -1;
 	}
@@ -204,6 +204,8 @@
 	else if (size == 2)
 		data = (data & ~(0xffff << ((where & 3) << 3))) |
 		    (val << ((where & 3) << 3));
+	else
+		data = val;
 
 	if (lasat_pcibios_config_access
 	    (PCI_ACCESS_WRITE, bus, devfn, where, &data))
Index: arch/mips/defconfig-lasat200
===================================================================
RCS file: /cvs/linux/arch/mips/defconfig-lasat200,v
retrieving revision 1.51
diff -u -r1.51 defconfig-lasat200
--- arch/mips/defconfig-lasat200	16 Jun 2003 01:04:44 -0000	1.51
+++ arch/mips/defconfig-lasat200	20 Jun 2003 21:02:33 -0000
@@ -117,7 +117,7 @@
 #
 CONFIG_PCI=y
 CONFIG_PCI_LEGACY_PROC=y
-CONFIG_PCI_NAMES=y
+# CONFIG_PCI_NAMES is not set
 CONFIG_MMU=y
 # CONFIG_HOTPLUG is not set
 
@@ -142,8 +142,7 @@
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
-# CONFIG_MTD_BLOCK is not set
-CONFIG_MTD_BLOCK_RO=y
+CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
 
@@ -227,7 +226,7 @@
 #
 # CONFIG_BLK_DEV_HD is not set
 CONFIG_BLK_DEV_IDEDISK=y
-# CONFIG_IDEDISK_MULTI_MODE is not set
+CONFIG_IDEDISK_MULTI_MODE=y
 # CONFIG_IDEDISK_STROKE is not set
 # CONFIG_BLK_DEV_IDECD is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
@@ -236,7 +235,41 @@
 #
 # IDE chipset support/bugfixes
 #
-# CONFIG_BLK_DEV_IDEPCI is not set
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_IDEPCI_SHARE_IRQ is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDE_TCQ is not set
+# CONFIG_BLK_DEV_OFFBOARD is not set
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+CONFIG_IDEDMA_PCI_AUTO=y
+# CONFIG_IDEDMA_ONLYDISK is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_PCI_WIP is not set
+CONFIG_BLK_DEV_ADMA=y
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+CONFIG_BLK_DEV_CMD64X=y
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_OPTI621 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+CONFIG_IDEDMA_AUTO=y
+# CONFIG_IDEDMA_IVB is not set
+CONFIG_BLK_DEV_IDE_MODES=y
 
 #
 # SCSI device support
@@ -546,9 +579,7 @@
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_DEVFS_FS=y
-# CONFIG_DEVFS_MOUNT is not set
-# CONFIG_DEVFS_DEBUG is not set
+# CONFIG_DEVFS_FS is not set
 CONFIG_DEVPTS_FS=y
 CONFIG_DEVPTS_FS_XATTR=y
 CONFIG_DEVPTS_FS_SECURITY=y
