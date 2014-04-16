Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:00:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:56019 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834698AbaDPM6sOvCbH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:58:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8E1C550E4FF3D
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:58:39 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 13:58:41 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:58:41 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:58:40 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 18/39] MIPS: inst.h: define MT yield op
Date:   Wed, 16 Apr 2014 13:53:09 +0100
Message-ID: <1397652810-4336-19-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The opcode for the MT ASE yield instruction within the spec3 group was
missing. This patch adds it for use by a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 044123b..b7492c6 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -74,16 +74,17 @@ enum spec2_op {
 enum spec3_op {
 	ext_op, dextm_op, dextu_op, dext_op,
 	ins_op, dinsm_op, dinsu_op, dins_op,
-	lx_op     = 0x0a, lwle_op   = 0x19,
-	lwre_op   = 0x1a, cachee_op = 0x1b,
-	sbe_op    = 0x1c, she_op    = 0x1d,
-	sce_op    = 0x1e, swe_op    = 0x1f,
-	bshfl_op  = 0x20, swle_op   = 0x21,
-	swre_op   = 0x22, prefe_op  = 0x23,
-	dbshfl_op = 0x24, lbue_op   = 0x28,
-	lhue_op   = 0x29, lbe_op    = 0x2c,
-	lhe_op    = 0x2d, lle_op    = 0x2e,
-	lwe_op    = 0x2f, rdhwr_op  = 0x3b
+	yield_op  = 0x09, lx_op     = 0x0a,
+	lwle_op   = 0x19, lwre_op   = 0x1a,
+	cachee_op = 0x1b, sbe_op    = 0x1c,
+	she_op    = 0x1d, sce_op    = 0x1e,
+	swe_op    = 0x1f, bshfl_op  = 0x20,
+	swle_op   = 0x21, swre_op   = 0x22,
+	prefe_op  = 0x23, dbshfl_op = 0x24,
+	lbue_op   = 0x28, lhue_op   = 0x29,
+	lbe_op    = 0x2c, lhe_op    = 0x2d,
+	lle_op    = 0x2e, lwe_op    = 0x2f,
+	rdhwr_op  = 0x3b
 };
 
 /*
-- 
1.8.5.3
