Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 03:18:41 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9001 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491015Ab0L1CSi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 03:18:38 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d19492a0000>; Mon, 27 Dec 2010 18:19:22 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 27 Dec 2010 18:18:36 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 27 Dec 2010 18:18:36 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBS2IWei011487;
        Mon, 27 Dec 2010 18:18:32 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBS2IUMp011486;
        Mon, 27 Dec 2010 18:18:30 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Use WARN() in uasm for better diagnostics.
Date:   Mon, 27 Dec 2010 18:18:29 -0800
Message-Id: <1293502709-11454-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 28 Dec 2010 02:18:36.0775 (UTC) FILETIME=[88BCE770:01CBA635]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On the off chance that uasm ever warns about overflow, there is no way
to know what the offending instruction is.

Change the printks to WARNs, so we can get a nice stack trace.  It has
the added benefit of being much more noticeable than the short single
line warning message, so is less likely to be ignored.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/uasm.c |   40 ++++++++++++++++------------------------
 1 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 357916d..4008c79 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -156,91 +156,83 @@ static struct insn insn_table[] __uasminitdata = {
 
 static inline __uasminit u32 build_rs(u32 arg)
 {
-	if (arg & ~RS_MASK)
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg & ~RS_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return (arg & RS_MASK) << RS_SH;
 }
 
 static inline __uasminit u32 build_rt(u32 arg)
 {
-	if (arg & ~RT_MASK)
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg & ~RT_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return (arg & RT_MASK) << RT_SH;
 }
 
 static inline __uasminit u32 build_rd(u32 arg)
 {
-	if (arg & ~RD_MASK)
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg & ~RD_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return (arg & RD_MASK) << RD_SH;
 }
 
 static inline __uasminit u32 build_re(u32 arg)
 {
-	if (arg & ~RE_MASK)
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg & ~RE_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return (arg & RE_MASK) << RE_SH;
 }
 
 static inline __uasminit u32 build_simm(s32 arg)
 {
-	if (arg > 0x7fff || arg < -0x8000)
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg > 0x7fff || arg < -0x8000,
+	     KERN_WARNING "Micro-assembler field overflow\n");
 
 	return arg & 0xffff;
 }
 
 static inline __uasminit u32 build_uimm(u32 arg)
 {
-	if (arg & ~IMM_MASK)
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg & ~IMM_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return arg & IMM_MASK;
 }
 
 static inline __uasminit u32 build_bimm(s32 arg)
 {
-	if (arg > 0x1ffff || arg < -0x20000)
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg > 0x1ffff || arg < -0x20000,
+	     KERN_WARNING "Micro-assembler field overflow\n");
 
-	if (arg & 0x3)
-		printk(KERN_WARNING "Invalid micro-assembler branch target\n");
+	WARN(arg & 0x3, KERN_WARNING "Invalid micro-assembler branch target\n");
 
 	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
 }
 
 static inline __uasminit u32 build_jimm(u32 arg)
 {
-	if (arg & ~((JIMM_MASK) << 2))
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg & ~((JIMM_MASK) << 2),
+	     KERN_WARNING "Micro-assembler field overflow\n");
 
 	return (arg >> 2) & JIMM_MASK;
 }
 
 static inline __uasminit u32 build_scimm(u32 arg)
 {
-	if (arg & ~SCIMM_MASK)
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg & ~SCIMM_MASK,
+	     KERN_WARNING "Micro-assembler field overflow\n");
 
 	return (arg & SCIMM_MASK) << SCIMM_SH;
 }
 
 static inline __uasminit u32 build_func(u32 arg)
 {
-	if (arg & ~FUNC_MASK)
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg & ~FUNC_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return arg & FUNC_MASK;
 }
 
 static inline __uasminit u32 build_set(u32 arg)
 {
-	if (arg & ~SET_MASK)
-		printk(KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg & ~SET_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return arg & SET_MASK;
 }
-- 
1.7.2.3
