Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Mar 2017 06:20:26 +0100 (CET)
Received: from smtpbgau1.qq.com ([54.206.16.166]:39089 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993869AbdCKFTvQdcMF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 11 Mar 2017 06:19:51 +0100
X-QQ-mid: bizesmtp8t1489209556tjl6jsqxe
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 11 Mar 2017 13:19:15 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82B00A0000000
X-QQ-FEAT: 8xd5gS3i22rPfpkSnG2sKeCn/YNvEEYKuV0j2H7DRZ5xOFgv/N4NpraqxSJdZ
        psLKhFY4bleyiicoJ97r3GfQ3tg1x+wt675lbfrhOSmg4IvqKpIROXRSCK/wsME+qJY+MFi
        swrC4iL8irzhNZKUmosyIpONp2heiXmrHVGm55EWLlN3Ix9FBm3UvW5X+UseC7xn+tlKZSr
        vrr5TBNgfNTC/bAAKH1+UApQ+iGy9p26wh9AFOVQ0+C43D8LX0ncmMRsdyQALzZIsHXKRzS
        ZURhoKboZ7STCwc88q9g18B3I=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V2 4/7] MIPS: Loongson-3: Select MIPS_L1_CACHE_SHIFT_6
Date:   Sat, 11 Mar 2017 13:19:55 +0800
Message-Id: <1489209598-30312-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1489209598-30312-1-git-send-email-chenhc@lemote.com>
References: <1489209598-30312-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57137
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


ÿÿÿ	
