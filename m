Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 14:05:17 +0100 (CET)
Received: from SMTPBG19.QQ.COM ([183.60.61.236]:36485 "EHLO smtpbg320.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991955AbdCPNFKYxvi- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Mar 2017 14:05:10 +0100
X-QQ-mid: bizesmtp3t1489669437txn9ig22c
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 16 Mar 2017 21:02:38 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82000A0000000
X-QQ-FEAT: HqsAE+iGIGhe1RY4ndo1pKTRmOpmZfSlqoc7yGvDKBGItkUQOrHAY5RB7qvRk
        1t9ZzSwZsuVLhc4om+1ex2pCJiMtpTmVMs29KrPFXpHAKysKS8pIQUcoSJcgFlcvd7v2DIp
        8VJ7sCvfUEeC6RiZqf9LXorpqo/7mhr7T41M9oNQFqU1sOQnVt6VwfT/ej5qZSFbgwbSHuW
        RPV21zumI0XtBy6Wb0tceEQgs0g6qfJGOfCS4neq5OgKzFT12zs6g4aJbz6O+UrmcZTJeh1
        ku041XDokQQgbEG7xEl7V1TvRaTWhXnbS5Ng==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH RESEND V2 4/7] MIPS: Loongson-3: Select MIPS_L1_CACHE_SHIFT_6
Date:   Thu, 16 Mar 2017 21:00:28 +0800
Message-Id: <1489669231-28162-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1489669231-28162-1-git-send-email-chenhc@lemote.com>
References: <1489669231-28162-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Some newer Loongson-3 has 64 bytes cache line size, so we select
MIPS_L1_CACHE_SHIFT_6.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e0bb576..c3c7d8a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1373,6 +1373,7 @@ config CPU_LOONGSON3
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
 	select MIPS_PGD_C0_CONTEXT
+	select MIPS_L1_CACHE_SHIFT_6
 	select GPIOLIB
 	help
 		The Loongson 3 processor implements the MIPS64R2 instruction
-- 
2.7.0


	
