Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2004 16:55:27 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:8874 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225305AbUAZQz0>; Mon, 26 Jan 2004 16:55:26 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 1143447831; Mon, 26 Jan 2004 17:55:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 02604477F0; Mon, 26 Jan 2004 17:55:23 +0100 (CET)
Date: Mon, 26 Jan 2004 17:55:23 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] pg-r4k.c bugs for R4k systems with a secondary cache
Message-ID: <Pine.LNX.4.55.0401261731370.26076@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 This patch fixes a bug in build_cdex() that makes the function invoke the
Create Dirty Exclusive command for the D-cache when a secondary cache is
present.  This is unnecessary as the Create Dirty Exclusive command for
the S-cache acts upon the D-cache appropriately and (for reasons yet to be
investigated) using the command on the D-cache directly leads to memory
corruption on my R4400SC system.  With the patch the system appears
stable.

 The patch also removes references to has_scache which currently disable 
code for the S-cache line size of 128 bytes as the variable is always 0.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-mips-pg-r4k-scache-0
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/mm/pg-r4k.c linux-mips-2.4.24-pre2-20040116/arch/mips/mm/pg-r4k.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/mm/pg-r4k.c	2004-01-03 03:56:38.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/mm/pg-r4k.c	2004-01-26 12:13:22.000000000 +0000
@@ -67,7 +67,6 @@ static int pref_offset_copy  __initdata 
 static unsigned int pref_src_mode __initdata;
 static unsigned int pref_dst_mode __initdata;
 
-static int has_scache __initdata = 0;
 static int load_offset __initdata = 0;
 static int store_offset __initdata = 0;
 
@@ -130,16 +129,20 @@ static inline void build_cdex(void)
 {
 	union mips_instruction mi;
 
-	if (cpu_has_cache_cdex_s &&
-	    !(store_offset & (cpu_scache_line_size() - 1))) {
+	if (cpu_has_cache_cdex_s) {
+		if (!(store_offset & (cpu_scache_line_size() - 1))) {
 
-		mi.c_format.opcode     = cache_op;
-		mi.c_format.rs         = 4;	/* $a0 */
-		mi.c_format.c_op       = 3;	/* Create Dirty Exclusive */
-		mi.c_format.cache      = 3;	/* Secondary Data Cache */
-		mi.c_format.simmediate = store_offset;
+			mi.c_format.opcode     = cache_op;
+			mi.c_format.rs         = 4;	/* $a0 */
+			mi.c_format.c_op       = 3;	/* Create Dirty
+							   Exclusive */
+			mi.c_format.cache      = 3;	/* Secondary Data
+							   Cache */
+			mi.c_format.simmediate = store_offset;
 
 		*epc++ = mi.word;
+		}
+		return;
 	}
 
 	if (store_offset & (cpu_dcache_line_size() - 1))
@@ -332,7 +335,7 @@ dest = epc;
 	build_store_reg(0);
 	build_store_reg(0);
 	build_store_reg(0);
-	if (has_scache && cpu_scache_line_size() == 128) {
+	if (cpu_scache_line_size() == 128) {
 		build_store_reg(0);
 		build_store_reg(0);
 		build_store_reg(0);
@@ -341,7 +344,7 @@ dest = epc;
 	build_addiu_a0(2 * store_offset);
 	build_store_reg(0);
 	build_store_reg(0);
-	if (has_scache && cpu_scache_line_size() == 128) {
+	if (cpu_scache_line_size() == 128) {
 		build_store_reg(0);
 		build_store_reg(0);
 		build_store_reg(0);
@@ -405,7 +408,7 @@ dest = epc;
 	build_store_reg( 9);
 	build_store_reg(10);
 	build_store_reg(11);
-	if (has_scache && cpu_scache_line_size() == 128) {
+	if (cpu_scache_line_size() == 128) {
 		build_load_reg( 8);
 		build_load_reg( 9);
 		build_load_reg(10);
@@ -424,7 +427,7 @@ dest = epc;
 	build_store_reg( 8);
 	build_store_reg( 9);
 	build_store_reg(10);
-	if (has_scache && cpu_scache_line_size() == 128) {
+	if (cpu_scache_line_size() == 128) {
 		build_store_reg(11);
 		build_load_reg( 8);
 		build_load_reg( 9);
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/mm/pg-r4k.c linux-mips-2.4.24-pre2-20040116/arch/mips64/mm/pg-r4k.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/mm/pg-r4k.c	2004-01-03 03:56:46.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/mm/pg-r4k.c	2004-01-26 12:13:22.000000000 +0000
@@ -67,7 +67,6 @@ static int pref_offset_copy  __initdata 
 static unsigned int pref_src_mode __initdata;
 static unsigned int pref_dst_mode __initdata;
 
-static int has_scache __initdata = 0;
 static int load_offset __initdata = 0;
 static int store_offset __initdata = 0;
 
@@ -130,16 +129,20 @@ static inline void build_cdex(void)
 {
 	union mips_instruction mi;
 
-	if (cpu_has_cache_cdex_s &&
-	    !(store_offset & (cpu_scache_line_size() - 1))) {
+	if (cpu_has_cache_cdex_s) {
+		if (!(store_offset & (cpu_scache_line_size() - 1))) {
 
-		mi.c_format.opcode     = cache_op;
-		mi.c_format.rs         = 4;	/* $a0 */
-		mi.c_format.c_op       = 3;	/* Create Dirty Exclusive */
-		mi.c_format.cache      = 3;	/* Secondary Data Cache */
-		mi.c_format.simmediate = store_offset;
+			mi.c_format.opcode     = cache_op;
+			mi.c_format.rs         = 4;	/* $a0 */
+			mi.c_format.c_op       = 3;	/* Create Dirty
+							   Exclusive */
+			mi.c_format.cache      = 3;	/* Secondary Data
+							   Cache */
+			mi.c_format.simmediate = store_offset;
 
 		*epc++ = mi.word;
+		}
+		return;
 	}
 
 	if (store_offset & (cpu_dcache_line_size() - 1))
@@ -332,7 +335,7 @@ dest = epc;
 	build_store_reg(0);
 	build_store_reg(0);
 	build_store_reg(0);
-	if (has_scache && cpu_scache_line_size() == 128) {
+	if (cpu_scache_line_size() == 128) {
 		build_store_reg(0);
 		build_store_reg(0);
 		build_store_reg(0);
@@ -341,7 +344,7 @@ dest = epc;
 	build_addiu_a0(2 * store_offset);
 	build_store_reg(0);
 	build_store_reg(0);
-	if (has_scache && cpu_scache_line_size() == 128) {
+	if (cpu_scache_line_size() == 128) {
 		build_store_reg(0);
 		build_store_reg(0);
 		build_store_reg(0);
@@ -405,7 +408,7 @@ dest = epc;
 	build_store_reg( 9);
 	build_store_reg(10);
 	build_store_reg(11);
-	if (has_scache && cpu_scache_line_size() == 128) {
+	if (cpu_scache_line_size() == 128) {
 		build_load_reg( 8);
 		build_load_reg( 9);
 		build_load_reg(10);
@@ -424,7 +427,7 @@ dest = epc;
 	build_store_reg( 8);
 	build_store_reg( 9);
 	build_store_reg(10);
-	if (has_scache && cpu_scache_line_size() == 128) {
+	if (cpu_scache_line_size() == 128) {
 		build_store_reg(11);
 		build_load_reg( 8);
 		build_load_reg( 9);
