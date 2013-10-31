Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2013 08:51:47 +0100 (CET)
Received: from mail-bk0-f51.google.com ([209.85.214.51]:57779 "EHLO
        mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822318Ab3JaHvns2eih (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Oct 2013 08:51:43 +0100
Received: by mail-bk0-f51.google.com with SMTP id e11so825809bkh.38
        for <multiple recipients>; Thu, 31 Oct 2013 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=xQnsCKvFaqJElzBYuouDOZKHCG4xmUOXkrlbXvilXLc=;
        b=i9rBDRvN4PaGkMKK/7viNbQWgtdGRbqBN1524FvokkHYrsVeo3nXeNzGm/xOizP86H
         fwOQ58F9tMGPr+ImYJacmhRfJ8IZb06resSkITBWepSHXhrFyvNvDRdHf2lCDKJspUTM
         /CgbOHSGHkR5SLv9yGfjnPQ5LV8uAImEh9vs0pVmJPCy39/1fJ4zP3K7Rc3mWbjGWXYR
         3JaCbhqIp4cl8oR2Mmaw82SEY2VY3X9VmL8xiYfmI9Y26QrrgjxxK3n5KgkmWr4xdACz
         dcEDtOTU1g5vTJxcs4y56wqFVtUr6G61ZrD2nQ2VXUDHoyT3CIGUD3JlprTMa7sPfl6o
         37/g==
MIME-Version: 1.0
X-Received: by 10.205.74.69 with SMTP id yv5mr317128bkb.35.1383205898406; Thu,
 31 Oct 2013 00:51:38 -0700 (PDT)
Received: by 10.205.19.10 with HTTP; Thu, 31 Oct 2013 00:51:38 -0700 (PDT)
Date:   Thu, 31 Oct 2013 15:51:38 +0800
Message-ID: <CAPgLHd81Ucjnc=pmdxiZzBrk15ui1ezyowdd8JxYzvmmdLoMwQ@mail.gmail.com>
Subject: [PATCH] MIPS: ralink: fix return value check in rt_timer_probe()
From:   Wei Yongjun <weiyj.lk@gmail.com>
To:     ralf@linux-mips.org, grant.likely@linaro.org,
        rob.herring@calxeda.com, blogic@openwrt.org
Cc:     yongjun_wei@trendmicro.com.cn, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <weiyj.lk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyj.lk@gmail.com
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

In case of error, the function devm_request_and_ioremap() returns NULL
pointer not ERR_PTR(). Fix it by using devm_ioremap_resource() instead
of devm_request_and_ioremap().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/mips/ralink/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index e49241a..2027857 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -126,7 +126,7 @@ static int rt_timer_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	rt->membase = devm_request_and_ioremap(&pdev->dev, res);
+	rt->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rt->membase))
 		return PTR_ERR(rt->membase);
 
