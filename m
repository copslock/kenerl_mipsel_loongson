Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4GNRJC25087
	for linux-mips-outgoing; Wed, 16 May 2001 16:27:19 -0700
Received: from sprint02.rtmx.net (IDENT:qmailr@sprint02.RTMX.NET [208.31.160.2])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4GNRHF25084
	for <linux-mips@oss.sgi.com>; Wed, 16 May 2001 16:27:17 -0700
Received: (qmail 11831 invoked by uid 102); 16 May 2001 23:27:16 -0000
Received: from host098.momenco.com (HELO beagle) (64.169.228.98)
  by 208.31.160.29 with SMTP; 16 May 2001 23:27:16 -0000
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@uni-koblenz.de>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
Cc: "Chuck Storey" <Chuck_Storey@pmc-sierra.com>,
   "Harry White" <harry@momenco.com>
Subject: PATCH: Extended Interrupt support for the RM7000-based Ocelot
Date: Wed, 16 May 2001 16:27:27 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAICEHGCBAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000B_01C0DE25.18CEB4D0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C0DE25.18CEB4D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Attached is a patch which adds support for extended interrupt devices
to the Ocelot.  It was created against a current CVS snapshot.  Ralf,
please apply.

The patch basically re-writes the interrupt handler to read the
extended interrupt mask from the Set 1 registers on the QED RM7000.
It also changes the support functions so that these interrupts can be
masked and unmasked properly.

It occurs to me that this probably should go (eventually) into an
RM7k-specific file, and not an Ocelot specific file.  But the current
arch/mips/ tree doesn't seem to support this well, so I figured that
for a first pass, keeping everything where it current is will cause
the least confusion.

Matt Dharm

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_000B_01C0DE25.18CEB4D0
Content-Type: application/octet-stream;
	name="irq_diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="irq_diff"

--- arch/mips/gt64120/momenco_ocelot/int-handler.S	2001/02/05 01:33:01	=
1.1=0A=
+++ arch/mips/gt64120/momenco_ocelot/int-handler.S	2001/05/16 23:08:43=0A=
@@ -43,6 +43,22 @@=0A=
 		bnez	t1, ll_galileo_irq=0A=
 		 andi	t1, t0, STATUSF_IP7	/* cpu timer */=0A=
 		bnez	t1, ll_cputimer_irq=0A=
+=0A=
+                /* now look at the extended interrupts */=0A=
+		mfc0	t0, CP0_CAUSE  =0A=
+		cfc0	t1, CP0_INTCONTROL=0A=
+=0A=
+		/* shift the mask 8 bits left to line up the bits */=0A=
+		 sll	t2, t1, 8=0A=
+=0A=
+		 and	t0, t2=0A=
+		 srl	t0, t0, 16=0A=
+=0A=
+		 andi	t1, t0, STATUSF_IP8	/* int6 hardware line */=0A=
+		bnez	t1, ll_pmc1_irq=0A=
+		 andi	t1, t0, STATUSF_IP9	/* int7 hardware line */=0A=
+		bnez	t1, ll_pmc2_irq=0A=
+=0A=
 		.set	reorder=0A=
 =0A=
 		/* wrong alarm or masked ... */=0A=
@@ -87,3 +103,14 @@=0A=
 		jal	do_IRQ=0A=
 		j	ret_from_irq=0A=
 	=0A=
+ll_pmc1_irq:=0A=
+		li	a0, 8=0A=
+		move	a1, sp=0A=
+		jal	do_IRQ=0A=
+		j	ret_from_irq=0A=
+=0A=
+ll_pmc2_irq:=0A=
+		li	a0, 9=0A=
+		move	a1, sp=0A=
+		jal	do_IRQ=0A=
+		j	ret_from_irq=0A=
Index: arch/mips/gt64120/momenco_ocelot/irq.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/gt64120/momenco_ocelot/irq.c,v=0A=
retrieving revision 1.3=0A=
diff -u -r1.3 irq.c=0A=
--- arch/mips/gt64120/momenco_ocelot/irq.c	2001/03/11 21:52:24	1.3=0A=
+++ arch/mips/gt64120/momenco_ocelot/irq.c	2001/05/16 23:08:43=0A=
@@ -58,9 +58,16 @@=0A=
 =0A=
 =0A=
 /* Function for careful CP0 interrupt mask access */=0A=
-static inline void modify_cp0_intmask(unsigned clr_mask, unsigned =
set_mask)=0A=
+static inline void modify_cp0_intmask(unsigned clr_mask_in, unsigned =
set_mask_in)=0A=
 {=0A=
-	unsigned long status =3D read_32bit_cp0_register(CP0_STATUS);=0A=
+	unsigned long status;=0A=
+	unsigned clr_mask;=0A=
+	unsigned set_mask;=0A=
+=0A=
+	/* do the low 8 bits first */=0A=
+	clr_mask =3D 0xFF & clr_mask_in;=0A=
+	set_mask =3D 0xFF & set_mask_in;=0A=
+	status =3D read_32bit_cp0_register(CP0_STATUS);=0A=
 	DBG(KERN_INFO "modify_cp0_intmask clr %x, set %x\n", clr_mask,=0A=
 	    set_mask);=0A=
 	DBG(KERN_INFO "modify_cp0_intmask status %x\n", status);=0A=
@@ -68,6 +75,18 @@=0A=
 	status |=3D (set_mask & 0xFF) << 8;=0A=
 	DBG(KERN_INFO "modify_cp0_intmask status %x\n", status);=0A=
 	write_32bit_cp0_register(CP0_STATUS, status);=0A=
+=0A=
+	/* do the high 8 bits */=0A=
+	clr_mask =3D 0xFF & (clr_mask_in >> 8);=0A=
+	set_mask =3D 0xFF & (set_mask_in >> 8);=0A=
+	status =3D read_32bit_cp0_aux_register(CP0_INTCONTROL);=0A=
+	DBG(KERN_INFO "modify_cp0_intmask clr %x, set %x\n", clr_mask,=0A=
+	    set_mask);=0A=
+	DBG(KERN_INFO "modify_cp0_intmask status %x\n", status);=0A=
+	status &=3D ~((clr_mask & 0xFF) << 8);=0A=
+	status |=3D (set_mask & 0xFF) << 8;=0A=
+	DBG(KERN_INFO "modify_cp0_intmask status %x\n", status);=0A=
+	write_32bit_cp0_aux_register(CP0_INTCONTROL, status);=0A=
 }=0A=
 =0A=
 static inline void mask_irq(unsigned int irq_nr)=0A=
@@ -87,8 +106,8 @@=0A=
 	DBG(KERN_INFO "disable_irq, irq %d\n", irq_nr);=0A=
 	save_and_cli(flags);=0A=
 	/* we don't support higher interrupts, nor cascaded interrupts */=0A=
-	if (irq_nr >=3D 8)=0A=
-		panic("irq_nr is greater than 8");=0A=
+	if (irq_nr > 15)=0A=
+		panic("irq_nr is greater than 15");=0A=
 	=0A=
 	mask_irq(1 << irq_nr);=0A=
 	restore_flags(flags);=0A=
@@ -98,10 +117,11 @@=0A=
 {=0A=
 	unsigned long flags;=0A=
 =0A=
+	DBG(KERN_INFO "enable_irq, irq %d\n", irq_nr);=0A=
 	save_and_cli(flags);=0A=
 	=0A=
-	if ( irq_nr >=3D 8 )=0A=
-		panic("irq_nr is greater than 8");=0A=
+	if ( irq_nr > 15 )=0A=
+		panic("irq_nr is greater than 15");=0A=
 	=0A=
 	unmask_irq( 1 << irq_nr );=0A=
 	restore_flags(flags);=0A=
Index: arch/mips/gt64120/momenco_ocelot/pci.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/gt64120/momenco_ocelot/pci.c,v=0A=
retrieving revision 1.2=0A=
diff -u -r1.2 pci.c=0A=
--- arch/mips/gt64120/momenco_ocelot/pci.c	2001/03/08 13:13:57	1.2=0A=
+++ arch/mips/gt64120/momenco_ocelot/pci.c	2001/05/16 23:08:43=0A=
@@ -53,6 +53,12 @@=0A=
 				      "found unexpected PCI device in slot 2.");=0A=
 			}=0A=
 			devices->irq =3D 3;       /* irq_nr is 3 for INT1 */=0A=
+		} else if (PCI_SLOT(devices->devfn) =3D=3D 4) {=0A=
+			/* PMC Slot 1 */=0A=
+			devices->irq =3D 8;       /* irq_nr is 8 for INT6 */=0A=
+		} else if (PCI_SLOT(devices->devfn) =3D=3D 5) {=0A=
+			/* PMC Slot 1 */=0A=
+			devices->irq =3D 9;       /* irq_nr is 9 for INT7 */=0A=
 		} else {=0A=
 			/* We don't have assign interrupts for other devices. */=0A=
 			devices->irq =3D 0xff;=0A=
Index: include/asm-mips/mipsregs.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/include/asm-mips/mipsregs.h,v=0A=
retrieving revision 1.16=0A=
diff -u -r1.16 mipsregs.h=0A=
--- include/asm-mips/mipsregs.h	2001/04/01 03:28:23	1.16=0A=
+++ include/asm-mips/mipsregs.h	2001/05/16 23:08:44=0A=
@@ -58,6 +58,9 @@=0A=
 #define CP0_TAGHI $29=0A=
 #define CP0_ERROREPC $30=0A=
 =0A=
+/* Auxillarly registers on the RM7000 */=0A=
+#define CP0_INTCONTROL $20=0A=
+=0A=
 /*=0A=
  * R4640/R4650 cp0 register names.  These registers are listed=0A=
  * here only for completeness; without MMU these CPUs are not useable=0A=
@@ -165,6 +168,16 @@=0A=
         : "=3Dr" (__res));                                        \=0A=
         __res;})=0A=
 =0A=
+#define read_32bit_cp0_aux_register(source)                     \=0A=
+({ int __res;                                                   \=0A=
+        __asm__ __volatile__(                                   \=0A=
+	".set\tpush\n\t"					\=0A=
+	".set\treorder\n\t"					\=0A=
+        "cfc0\t%0,"STR(source)"\n\t"                            \=0A=
+	".set\tpop"						\=0A=
+        : "=3Dr" (__res));                                        \=0A=
+        __res;})=0A=
+=0A=
 /*=0A=
  * For now use this only with interrupts disabled!=0A=
  */=0A=
@@ -183,6 +196,12 @@=0A=
 	"nop"							\=0A=
         : : "r" (value));=0A=
 =0A=
+#define write_32bit_cp0_aux_register(register,value)            \=0A=
+        __asm__ __volatile__(                                   \=0A=
+        "ctc0\t%0,"STR(register)"\n\t"				\=0A=
+	"nop"							\=0A=
+        : : "r" (value));=0A=
+=0A=
 #define write_64bit_cp0_register(register,value)                \=0A=
         __asm__ __volatile__(                                   \=0A=
         ".set\tmips3\n\t"                                       \=0A=
@@ -370,6 +389,22 @@=0A=
 #define  STATUSF_IP6		(1   << 14)=0A=
 #define  STATUSB_IP7		15=0A=
 #define  STATUSF_IP7		(1   << 15)=0A=
+#define  STATUSB_IP8		0=0A=
+#define  STATUSF_IP8		(1   << 0)=0A=
+#define  STATUSB_IP9		1=0A=
+#define  STATUSF_IP9		(1   << 1)=0A=
+#define  STATUSB_IP10		2=0A=
+#define  STATUSF_IP10		(1   << 2)=0A=
+#define  STATUSB_IP11		3=0A=
+#define  STATUSF_IP11		(1   << 3)=0A=
+#define  STATUSB_IP12		4=0A=
+#define  STATUSF_IP12		(1   << 4)=0A=
+#define  STATUSB_IP13		5=0A=
+#define  STATUSF_IP13		(1   << 5)=0A=
+#define  STATUSB_IP14		6=0A=
+#define  STATUSF_IP14		(1   << 6)=0A=
+#define  STATUSB_IP15		7=0A=
+#define  STATUSF_IP15		(1   << 7)=0A=
 #define ST0_CH			0x00040000=0A=
 #define ST0_SR			0x00100000=0A=
 #define ST0_BEV			0x00400000=0A=

------=_NextPart_000_000B_01C0DE25.18CEB4D0--
