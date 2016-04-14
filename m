Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 05:09:24 +0200 (CEST)
Received: from m50-135.163.com ([123.125.50.135]:57632 "EHLO m50-135.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006657AbcDNDJW5euPW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Apr 2016 05:09:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=bZJ/MTG3Jh8uOuBhfJ
        X/nvGnfJzeCxGCZeX9VcdPjPw=; b=J6l0Ru2tAILOjzmosZP3p0dLRBK0HY47S4
        xY/QmYb1L2oMqyP49pqqlKPAiwwsHf0N2qBchll3NIDGZhegunUCWgkYRYZDzJjG
        KIWVGXAUpkmWtQEk6fTIzIMcTUVyFJPFiWgaeBvZRGmJvNVNN77nVGsl0NWk0jLs
        6rjbyiGo4=
Received: from zhaoxiuzeng-VirtualBox.spreadtrum.com (unknown [112.95.225.98])
        by smtp5 (Coremail) with SMTP id D9GowAB3oMHcCQ9X4U_cCQ--.23862S2;
        Thu, 14 Apr 2016 11:09:20 +0800 (CST)
From:   zengzhaoxiu@163.com
To:     linux-kernel@vger.kernel.org
Cc:     Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH V3 11/29] mips: use parity functions in cerr-sb1.c
Date:   Thu, 14 Apr 2016 11:09:13 +0800
Message-Id: <1460603355-5033-1-git-send-email-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
References: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
X-CM-TRANSID: D9GowAB3oMHcCQ9X4U_cCQ--.23862S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFW7uFWUXr13AFWkKw1fXrb_yoW5Zr4kpr
        s8J3srtr1xJ3W3ZF9rJr1UJ3WrtrWkGF1UJryUGrn5Jr43AF1Utry5J3yxCryFgrWFqFy8
        Ar4aqrWqgrnrArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bO3ktUUUUU=
X-Originating-IP: [112.95.225.98]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/xtbBDQBLgFaDmYPRQgAAsa
Return-Path: <zengzhaoxiu@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zengzhaoxiu@163.com
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

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 arch/mips/mm/cerr-sb1.c | 67 +++++++++++++------------------------------------
 1 file changed, 17 insertions(+), 50 deletions(-)

diff --git a/arch/mips/mm/cerr-sb1.c b/arch/mips/mm/cerr-sb1.c
index ee5c1ff..2e7d660 100644
--- a/arch/mips/mm/cerr-sb1.c
+++ b/arch/mips/mm/cerr-sb1.c
@@ -264,27 +264,6 @@ asmlinkage void sb1_cache_error(void)
 #endif
 }
 
-
-/* Parity lookup table. */
-static const uint8_t parity[256] = {
-	0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-	1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-	1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-	0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-	1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-	0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-	0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-	1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-	1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-	0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-	0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-	1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-	0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
-	1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-	1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
-	0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0
-};
-
 /* Masks to select bits for Hamming parity, mask_72_64[i] for bit[i] */
 static const uint64_t mask_72_64[8] = {
 	0x0738C808099264FFULL,
@@ -298,34 +277,28 @@ static const uint64_t mask_72_64[8] = {
 };
 
 /* Calculate the parity on a range of bits */
-static char range_parity(uint64_t dword, int max, int min)
+static inline char range_parity(uint64_t dword, int max, int min)
 {
-	char parity = 0;
-	int i;
-	dword >>= min;
-	for (i=max-min; i>=0; i--) {
-		if (dword & 0x1)
-			parity = !parity;
-		dword >>= 1;
+	int n = max - min + 1;
+	if (__builtin_constant_p(n)) {
+		if (n <= 8)
+			return parity8((unsigned int)(dword >> min) & ((1U << n) - 1));
+		if (n <= 16)
+			return parity16((unsigned int)(dword >> min) & ((1U << n) - 1));
+		if (n <= 32)
+			return parity32((unsigned int)(dword >> min) & ((1U << n) - 1));
 	}
-	return parity;
+	return parity64((dword >> min) & ((1ULL << n) - 1));
 }
 
 /* Calculate the 4-bit even byte-parity for an instruction */
-static unsigned char inst_parity(uint32_t word)
+static inline unsigned char inst_parity(uint32_t word)
 {
-	int i, j;
-	char parity = 0;
-	for (j=0; j<4; j++) {
-		char byte_parity = 0;
-		for (i=0; i<8; i++) {
-			if (word & 0x80000000)
-				byte_parity = !byte_parity;
-			word <<= 1;
-		}
-		parity <<= 1;
-		parity |= byte_parity;
-	}
+	char parity;
+	parity  = parity8(word >> 24) << 3;
+	parity |= parity8(word >> 16) << 2;
+	parity |= parity8(word >> 8) << 1;
+	parity |= parity8(word);
 	return parity;
 }
 
@@ -436,7 +409,6 @@ static uint32_t extract_ic(unsigned short addr, int data)
 static uint8_t dc_ecc(uint64_t dword)
 {
 	uint64_t t;
-	uint32_t w;
 	uint8_t	 p;
 	int	 i;
 
@@ -445,12 +417,7 @@ static uint8_t dc_ecc(uint64_t dword)
 	{
 		p <<= 1;
 		t = dword & mask_72_64[i];
-		w = (uint32_t)(t >> 32);
-		p ^= (parity[w>>24] ^ parity[(w>>16) & 0xFF]
-		      ^ parity[(w>>8) & 0xFF] ^ parity[w & 0xFF]);
-		w = (uint32_t)(t & 0xFFFFFFFF);
-		p ^= (parity[w>>24] ^ parity[(w>>16) & 0xFF]
-		      ^ parity[(w>>8) & 0xFF] ^ parity[w & 0xFF]);
+		p |= parity64(t);
 	}
 	return p;
 }
-- 
2.5.0
