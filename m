Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2011 01:35:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1464 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492023Ab1GEXe4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jul 2011 01:34:56 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e139fe10000>; Tue, 05 Jul 2011 16:36:01 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 5 Jul 2011 16:34:53 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 5 Jul 2011 16:34:53 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p65NYmM1001659;
        Tue, 5 Jul 2011 16:34:48 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p65NYlmo001658;
        Tue, 5 Jul 2011 16:34:47 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS: Add uasm UASM_i_SRL_SAFE macro.
Date:   Tue,  5 Jul 2011 16:34:45 -0700
Message-Id: <1309908886-1624-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 05 Jul 2011 23:34:53.0402 (UTC) FILETIME=[2409A3A0:01CC3B6C]
X-archive-position: 30583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3612

This can be used from either 32-bit or 64-bit code to generate logical
right shifts of any constant amount.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/uasm.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index dcbd4bb..504d40a 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -150,6 +150,7 @@ static inline void __uasminit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
 # define UASM_i_SLL(buf, rs, rt, sh) uasm_i_dsll(buf, rs, rt, sh)
 # define UASM_i_SRA(buf, rs, rt, sh) uasm_i_dsra(buf, rs, rt, sh)
 # define UASM_i_SRL(buf, rs, rt, sh) uasm_i_dsrl(buf, rs, rt, sh)
+# define UASM_i_SRL_SAFE(buf, rs, rt, sh) uasm_i_dsrl_safe(buf, rs, rt, sh)
 # define UASM_i_ROTR(buf, rs, rt, sh) uasm_i_drotr(buf, rs, rt, sh)
 # define UASM_i_MFC0(buf, rt, rd...) uasm_i_dmfc0(buf, rt, rd)
 # define UASM_i_MTC0(buf, rt, rd...) uasm_i_dmtc0(buf, rt, rd)
@@ -165,6 +166,7 @@ static inline void __uasminit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
 # define UASM_i_SLL(buf, rs, rt, sh) uasm_i_sll(buf, rs, rt, sh)
 # define UASM_i_SRA(buf, rs, rt, sh) uasm_i_sra(buf, rs, rt, sh)
 # define UASM_i_SRL(buf, rs, rt, sh) uasm_i_srl(buf, rs, rt, sh)
+# define UASM_i_SRL_SAFE(buf, rs, rt, sh) uasm_i_srl(buf, rs, rt, sh)
 # define UASM_i_ROTR(buf, rs, rt, sh) uasm_i_rotr(buf, rs, rt, sh)
 # define UASM_i_MFC0(buf, rt, rd...) uasm_i_mfc0(buf, rt, rd)
 # define UASM_i_MTC0(buf, rt, rd...) uasm_i_mtc0(buf, rt, rd)
-- 
1.7.2.3
