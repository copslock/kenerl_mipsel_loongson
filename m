Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2004 13:36:00 +0000 (GMT)
Received: from relay-5v.club-internet.fr ([IPv6:::ffff:194.158.96.110]:53748
	"EHLO relay-5v.club-internet.fr") by linux-mips.org with ESMTP
	id <S8225219AbUCONf7> convert rfc822-to-8bit; Mon, 15 Mar 2004 13:35:59 +0000
Received: from club-internet.fr (flashmail-5v.cs.clubint.net [172.16.0.156])
	by relay-5v.club-internet.fr (Postfix) with SMTP id CE950172F
	for <linux-mips@linux-mips.org>; Mon, 15 Mar 2004 14:35:54 +0100 (CET)
Received: from [218.233.102.145] by flashmail-5v.club-internet.fr via html
	interface
From: pinotj@club-internet.fr
To: linux-mips@linux-mips.org
Subject: [DOC] Linux 2.6.4
Date: Mon, 15 Mar 2004 14:35:54 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet6.1079357754.20900.pinotj@club-internet.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <pinotj@club-internet.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pinotj@club-internet.fr
Precedence: bulk
X-list: linux-mips

Hi, 

I wrote this week-end a document to sum up all the arch that Linux 2.6.4 support. I extracted the informations from the source and I would like to have comments/changes/advice from you about the MIPS part. I have maybe make some mistake and/or things are little bit different so I would like you to take a look at this (I removed the non-MIPS parts, the complete file is around 11ko) before suggesting a patch.

Thanks, 
(Please cc me) 

Jerome Pinot

diff -Nru -U 2 linux-2.6.4.orig/Documentation/ARCH linux-2.6.4/Documentation/ARCH
--- linux-2.6.4.orig/Documentation/ARCH	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.4/Documentation/ARCH	2004-03-15 16:20:06.000000000 +0900
@@ -0,0 +1,425 @@
+
+March 2004		Supported arch for Linux		v2.6.4
+			~~~~~~~~~~~~~~~~~~~~~~~~
+
+
+The following is a quite complete list of all the arch supported by Linux.
+Of course, you will find here Alpha, ARM, ARM26, CRIS, H8300, i386, IA-64,
+M68000, MIPS, PA-RISC, PPC, S390, SH, SPARC, v850 and x86-64. But you will
+find too a complete list of CPUs and board supported by the kernel. For 
+each part, first list means "board" and second one means "CPU".
+
+
+ Content:
+ ~~~~~~~~
+	1. i386		7. IA-64		13. S390
+	2. Alpha	8. M68K (w/o MMU)	14. SuperH
+	3. ARM		9. MIPS (32/64)		15. SPARC
+	4. ARM26	10. PA-RISC		16. UltraSPARC
+	5. CRIS		11. PPC			17. v850
+	6. H8300	12. PPC64		18. x86-64

[snip]

+ 9. MIPS (32/64)
+ ~~~~~~~~~~~~~~~
+	ACER PICA
+	AMD/Alchemy Au1x00 	(PB1000/1100/1500)
+	AMD/Alchemy Au1x00 	(DB1000/1100/1500)
+	AMD/Alchemy Au1x00 	(Bosporus, Mirage)
+	AMD/Alchemy Au1x00 	(MyCable XXS1500, 4G Systems MTX-1)
+	Atlas board		(QED R5231-based)
+	Baget series		(Russian embedded system)
+	Broadcom BCM1xxx 	(BCM91250A-SWARM, BCM91250E-Sentosa)
+	Broadcom BCM1xxx 	(BCM91125E-Rhone, BCM91120x-Carmel)
+	Broadcom BCM1xxx 	(BCM91250PT-PTSWARM, BCM91250C2-LittleSur)
+	Broadcom BCM1xxx 	(BCM91120C-CRhine, BCM91125C-CRhone, generic)
+	CASIO CASSIOPEIA E-10/15/55/65
+	Cobalt Server
+	DECstations		(5000/50, 5000/150, 5000/260, 5900/260)
+	Galileo EV64120		(Evaluation board, MIPS R5000 compatible)
+	Galileo EV96100		(Evaluation board, MIPS R5000 compatible)
+	Galileo Technology	(GT96100 communications controller card)
+	Globspan IVR		(QED RM5231 R5000 MIPS core)
+	Hewlett Packard		(LaserJet board)
+	IBM WorkPad z50
+	ITE 8172G	
+	ITE 8172SBC
+	Jazz Family		(R4030 chipset)
+	LASAT Networks platforms
+	Malta board
+	MIPS Magnum 4000
+	MIPS Millenium
+	Momentum Jaguar board
+	Momentum Ocelot board
+	Momentum Ocelot-C board
+	Momentum Ocelot-G board
+	NEC DDB Vrc-5074	(VR5000-based)
+	NEC DDB Vrc-5076	(R5432-based)
+	NEC DDB Vrc-5477	(R5432-based)
+	NEC Eagle/Hawk board
+	NEC Osprey board
+	NEC VR41XX
+	Olivetti M700-10
+	PMC-Sierra Yosemite	(evaluation board)
+	Rockhopper board	(R5432/R5500)
+	SolutionGear board	(R5432/R5500)
+	SEAD board
+	SGI IP22		(Indy/Indigo2)
+	SGI IP27		(Origin200/2000)
+	SGI IP32		(O2)
+	SNI RM200 PCI
+	TANBAC TB0219		(base board)
+	TANBAC TB0226		(Mbase)
+	TANBAC TB0229		(VR4131DIMM)
+	Toshiba JMR-TX3927
+	Victor MP-C303/304
+	ZAO Networks Capcella
+
+		R3000
+		R39XX
+		R41xx
+		R4300
+		R4x00	(including 4000/4400/4600/4700)
+		R49XX
+		R5000
+		R52xx	(Nevada)
+		R6000
+		R6000A
+		RM7000
+		R8000	(incomplete support)
+		R10000
+		RM9000
+		SB1
+		
+  (see Documentation/mips)
+  <http://www.linux-mips.org/>

EOF
