Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Feb 2003 23:06:00 +0000 (GMT)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:829
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225198AbTBSXF6>; Wed, 19 Feb 2003 23:05:58 +0000
Received: from brm by brian.localnet with local (Exim 3.35 #1 (Debian))
	id 18ldHh-0003Mx-00; Thu, 20 Feb 2003 00:05:49 +0100
To: linux-mips@linux-mips.org
Subject: [PATCH 2.4] Latest updates for LASAT 2.4
Cc: ralf@linux-mips.org
Message-Id: <E18ldHh-0003Mx-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Thu, 20 Feb 2003 00:05:49 +0100
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

This is just a maintainance patch for LASAT removing unused 
cruft and updating stuff to be more compatible with the 2.5 way of
doing things (mostly local_irq_* stuff). It also impliments a polling
printf (prom_printf) for debugging and if you have a recent prom
monitor / bootloader it gets started after a shutdown or panic
from whence you can restart, examine memory, etc...

I have a unifying patch for 2.5 but It wont work until a newer
2.5 is merged back to the mips-linux tree (for crc support) and 
the serial driver in 2.5 is fixed so a serial port can be 
registered dynamically (or do you want the patch anyway Ralf
to sync things up?)

/Brian

Index: arch/mips/lasat/ds1603.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/ds1603.c,v
retrieving revision 1.1.1.2
retrieving revision 1.4
diff -u -r1.1.1.2 -r1.4
--- arch/mips/lasat/ds1603.c	13 Dec 2002 23:41:18 -0000	1.1.1.2
+++ arch/mips/lasat/ds1603.c	14 Dec 2002 17:43:38 -0000	1.4
@@ -145,12 +145,14 @@
 	return word;
 }
 
-void ds1603_set(unsigned long time)
+int ds1603_set(unsigned long time)
 {
 	rtc_init_op();
 	rtc_write_byte(SET_TIME_CMD);
 	rtc_write_word(time);
 	rtc_end_op();
+
+	return 0;
 }
 
 void ds1603_set_trimmer(unsigned int trimval)
Index: arch/mips/lasat/ds1603.h
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/ds1603.h,v
retrieving revision 1.1.1.2
retrieving revision 1.4
diff -u -r1.1.1.2 -r1.4
--- arch/mips/lasat/ds1603.h	13 Dec 2002 23:41:18 -0000	1.1.1.2
+++ arch/mips/lasat/ds1603.h	19 Jan 2003 21:51:44 -0000	1.4
@@ -21,7 +21,7 @@
 extern struct ds_defs *ds1603;
 
 unsigned long ds1603_read(void);
-void ds1603_set(unsigned long);
+int ds1603_set(unsigned long);
 void ds1603_set_trimmer(unsigned int);
 void ds1603_enable(void);
 void ds1603_disable(void);
Index: arch/mips/lasat/interrupt.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/interrupt.c,v
retrieving revision 1.1.1.2
retrieving revision 1.15
diff -u -r1.1.1.2 -r1.15
--- arch/mips/lasat/interrupt.c	13 Dec 2002 23:41:18 -0000	1.1.1.2
+++ arch/mips/lasat/interrupt.c	19 Jan 2003 21:16:19 -0000	1.15
@@ -53,9 +53,9 @@
 	unsigned long flags;
 	DEBUG_INT("disable_lasat_irq: %d", irq_nr);
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 	*lasat_int_mask &= ~(1 << irq_nr) << lasat_int_mask_shift;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 void enable_lasat_irq(unsigned int irq_nr)
@@ -63,9 +63,9 @@
 	unsigned long flags;
 	DEBUG_INT("enable_lasat_irq: %d", irq_nr);
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 	*lasat_int_mask |= (1 << irq_nr) << lasat_int_mask_shift;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static unsigned int startup_lasat_irq(unsigned int irq)
@@ -164,15 +164,15 @@
 
 	switch (mips_machtype) {
 	case MACH_LASAT_100:
-		lasat_int_status = LASAT_INT_STATUS_REG_100;
-		lasat_int_mask = LASAT_INT_MASK_REG_100;
+		lasat_int_status = (void *)LASAT_INT_STATUS_REG_100;
+		lasat_int_mask = (void *)LASAT_INT_MASK_REG_100;
 		lasat_int_mask_shift = LASATINT_MASK_SHIFT_100;
 		get_int_status = get_int_status_100;
 		*lasat_int_mask = 0;
 		break;
 	case MACH_LASAT_200:
-		lasat_int_status = LASAT_INT_STATUS_REG_200;
-		lasat_int_mask = LASAT_INT_MASK_REG_200;
+		lasat_int_status = (void *)LASAT_INT_STATUS_REG_200;
+		lasat_int_mask = (void *)LASAT_INT_MASK_REG_200;
 		lasat_int_mask_shift = LASATINT_MASK_SHIFT_200;
 		get_int_status = get_int_status_200;
 		*lasat_int_mask &= 0xffff;
Index: arch/mips/lasat/lasat_board.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/lasat_board.c,v
retrieving revision 1.1.1.2
retrieving revision 1.15
diff -u -r1.1.1.2 -r1.15
--- arch/mips/lasat/lasat_board.c	13 Dec 2002 23:41:18 -0000	1.1.1.2
+++ arch/mips/lasat/lasat_board.c	19 Jan 2003 21:07:58 -0000	1.15
@@ -23,20 +23,20 @@
  *
  * Routines specific to the LASAT boards
  */
+#include <linux/types.h>
 #include <asm/lasat/lasat.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <asm/bootinfo.h>
-#include <asm/lasat/lasat_mtd.h>
 #include <asm/addrspace.h>
 #include "at93c.h"
 /* New model description table */
 #include "lasat_models.h"
 struct lasat_info lasat_board_info;
 
-extern unsigned long crc32(unsigned long, unsigned char *, int);
-
+unsigned long crc32(unsigned long, unsigned char *, int);
+void update_bcastaddr(void);
 
 int EEPROMRead(unsigned int pos, unsigned char *data, int len)
 {
@@ -57,81 +57,39 @@
 	return 0;
 }
 
-static int upgrade_eeprom_info(struct lasat_eeprom_struct * ser_data)
+static void init_flash_sizes(void)
 {
-	struct lasat_eeprom_struct_pre7 old;
-
-	memcpy(&old, ser_data, sizeof(struct lasat_eeprom_struct_pre7));
-
-	switch (ser_data->version) {
-	case 1:
-	case 2:
-	case 3:
-		/* These have old serial numbers that we can't convert. */
-		return -1;
-
-	case 4:
-		/* This used flags for obscure purposes. */
-		old.version = 5;
-
-	case 5:
-		/* Writecount didn't exist. */
-		old.writecount = 1;
-		old.version = 6;
-
-	case 6:
-		/* The length of the part numbers have changed. */
-		/* So the print_serial, prod_partno, etc have moved. */
-		/* Also, now the dash is part of the part number (in
-		 * accordance with our philosophy that the part numbers
-		 * are to be considered "random data"). */
-
-		memset(ser_data, 0, 128);
-
-		ser_data->cfg[0] = 0;
-		ser_data->cfg[1] = 0;
-		ser_data->cfg[2] = 0;
-
-		memcpy(ser_data->hwaddr, old.hwaddr0, 6);
-
-		memcpy(ser_data->print_partno, old.print_partno, 6);
-		ser_data->print_partno[6] = '-';
-		memcpy(ser_data->print_partno+7, old.print_partno+6, 3);
-
-		memcpy(ser_data->print_serial, old.print_serial, 14);
-
-		memcpy(ser_data->prod_partno, old.prod_partno, 6);
-		ser_data->prod_partno[6] = '-';
-		memcpy(ser_data->prod_partno+7, old.prod_partno+6, 3);
-
-		memcpy(ser_data->prod_serial, old.prod_serial, 14);
-
-		memcpy(ser_data->passwd_hash, old.passwd_hash, 16);
-
-		ser_data->vendid = old.vendor;
-		ser_data->ts_ref = old.ts_ref;
-		ser_data->ts_signoff = old.ts_signoff;
-		ser_data->serviceflag = old.writecount;
-
-		ser_data->ipaddr = old.ipaddr;
-		ser_data->netmask = old.netmask;
-
-		/* make up something */
-		ser_data->cfg[0] = 0x01132001;
-		ser_data->cfg[1] = 0x00010061;
+	int i;
+	unsigned long *lb = lasat_board_info.li_flashpart_base;
+	unsigned long *ls = lasat_board_info.li_flashpart_size;
 
-		ser_data->prid = ((ser_data->cfg[0] >> 4) & 0x0f);
-		ser_data->version = 7;
+	ls[LASAT_MTD_BOOTLOADER] = 0x40000;
+	ls[LASAT_MTD_SERVICE] = 0xC0000;
+	ls[LASAT_MTD_NORMAL] = 0x100000;
 
+	if (mips_machtype == MACH_LASAT_100) {
+		lasat_board_info.li_flash_base = KSEG1ADDR(0x1e000000);
+		
+		lb[LASAT_MTD_BOOTLOADER] = KSEG1ADDR(0x1e400000);
 
-	case 7:
-		/* Up to date */
-		return 0;
+		if (lasat_board_info.li_flash_size > 0x200000) {
+			ls[LASAT_MTD_CONFIG] = 0x100000;
+			ls[LASAT_MTD_FS] = 0x500000;
+		}
+	} else {
+		lasat_board_info.li_flash_base = KSEG1ADDR(0x10000000);
 
-	default:
-		/* What, an unknown version? */
-		return -1;
+		if (lasat_board_info.li_flash_size < 0x1000000) {
+			lb[LASAT_MTD_BOOTLOADER] = KSEG1ADDR(0x10000000);
+			ls[LASAT_MTD_CONFIG] = 0x100000;
+			if (lasat_board_info.li_flash_size >= 0x400000) {
+				ls[LASAT_MTD_FS] = lasat_board_info.li_flash_size - 0x300000;
+			}
+		}
 	}
+
+	for (i = 1; i < LASAT_MTD_LAST; i++)
+		lb[i] = lb[i-1] + ls[i-1];
 }
 
 int lasat_init_board_info(void)
@@ -139,19 +97,13 @@
 	int c;
 	unsigned long crc;
 	unsigned long cfg0, cfg1;
-	const vendor_info_t    *pvi;
 	const product_info_t   *ppi;
 	int i_n_base_models = N_BASE_MODELS;
 	const char * const * i_txt_base_models = txt_base_models;
-	int i_n_vendors = N_VENDORS;
-	vendor_info_t const *i_vendor_info_table = vendor_info_table;
 	int i_n_prids = N_PRIDS;
 
 	memset(&lasat_board_info, 0, sizeof(lasat_board_info));
 
-	/* Assume EEPROM struct is LASAT_EEPROM_VERSION */
-	lasat_board_info.li_eeprom_upgrade_version = 1;
-	
 	/* First read the EEPROM info */
 	EEPROMRead(0, (unsigned char *)&lasat_board_info.li_eeprom_info, 
 		   sizeof(struct lasat_eeprom_struct));
@@ -161,44 +113,21 @@
 		    sizeof(struct lasat_eeprom_struct) - 4);
 
 	if (crc != lasat_board_info.li_eeprom_info.crc32) {
-		return -1;
+		prom_printf("WARNING...\nWARNING...\nEEPROM CRC does not match calculated, attempting to soldier on...\n");
 	}
 
 	if (lasat_board_info.li_eeprom_info.version != LASAT_EEPROM_VERSION)
 	{
-		if (0 > upgrade_eeprom_info(&(lasat_board_info.li_eeprom_info))) {
-			printk("Upgrading EEPROM information from version %d to version %d failed!\n", 
-			       (unsigned int)lasat_board_info.li_eeprom_info.version,
-			       LASAT_EEPROM_VERSION);
-			return -1;
-		}
-		lasat_write_eeprom_info();
-
-		/* OK, the EEPROM struct is not LASAT_EEPROM_VERSION */
-		lasat_board_info.li_eeprom_upgrade_version = 0;
+		prom_printf("WARNING...\nWARNING...\nEEPROM version %d, wanted version %d, attempting to soldier on...\n",
+		       (unsigned int)lasat_board_info.li_eeprom_info.version,
+		       LASAT_EEPROM_VERSION);
 	}
 
-	/*
-	 * Part and serial no.
-	 */
-	memcpy(lasat_board_info.li_partno,
-	       lasat_board_info.li_eeprom_info.prod_partno, 12);
-	lasat_board_info.li_partno[12] = '\0';
-
-	memcpy(lasat_board_info.li_serial,
-	       lasat_board_info.li_eeprom_info.prod_serial,
-	       14);
-	lasat_board_info.li_serial[14] = '\0';
-
-	/*
-	 * If configuration field is present, use that
-	 */
-
 	cfg0 = lasat_board_info.li_eeprom_info.cfg[0];
 	cfg1 = lasat_board_info.li_eeprom_info.cfg[1];
 
 	if ( LASAT_W0_DSCTYPE(cfg0) != 1) {
-		return -1;
+		prom_printf("WARNING...\nWARNING...\nInvalid configuration read from EEPROM, attempting to soldier on...");
 	}
 	/* We have a valid configuration */
 
@@ -282,35 +211,6 @@
 		break;
 	}
 
-	switch (LASAT_W1_EDHAC(cfg1)) {
-	case 0x0:
-		lasat_board_info.li_edhac = 0;
-		lasat_board_info.li_eadi  = 0;
-		break;
-	case 0x1:
-		lasat_board_info.li_edhac = 0;
-		lasat_board_info.li_eadi  = 1;
-		break;
-	case 0x2:
-		lasat_board_info.li_edhac = 1;
-		lasat_board_info.li_eadi  = 1;
-		break;
-	case 0x3:
-		lasat_board_info.li_edhac = 2;
-		lasat_board_info.li_eadi  = 1;
-		break;
-	}
-	/* The 200 board always has EADI */
-	if (LASAT_W0_CPUTYPE(cfg0) == 1) {
-		lasat_board_info.li_eadi = 1;
-	}
-
-	lasat_board_info.li_hifn = LASAT_W1_HIFN(cfg1);
-	lasat_board_info.li_isdn = LASAT_W1_ISDN(cfg1);
-	lasat_board_info.li_ide  = LASAT_W1_IDE(cfg1);
-	lasat_board_info.li_hdlc = LASAT_W1_HDLC(cfg1);
-	lasat_board_info.li_usversion = LASAT_W1_USVERSION(cfg1);
-
 	/* Flash size */
 	switch (LASAT_W1_FLASHSIZE(cfg1)) {
 	case 0:
@@ -330,73 +230,25 @@
 		break;
 	}
 
-	/* Flash base addresses */
-	if (mips_machtype == MACH_LASAT_100) {
-		lasat_board_info.li_flash_base = KSEG1ADDR(0x1e000000);
-		lasat_board_info.li_flash_service_base = KSEG1ADDR(0x1e400000);
-		lasat_board_info.li_flash_service_size = 0x100000;
-		lasat_board_info.li_flash_normal_base = KSEG1ADDR(0x1e500000);
-		lasat_board_info.li_flash_normal_size = 0x100000;
-		if (lasat_board_info.li_flash_size > 0x200000) {
-			lasat_board_info.li_flash_cfg_base = KSEG1ADDR(0x1e600000);
-			lasat_board_info.li_flash_cfg_size = 0x100000;
-			lasat_board_info.li_flash_fs_base = KSEG1ADDR(0x1e700000);
-			lasat_board_info.li_flash_fs_size = 0x500000;
-		}
-	} else {
-		lasat_board_info.li_flash_base = KSEG1ADDR(0x10000000);
-		if (lasat_board_info.li_flash_size < 0x1000000) {
-			lasat_board_info.li_flash_service_base = KSEG1ADDR(0x10000000);
-			lasat_board_info.li_flash_service_size = 0x100000;
-			lasat_board_info.li_flash_cfg_base = KSEG1ADDR(0x10200000);
-			lasat_board_info.li_flash_cfg_size = 0x100000;
-			lasat_board_info.li_flash_normal_base = KSEG1ADDR(0x10100000);
-			lasat_board_info.li_flash_normal_size = 0x100000;
-			if (lasat_board_info.li_flash_size >= 0x400000) {
-				lasat_board_info.li_flash_fs_base = KSEG1ADDR(0x10300000);
-				lasat_board_info.li_flash_fs_size = 
-					lasat_board_info.li_flash_size - 0x300000;
-			}
-		} else {
-			lasat_board_info.li_flash_service_base = KSEG1ADDR(0x10400000);
-			lasat_board_info.li_flash_service_size = 0x100000;
-			lasat_board_info.li_flash_cfg_base = KSEG1ADDR(0x10000000);
-			lasat_board_info.li_flash_cfg_size = 0x200000;
-			lasat_board_info.li_flash_normal_base = KSEG1ADDR(0x10200000);
-			lasat_board_info.li_flash_normal_size = 0x100000;
-			lasat_board_info.li_flash_fs_base = KSEG1ADDR(0x10500000);
-			lasat_board_info.li_flash_fs_size = 0xa00000;
-		}
-	}
+	init_flash_sizes();
 
 	lasat_board_info.li_bmid = LASAT_W0_BMID(cfg0);
 	lasat_board_info.li_prid = lasat_board_info.li_eeprom_info.prid;
 	if (lasat_board_info.li_prid == 0xffff || lasat_board_info.li_prid == 0)
 		lasat_board_info.li_prid = lasat_board_info.li_bmid;
-	lasat_board_info.li_vendid = lasat_board_info.li_eeprom_info.vendid;
 
 	/* Base model stuff */
 	if (lasat_board_info.li_bmid > i_n_base_models)
 		lasat_board_info.li_bmid = i_n_base_models;
 	strcpy(lasat_board_info.li_bmstr, i_txt_base_models[lasat_board_info.li_bmid]);
 
-	/* Vendor stuff */
-	if (lasat_board_info.li_vendid >= i_n_vendors)
-		lasat_board_info.li_vendid = 0;
-	pvi = &i_vendor_info_table[lasat_board_info.li_vendid];
-	strcpy(lasat_board_info.li_vendstr, pvi->vi_name);
-
 	/* Product ID dependent values */
 	c = lasat_board_info.li_prid;
 	if (c >= i_n_prids) {
 		strcpy(lasat_board_info.li_namestr, "Unknown Model");
 		strcpy(lasat_board_info.li_typestr, "Unknown Type");
-		lasat_board_info.li_vpn_kbps = 0;
-		lasat_board_info.li_vpn_tunnels = 0;
-		lasat_board_info.li_vpn_clients = 0;
 	} else {
-		/* Product ID names (also depending on vendor ID) */
-		ppi = &pvi->vi_product_info[c];
+		ppi = &vendor_info_table[0].vi_product_info[c];
 		strcpy(lasat_board_info.li_namestr, ppi->pi_name);
 		if (ppi->pi_type)
 			strcpy(lasat_board_info.li_typestr, ppi->pi_type);
@@ -404,7 +256,9 @@
 			sprintf(lasat_board_info.li_typestr, "%d",10*c);
 	}
 
-	lasat_board_info.li_debugaccess = lasat_board_info.li_eeprom_info.debugaccess;
+#if defined(CONFIG_INET) && defined(CONFIG_SYSCTL)
+	update_bcastaddr();
+#endif
 
 	return 0;
 }
@@ -423,19 +277,3 @@
 		    sizeof(struct lasat_eeprom_struct));
 }
 
-char *get_firmware_version(void)
-{
-	char *fw;
-	fw = (unsigned char *)(lasat_board_info.li_flash_normal_base);
-
-	if ( (((unsigned long *)fw)[0] != 0xfedeabba) ||
-			(((unsigned long *)fw)[1] != 0x00bedead))
-		return "NONE";
-
-	fw += 0x50;
-	if ((*fw == 0) || (strlen(fw) > 175)) {
-		return "UNKNOWN";
-	}
-
-	return fw;
-}
Index: arch/mips/lasat/pci.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/pci.c,v
retrieving revision 1.1.1.3
retrieving revision 1.7
diff -u -r1.1.1.3 -r1.7
--- arch/mips/lasat/pci.c	11 Jan 2003 23:38:10 -0000	1.1.1.3
+++ arch/mips/lasat/pci.c	11 Jan 2003 23:47:58 -0000	1.7
@@ -164,16 +164,16 @@
 {
         u32 data=0, flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	if (lasat_pcibios_config_access(PCI_ACCESS_READ, dev, reg, &data)) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return -1;
 	}
 
 	*val = (data >> ((reg & 3) << 3)) & 0xff;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -185,16 +185,16 @@
 	if (reg & 1)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	if (lasat_pcibios_config_access(PCI_ACCESS_READ, dev, reg, &data)) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return -1;
 	}
 
 	*val = (data >> ((reg & 3) << 3)) & 0xffff;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -205,16 +205,16 @@
 	if (reg & 3)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	if (lasat_pcibios_config_access(PCI_ACCESS_READ, dev, reg, &data)) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return -1;
 	}
 
 	*val = data;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -223,7 +223,7 @@
 {
         u32 data=0, flags, err;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
         err = lasat_pcibios_config_access(PCI_ACCESS_READ, dev, reg, &data);
         if (err)
@@ -234,7 +234,7 @@
 
 	err = lasat_pcibios_config_access(PCI_ACCESS_WRITE, dev, reg, &data);
 out:
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if (err)
 		return -1;
@@ -249,7 +249,7 @@
 	if (reg & 1)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
        
-	save_and_cli(flags);
+	local_irq_save(flags);
 
         err = lasat_pcibios_config_access(PCI_ACCESS_READ, dev, reg, &data);
         if (err)
@@ -260,7 +260,7 @@
 
 	err = lasat_pcibios_config_access(PCI_ACCESS_WRITE, dev, reg, &data);
 out:
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if (err)
 		return -1;
@@ -275,10 +275,10 @@
 	if (reg & 3)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	err = lasat_pcibios_config_access(PCI_ACCESS_WRITE, dev, reg, &val);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if (err)
 		return -1;
Index: arch/mips/lasat/picvue.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/picvue.c,v
retrieving revision 1.1.1.2
retrieving revision 1.11
diff -u -r1.1.1.2 -r1.11
--- arch/mips/lasat/picvue.c	13 Dec 2002 23:41:18 -0000	1.1.1.2
+++ arch/mips/lasat/picvue.c	6 Feb 2003 21:52:44 -0000	1.11
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 #include "picvue.h"
 
@@ -109,7 +110,8 @@
 	pvc_wait();
 }
 
-void pvc_write_string(const unsigned char *str, u8 addr, int line) {
+void pvc_write_string(const unsigned char *str, u8 addr, int line)
+{
 	int i = 0;
 
 	if (line > 0 && (PVC_NLINES > 1))
@@ -122,9 +124,33 @@
 	}
 }
 
+void pvc_write_string_centered(const unsigned char *str, int line)
+{
+	int len = strlen(str);
+	u8 addr;
+
+	if (len > PVC_VISIBLE_CHARS)
+		addr = 0;
+	else
+		addr = (PVC_VISIBLE_CHARS - strlen(str))/2;
+
+	pvc_write_string(str, addr, line);
+}
+
+void pvc_dump_string(const unsigned char *str)
+{
+	int len = strlen(str);
+
+	pvc_clear();
+	pvc_write_string(str, 0, 0);
+	if (len > PVC_VISIBLE_CHARS)
+		pvc_write_string(&str[PVC_VISIBLE_CHARS], 0, 1);
+}
+
 #define BM_SIZE			8
 #define MAX_PROGRAMMABLE_CHARS	8
-int pvc_program_cg(int charnum, u8 bitmap[BM_SIZE]) {
+int pvc_program_cg(int charnum, u8 bitmap[BM_SIZE])
+{
 	int i;
 	int addr;
 
@@ -146,7 +172,8 @@
 #define  ONE_LINE	0
 #define  LARGE_FONT	(1 << 2)
 #define  SMALL_FONT	0
-static void pvc_funcset(u8 cmd) {
+static void pvc_funcset(u8 cmd)
+{
 	pvc_write(FUNC_SET_CMD | (cmd & (EIGHT_BYTE|TWO_LINES|LARGE_FONT)), MODE_INST);
 }
 
@@ -154,7 +181,8 @@
 #define  AUTO_INC		(1 << 1)
 #define  AUTO_DEC		0
 #define  CURSOR_FOLLOWS_DISP	(1 << 0)
-static void pvc_entrymode(u8 cmd) {
+static void pvc_entrymode(u8 cmd)
+{
 	pvc_write(ENTRYMODE_CMD | (cmd & (AUTO_INC|CURSOR_FOLLOWS_DISP)), MODE_INST);
 }
 
@@ -163,7 +191,8 @@
 #define  DISP_ON	(1 << 2)
 #define  CUR_ON		(1 << 1)
 #define  CUR_BLINK	(1 << 0)
-void pvc_dispcnt(u8 cmd) {
+void pvc_dispcnt(u8 cmd)
+{
 	pvc_write(DISP_CNT_CMD | (cmd & (DISP_ON|CUR_ON|CUR_BLINK)), MODE_INST);
 }
 
@@ -172,17 +201,20 @@
 #define  CURSOR		0
 #define  RIGHT		(1 << 2)
 #define  LEFT		0
-void pvc_move(u8 cmd) {
+void pvc_move(u8 cmd)
+{
 	pvc_write(MOVE_CMD | (cmd & (DISPLAY|RIGHT)), MODE_INST);
 }
 
 #define CLEAR_CMD	0x1
-void pvc_clear(void) {
+void pvc_clear(void)
+{
 	pvc_write(CLEAR_CMD, MODE_INST);
 }
 
 #define HOME_CMD	0x2
-void pvc_home(void) {
+void pvc_home(void)
+{
 	pvc_write(HOME_CMD, MODE_INST);
 }
 
@@ -197,6 +229,10 @@
 	pvc_funcset(cmd);
 	pvc_dispcnt(DISP_ON);
 	pvc_entrymode(AUTO_INC);
+
+	pvc_clear();
+	pvc_write_string_centered("Display", 0);
+	pvc_write_string_centered("Initialized", 1);
 
 	return 0;
 }
Index: arch/mips/lasat/picvue.h
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/picvue.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 picvue.h
--- arch/mips/lasat/picvue.h	13 Dec 2002 23:41:18 -0000	1.1.1.2
+++ arch/mips/lasat/picvue.h	19 Feb 2003 20:29:12 -0000
@@ -23,6 +23,8 @@
 #define PVC_VISIBLE_CHARS	16
 
 void pvc_write_string(const unsigned char *str, u8 addr, int line);
+void pvc_write_string_centered(const unsigned char *str, int line);
+void pvc_dump_string(const unsigned char *str);
 
 #define BM_SIZE			8
 #define MAX_PROGRAMMABLE_CHARS	8
Index: arch/mips/lasat/picvue_proc.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/picvue_proc.c,v
retrieving revision 1.1.1.2
retrieving revision 1.6
diff -u -r1.1.1.2 -r1.6
--- arch/mips/lasat/picvue_proc.c	13 Dec 2002 23:41:18 -0000	1.1.1.2
+++ arch/mips/lasat/picvue_proc.c	12 Jan 2003 17:10:28 -0000	1.6
@@ -81,7 +81,7 @@
         return origcount;
 }
 
-static int pvc_proc_scroll(struct file *file, const char *buffer,            
+static int pvc_proc_write_scroll(struct file *file, const char *buffer,
                            unsigned long count, void *data)
 {
         int origcount = count;
@@ -109,6 +109,20 @@
         return origcount;
 }
 
+static int pvc_proc_read_scroll(char *page, char **start,
+                             off_t off, int count,
+                             int *eof, void *data)
+{
+        char *origpage = page;
+
+	down(&pvc_sem);
+        page += sprintf(page, "%d\n", scroll_dir * scroll_interval);
+	up(&pvc_sem);
+
+        return page - origpage; 
+}
+
+
 void pvc_proc_timerfunc(unsigned long data)
 {
 	if (scroll_dir < 0)
@@ -155,7 +169,8 @@
 	proc_entry = create_proc_entry("scroll", 0644, pvc_display_dir);
 	if (proc_entry == NULL)
 		goto error;
-	proc_entry->write_proc = pvc_proc_scroll;
+	proc_entry->write_proc = pvc_proc_write_scroll;
+	proc_entry->read_proc = pvc_proc_read_scroll;
 
 	init_timer(&timer);
 	timer.function = pvc_proc_timerfunc;
Index: arch/mips/lasat/prom.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/prom.c,v
retrieving revision 1.1.1.2
retrieving revision 1.12
diff -u -r1.1.1.2 -r1.12
--- arch/mips/lasat/prom.c	13 Dec 2002 23:41:18 -0000	1.1.1.2
+++ arch/mips/lasat/prom.c	6 Feb 2003 21:28:52 -0000	1.12
@@ -1,6 +1,7 @@
 /*
  * PROM interface routines.
  */
+#include <linux/types.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -15,6 +16,74 @@
 
 #include "at93c.h"
 #include <asm/lasat/eeprom.h>
+#include "prom.h"
+
+#define RESET_VECTOR	0xbfc00000
+#define PROM_JUMP_TABLE_ENTRY(n) (*((u32 *)(RESET_VECTOR + 0x20) + n))
+#define PROM_DISPLAY_ADDR	PROM_JUMP_TABLE_ENTRY(0)
+#define PROM_PUTC_ADDR		PROM_JUMP_TABLE_ENTRY(1)
+#define PROM_MONITOR_ADDR	PROM_JUMP_TABLE_ENTRY(2)
+
+static void null_prom_printf(const char * fmt, ...)
+{
+}
+
+static void null_prom_display(const char *string, int pos, int clear)
+{
+}
+
+static void null_prom_monitor(void)
+{
+}
+
+static void null_prom_putc(char c)
+{
+}
+
+/* these are functions provided by the bootloader */
+static void (* prom_putc)(char c) = null_prom_putc;
+void (* prom_printf)(const char * fmt, ...) = null_prom_printf;
+void (* prom_display)(const char *string, int pos, int clear) = 
+		null_prom_display;
+void (* prom_monitor)(void) = null_prom_monitor;
+
+#define PROM_PRINTFBUF_SIZE 256
+static char prom_printfbuf[PROM_PRINTFBUF_SIZE];
+
+static void real_prom_printf(const char * fmt, ...)
+{
+	va_list ap;
+	int len;
+	char *c = prom_printfbuf;
+	int i;
+
+	va_start(ap, fmt);
+	len = vsnprintf(prom_printfbuf, PROM_PRINTFBUF_SIZE, fmt, ap);
+	va_end(ap);
+
+	/* output overflowed the buffer */
+	if (len < 0 || len > PROM_PRINTFBUF_SIZE)
+		len = PROM_PRINTFBUF_SIZE;
+
+	for (i=0; i < len; i++) {
+		if (*c == '\n')
+			prom_putc('\r');
+		prom_putc(*c++);
+	}
+}
+
+static void setup_prom_vectors(void)
+{
+	u32 version = *(u32 *)(RESET_VECTOR + 0x90);
+
+	if (version == 306) {
+		prom_display = (void *)PROM_DISPLAY_ADDR;
+		prom_putc = (void *)PROM_PUTC_ADDR;
+		prom_printf = real_prom_printf;
+		prom_monitor = (void *)PROM_MONITOR_ADDR;
+	}
+	prom_printf("prom vectors set up\n");
+}
 
 char arcs_cmdline[CL_SIZE];
 
@@ -27,6 +96,8 @@
 
 void __init prom_init(int argc, char **argv, char **envp, int *prom_vec)
 {
+	setup_prom_vectors();
+
 	if (mips_cpu.cputype == CPU_R5000)
 		mips_machtype = MACH_LASAT_200;
 	else
@@ -50,21 +121,12 @@
 	/* Set memory regions */
 	ioport_resource.start = 0;		/* Should be KSEGx ???	*/
 	ioport_resource.end = 0xffffffff;	/* Should be ???	*/
-#if 0
-	/*
-	 * We should do it right, i.e. like this, in stead of passing mem=xxxM.
-	 */
+
 	add_memory_region(0, lasat_board_info.li_memsize, BOOT_MEM_RAM);
-#endif
 }
 
 void prom_free_prom_memory(void)
 {
-}
-
-void prom_printf(const char * fmt, ...)
-{
-	return;
 }
 
 const char *get_system_type(void)
Index: arch/mips/lasat/prom.h
===================================================================
RCS file: arch/mips/lasat/prom.h
diff -N arch/mips/lasat/prom.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ arch/mips/lasat/prom.h	4 Feb 2003 20:38:40 -0000	1.2
@@ -0,0 +1,6 @@
+#ifndef PROM_H
+#define PROM_H
+extern void (* prom_display)(const char *string, int pos, int clear);
+extern void (* prom_monitor)(void);
+extern void (* prom_printf)(const char * fmt, ...);
+#endif
Index: arch/mips/lasat/reset.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/reset.c,v
retrieving revision 1.1.1.2
retrieving revision 1.6
diff -u -r1.1.1.2 -r1.6
--- arch/mips/lasat/reset.c	13 Dec 2002 23:41:18 -0000	1.1.1.2
+++ arch/mips/lasat/reset.c	12 Jan 2003 17:10:28 -0000	1.6
@@ -29,6 +29,7 @@
 #include <asm/system.h>
 #include <asm/lasat/lasat.h>
 #include "picvue.h"
+#include "prom.h"
 
 static void lasat_machine_restart(char *command);
 static void lasat_machine_halt(void);
@@ -38,31 +39,29 @@
 
 static void lasat_machine_restart(char *command)
 {
-	cli();
+	local_irq_disable();
 
-	{
-		volatile unsigned int *softres_reg = lasat_misc->reset_reg;
-
-		if (lasat_boot_to_service) {
-			printk("machine_restart: Rebooting to service mode\n");
-			*(volatile unsigned int *)0xa0000024 = 0xdeadbeef;
-			*(volatile unsigned int *)0xa00000fc = 0xfedeabba;
-		}
-		*softres_reg = 0xbedead;
+	if (lasat_boot_to_service) {
+		printk("machine_restart: Rebooting to service mode\n");
+		*(volatile unsigned int *)0xa0000024 = 0xdeadbeef;
+		*(volatile unsigned int *)0xa00000fc = 0xfedeabba;
 	}
+	*lasat_misc->reset_reg = 0xbedead;
 	for (;;) ;
 }
 
 #define MESSAGE "System halted"
 static void lasat_machine_halt(void)
 {
+	local_irq_disable();
+
 	/* Disable interrupts and loop forever */
 	printk(KERN_NOTICE MESSAGE "\n");
 #ifdef CONFIG_PICVUE
 	pvc_clear();
 	pvc_write_string(MESSAGE, 0, 0);
 #endif
-	cli();
+	prom_monitor();
 	for (;;) ;
 }
 
Index: arch/mips/lasat/setup.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/setup.c,v
retrieving revision 1.1.1.4
retrieving revision 1.19
diff -u -r1.1.1.4 -r1.19
--- arch/mips/lasat/setup.c	13 Dec 2002 23:41:18 -0000	1.1.1.4
+++ arch/mips/lasat/setup.c	19 Jan 2003 22:05:31 -0000	1.19
@@ -7,6 +7,8 @@
  * Thomas Horsten <thh@lasat.com>
  * Copyright (C) 2000 LASAT Networks A/S.
  *
+ * Brian Murphy <brian@murphy.dk>
+ *
  * ########################################################################
  *
  *  This program is free software; you can distribute it and/or modify it
@@ -40,7 +42,6 @@
 #include <asm/irq.h>
 #include <asm/lasat/lasat.h>
 
-#include <asm/lasat/lasat_mtd.h>
 #include <linux/serial.h>
 #include <asm/serial.h>
 #include <asm/lasat/serial.h>
@@ -55,6 +56,8 @@
 #include <asm/lasat/picvue.h>
 #include <asm/lasat/eeprom.h>
 
+#include "prom.h"
+
 int lasat_command_line = 0;
 void lasatint_init(void);
 
@@ -98,27 +101,34 @@
 	{ (void *)PVC_REG_200, PVC_DATA_SHIFT_200, PVC_DATA_M_200,
 		PVC_E_200, PVC_RW_200, PVC_RS_200 }
 };
+#endif
 
-
-static int lasat_panic_event(struct notifier_block *this,
+static int lasat_panic_display(struct notifier_block *this,
 			     unsigned long event, void *ptr)
 {
+#ifdef CONFIG_PICVUE
 	unsigned char *string = ptr;
 	if (string == NULL)
 		string = "Kernel Panic";
-	pvc_write_string(string, 0, 0);
-	if (strlen(string) > PVC_VISIBLE_CHARS)
-		pvc_write_string(&string[PVC_VISIBLE_CHARS], 0, 1);
+	pvc_dump_string(string);
+#endif
+	return NOTIFY_DONE;
+}
+
+static int lasat_panic_prom_monitor(struct notifier_block *this,
+			     unsigned long event, void *ptr)
+{
+	prom_monitor();
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block lasat_panic_block = {
-	lasat_panic_event,
-	NULL,
-	INT_MAX /* try to do it first */
+static struct notifier_block lasat_panic_block[] = 
+{
+	{ lasat_panic_display, NULL, INT_MAX },
+	{ lasat_panic_prom_monitor, NULL, INT_MIN }
 };
-#endif
 
+#ifdef CONFIG_BLK_DEV_IDE
 static int lasat_ide_default_irq(ide_ioreg_t base) {
 	return 0;
 }
@@ -126,6 +136,7 @@
 static ide_ioreg_t lasat_ide_default_io_base(int index) {
 	return 0;
 }
+#endif
 
 static void lasat_time_init(void)
 {
@@ -176,14 +187,16 @@
 
 void __init lasat_setup(void)
 {
+	int i;
 	lasat_misc  = &lasat_misc_info[mips_machtype];
 #ifdef CONFIG_PICVUE
 	picvue = &pvc_defs[mips_machtype];
-	/* Set up panic notifier */
-
-	notifier_chain_register(&panic_notifier_list, &lasat_panic_block);
 #endif
 
+	/* Set up panic notifier */
+	for (i = 0; i < sizeof(lasat_panic_block) / sizeof(struct notifier_block); i++)
+		notifier_chain_register(&panic_notifier_list, &lasat_panic_block[i]);
+
 #ifdef CONFIG_BLK_DEV_IDE
 	ide_ops = &std_ide_ops;
 	ide_ops->ide_default_irq = &lasat_ide_default_irq;
@@ -205,76 +218,8 @@
 
 	/* Switch from prom exception handler to normal mode */
 	change_c0_status(ST0_BEV,0);
-}
-
-#ifdef CONFIG_LASAT_SERVICE
-/*
- * Called by init() (just before starting user space init program)
- */
-static int __init lasat_init(void)
-{
-	/* This is where we call service mode */
-	lasat_service();
-	for (;;) {}	/* We should never get here */
-
-	return 0;
-}
-
-__initcall(lasat_init);
-#endif
-
-unsigned long lasat_flash_partition_start(int partno)
-{
-	unsigned long dst;
-
-	switch (partno) {
-	case LASAT_MTD_BOOTLOADER:
-		dst = lasat_board_info.li_flash_service_base;
-		break;
-	case LASAT_MTD_SERVICE:
-		dst = lasat_board_info.li_flash_service_base + BOOTLOADER_SIZE;
-		break;
-	case LASAT_MTD_NORMAL:
-		dst = lasat_board_info.li_flash_normal_base;
-		break;
-	case LASAT_MTD_FS:
-		dst = lasat_board_info.li_flash_fs_base;
-		break;
-	case LASAT_MTD_CONFIG:
-		dst = lasat_board_info.li_flash_cfg_base;
-		break;
-	default:
-		dst = 0;
-		break;
-	}
 
-	return dst;
+	prom_printf("Lasat specific initialization complete\n");
 }
 
-unsigned long lasat_flash_partition_size(int partno)
-{
-	unsigned long size;
-
-	switch (partno) {
-	case LASAT_MTD_BOOTLOADER:
-		size = BOOTLOADER_SIZE;
-		break;
-	case LASAT_MTD_SERVICE:
-		size = lasat_board_info.li_flash_service_size - BOOTLOADER_SIZE;
-		break;
-	case LASAT_MTD_NORMAL:
-		size = lasat_board_info.li_flash_normal_size;
-		break;
-	case LASAT_MTD_FS:
-		size = lasat_board_info.li_flash_fs_size;
-		break;
-	case LASAT_MTD_CONFIG:
-		size = lasat_board_info.li_flash_cfg_size;
-		break;
-	default:
-		size = 0;
-		break;
-	}
 
-	return size;
-}
Index: arch/mips/lasat/sysctl.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/sysctl.c,v
retrieving revision 1.1.1.1
retrieving revision 1.5
diff -u -r1.1.1.1 -r1.5
--- arch/mips/lasat/sysctl.c	8 Oct 2002 18:52:04 -0000	1.1.1.1
+++ arch/mips/lasat/sysctl.c	19 Feb 2003 21:42:14 -0000	1.5
@@ -23,6 +23,7 @@
  *
  * Routines specific to the LASAT boards
  */
+#include <linux/types.h>
 #include <asm/lasat/lasat.h>
 
 #include <linux/config.h>
@@ -39,8 +40,6 @@
 #include "sysctl.h"
 #include "ds1603.h"
 
-static char lasat_firmware_version[176];
-
 static DECLARE_MUTEX(lasat_info_sem);
 
 /* Strategy function to write EEPROM after changing string entry */ 
@@ -96,25 +95,6 @@
 	return 0;
 }
 
-/* Same for vendor ID that's only a char in EEPROM struct */
-int proc_dolasatvendor(ctl_table *table, int write, struct file *filp,
-		       void *buffer, size_t *lenp)
-{
-	int r;
-	down(&lasat_info_sem);
-	r = proc_dointvec(table, write, filp, buffer, lenp);
-	if ( (!write) || r) {
-		up(&lasat_info_sem);
-		return r;
-	}
-	lasat_board_info.li_eeprom_info.vendid = 
-		lasat_board_info.li_vendid & 0xff;
-	lasat_board_info.li_vendid &= 0xff;
-	lasat_write_eeprom_info();
-	up(&lasat_info_sem);
-	return 0;
-}
-
 static int rtctmp;
 
 #ifdef CONFIG_DS1603
@@ -185,6 +165,22 @@
 #endif
 
 #ifdef CONFIG_INET
+static char lasat_bcastaddr[16];
+
+void update_bcastaddr(void)
+{
+	unsigned int ip;
+	
+	ip = lasat_board_info.li_eeprom_info.ipaddr |
+		~lasat_board_info.li_eeprom_info.netmask;
+
+	sprintf(lasat_bcastaddr, "%d.%d.%d.%d",
+			(ip      ) & 0xff,
+			(ip >>  8) & 0xff,
+			(ip >> 16) & 0xff,
+			(ip >> 24) & 0xff);
+}
+
 static char proc_lasat_ipbuf[32];
 /* Parsing of IP address */
 int proc_lasat_ip(ctl_table *table, int write, struct file *filp,
@@ -251,6 +247,7 @@
 		*lenp = len;
 		filp->f_pos += len;
 	}
+	update_bcastaddr();
 	up(&lasat_info_sem);
 	return 0;
 }
@@ -274,8 +271,6 @@
 	{
 		if (name && *name == LASAT_PRID)
 			lasat_board_info.li_eeprom_info.prid = *(int*)newval;
-		if (name && *name == LASAT_DEBUGACCESS)
-			lasat_board_info.li_eeprom_info.debugaccess = *(char*)newval;
 
 		lasat_write_eeprom_info();
 		lasat_init_board_info();
@@ -318,66 +313,29 @@
 	 0444, NULL, &proc_dointvec, &sysctl_intvec},
 	{LASAT_MODEL, "bmid", &lasat_board_info.li_bmid, sizeof(int),
 	 0444, NULL, &proc_dointvec, &sysctl_intvec},
-	{LASAT_SERIAL, "serial", &lasat_board_info.li_serial, sizeof(lasat_board_info.li_serial),
-	 0444, NULL, &proc_dostring, &sysctl_string},
-	{LASAT_PARTNO, "partno", &lasat_board_info.li_partno, sizeof(lasat_board_info.li_partno),
-	 0444, NULL, &proc_dostring, &sysctl_string},
-	{LASAT_EDHAC, "edhac", &lasat_board_info.li_edhac, sizeof(int),
-	 0444, NULL, &proc_dointvec, &sysctl_intvec},
-	{LASAT_EADI, "eadi", &lasat_board_info.li_eadi, sizeof(int),
-	 0444, NULL, &proc_dointvec, &sysctl_intvec},
-	{LASAT_LEASEDLINE, "leasedline", &lasat_board_info.li_leasedline, sizeof(int),
-	 0444, NULL, &proc_dointvec, &sysctl_intvec},
-	{LASAT_ISDN, "isdn", &lasat_board_info.li_isdn, sizeof(int),
-	 0444, NULL, &proc_dointvec, &sysctl_intvec},
-	{LASAT_HIFN, "hifn", &lasat_board_info.li_hifn, sizeof(int),
-	 0444, NULL, &proc_dointvec, &sysctl_intvec},
-	{LASAT_USVER, "us-version", &lasat_board_info.li_usversion, sizeof(int),
-	 0444, NULL, &proc_dointvec, &sysctl_intvec},
 	{LASAT_PRID, "prid", &lasat_board_info.li_prid, sizeof(int),
 	 0644, NULL, &proc_lasat_eeprom_value, &sysctl_lasat_eeprom_value},
-	{LASAT_VENDID, "vendid", &lasat_board_info.li_vendid, sizeof(int),
-	 0644, NULL, &proc_dolasatvendor, &sysctl_intvec},
 #ifdef CONFIG_INET
 	{LASAT_IPADDR, "ipaddr", &lasat_board_info.li_eeprom_info.ipaddr, sizeof(int),
 	 0644, NULL, &proc_lasat_ip, &sysctl_lasat_intvec},
 	{LASAT_NETMASK, "netmask", &lasat_board_info.li_eeprom_info.netmask, sizeof(int),
 	 0644, NULL, &proc_lasat_ip, &sysctl_lasat_intvec},
+	{LASAT_BCAST, "bcastaddr", &lasat_bcastaddr, 
+		sizeof(lasat_bcastaddr), 0600, NULL, 
+		&proc_dostring, &sysctl_string},
 #endif
 	{LASAT_PASSWORD, "passwd_hash", &lasat_board_info.li_eeprom_info.passwd_hash, sizeof(lasat_board_info.li_eeprom_info.passwd_hash),
 	 0600, NULL, &proc_dolasatstring, &sysctl_lasatstring},
-	{LASAT_SERVICEFLAG, "serviceflag", &lasat_board_info.li_eeprom_info.serviceflag, sizeof(lasat_board_info.li_eeprom_info.serviceflag),
-	 0644, NULL, &proc_dolasatint, &sysctl_lasat_intvec},
 	{LASAT_SBOOT, "boot-service", &lasat_boot_to_service, sizeof(int),
-	 0666, NULL, &proc_dointvec, &sysctl_intvec},
+	 0644, NULL, &proc_dointvec, &sysctl_intvec},
 #if CONFIG_DS1603
 	{LASAT_RTC, "rtc", &rtctmp, sizeof(int),
 	 0644, NULL, &proc_dolasatrtc, &sysctl_lasat_rtc},
 #endif
-	{LASAT_VER, "version", &lasat_firmware_version, 176,
-	 0444, NULL, &proc_dostring, &sysctl_string},
-	{LASAT_SERVICEVER, "service-version", (char*)0xbfc00100/* fixed position */, 64,
-	 0444, NULL, &proc_dostring, &sysctl_string},
-#if 0
-	{LASAT_WANLED, "wan_led", &lasat_wan_led, sizeof(int),
-	 0644, NULL, &proc_dointvec, &sysctl_intvec},
-#endif
- 	{LASAT_UPGRADE, "upgrade_eeprom", &lasat_board_info.li_eeprom_upgrade_version, sizeof(int),
-	 0644, NULL, &proc_dointvec, &sysctl_intvec},
- 	{LASAT_VPN_KBPS, "vpn_kbps", &lasat_board_info.li_vpn_kbps, sizeof(int),
-	 0644, NULL, &proc_dointvec, &sysctl_intvec},
- 	{LASAT_TUNNELS, "vpn_tunnels", &lasat_board_info.li_vpn_tunnels, sizeof(int),
-	 0644, NULL, &proc_dointvec, &sysctl_intvec},
- 	{LASAT_CLIENTS, "vpn_clients", &lasat_board_info.li_vpn_clients, sizeof(int),
-	 0644, NULL, &proc_dointvec, &sysctl_intvec},
-	{LASAT_VENDSTR, "vendstr", &lasat_board_info.li_vendstr, sizeof(lasat_board_info.li_vendstr),
-	 0444, NULL, &proc_dostring, &sysctl_string},
 	{LASAT_NAMESTR, "namestr", &lasat_board_info.li_namestr, sizeof(lasat_board_info.li_namestr),
 	 0444, NULL, &proc_dostring, &sysctl_string},
 	{LASAT_TYPESTR, "typestr", &lasat_board_info.li_typestr, sizeof(lasat_board_info.li_typestr),
 	 0444, NULL, &proc_dostring, &sysctl_string},
-	{LASAT_DEBUGACCESS, "debugaccess", &lasat_board_info.li_debugaccess, sizeof(int),
-	 0644, NULL, &proc_lasat_eeprom_value, &sysctl_lasat_eeprom_value},
 	{0}
 };
 
Index: arch/mips/lasat/sysctl.h
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/sysctl.h,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- arch/mips/lasat/sysctl.h	8 Oct 2002 18:52:04 -0000	1.1.1.1
+++ arch/mips/lasat/sysctl.h	19 Jan 2003 20:05:36 -0000	1.2
@@ -8,36 +8,17 @@
 /* /proc/sys/lasat */
 enum {
 	LASAT_CPU_HZ=1,
-	LASAT_BUS_HZ=2,
-	LASAT_MODEL=3,
-	LASAT_SERIAL=4,
-	LASAT_PARTNO=5,
-	LASAT_EDHAC=6,
-	LASAT_EADI=7,
-	LASAT_LEASEDLINE=8,
-	LASAT_ISDN=9,
-	LASAT_HIFN=10,
-	LASAT_USVER=11,
-	LASAT_PRID=12,
-	LASAT_IPADDR=13,
-	LASAT_NETMASK=14,
-	LASAT_PASSWORD=15,
-	LASAT_SERVICEFLAG=16,
-	LASAT_VENDID=17,
-	LASAT_SBOOT=18,
-	LASAT_RTC=19,
-/*	LASAT_CFG=20,		*/
-	LASAT_VER=21,
-/*	LASAT_WANLED=22,	*/
-	LASAT_UPGRADE=23,
-	LASAT_VPN_KBPS=24,
-	LASAT_TUNNELS=25,
-	LASAT_CLIENTS=26,
-	LASAT_VENDSTR=27,
-	LASAT_NAMESTR=28,
-	LASAT_TYPESTR=29,
-	LASAT_SERVICEVER=30,
-	LASAT_DEBUGACCESS=31,
+	LASAT_BUS_HZ,
+	LASAT_MODEL,
+	LASAT_PRID,
+	LASAT_IPADDR,
+	LASAT_NETMASK,
+	LASAT_BCAST,
+	LASAT_PASSWORD,
+	LASAT_SBOOT,
+	LASAT_RTC,
+	LASAT_NAMESTR,
+	LASAT_TYPESTR,
 };
 
 #endif /* _LASAT_SYSCTL_H */
Index: arch/mips/lasat/image/Makefile
===================================================================
RCS file: /cvs/linux-mips/arch/mips/lasat/image/Makefile,v
retrieving revision 1.1.1.2
retrieving revision 1.6
diff -u -r1.1.1.2 -r1.6
--- arch/mips/lasat/image/Makefile	13 Dec 2002 23:41:18 -0000	1.1.1.2
+++ arch/mips/lasat/image/Makefile	12 Jan 2003 17:49:45 -0000	1.6
@@ -11,7 +11,7 @@
 endif
 
 MKLASATIMG = mklasatimg
-MKLASATIMG_ARCH = mq2,mqpro
+MKLASATIMG_ARCH = mq2,mqpro,sp100,sp200
 ifdef CONFIG_LASAT_SERVICE
 MKLASATIMG_FLAG = -s
 else
Index: drivers/mtd/maps/lasat.c
===================================================================
RCS file: /cvs/linux-mips/drivers/mtd/maps/lasat.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 lasat.c
--- drivers/mtd/maps/lasat.c	13 Dec 2002 23:39:54 -0000	1.1.1.2
+++ drivers/mtd/maps/lasat.c	10 Feb 2003 19:44:15 -0000
@@ -12,7 +12,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/config.h>
 #include <asm/lasat/lasat.h>
-#include <asm/lasat/lasat_mtd.h>
 
 static struct mtd_info *mymtd;
 
@@ -73,11 +72,12 @@
 };
 
 static struct mtd_partition partition_info[LASAT_MTD_LAST];
-static char *lasat_mtd_partnames[] = {"Bootloader", "Service", "Normal", "Filesystem", "Config"};
+static char *lasat_mtd_partnames[] = {"Bootloader", "Service", "Normal", "Config", "Filesystem"};
 
 static int __init init_sp(void)
 {
 	int i;
+	int nparts = 0;
 	/* this does not play well with the old flash code which 
 	 * protects and uprotects the flash when necessary */
        	printk(KERN_NOTICE "Unprotecting flash\n");
@@ -100,12 +100,15 @@
 
 		for (i=0; i < LASAT_MTD_LAST; i++) {
 			size = lasat_flash_partition_size(i);
-			partition_info[i].size = size;
-			partition_info[i].offset = offset;
-			offset += size;
+			if (size != 0) {
+				nparts++;
+				partition_info[i].size = size;
+				partition_info[i].offset = offset;
+				offset += size;
+			}
 		}
 
-		add_mtd_partitions( mymtd, partition_info, LASAT_MTD_LAST );
+		add_mtd_partitions( mymtd, partition_info, nparts );
 		return 0;
 	}
 
Index: include/asm-mips/lasat/lasat.h
===================================================================
RCS file: /cvs/linux-mips/include/asm-mips/lasat/lasat.h,v
retrieving revision 1.1.1.2
retrieving revision 1.8
diff -u -r1.1.1.2 -r1.8
--- include/asm-mips/lasat/lasat.h	13 Dec 2002 23:38:24 -0000	1.1.1.2
+++ include/asm-mips/lasat/lasat.h	11 Feb 2003 18:26:02 -0000	1.8
@@ -27,16 +27,7 @@
 #ifndef _LASAT_H
 #define _LASAT_H
 
-#include <linux/config.h>
-
-/*
- * Configuration block magic word(s)
- */
-#define LASAT_CONFIG_MAGIC     ('L'|('C'<<8)|('B'<<16)|('2'<<24)) /* LCB2 */
-#define LASAT_CONFIG_MAGIC_INT ('L'|('C'<<8)|('B'<<16)|('x'<<24)) /* LCBx */
-
 #ifndef _LANGUAGE_ASSEMBLY
-#include <linux/types.h>
 
 extern struct lasat_misc {
 	volatile u32 *reset_reg;
@@ -44,6 +35,15 @@
 	u32 flash_wp_bit;
 } *lasat_misc;
 
+enum lasat_mtdparts {
+	LASAT_MTD_BOOTLOADER,
+	LASAT_MTD_SERVICE,
+	LASAT_MTD_NORMAL,
+	LASAT_MTD_CONFIG,
+	LASAT_MTD_FS,
+	LASAT_MTD_LAST
+};
+
 /*
  * The format of the data record in the EEPROM.
  * See Documentation/LASAT/eeprom.txt for a detailed description
@@ -182,42 +182,17 @@
 struct lasat_info {
 	unsigned int  li_cpu_hz;
 	unsigned int  li_bus_hz;
-	unsigned int  li_flags;
 	unsigned int  li_bmid;
 	unsigned int  li_memsize;
 	unsigned int  li_flash_size;
-	unsigned int  li_edhac;
-	unsigned int  li_eadi;
-	unsigned int  li_hifn;
-	unsigned int  li_isdn;
-	unsigned int  li_ide;
-	unsigned int  li_hdlc;
-	unsigned int  li_leasedline;
-	unsigned int  li_usversion;
-	unsigned int  li_hw_flags;
-	unsigned int  li_vendid;
 	unsigned int  li_prid;
 	unsigned char li_bmstr[16];
-	unsigned char li_vendstr[32];
 	unsigned char li_namestr[32];
 	unsigned char li_typestr[16];
-	unsigned char li_partno[13];
-	unsigned char li_serial[15];
-	unsigned int  li_vpn_kbps;	/* kbit/s */
-	unsigned int  li_vpn_tunnels;
-	unsigned int  li_vpn_clients;
 	/* Info on the Flash layout */
 	unsigned int  li_flash_base;
-	unsigned int  li_flash_service_base;
-	unsigned int  li_flash_service_size;
-	unsigned int  li_flash_normal_base;
-	unsigned int  li_flash_normal_size;
-	unsigned int  li_flash_cfg_base;
-	unsigned int  li_flash_cfg_size;
-	unsigned int  li_flash_fs_base;
-	unsigned int  li_flash_fs_size;
-	unsigned int  li_flash_fs2_base;
-	unsigned int  li_flash_fs2_size;
+	unsigned long li_flashpart_base[LASAT_MTD_LAST];
+	unsigned long li_flashpart_size[LASAT_MTD_LAST];
 	struct lasat_eeprom_struct li_eeprom_info;
 	unsigned int  li_eeprom_upgrade_version;
 	unsigned int  li_debugaccess;
@@ -225,6 +200,22 @@
 
 extern struct lasat_info lasat_board_info;
 
+static inline unsigned long lasat_flash_partition_start(int partno)
+{
+	if (partno < 0 || partno >= LASAT_MTD_LAST)
+		return 0;
+
+	return lasat_board_info.li_flashpart_base[partno];
+}
+
+static inline unsigned long lasat_flash_partition_size(int partno)
+{
+	if (partno < 0 || partno >= LASAT_MTD_LAST)
+		return 0;
+
+	return lasat_board_info.li_flashpart_size[partno];
+}
+
 /* Called from setup() to initialize the global board_info struct */
 extern int lasat_init_board_info(void);
 
@@ -241,7 +232,12 @@
 		__delay(lasat_board_info.li_cpu_hz / 2 / (NANOTH / ns) + 1);
 }
 
+extern void (* prom_printf)(const char *fmt, ...);
+
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
+
+#define LASAT_SERVICEMODE_MAGIC_1     0xdeadbeef
+#define LASAT_SERVICEMODE_MAGIC_2     0xfedeabba
 
 /* Lasat 100 boards */
 #define LASAT_GT_BASE           (KSEG1ADDR(0x14000000))
Index: include/asm-mips/lasat/lasat_mtd.h
===================================================================
RCS file: include/asm-mips/lasat/lasat_mtd.h
diff -N include/asm-mips/lasat/lasat_mtd.h
--- include/asm-mips/lasat/lasat_mtd.h	8 Oct 2002 18:48:35 -0000	1.1.1.1
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,15 +0,0 @@
-#include <linux/types.h>
-
-enum lasat_mtdparts {
-	LASAT_MTD_BOOTLOADER,
-	LASAT_MTD_SERVICE,
-	LASAT_MTD_NORMAL,
-	LASAT_MTD_FS,
-	LASAT_MTD_CONFIG,
-	LASAT_MTD_LAST
-}; 
-
-#define BOOTLOADER_SIZE 0x40000
-
-extern unsigned long lasat_flash_partition_start(int partno);
-extern unsigned long lasat_flash_partition_size(int partno);
