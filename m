Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 21:18:18 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9084 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492612Ab0D1TRR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 21:17:17 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bd889c90002>; Wed, 28 Apr 2010 12:17:29 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 12:16:27 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 12:16:27 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o3SJGNZ3004759;
        Wed, 28 Apr 2010 12:16:23 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o3SJGNkI004758;
        Wed, 28 Apr 2010 12:16:23 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/3] MIPS:  Add uasm_i_dsrl_safe() and uasm_i_dsll_safe() to uasm.
Date:   Wed, 28 Apr 2010 12:16:16 -0700
Message-Id: <1272482178-4712-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1272482178-4712-1-git-send-email-ddaney@caviumnetworks.com>
References: <1272482178-4712-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Apr 2010 19:16:27.0635 (UTC) FILETIME=[4D039C30:01CAE707]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This allows us to clean up the code by not having to explicitly code
checks for shift amounts greater than 32.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/uasm.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 11a8b52..697e40c 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -167,6 +167,24 @@ static inline void __cpuinit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
 #define uasm_i_ssnop(buf) uasm_i_sll(buf, 0, 0, 1)
 #define uasm_i_ehb(buf) uasm_i_sll(buf, 0, 0, 3)
 
+static inline void uasm_i_dsrl_safe(u32 **p, unsigned int a1,
+				    unsigned int a2, unsigned int a3)
+{
+	if (a3 < 32)
+		uasm_i_dsrl(p, a1, a2, a3);
+	else
+		uasm_i_dsrl32(p, a1, a2, a3 - 32);
+}
+
+static inline void uasm_i_dsll_safe(u32 **p, unsigned int a1,
+				    unsigned int a2, unsigned int a3)
+{
+	if (a3 < 32)
+		uasm_i_dsll(p, a1, a2, a3);
+	else
+		uasm_i_dsll32(p, a1, a2, a3 - 32);
+}
+
 /* Handle relocations. */
 struct uasm_reloc {
 	u32 *addr;
-- 
1.6.6.1
