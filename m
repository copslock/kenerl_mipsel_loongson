Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 03:50:16 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:3069 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133571AbWCQDuH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Mar 2006 03:50:07 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 17 Mar 2006 12:59:26 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id C3BCC20120;
	Fri, 17 Mar 2006 12:59:23 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B082517D14;
	Fri, 17 Mar 2006 12:59:23 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k2H3xM4D031767;
	Fri, 17 Mar 2006 12:59:23 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 17 Mar 2006 12:59:22 +0900 (JST)
Message-Id: <20060317.125922.112626420.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TX49XX has PREFETCH instruction
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

TX49XX has PREFETCH instruction.  It supports only Pref_Load (hint 0).
Actually changes in this patch except for Kconfig are not have any
effects, I added these changes to prevent misuse of unsupported hints.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f0329a7..1e72c47 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1159,6 +1159,7 @@ config CPU_R4X00
 config CPU_TX49XX
 	bool "R49XX"
 	depends on SYS_HAS_CPU_TX49XX
+	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 9572ed4..32b7f6a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -786,6 +786,7 @@ static void __init probe_pcache(void)
 		c->dcache.waybit = 0;
 
 		c->options |= MIPS_CPU_CACHE_CDEX_P;
+		c->options |= MIPS_CPU_PREFETCH;
 		break;
 
 	case CPU_R4000PC:
diff --git a/arch/mips/mm/pg-r4k.c b/arch/mips/mm/pg-r4k.c
index f51e180..e4390dc 100644
--- a/arch/mips/mm/pg-r4k.c
+++ b/arch/mips/mm/pg-r4k.c
@@ -124,7 +124,7 @@ static inline void build_nop(void)
 
 static inline void build_src_pref(int advance)
 {
-	if (!(load_offset & (cpu_dcache_line_size() - 1))) {
+	if (!(load_offset & (cpu_dcache_line_size() - 1)) && advance) {
 		union mips_instruction mi;
 
 		mi.i_format.opcode     = pref_op;
@@ -166,7 +166,7 @@ static inline void build_load_reg(int re
 
 static inline void build_dst_pref(int advance)
 {
-	if (!(store_offset & (cpu_dcache_line_size() - 1))) {
+	if (!(store_offset & (cpu_dcache_line_size() - 1)) && advance) {
 		union mips_instruction mi;
 
 		mi.i_format.opcode     = pref_op;
@@ -340,6 +340,12 @@ void __init build_clear_page(void)
 
 	if (cpu_has_prefetch) {
 		switch (current_cpu_data.cputype) {
+		case CPU_TX49XX:
+			/* TX49 supports only Pref_Load */
+			pref_offset_clear = 0;
+			pref_offset_copy = 0;
+			break;
+
 		case CPU_RM9000:
 			/*
 			 * As a workaround for erratum G105 which make the
