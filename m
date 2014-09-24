Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 11:49:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38423 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008960AbaIXJtJLyoFE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 11:49:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 218F15B460571
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 10:49:00 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Sep 2014 10:49:02 +0100
Received: from pburton-laptop.home (192.168.159.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:49:01 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <stable@vger.kernel.org # v3.15+>
Subject: [PATCH 06/11] MIPS: fix mfc1 & mfhc1 emulation for mips64 systems
Date:   Wed, 24 Sep 2014 10:45:37 +0100
Message-ID: <1411551942-11153-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
References: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.158]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42761
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

Commit bbd426f542cb "MIPS: Simplify FP context access" modified the
SIFROMREG & SIFROMHREG macros such that they return unsigned rather
than signed 32b integers. I had believed that to be fine, but
inadvertently missed the mfc1 & mfhc1 cases which write to a struct
pt_regs regs element. On mips32 this is fine, but on mips64 those
saved regs fields are 64b wide. Using unsigned values caused the
32b value from the FP register to be zero rather than sign extended
as the architecture specifies, causing incorrect emulation of the
mfc1 & mfhc1 instructions. Fix by reintroducing the casts to signed
integers, and therefore the sign extension.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: stable@vger.kernel.org # v3.15+
---
 arch/mips/math-emu/cp1emu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index ef8447f..298c1ae 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -655,9 +655,9 @@ static inline bool hybrid_fprs(void)
 #define SIFROMREG(si, x)						\
 do {									\
 	if (cop1_64bit(xcp) && !hybrid_fprs())				\
-		(si) = get_fpr32(&ctx->fpr[x], 0);			\
+		(si) = (int)get_fpr32(&ctx->fpr[x], 0);			\
 	else								\
-		(si) = get_fpr32(&ctx->fpr[(x) & ~1], (x) & 1);		\
+		(si) = (int)get_fpr32(&ctx->fpr[(x) & ~1], (x) & 1);	\
 } while (0)
 
 #define SITOREG(si, x)							\
@@ -672,7 +672,7 @@ do {									\
 	}								\
 } while (0)
 
-#define SIFROMHREG(si, x)	((si) = get_fpr32(&ctx->fpr[x], 1))
+#define SIFROMHREG(si, x)	((si) = (int)get_fpr32(&ctx->fpr[x], 1))
 
 #define SITOHREG(si, x)							\
 do {									\
-- 
2.0.4
