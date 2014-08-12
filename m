Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2014 14:27:11 +0200 (CEST)
Received: from m12-12.163.com ([220.181.12.12]:33169 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6898450AbaHLM0cqRTXC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Aug 2014 14:26:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=GavTWBcNP9v1kSAatE
        zi69xxf1Aah869cz391p0eAkA=; b=bNbPimYH7aSVxIG0MrVql1YpNZXhTpWurd
        14NVnUhFzotfmL8JxVA8wS9KiHkOtWc8ODZCg9EJA0J4iDJ1BtUWNWE8jxAyVtSZ
        EMKOpGuvp4auFtqHpgwZ0hfXFFDp05Z4EbBRgZuOULMZkDsQRRtaY/3JV6QUgM23
        2agU0ZhGk=
Received: from localhost.localdomain.localdomain (unknown [180.110.160.105])
        by smtp8 (Coremail) with SMTP id DMCowEDp2WDwB+pTt3oPAA--.584S2;
        Tue, 12 Aug 2014 20:26:25 +0800 (CST)
X-Coremail-DSSMTP: 180.110.160.105
From:   weiyj_lk@163.com
To:     Ralf Baechle <ralf@linux-mips.org>, Huacai Chen <chenhc@lemote.com>
Cc:     Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next] MIPS: Remove duplicated include from numa.c
Date:   Tue, 12 Aug 2014 20:26:22 +0800
Message-Id: <1407846382-29951-1-git-send-email-weiyj_lk@163.com>
X-Mailer: git-send-email 1.9.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DMCowEDp2WDwB+pTt3oPAA--.584S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7WryUGr15JF4fXr4rXrWUJwb_yoWxKrgEka
        4a9w48G34fJF1xt3yxXrsrJ3y3W34UJ3WY9FnY9r1Svas8twsIgayDAw15Jr1a9wn0yrs3
        X3yrGr48ur1xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5vfO7UUUUU==
X-Originating-IP: [180.110.160.105]
X-CM-SenderInfo: pzhl5yxbonqiywtou0bp/1tbibhLl1lD+JvezEgAAsR
Return-Path: <weiyj_lk@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyj_lk@163.com
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

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/mips/loongson/loongson-3/numa.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/loongson/loongson-3/numa.c b/arch/mips/loongson/loongson-3/numa.c
index ca025a6..37ed184 100644
--- a/arch/mips/loongson/loongson-3/numa.c
+++ b/arch/mips/loongson/loongson-3/numa.c
@@ -24,8 +24,6 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
-#include <linux/bootmem.h>
-#include <linux/init.h>
 #include <linux/irq.h>
 #include <asm/bootinfo.h>
 #include <asm/mc146818-time.h>
