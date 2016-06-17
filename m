Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 19:11:13 +0200 (CEST)
Received: from m12-13.163.com ([220.181.12.13]:46341 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27042878AbcFQRLLpN4Q7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 19:11:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=52Rks
        hwsFqMVfDejpURMmAyimk9W0z5yLjRByYIvFS8=; b=Hyx1Jpsk8e1bo6nazwYdo
        KBQUFGrDDwtOvOOHuj3EUmr6QGf+4kuMLEuqaB4b4hjsG6nFOjHe8VaIR1fsmumK
        362RlAneEhIzjp1eF2sMplcgLWMuj0zPqcMctMHTrLOfm7Z6sGHqXRn8BgJZXeX/
        j/AfLvwq5222ZBZwaDsfHs=
Received: from localhost.localdomain.localdomain (unknown [117.36.101.242])
        by smtp9 (Coremail) with SMTP id DcCowAB3Pu8pL2RXGm68AA--.159S3;
        Sat, 18 Jun 2016 01:11:08 +0800 (CST)
From:   weiyj_lk@163.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ath79: Fix return value check in ath79_reg_ffclk()
Date:   Fri, 17 Jun 2016 17:11:05 +0000
Message-Id: <1466183465-23179-1-git-send-email-weiyj_lk@163.com>
X-Mailer: git-send-email 2.5.5
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DcCowAB3Pu8pL2RXGm68AA--.159S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4kCr4kWryfArW5ZFyDGFg_yoW3twb_G3
        yaqw1kKrn5GrnIvry7uF45Ga4aka4Durs3Zw1FqFnrXFyrKrWYkFykZ3srCr17t3yvyrWY
        kFn5Gr1ayFsFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnorW5UUUUU==
X-Originating-IP: [117.36.101.242]
X-CM-SenderInfo: pzhl5yxbonqiywtou0bp/1tbiNQ2L1lSIOT2jaQAAs3
Return-Path: <weiyj_lk@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54108
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

In case of error, the function clk_register_fixed_factor() returns
ERR_PTR() and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/mips/ath79/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 2e73784..cc3a1e3 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -96,7 +96,7 @@ static struct clk * __init ath79_reg_ffclk(const char *name,
 	struct clk *clk;
 
 	clk = clk_register_fixed_factor(NULL, name, parent_name, 0, mult, div);
-	if (!clk)
+	if (IS_ERR(clk))
 		panic("failed to allocate %s clock structure", name);
 
 	return clk;
