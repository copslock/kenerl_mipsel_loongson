Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18MeuC12232
	for linux-mips-outgoing; Fri, 8 Feb 2002 14:40:56 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18MeRA12228
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 14:40:27 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g18MeOR26336;
	Fri, 8 Feb 2002 14:40:24 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>,
   "Ralf Baechle" <ralf@uni-koblenz.de>
Subject: PATCH: Updated support for Ocelot boot PROM
Date: Fri, 8 Feb 2002 14:40:24 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIGEGKCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0024_01C1B0AE.8B076400"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_0024_01C1B0AE.8B076400
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Ralf et al --

Attached is a patch made against the lastest CVS snapshot (from about
an hour ago).  Please apply.

This patch adds support for our PMON v2.0 boot PROM.  This boot prom
uses a completely different mapping from the v1 boot prom, so the
kernel code had to change significantly.  This code auto-detects the
version of PMON and adjusts accordingly.

Oh, it also adds support for some of the debugging callbacks, which
can be used before the MMU/TLBs are reconfigured.  And it prints a
nice "Booting Linux kernel" message just to let you know that life is
good. :)

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_0024_01C1B0AE.8B076400
Content-Type: application/octet-stream;
	name="patch20020208"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch20020208"

? arch/mips/boot/elf2ecoff=0A=
? arch/mips/boot/vmlinux.ecoff=0A=
? arch/mips/boot/addinitrd=0A=
? arch/mips/gt64120/momenco_ocelot/setup-save.c=0A=
Index: arch/mips/gt64120/momenco_ocelot/prom.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/gt64120/momenco_ocelot/prom.c,v=0A=
retrieving revision 1.3.2.1=0A=
diff -u -r1.3.2.1 prom.c=0A=
--- arch/mips/gt64120/momenco_ocelot/prom.c	2001/12/12 13:45:58	1.3.2.1=0A=
+++ arch/mips/gt64120/momenco_ocelot/prom.c	2002/02/08 21:32:29=0A=
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
+++ arch/mips/gt64120/momenco_ocelot/setup.c	2002/02/08 21:32:29=0A=
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
Index: drivers/mtd/devices/docprobe.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/drivers/mtd/devices/docprobe.c,v=0A=
retrieving revision 1.3=0A=
diff -u -r1.3 docprobe.c=0A=
--- drivers/mtd/devices/docprobe.c	2001/11/05 20:15:52	1.3=0A=
+++ drivers/mtd/devices/docprobe.c	2002/02/08 21:32:30=0A=
@@ -88,6 +88,7 @@=0A=
 	0xe4000000,=0A=
 #elif defined(CONFIG_MOMENCO_OCELOT)=0A=
 	0x2f000000,=0A=
+	0xff000000,=0A=
 #else=0A=
 #warning Unknown architecture for DiskOnChip. No default probe =
locations defined=0A=
 #endif=0A=

------=_NextPart_000_0024_01C1B0AE.8B076400--
