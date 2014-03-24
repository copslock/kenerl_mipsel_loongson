Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 11:24:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.115]:45244 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823033AbaCXKWMKBP1l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 11:22:12 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 829D878172C0B
        for <linux-mips@linux-mips.org>; Mon, 24 Mar 2014 10:22:04 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:22:05 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:22:05 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 12/12] MIPS: CPC: use __raw_ memory access functions
Date:   Mon, 24 Mar 2014 10:19:35 +0000
Message-ID: <1395656375-9300-13-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
References: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39572
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

The CPC registers use native endianness, so using plain readl & writel
will produce incorrect results on big endian systems.

Reported-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
Reported-by: Keng Koh <keng.koh@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Feel free to apply as a fixup for "MIPS: Add CPC probe, access
functions".
---
 arch/mips/include/asm/mips-cpc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
index fb78935..988507e 100644
--- a/arch/mips/include/asm/mips-cpc.h
+++ b/arch/mips/include/asm/mips-cpc.h
@@ -75,13 +75,13 @@ static inline bool mips_cpc_present(void)
 #define BUILD_CPC_R_(name, off) \
 static inline u32 read_cpc_##name(void)				\
 {								\
-	return readl(mips_cpc_base + (off));			\
+	return __raw_readl(mips_cpc_base + (off));		\
 }
 
 #define BUILD_CPC__W(name, off) \
 static inline void write_cpc_##name(u32 value)			\
 {								\
-	writel(value, mips_cpc_base + (off));			\
+	__raw_writel(value, mips_cpc_base + (off));		\
 }
 
 #define BUILD_CPC_RW(name, off)					\
-- 
1.8.5.3
