Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2004 17:12:45 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:60849 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225251AbUAZRMo>; Mon, 26 Jan 2004 17:12:44 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 6598C4C174; Mon, 26 Jan 2004 18:12:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 58BBF4BEF0; Mon, 26 Jan 2004 18:12:43 +0100 (CET)
Date: Mon, 26 Jan 2004 18:12:43 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] pg-r4k.c cp0 hazards for R4000/R4400
Message-ID: <Pine.LNX.4.55.0401261755460.26076@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 The R4000/R4400 has a coprocessor 0 hazard when a P-cache operation is
less than two non-load, non-cache instructions apart from a store to the
same line.  For processors without a secondary cache, the code in pg-r4k.c
currently issues a Create Dirty Exclusive D-cache operation and then
immediately executes consecutive stores to the same line, therefore 
fulfilling the conditions for the hazard.

 The following patch changes the problematic operations to be performed on 
the cache line following the one to be written immediately.  It is safe to 
do so, because the cache operations are only a performance hint and are 
not required for data coherency.  However it is essential not to bypass 
the end of the page, so the trailing area of the page is excluded from 
these cache operation, similarly to what has already been done for 
prefetching.

 Actually, I'd like to optimize the functions a bit further, specifically 
to avoid multiple cacheops to the same line (if you don't mind), but 
currently I'd like to apply this change to assure correct operation.  As I 
have no non-SC R4000/R4400 system, this was untested, but perhaps studying 
the problem covered by the -scache patch sent previously will show if the 
hazard is indeed avoided.

 The patch also increases the buffers a bit for three reasons:

1. copy_page_array is already too small for the 128-byte S-cache line 
case. ;-)

2. The trail for non-SC R4000/R4400 increases buffer consumption and I was 
too lazy to calculate the requirements.

3. The planned optimization will likely require a little bit more space as 
well.

BTW, I was unable to reproduce your instruction count calculation for the
prefetch case; other results seem OK.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-mips-pg-r4k-hazard-7
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/mm/pg-r4k.c linux-mips-2.4.24-pre2-20040116/arch/mips/mm/pg-r4k.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/mm/pg-r4k.c	2004-01-26 16:05:38.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/mm/pg-r4k.c	2004-01-26 16:06:21.000000000 +0000
@@ -34,7 +34,7 @@
  * With prefetching, 16 byte strides			0xa0 bytes
  */
 
-static unsigned int clear_page_array[0xa0 / 4];
+static unsigned int clear_page_array[0x100 / 4];
 
 void clear_page(void * page) __attribute__((alias("clear_page_array")));
 
@@ -46,7 +46,7 @@ void clear_page(void * page) __attribute
  * R4600 v2.0:						0x84 bytes
  * With prefetching, 16 byte strides			0xb8 bytes
  */
-static unsigned int copy_page_array[0xb8 / 4];
+static unsigned int copy_page_array[0x100 / 4];
 
 void copy_page(void *to, void *from) __attribute__((alias("copy_page_array")));
 
@@ -159,7 +159,7 @@ static inline void build_cdex(void)
 	mi.c_format.rs         = 4;		/* $a0 */
 	mi.c_format.c_op       = 3;		/* Create Dirty Exclusive */
 	mi.c_format.cache      = 1;		/* Data Cache */
-	mi.c_format.simmediate = store_offset;
+	mi.c_format.simmediate = store_offset + cpu_dcache_line_size();
 
 	*epc++ = mi.word;
 }
@@ -300,6 +300,8 @@ static inline void build_jr_ra(void)
 
 void __init build_clear_page(void)
 {
+	int lead_size, loop_size;
+
 	epc = (unsigned int *) &clear_page_array;
 
 	if (cpu_has_prefetch) {
@@ -316,7 +318,20 @@ void __init build_clear_page(void)
 		}
 	}
 
-	build_addiu_a2_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_clear : 0));
+	if (cpu_has_prefetch)
+		lead_size = PAGE_SIZE - pref_offset_clear;
+	else if (cpu_has_cache_cdex_p && !cpu_has_cache_cdex_s) {
+		loop_size = 4;
+		if (cpu_has_64bit_registers)
+			loop_size *= 2;
+		loop_size *= 8;
+		if (loop_size < cpu_dcache_line_size())
+			loop_size = cpu_dcache_line_size();
+		lead_size = PAGE_SIZE - loop_size;
+	} else
+		lead_size = PAGE_SIZE;
+
+	build_addiu_a2_a0(lead_size);
 
 	if (R4600_V2_HIT_CACHEOP_WAR && ((read_c0_prid() & 0xfff0) == 0x2020)) {
 		*epc++ = 0x40026000;		/* mfc0    $v0, $12	*/
@@ -354,8 +369,8 @@ dest = epc;
 	build_bne(dest);
 	 build_store_reg(0);
 
-	if (cpu_has_prefetch && pref_offset_clear) {
-		build_addiu_a2_a0(pref_offset_clear);
+	if (lead_size < PAGE_SIZE) {
+		build_addiu_a2_a0(PAGE_SIZE - lead_size);
 	dest = epc;
 		__build_store_reg(0);
 		__build_store_reg(0);
@@ -383,9 +398,26 @@ dest = epc;
 
 void __init build_copy_page(void)
 {
+	int lead_size, loop_size;
+
 	epc = (unsigned int *) &copy_page_array;
 
-	build_addiu_a2_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_copy : 0));
+	if (cpu_has_prefetch)
+		lead_size = PAGE_SIZE - pref_offset_copy;
+	else if (cpu_has_cache_cdex_p && !cpu_has_cache_cdex_s) {
+		loop_size = 4;
+#ifdef CONFIG_MIPS64
+		loop_size *= 2;
+#endif
+		loop_size *= 8;
+		if (loop_size < cpu_dcache_line_size())
+			loop_size = cpu_dcache_line_size();
+		lead_size = PAGE_SIZE - loop_size;
+	} else
+		lead_size = PAGE_SIZE;
+
+	build_addiu_a2_a0(lead_size);
+
 
 	if (R4600_V2_HIT_CACHEOP_WAR && ((read_c0_prid() & 0xfff0) == 0x2020)) {
 		*epc++ = 0x40026000;		/* mfc0    $v0, $12	*/
@@ -440,8 +472,8 @@ dest = epc;
 	build_bne(dest);
 	 build_store_reg(11);
 
-	if (cpu_has_prefetch && pref_offset_copy) {
-		build_addiu_a2_a0(pref_offset_copy);
+	if (lead_size < PAGE_SIZE) {
+		build_addiu_a2_a0(PAGE_SIZE - lead_size);
 	dest = epc;
 		__build_load_reg( 8);
 		__build_load_reg( 9);
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/mm/pg-r4k.c linux-mips-2.4.24-pre2-20040116/arch/mips64/mm/pg-r4k.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/mm/pg-r4k.c	2004-01-26 16:05:38.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/mm/pg-r4k.c	2004-01-26 16:06:21.000000000 +0000
@@ -34,7 +34,7 @@
  * With prefetching, 16 byte strides			0xa0 bytes
  */
 
-static unsigned int clear_page_array[0xa0 / 4];
+static unsigned int clear_page_array[0x100 / 4];
 
 void clear_page(void * page) __attribute__((alias("clear_page_array")));
 
@@ -46,7 +46,7 @@ void clear_page(void * page) __attribute
  * R4600 v2.0:						0x84 bytes
  * With prefetching, 16 byte strides			0xb8 bytes
  */
-static unsigned int copy_page_array[0xb8 / 4];
+static unsigned int copy_page_array[0x100 / 4];
 
 void copy_page(void *to, void *from) __attribute__((alias("copy_page_array")));
 
@@ -159,7 +159,7 @@ static inline void build_cdex(void)
 	mi.c_format.rs         = 4;		/* $a0 */
 	mi.c_format.c_op       = 3;		/* Create Dirty Exclusive */
 	mi.c_format.cache      = 1;		/* Data Cache */
-	mi.c_format.simmediate = store_offset;
+	mi.c_format.simmediate = store_offset + cpu_dcache_line_size();
 
 	*epc++ = mi.word;
 }
@@ -300,6 +300,8 @@ static inline void build_jr_ra(void)
 
 void __init build_clear_page(void)
 {
+	int lead_size, loop_size;
+
 	epc = (unsigned int *) &clear_page_array;
 
 	if (cpu_has_prefetch) {
@@ -316,7 +318,20 @@ void __init build_clear_page(void)
 		}
 	}
 
-	build_addiu_a2_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_clear : 0));
+	if (cpu_has_prefetch)
+		lead_size = PAGE_SIZE - pref_offset_clear;
+	else if (cpu_has_cache_cdex_p && !cpu_has_cache_cdex_s) {
+		loop_size = 4;
+		if (cpu_has_64bit_registers)
+			loop_size *= 2;
+		loop_size *= 8;
+		if (loop_size < cpu_dcache_line_size())
+			loop_size = cpu_dcache_line_size();
+		lead_size = PAGE_SIZE - loop_size;
+	} else
+		lead_size = PAGE_SIZE;
+
+	build_addiu_a2_a0(lead_size);
 
 	if (R4600_V2_HIT_CACHEOP_WAR && ((read_c0_prid() & 0xfff0) == 0x2020)) {
 		*epc++ = 0x40026000;		/* mfc0    $v0, $12	*/
@@ -354,8 +369,8 @@ dest = epc;
 	build_bne(dest);
 	 build_store_reg(0);
 
-	if (cpu_has_prefetch && pref_offset_clear) {
-		build_addiu_a2_a0(pref_offset_clear);
+	if (lead_size < PAGE_SIZE) {
+		build_addiu_a2_a0(PAGE_SIZE - lead_size);
 	dest = epc;
 		__build_store_reg(0);
 		__build_store_reg(0);
@@ -383,9 +398,26 @@ dest = epc;
 
 void __init build_copy_page(void)
 {
+	int lead_size, loop_size;
+
 	epc = (unsigned int *) &copy_page_array;
 
-	build_addiu_a2_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_copy : 0));
+	if (cpu_has_prefetch)
+		lead_size = PAGE_SIZE - pref_offset_copy;
+	else if (cpu_has_cache_cdex_p && !cpu_has_cache_cdex_s) {
+		loop_size = 4;
+#ifdef CONFIG_MIPS64
+		loop_size *= 2;
+#endif
+		loop_size *= 8;
+		if (loop_size < cpu_dcache_line_size())
+			loop_size = cpu_dcache_line_size();
+		lead_size = PAGE_SIZE - loop_size;
+	} else
+		lead_size = PAGE_SIZE;
+
+	build_addiu_a2_a0(lead_size);
+
 
 	if (R4600_V2_HIT_CACHEOP_WAR && ((read_c0_prid() & 0xfff0) == 0x2020)) {
 		*epc++ = 0x40026000;		/* mfc0    $v0, $12	*/
@@ -440,8 +472,8 @@ dest = epc;
 	build_bne(dest);
 	 build_store_reg(11);
 
-	if (cpu_has_prefetch && pref_offset_copy) {
-		build_addiu_a2_a0(pref_offset_copy);
+	if (lead_size < PAGE_SIZE) {
+		build_addiu_a2_a0(PAGE_SIZE - lead_size);
 	dest = epc;
 		__build_load_reg( 8);
 		__build_load_reg( 9);
