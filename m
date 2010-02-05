Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2010 00:27:40 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11627 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492265Ab0BEX1g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Feb 2010 00:27:36 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6ca96f0001>; Fri, 05 Feb 2010 15:27:43 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 5 Feb 2010 15:27:18 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 5 Feb 2010 15:27:18 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o15NRFgJ028559;
        Fri, 5 Feb 2010 15:27:15 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o15NRFFN028558;
        Fri, 5 Feb 2010 15:27:15 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/4] MIPS: Add TLBP to uasm.
Date:   Fri,  5 Feb 2010 15:27:10 -0800
Message-Id: <1265412431-28526-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4B6CA90C.1000609@caviumnetworks.com>
References: <4B6CA90C.1000609@caviumnetworks.com>
X-OriginalArrivalTime: 05 Feb 2010 23:27:18.0059 (UTC) FILETIME=[C1E48FB0:01CAA6BA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The soon to follow Read Inhibit/eXecute Inhibit patch needs TLBP
support in uasm.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/uasm.h |    1 +
 arch/mips/mm/uasm.c          |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 3d153ed..b18588b 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -95,6 +95,7 @@ Ip_u2u1u3(_srl);
 Ip_u3u1u2(_subu);
 Ip_u2s3u1(_sw);
 Ip_0(_tlbp);
+Ip_0(_tlbr);
 Ip_0(_tlbwi);
 Ip_0(_tlbwr);
 Ip_u3u1u2(_xor);
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index e3ca0f7..8f4f14d 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -63,7 +63,8 @@ enum opcode {
 	insn_jr, insn_ld, insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0,
 	insn_mtc0, insn_ori, insn_pref, insn_rfe, insn_sc, insn_scd,
 	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
-	insn_tlbp, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori, insn_dins
+	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
+	insn_dins
 };
 
 struct insn {
@@ -128,6 +129,7 @@ static struct insn insn_table[] __cpuinitdata = {
 	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),  RS | RT | RD },
 	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
+	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
 	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
 	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
 	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
@@ -381,6 +383,7 @@ I_u2u1u3(_srl)
 I_u3u1u2(_subu)
 I_u2s3u1(_sw)
 I_0(_tlbp)
+I_0(_tlbr)
 I_0(_tlbwi)
 I_0(_tlbwr)
 I_u3u1u2(_xor)
-- 
1.6.0.6
