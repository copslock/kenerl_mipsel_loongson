Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2004 16:31:13 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:17043 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225251AbUAZQbM>; Mon, 26 Jan 2004 16:31:12 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id D97314C174; Mon, 26 Jan 2004 17:31:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id C2E8B477F0; Mon, 26 Jan 2004 17:31:07 +0100 (CET)
Date: Mon, 26 Jan 2004 17:31:07 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>,
	Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] pg-r4k.c bugs for R4600 rev.2.0
In-Reply-To: <20040123161410.GC20047@icm.edu.pl>
Message-ID: <Pine.LNX.4.55.0401261659540.14505@jurand.ds.pg.gda.pl>
References: <20040115141427.GA28546@icm.edu.pl>
 <Pine.LNX.4.21.0401151816540.3511-100000@www.marty44.net>
 <20040115231735.GA6619@icm.edu.pl> <4007386F.80207@gentoo.org>
 <20040115172602.H18368@mvista.com> <20040116115053.GA18099@icm.edu.pl>
 <20040120130625.GA24435@icm.edu.pl> <20040120162800.GA29792@icm.edu.pl>
 <20040123161410.GC20047@icm.edu.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 23 Jan 2004, Dominik 'Rathann' Mierzejewski wrote:

> > > 6242 2003/12/11 01:29:17 linux_2_4 ralf Fix a bunch of long standing bugs
> > > and performance clear_page issues: - Fi .....
> > [...] 
> > 
> > Found it! After applying the above patch, the kernel no longer goes
> > past the "Freeing unused kernel memory" stage. So for now I'm sticking
> > with the 20031205 kernel.
> 
> Could someone please look into this?

 There are a few bugs in arch/mips*/mm/pg-r4k.c and one of them affects 
your system:

> ARCH: SGI-IP22
> PROMLIB: ARC firmware Version 1 Revision 10
> CPU revision is: 00002020
> FPU revision is: 00002020
> Primary instruction cache 16kB, physically tagged, 2-way, linesize 32 bytes.
> Primary data cache 16kB 2-way, linesize 32 bytes.
> Linux version 2.4.22 (dominik@indy0) (gcc version 3.3.1 20030626 (Debian
> prerelease)) #1 Thu Sep 25 15:11:35 CEST 2003

This is an R4600 rev.2.0 which has a D-cache erratum that is worked around 
in these files.  Unfortunately, the work around corrupts the $at register 
that is assumed to be initialized and used afterwards elsewhere.  Since 
the functions affected are called with the assumption of the usual ABI 
convention, there's plenty of temporary registers to use and I propose to 
reserve $at for use as a local scratch register.  Here is a patch.  It 
should fix the problems for you.

 I have two other fixes for the file -- you might try them as well, as
I've only tested all three of them together, because of a different
configuration of the system I've used.  They fix a problem with R4k
systems with a secondary cache and a coprocessor 0 hazard with R4000/R4400
systems with primary caches only.

 Ralf, OK to apply this one?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-mips-pg-r4k-5
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/mm/pg-r4k.c linux-mips-2.4.24-pre2-20040116/arch/mips/mm/pg-r4k.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/mm/pg-r4k.c	2004-01-03 03:56:38.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/mm/pg-r4k.c	2004-01-26 12:09:56.000000000 +0000
@@ -96,7 +96,7 @@ static inline void __build_load_reg(int 
 	else
 		mi.i_format.opcode     = lw_op;
 	mi.i_format.rs         = 5;		/* $a1 */
-	mi.i_format.rt         = reg;		/* $zero */
+	mi.i_format.rt         = reg;		/* $reg */
 	mi.i_format.simmediate = load_offset;
 
 	load_offset += (cpu_has_64bit_registers ? 8 : 4);
@@ -197,7 +197,7 @@ static inline void __build_store_reg(int
 	reg_size               = 8;
 #endif
 	mi.i_format.rs         = 4;		/* $a0 */
-	mi.i_format.rt         = reg;		/* $zero */
+	mi.i_format.rt         = reg;		/* $reg */
 	mi.i_format.simmediate = store_offset;
 
 	store_offset += reg_size;
@@ -218,7 +218,7 @@ static inline void build_store_reg(int r
 	__build_store_reg(reg);
 }
 
-static inline void build_addiu_at_a0(unsigned long offset)
+static inline void build_addiu_a2_a0(unsigned long offset)
 {
 	union mips_instruction mi;
 
@@ -226,7 +226,7 @@ static inline void build_addiu_at_a0(uns
 
 	mi.i_format.opcode     = cpu_has_64bit_addresses ? daddiu_op : addiu_op;
 	mi.i_format.rs         = 4;		/* $a0 */
-	mi.i_format.rt         = 1;		/* $at */
+	mi.i_format.rt         = 6;		/* $a2 */
 	mi.i_format.simmediate = offset;
 
 	*epc++ = mi.word;
@@ -269,7 +269,7 @@ static inline void build_bne(unsigned in
 	union mips_instruction mi;
 
 	mi.i_format.opcode = bne_op;
-	mi.i_format.rs     = 1;			/* $at */
+	mi.i_format.rs     = 6;			/* $a2 */
 	mi.i_format.rt     = 4;			/* $a0 */
 	mi.i_format.simmediate = dest - epc - 1;
 
@@ -313,7 +313,7 @@ void __init build_clear_page(void)
 		}
 	}
 
-	build_addiu_at_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_clear : 0));
+	build_addiu_a2_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_clear : 0));
 
 	if (R4600_V2_HIT_CACHEOP_WAR && ((read_c0_prid() & 0xfff0) == 0x2020)) {
 		*epc++ = 0x40026000;		/* mfc0    $v0, $12	*/
@@ -352,7 +352,7 @@ dest = epc;
 	 build_store_reg(0);
 
 	if (cpu_has_prefetch && pref_offset_clear) {
-		build_addiu_at_a0(pref_offset_clear);
+		build_addiu_a2_a0(pref_offset_clear);
 	dest = epc;
 		__build_store_reg(0);
 		__build_store_reg(0);
@@ -382,7 +382,7 @@ void __init build_copy_page(void)
 {
 	epc = (unsigned int *) &copy_page_array;
 
-	build_addiu_at_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_copy : 0));
+	build_addiu_a2_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_copy : 0));
 
 	if (R4600_V2_HIT_CACHEOP_WAR && ((read_c0_prid() & 0xfff0) == 0x2020)) {
 		*epc++ = 0x40026000;		/* mfc0    $v0, $12	*/
@@ -438,7 +438,7 @@ dest = epc;
 	 build_store_reg(11);
 
 	if (cpu_has_prefetch && pref_offset_copy) {
-		build_addiu_at_a0(pref_offset_copy);
+		build_addiu_a2_a0(pref_offset_copy);
 	dest = epc;
 		__build_load_reg( 8);
 		__build_load_reg( 9);
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/mm/pg-r4k.c linux-mips-2.4.24-pre2-20040116/arch/mips64/mm/pg-r4k.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/mm/pg-r4k.c	2004-01-03 03:56:46.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/mm/pg-r4k.c	2004-01-26 12:09:56.000000000 +0000
@@ -96,7 +96,7 @@ static inline void __build_load_reg(int 
 	else
 		mi.i_format.opcode     = lw_op;
 	mi.i_format.rs         = 5;		/* $a1 */
-	mi.i_format.rt         = reg;		/* $zero */
+	mi.i_format.rt         = reg;		/* $reg */
 	mi.i_format.simmediate = load_offset;
 
 	load_offset += (cpu_has_64bit_registers ? 8 : 4);
@@ -197,7 +197,7 @@ static inline void __build_store_reg(int
 	reg_size               = 8;
 #endif
 	mi.i_format.rs         = 4;		/* $a0 */
-	mi.i_format.rt         = reg;		/* $zero */
+	mi.i_format.rt         = reg;		/* $reg */
 	mi.i_format.simmediate = store_offset;
 
 	store_offset += reg_size;
@@ -218,7 +218,7 @@ static inline void build_store_reg(int r
 	__build_store_reg(reg);
 }
 
-static inline void build_addiu_at_a0(unsigned long offset)
+static inline void build_addiu_a2_a0(unsigned long offset)
 {
 	union mips_instruction mi;
 
@@ -226,7 +226,7 @@ static inline void build_addiu_at_a0(uns
 
 	mi.i_format.opcode     = cpu_has_64bit_addresses ? daddiu_op : addiu_op;
 	mi.i_format.rs         = 4;		/* $a0 */
-	mi.i_format.rt         = 1;		/* $at */
+	mi.i_format.rt         = 6;		/* $a2 */
 	mi.i_format.simmediate = offset;
 
 	*epc++ = mi.word;
@@ -269,7 +269,7 @@ static inline void build_bne(unsigned in
 	union mips_instruction mi;
 
 	mi.i_format.opcode = bne_op;
-	mi.i_format.rs     = 1;			/* $at */
+	mi.i_format.rs     = 6;			/* $a2 */
 	mi.i_format.rt     = 4;			/* $a0 */
 	mi.i_format.simmediate = dest - epc - 1;
 
@@ -313,7 +313,7 @@ void __init build_clear_page(void)
 		}
 	}
 
-	build_addiu_at_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_clear : 0));
+	build_addiu_a2_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_clear : 0));
 
 	if (R4600_V2_HIT_CACHEOP_WAR && ((read_c0_prid() & 0xfff0) == 0x2020)) {
 		*epc++ = 0x40026000;		/* mfc0    $v0, $12	*/
@@ -352,7 +352,7 @@ dest = epc;
 	 build_store_reg(0);
 
 	if (cpu_has_prefetch && pref_offset_clear) {
-		build_addiu_at_a0(pref_offset_clear);
+		build_addiu_a2_a0(pref_offset_clear);
 	dest = epc;
 		__build_store_reg(0);
 		__build_store_reg(0);
@@ -382,7 +382,7 @@ void __init build_copy_page(void)
 {
 	epc = (unsigned int *) &copy_page_array;
 
-	build_addiu_at_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_copy : 0));
+	build_addiu_a2_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_copy : 0));
 
 	if (R4600_V2_HIT_CACHEOP_WAR && ((read_c0_prid() & 0xfff0) == 0x2020)) {
 		*epc++ = 0x40026000;		/* mfc0    $v0, $12	*/
@@ -438,7 +438,7 @@ dest = epc;
 	 build_store_reg(11);
 
 	if (cpu_has_prefetch && pref_offset_copy) {
-		build_addiu_at_a0(pref_offset_copy);
+		build_addiu_a2_a0(pref_offset_copy);
 	dest = epc;
 		__build_load_reg( 8);
 		__build_load_reg( 9);
