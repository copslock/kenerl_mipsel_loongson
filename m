Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1M4iIM20030
	for linux-mips-outgoing; Thu, 21 Feb 2002 20:44:18 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1M4gT920013;
	Thu, 21 Feb 2002 20:42:29 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1M3gTR00321;
	Thu, 21 Feb 2002 19:42:29 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>, "Ralf Baechle" <ralf@oss.sgi.com>
Subject: PATCH: Ocelot (resend) and Ocelot-G
Date: Thu, 21 Feb 2002 19:42:29 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIIELCCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003F_01C1BB0F.E5696E00"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_003F_01C1BB0F.E5696E00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Ralf --

Attached to this message is a patch to update the support for the
Ocelot to support both v1 and v2 PROMs (with auto-detection!) and add
support for the Ocelot-G.

The update to the Ocelot is something I _thought_ I already sent
you... but it's not in the CVS repository, so I can't be sure.  It's
in my development tree, so I figured I'd send it as part of this
update anyway.

Support for the Ocelot-G isn't quite done yet, but it's very close.
The ethernet drivers need to be worked on, but the board is currently
running on my workbench with an add-on ethernet card and NFS-root.  So
far, it seems pretty stable.

This patch is against a recent CVS snapshot (from about an hour ago).

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_003F_01C1BB0F.E5696E00
Content-Type: application/octet-stream;
	name="patch20020221-3"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch20020221-3"

? arch/mips/gt64240=0A=
? arch/mips/boot/elf2ecoff=0A=
? arch/mips/boot/vmlinux.ecoff=0A=
? arch/mips/boot/addinitrd=0A=
Index: arch/mips/Makefile=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/Makefile,v=0A=
retrieving revision 1.78.2.2=0A=
diff -u -r1.78.2.2 Makefile=0A=
--- arch/mips/Makefile	2002/02/15 21:05:47	1.78.2.2=0A=
+++ arch/mips/Makefile	2002/02/22 04:34:35=0A=
@@ -262,6 +262,17 @@=0A=
 endif=0A=
 =0A=
 #=0A=
+# Momentum Ocelot-G board=0A=
+#=0A=
+ifdef CONFIG_MOMENCO_OCELOT_G=0A=
+# The Ocelot-G setup.o must be linked early - it does the ioremap() for =
the=0A=
+# mips_io_port_base.=0A=
+CORE_FILES    +=3D arch/mips/gt64240/momenco_ocelot_g.o=0A=
+SUBDIRS       +=3D arch/mips/gt64240=0A=
+LOADADDR      +=3D 0x80100000=0A=
+endif=0A=
+=0A=
+#=0A=
 # Philips Nino=0A=
 #=0A=
 ifdef CONFIG_NINO=0A=
Index: arch/mips/config.in=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/config.in,v=0A=
retrieving revision 1.154.2.14=0A=
diff -u -r1.154.2.14 config.in=0A=
--- arch/mips/config.in	2002/02/15 21:05:47	1.154.2.14=0A=
+++ arch/mips/config.in	2002/02/22 04:34:37=0A=
@@ -56,6 +56,7 @@=0A=
 fi=0A=
 bool 'Support for Mips Magnum 4000' CONFIG_MIPS_MAGNUM_4000=0A=
 bool 'Support for Momentum Ocelot board' CONFIG_MOMENCO_OCELOT=0A=
+bool 'Support for Momentum Ocelot-G board' CONFIG_MOMENCO_OCELOT_G=0A=
 bool 'Support for NEC DDB Vrc-5476' CONFIG_DDB5476=0A=
 bool 'Support for NEC DDB Vrc-5477' CONFIG_DDB5477=0A=
 bool 'Support for NEC Osprey board' CONFIG_NEC_OSPREY=0A=
@@ -161,6 +162,13 @@=0A=
 if [ "$CONFIG_MOMENCO_OCELOT" =3D "y" ]; then=0A=
    define_bool CONFIG_PCI y=0A=
    define_bool CONFIG_SYSCLK_100 y=0A=
+   define_bool CONFIG_SWAP_IO_SPACE y=0A=
+   define_bool CONFIG_NEW_IRQ y=0A=
+   define_bool CONFIG_NONCOHERENT_IO y=0A=
+   define_bool CONFIG_OLD_TIME_C y=0A=
+fi=0A=
+if [ "$CONFIG_MOMENCO_OCELOT_G" =3D "y" ]; then=0A=
+   define_bool CONFIG_PCI y=0A=
    define_bool CONFIG_SWAP_IO_SPACE y=0A=
    define_bool CONFIG_NEW_IRQ y=0A=
    define_bool CONFIG_NONCOHERENT_IO y=0A=
Index: arch/mips/gt64120/momenco_ocelot/prom.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/gt64120/momenco_ocelot/prom.c,v=0A=
retrieving revision 1.3.2.1=0A=
diff -u -r1.3.2.1 prom.c=0A=
--- arch/mips/gt64120/momenco_ocelot/prom.c	2001/12/12 13:45:58	1.3.2.1=0A=
+++ arch/mips/gt64120/momenco_ocelot/prom.c	2002/02/22 04:34:38=0A=
@@ -15,34 +15,35 @@=0A=
 #include <asm/addrspace.h>=0A=
 #include <asm/bootinfo.h>=0A=
 =0A=
-#define PLD_BASE	0xbc000000=0A=
+struct callvectors {=0A=
+	int	(*open) (char*, int, int);=0A=
+	int	(*close) (int);=0A=
+	int	(*read) (int, void*, int);=0A=
+	int	(*write) (int, void*, int);=0A=
+	off_t	(*lseek) (int, off_t, int);=0A=
+	int	(*printf) (const char*, ...);=0A=
+	void	(*cacheflush) (void);=0A=
+	char*	(*gets) (char*);=0A=
+};=0A=
 =0A=
-#define REV             0x0     /* Board Assembly Revision */=0A=
-#define PLD1ID          0x1     /* PLD 1 ID */=0A=
-#define PLD2ID          0x2     /* PLD 2 ID */=0A=
-#define RESET_STAT      0x3     /* Reset Status Register */=0A=
-#define BOARD_STAT      0x4     /* Board Status Register */=0A=
-#define CPCI_ID         0x5     /* Compact PCI ID Register */=0A=
-#define CONTROL         0x8     /* Control Register */=0A=
-#define CPU_EEPROM      0x9     /* CPU Configuration EEPROM Register */=0A=
-#define INTMASK         0xA     /* Interrupt Mask Register */=0A=
-#define INTSTAT         0xB     /* Interrupt Status Register */=0A=
-#define INTSET          0xC     /* Interrupt Set Register */=0A=
-#define INTCLR          0xD     /* Interrupt Clear Register */=0A=
-=0A=
-#define PLD_REG(x)	((uint8_t*)(PLD_BASE+(x)))=0A=
-=0A=
+struct callvectors* debug_vectors;=0A=
 char arcs_cmdline[CL_SIZE];=0A=
 =0A=
+extern unsigned long gt64120_base;=0A=
+=0A=
 const char *get_system_type(void)=0A=
 {=0A=
 	return "Momentum Ocelot";=0A=
 }=0A=
 =0A=
 /* [jsun@junsun.net] PMON passes arguments in C main() style */=0A=
-void __init prom_init(int argc, const char **arg)=0A=
+void __init prom_init(int argc, char **arg, char** env, struct =
callvectors *cv)=0A=
 {=0A=
 	int i;=0A=
+	uint32_t tmp;=0A=
+=0A=
+	/* save the PROM vectors for debugging use */=0A=
+	debug_vectors =3D cv;=0A=
 =0A=
 	/* arg[0] is "g", the rest is boot parameters */=0A=
 	arcs_cmdline[0] =3D '\0';=0A=
@@ -56,10 +57,17 @@=0A=
 =0A=
 	mips_machgroup =3D MACH_GROUP_MOMENCO;=0A=
 	mips_machtype =3D MACH_MOMENCO_OCELOT;=0A=
+=0A=
+	while (*env) {=0A=
+		if (strncmp("gtbase", *env, 6) =3D=3D 0) {=0A=
+			gt64120_base =3D simple_strtol(*env + strlen("gtbase=3D"),=0A=
+							NULL, 16);=0A=
+			break;=0A=
+		}=0A=
+		*env++;=0A=
+	}=0A=
 =0A=
-	/* turn off the Bit Error LED, which comes on automatically=0A=
-	 * at power-up reset */=0A=
-	*PLD_REG(INTCLR) =3D 0x80;=0A=
+	debug_vectors->printf("Booting Linux kernel...\n");=0A=
 =0A=
 	/* All the boards have at least 64MiB. If there's more, we=0A=
 	   detect and register it later */=0A=
Index: arch/mips/gt64120/momenco_ocelot/setup.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/gt64120/momenco_ocelot/setup.c,v=0A=
retrieving revision 1.5.2.1=0A=
diff -u -r1.5.2.1 setup.c=0A=
--- arch/mips/gt64120/momenco_ocelot/setup.c	2002/02/07 01:58:06	1.5.2.1=0A=
+++ arch/mips/gt64120/momenco_ocelot/setup.c	2002/02/22 04:34:38=0A=
@@ -83,25 +83,9 @@=0A=
 =0A=
 static void __init setup_l3cache(unsigned long size);=0A=
 =0A=
-void __init momenco_ocelot_setup(void)=0A=
+/* setup code for a handoff from a version 1 PMON 2000 PROM */=0A=
+void PMON_v1_setup()=0A=
 {=0A=
-	void (*l3func)(unsigned long)=3DKSEG1ADDR(&setup_l3cache);=0A=
-	unsigned int tmpword;=0A=
-=0A=
-	board_time_init =3D gt64120_time_init;=0A=
-=0A=
-	_machine_restart =3D momenco_ocelot_restart;=0A=
-	_machine_halt =3D momenco_ocelot_halt;=0A=
-	_machine_power_off =3D momenco_ocelot_power_off;=0A=
-=0A=
-	/*=0A=
-	 * initrd_start =3D (ulong)ocelot_initrd_start;=0A=
-	 * initrd_end =3D (ulong)ocelot_initrd_start + =
(ulong)ocelot_initrd_size;=0A=
-	 * initrd_below_start_ok =3D 1;=0A=
-	 */=0A=
-	rtc_ops =3D &no_rtc_ops;=0A=
-=0A=
-=0A=
 	/* A wired TLB entry for the GT64120A and the serial port. The=0A=
 	   GT64120A is going to be hit on every IRQ anyway - there's=0A=
 	   absolutely no point in letting it be a random TLB entry, as=0A=
@@ -122,12 +106,10 @@=0A=
 		Ocelot PLD (CS0)	0x2c000000	0xe0020000=0A=
 		NVRAM			0x2c800000	0xe0030000=0A=
 	*/=0A=
-		=0A=
 	add_temporary_entry(ENTRYLO(0x2C000000), ENTRYLO(0x2d000000), =
0xe0020000, PM_64K);=0A=
 =0A=
-=0A=
 	/* Relocate the CS3/BootCS region */=0A=
-  	GT_WRITE( GT_CS3BOOTLD_OFS, 0x2f000000 >> 21);=0A=
+  	GT_WRITE(GT_CS3BOOTLD_OFS, 0x2f000000 >> 21);=0A=
 =0A=
 	/* Relocate CS[012] */=0A=
  	GT_WRITE(GT_CS20LD_OFS, 0x2c000000 >> 21);=0A=
@@ -142,18 +124,74 @@=0A=
 	GT_WRITE(GT_PCI0_CFGDATA_OFS, 0x24000000);=0A=
 	GT_WRITE(GT_PCI0_CFGADDR_OFS, 0x80000024);=0A=
 	GT_WRITE(GT_PCI0_CFGDATA_OFS, 0x24000001);=0A=
+}=0A=
 =0A=
-	/* Relocate PCI0 I/O and Mem0 */=0A=
-	GT_WRITE(GT_PCI0IOLD_OFS, 0x20000000 >> 21);=0A=
-	GT_WRITE(GT_PCI0M0LD_OFS, 0x22000000 >> 21);=0A=
+/* setup code for a handoff from a version 2 PMON 2000 PROM */=0A=
+void PMON_v2_setup()=0A=
+{=0A=
+	/* A wired TLB entry for the GT64120A and the serial port. The=0A=
+	   GT64120A is going to be hit on every IRQ anyway - there's=0A=
+	   absolutely no point in letting it be a random TLB entry, as=0A=
+	   it'll just cause needless churning of the TLB. And we use=0A=
+	   the other half for the serial port, which is just a PITA=0A=
+	   otherwise :)=0A=
 =0A=
-	/* Relocate PCI0 Mem1 */=0A=
-	GT_WRITE(GT_PCI0M1LD_OFS, 0x36000000 >> 21);=0A=
+		Device			Physical	Virtual=0A=
+		GT64120 Internal Regs	0xf4000000	0xe0000000=0A=
+		UARTs (CS2)		0xfd000000	0xe0001000=0A=
+	*/=0A=
+	add_wired_entry(ENTRYLO(0xf4000000), ENTRYLO(0xfD000000), 0xe0000000, =
PM_4K);=0A=
+=0A=
+	/* Also a temporary entry to let us talk to the Ocelot PLD and NVRAM=0A=
+	   in the CS[012] region. We can't use ioremap() yet. The NVRAM=0A=
+	   is a ST M48T37Y, which includes NVRAM, RTC, and Watchdog functions.=0A=
+=0A=
+		Ocelot PLD (CS0)	0xfc000000	0xe0020000=0A=
+		NVRAM			0xfc800000	0xe0030000=0A=
+	*/=0A=
+	add_temporary_entry(ENTRYLO(0xfC000000), ENTRYLO(0xfd000000), =
0xe0020000, PM_64K);=0A=
+=0A=
+	gt64120_base =3D 0xe0000000;=0A=
+}=0A=
+=0A=
+void __init momenco_ocelot_setup(void)=0A=
+{=0A=
+	void (*l3func)(unsigned long)=3DKSEG1ADDR(&setup_l3cache);=0A=
+	unsigned int tmpword;=0A=
+=0A=
+	board_time_init =3D gt64120_time_init;=0A=
+=0A=
+	_machine_restart =3D momenco_ocelot_restart;=0A=
+	_machine_halt =3D momenco_ocelot_halt;=0A=
+	_machine_power_off =3D momenco_ocelot_power_off;=0A=
+=0A=
+	/*=0A=
+	 * initrd_start =3D (ulong)ocelot_initrd_start;=0A=
+	 * initrd_end =3D (ulong)ocelot_initrd_start + =
(ulong)ocelot_initrd_size;=0A=
+	 * initrd_below_start_ok =3D 1;=0A=
+	 */=0A=
+	rtc_ops =3D &no_rtc_ops;=0A=
+=0A=
+	/* do handoff reconfiguration */=0A=
+	if (gt64120_base =3D=3D KSEG1ADDR(GT_DEF_BASE))=0A=
+		PMON_v1_setup();=0A=
+	else=0A=
+		PMON_v2_setup();=0A=
 =0A=
+	/* Turn off the Bit-Error LED */=0A=
+	OCELOT_PLD_WRITE(0x80, INTCLR);=0A=
+=0A=
 	/* Relocate all the PCI1 stuff, not that we use it */=0A=
 	GT_WRITE(GT_PCI1IOLD_OFS, 0x30000000 >> 21);=0A=
 	GT_WRITE(GT_PCI1M0LD_OFS, 0x32000000 >> 21);=0A=
 	GT_WRITE(GT_PCI1M1LD_OFS, 0x34000000 >> 21);=0A=
+=0A=
+	/* Relocate PCI0 I/O and Mem0 */=0A=
+	GT_WRITE(GT_PCI0IOLD_OFS, 0x20000000 >> 21);=0A=
+	GT_WRITE(GT_PCI0M0LD_OFS, 0x22000000 >> 21);=0A=
+=0A=
+	/* Relocate PCI0 Mem1 */=0A=
+	GT_WRITE(GT_PCI0M1LD_OFS, 0x36000000 >> 21);=0A=
 =0A=
 	/* For the initial programming, we assume 512MB configuration */=0A=
 	/* Relocate the CPU's view of the RAM... */=0A=
Index: arch/mips/kernel/setup.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v=0A=
retrieving revision 1.96.2.12=0A=
diff -u -r1.96.2.12 setup.c=0A=
--- arch/mips/kernel/setup.c	2002/02/15 21:05:48	1.96.2.12=0A=
+++ arch/mips/kernel/setup.c	2002/02/22 04:34:39=0A=
@@ -665,6 +665,7 @@=0A=
 	void malta_setup(void);=0A=
 	void ikos_setup(void);=0A=
 	void momenco_ocelot_setup(void);=0A=
+	void momenco_ocelot_g_setup(void);=0A=
 	void nino_setup(void);=0A=
 	void nec_osprey_setup(void);=0A=
 	void jmr3927_setup(void);=0A=
@@ -730,6 +731,11 @@=0A=
 #ifdef CONFIG_MOMENCO_OCELOT=0A=
 	case MACH_GROUP_MOMENCO:=0A=
 		momenco_ocelot_setup();=0A=
+		break;=0A=
+#endif=0A=
+#ifdef CONFIG_MOMENCO_OCELOT_G=0A=
+	case MACH_GROUP_MOMENCO:=0A=
+		momenco_ocelot_g_setup();=0A=
 		break;=0A=
 #endif=0A=
 #ifdef CONFIG_SGI_IP22=0A=
Index: drivers/mtd/devices/docprobe.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/drivers/mtd/devices/docprobe.c,v=0A=
retrieving revision 1.3=0A=
diff -u -r1.3 docprobe.c=0A=
--- drivers/mtd/devices/docprobe.c	2001/11/05 20:15:52	1.3=0A=
+++ drivers/mtd/devices/docprobe.c	2002/02/22 04:34:53=0A=
@@ -88,6 +88,9 @@=0A=
 	0xe4000000,=0A=
 #elif defined(CONFIG_MOMENCO_OCELOT)=0A=
 	0x2f000000,=0A=
+	0xff000000,=0A=
+#elif defined(CONFIG_MOMENCO_OCELOT_G)=0A=
+	0xff000000,=0A=
 #else=0A=
 #warning Unknown architecture for DiskOnChip. No default probe =
locations defined=0A=
 #endif=0A=
Index: include/asm-mips/bootinfo.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/include/asm-mips/bootinfo.h,v=0A=
retrieving revision 1.43.2.8=0A=
diff -u -r1.43.2.8 bootinfo.h=0A=
--- include/asm-mips/bootinfo.h	2002/02/15 21:05:49	1.43.2.8=0A=
+++ include/asm-mips/bootinfo.h	2002/02/22 04:35:04=0A=
@@ -121,6 +121,7 @@=0A=
  * Valid machtype for group MOMENCO=0A=
  */=0A=
 #define MACH_MOMENCO_OCELOT		0=0A=
+#define MACH_MOMENCO_OCELOT_G		1=0A=
 =0A=
  =0A=
 /*=0A=
Index: include/asm-mips/serial.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/include/asm-mips/serial.h,v=0A=
retrieving revision 1.23.2.2=0A=
diff -u -r1.23.2.2 serial.h=0A=
--- include/asm-mips/serial.h	2002/01/07 03:33:54	1.23.2.2=0A=
+++ include/asm-mips/serial.h	2002/02/22 04:35:04=0A=
@@ -267,6 +267,23 @@=0A=
 #define MOMENCO_OCELOT_SERIAL_PORT_DEFNS=0A=
 #endif=0A=
 =0A=
+#ifdef CONFIG_MOMENCO_OCELOT_G=0A=
+/* Ordinary NS16552 duart with a 20MHz crystal.  */=0A=
+#define OCELOT_G_BASE_BAUD ( 20000000 / 16 )=0A=
+=0A=
+#define OCELOT_G_SERIAL1_IRQ	4=0A=
+#define OCELOT_G_SERIAL1_BASE	0xe0001020=0A=
+=0A=
+#define _OCELOT_G_SERIAL_INIT(int, base)				\=0A=
+	{ baud_base: OCELOT_G_BASE_BAUD, irq: int, flags: STD_COM_FLAGS,\=0A=
+	  iomem_base: (u8 *) base, iomem_reg_shift: 2,			\=0A=
+	  io_type: SERIAL_IO_MEM }=0A=
+#define MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS				\=0A=
+	_OCELOT_G_SERIAL_INIT(OCELOT_G_SERIAL1_IRQ, OCELOT_G_SERIAL1_BASE)=0A=
+#else=0A=
+#define MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS=0A=
+#endif=0A=
+=0A=
 #ifdef CONFIG_DDB5477=0A=
 #define DDB5477_SERIAL_PORT_DEFNS                                       =
\=0A=
         { baud_base: BASE_BAUD, irq: 12, flags: STD_COM_FLAGS,          =
\=0A=
@@ -279,17 +296,18 @@=0A=
 #define DDB5477_SERIAL_PORT_DEFNS=0A=
 #endif=0A=
 =0A=
-#define SERIAL_PORT_DFNS		\=0A=
-	IVR_SERIAL_PORT_DEFNS           \=0A=
-	ITE_SERIAL_PORT_DEFNS           \=0A=
-	ATLAS_SERIAL_PORT_DEFNS		\=0A=
-	COBALT_SERIAL_PORT_DEFNS	\=0A=
-	EV96100_SERIAL_PORT_DEFNS	\=0A=
-	JAZZ_SERIAL_PORT_DEFNS		\=0A=
-	STD_SERIAL_PORT_DEFNS		\=0A=
-	EXTRA_SERIAL_PORT_DEFNS		\=0A=
-	HUB6_SERIAL_PORT_DFNS		\=0A=
-	MOMENCO_OCELOT_SERIAL_PORT_DEFNS\=0A=
-	AU1000_SERIAL_PORT_DEFNS	\=0A=
-        TXX927_SERIAL_PORT_DEFNS        \=0A=
+#define SERIAL_PORT_DFNS			\=0A=
+	IVR_SERIAL_PORT_DEFNS           	\=0A=
+	ITE_SERIAL_PORT_DEFNS           	\=0A=
+	ATLAS_SERIAL_PORT_DEFNS			\=0A=
+	COBALT_SERIAL_PORT_DEFNS		\=0A=
+	EV96100_SERIAL_PORT_DEFNS		\=0A=
+	JAZZ_SERIAL_PORT_DEFNS			\=0A=
+	STD_SERIAL_PORT_DEFNS			\=0A=
+	EXTRA_SERIAL_PORT_DEFNS			\=0A=
+	HUB6_SERIAL_PORT_DFNS			\=0A=
+	MOMENCO_OCELOT_SERIAL_PORT_DEFNS	\=0A=
+	MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS	\=0A=
+	AU1000_SERIAL_PORT_DEFNS		\=0A=
+        TXX927_SERIAL_PORT_DEFNS        	\=0A=
 	DDB5477_SERIAL_PORT_DEFNS=0A=

------=_NextPart_000_003F_01C1BB0F.E5696E00--
