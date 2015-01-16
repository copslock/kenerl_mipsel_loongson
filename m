Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:02:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57789 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010770AbbAPKxXIeAVA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:23 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 59B4A82E44D79
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:15 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:17 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:16 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 40/70] MIPS: mm: page: Add MIPS R6 support
Date:   Fri, 16 Jan 2015 10:49:19 +0000
Message-ID: <1421405389-15512-41-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The MIPS R6 pref instruction only have 9 bits for the immediate
field so skip the micro-assembler PREF instruction is the offset
does not fit in 9 bits.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mm/page.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index b611102e23b5..b84e0b2ce140 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -72,6 +72,20 @@ static struct uasm_reloc relocs[5];
 #define cpu_is_r4600_v1_x()	((read_c0_prid() & 0xfffffff0) == 0x00002010)
 #define cpu_is_r4600_v2_x()	((read_c0_prid() & 0xfffffff0) == 0x00002020)
 
+/*
+ * R6 has a limited offset of the pref instruction.
+ * Skip it if the offset is more than 9 bits.
+ */
+#define _uasm_i_pref(a, b, c, d)		\
+do {						\
+	if (cpu_has_mips_r6) {			\
+	    if ((d > 0xff) || (d < -0x100))	\
+		uasm_i_pref(a, b, c, d);	\
+	} else {				\
+		uasm_i_pref(a, b, c, d);	\
+	}					\
+} while(0)
+
 static int pref_bias_clear_store;
 static int pref_bias_copy_load;
 static int pref_bias_copy_store;
@@ -214,7 +228,7 @@ static inline void build_clear_pref(u32 **buf, int off)
 		return;
 
 	if (pref_bias_clear_store) {
-		uasm_i_pref(buf, pref_dst_mode, pref_bias_clear_store + off,
+		_uasm_i_pref(buf, pref_dst_mode, pref_bias_clear_store + off,
 			    A0);
 	} else if (cache_line_size == (half_clear_loop_size << 1)) {
 		if (cpu_has_cache_cdex_s) {
@@ -357,7 +371,7 @@ static inline void build_copy_load_pref(u32 **buf, int off)
 		return;
 
 	if (pref_bias_copy_load)
-		uasm_i_pref(buf, pref_src_mode, pref_bias_copy_load + off, A1);
+		_uasm_i_pref(buf, pref_src_mode, pref_bias_copy_load + off, A1);
 }
 
 static inline void build_copy_store_pref(u32 **buf, int off)
@@ -366,7 +380,7 @@ static inline void build_copy_store_pref(u32 **buf, int off)
 		return;
 
 	if (pref_bias_copy_store) {
-		uasm_i_pref(buf, pref_dst_mode, pref_bias_copy_store + off,
+		_uasm_i_pref(buf, pref_dst_mode, pref_bias_copy_store + off,
 			    A0);
 	} else if (cache_line_size == (half_copy_loop_size << 1)) {
 		if (cpu_has_cache_cdex_s) {
-- 
2.2.1
