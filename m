Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 11:50:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18882 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008868AbaIXJuzBiQpM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 11:50:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0A64EB8DBB164
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 10:50:46 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:50:48 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Sep 2014 10:50:48 +0100
Received: from pburton-laptop.home (192.168.159.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:50:47 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 11/11] MIPS: MSA: Fix big-endian FPR_IDX implementation
Date:   Wed, 24 Sep 2014 10:45:42 +0100
Message-ID: <1411551942-11153-12-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 42766
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

From: James Hogan <james.hogan@imgtec.com>

The maximum word size is 64-bits since MSA state is saved using st.d
which stores two 64-bit words, therefore reimplement FPR_IDX using xor,
and only within each 64-bit word.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 05f0843..1c6f086 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -111,7 +111,7 @@ union fpureg {
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 # define FPR_IDX(width, idx)	(idx)
 #else
-# define FPR_IDX(width, idx)	((FPU_REG_WIDTH / (width)) - 1 - (idx))
+# define FPR_IDX(width, idx)	((idx) ^ ((64 / (width)) - 1))
 #endif
 
 #define BUILD_FPR_ACCESS(width) \
-- 
2.0.4
