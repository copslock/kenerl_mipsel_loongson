Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2017 14:31:31 +0100 (CET)
Received: from smtpbg126.qq.com ([183.60.2.42]:60062 "EHLO smtpbg126.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990513AbdADNbXsYK77 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jan 2017 14:31:23 +0100
X-QQ-mid: Xesmtp31t1483536660txgflebd0
Received: from Red54.com (unknown [183.39.159.125])
        by esmtp4.qq.com (ESMTP) with SMTP id 0
        for <linux-mips@linux-mips.org>; Wed, 04 Jan 2017 21:30:58 +0800 (CST)
X-QQ-SSF: 00000000000000000M104F00000000U
X-QQ-FEAT: 3jlOKZxptE6tTEWJeSspw/JJsQs9PHIQ8a0BA2zZfX076H6wmODwojNhEs/ex
        p5x9DV2YentViIqxD0fwjYCOkHomhhx0caGRQJUi5u5F/E3+mo1Au4/SZAsbxj4+gKR1t4r
        gG62lSMLjG7m61rJdFg00vRGYApFnOwCRD9kkSnC+48XMQTvWa3S50yV9L7gAAs9LfOqmQo
        mUPNsoofA3nUAeigvPBnOQigk6qEevBeYAvEuwPlTFCwqwL3eUo9JwLGEIv4jxJGJiNf+kA
        ncoZFothO86aFKW3+IKge15vQ=
X-QQ-GoodBg: 0
Received: by Red54.com (sSMTP sendmail emulation); Wed, 04 Jan 2017 21:30:58 +0800
Date:   Wed, 4 Jan 2017 21:30:58 +0800
From:   =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Loongson: Merge load addresses
Message-ID: <20170104133058.GA20822@red54.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.2 (2016-11-26)
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:Red54.com:bgforeign:bgforeign3
X-QQ-Bgrelay: 1
Return-Path: <Yeking@Red54.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Yeking@Red54.com
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

Loongson 1 is a 32-bit MIPS CPU family with PRID 0x4220.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 arch/mips/loongson32/Platform | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/loongson32/Platform b/arch/mips/loongson32/Platform
index ffe01c6d..29795d56 100644
--- a/arch/mips/loongson32/Platform
+++ b/arch/mips/loongson32/Platform
@@ -4,5 +4,4 @@ cflags-$(CONFIG_CPU_LOONGSON1)	+= \
 
 platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
 cflags-$(CONFIG_MACH_LOONGSON32)	+= -I$(srctree)/arch/mips/include/asm/mach-loongson32
-load-$(CONFIG_LOONGSON1_LS1B)		+= 0xffffffff80100000
-load-$(CONFIG_LOONGSON1_LS1C)		+= 0xffffffff80100000
+load-$(CONFIG_CPU_LOONGSON1)		+= 0xffffffff80100000
-- 
2.11.0
