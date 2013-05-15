Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 May 2013 03:35:48 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:17742 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827452Ab3EOBfo69GwV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 May 2013 03:35:44 +0200
Received: from 172.24.2.119 (EHLO szxeml212-edg.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.4-GA FastPath queued)
        with ESMTP id BCD46289;
        Wed, 15 May 2013 09:35:24 +0800 (CST)
Received: from SZXEML402-HUB.china.huawei.com (10.82.67.32) by
 szxeml212-edg.china.huawei.com (172.24.2.181) with Microsoft SMTP Server
 (TLS) id 14.1.323.7; Wed, 15 May 2013 09:35:20 +0800
Received: from [127.0.0.1] (10.135.72.158) by szxeml402-hub.china.huawei.com
 (10.82.67.32) with Microsoft SMTP Server id 14.1.323.7; Wed, 15 May 2013
 09:35:18 +0800
Message-ID: <5192E650.3070303@huawei.com>
Date:   Wed, 15 May 2013 09:35:12 +0800
From:   Libo Chen <clbchenlibo.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     <grant.likely@linaro.org>, <rob.herring@calxeda.com>
CC:     <linux-mips@linux-mips.org>, LKML <linux-kernel@vger.kernel.org>,
        <devicetree-discuss@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] usb: omap2430: fix memleak in err case
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.135.72.158]
X-CFilter-Loop: Reflected
Return-Path: <libo.chen@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clbchenlibo.chen@huawei.com
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


when omap_get_control_dev fail, we should release relational platform_device

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 drivers/usb/musb/omap2430.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 3551f1a..b626f19 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -549,7 +549,8 @@ static int omap2430_probe(struct platform_device *pdev)
 		glue->control_otghs = omap_get_control_dev();
 		if (IS_ERR(glue->control_otghs)) {
 			dev_vdbg(&pdev->dev, "Failed to get control device\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err2;
 		}
 	} else {
 		glue->control_otghs = ERR_PTR(-ENODEV);
-- 
1.7.1
