Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2016 08:56:30 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36309 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006954AbcC0G42uYRLG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Mar 2016 08:56:28 +0200
Received: by mail-pf0-f193.google.com with SMTP id q129so16766969pfb.3;
        Sat, 26 Mar 2016 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=6Bu4jyPuF1D7JoGd1Q84Sw90Y53sE1V1YSmS8XVFZ0o=;
        b=TV49XkORQqaXYqsf9gup+6U4JHGH/+OftllYVL8d9XDD8hbqm1HaJjBL1IJA1NGCYY
         TOiiKf4a5G61toHIGRHyyCek4IXkJ98ft9EjHTcwyVV/No3Sc9C/fI0kY/kIzpqKHAqJ
         DFAS/ebLiBPtWEmh5Sf2gwMB/mBKfPUIZUQBOuVIPMmgSOqyH/hx3AdyQc8IEQwSVO3+
         gqb28NnXdDgLQ/vITOUhWzX63BlY+G5tPJmpfZyHIUGa5f2uaqrPopIG1s48dStv5wEP
         yFOF+jzKHrPQ85PDmenq8IV0Bd8prtQUikh8FhHTXZNcN99dYX5BY8RA4JiCaoHMxtZY
         CqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=6Bu4jyPuF1D7JoGd1Q84Sw90Y53sE1V1YSmS8XVFZ0o=;
        b=cGBUwT6pxDjAI0dhXNIlAXNMvmfSuC4KkuiLS9TP4XPWi6lPF53It0iruc27nUgMe8
         atcCUIZz4GAMo2kRhweHu/ocKWDM6g4CBQT6oqOZIaU/lQWeRkDCoDTYR5zIR1m+PRbC
         3eA99BiL5FnmA3qty1r/oGzGDjX/EqUbi4Jyz4UkSbUcaoew9cDP/hgBmWDhZjTejr14
         4oafKbWhCdj5OmsmdHfnk+cG+dOmNzdng0IwgMHX9eGZJ57yIl8Nw1U/TJNEbnX5/Vr1
         E34P8fanHniPRISsQEXOfRCYzulW8QINAmAMEZccdmvKAyaCcYLG0sQBfJeLBow1wXhe
         CxuA==
X-Gm-Message-State: AD7BkJJqelr2ECNG+p98GHjakphcJeagW4IlrtdGkf173cjy8Xi9zE4DFyDxjQQdeH/Wxw==
X-Received: by 10.98.10.83 with SMTP id s80mr32931501pfi.120.1459061782830;
        Sat, 26 Mar 2016 23:56:22 -0700 (PDT)
Received: from [0.0.0.0] (dsl-olubrasgw1-54fb5b-165.dhcp.inet.fi. [84.251.91.165])
        by smtp.googlemail.com with ESMTPSA id d19sm26848478pfj.92.2016.03.26.23.56.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Mar 2016 23:56:22 -0700 (PDT)
Subject: [PATCH 13/31] mips: use parity functions in cerr-sb1.c
To:     Ralf Baechle <ralf@linux-mips.org>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
From:   "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Message-ID: <56F783FE.6080304@gmail.com>
Date:   Sun, 27 Mar 2016 14:55:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-Path: <zhaoxiu.zeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhaoxiu.zeng@gmail.com
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

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
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
2.5.5
