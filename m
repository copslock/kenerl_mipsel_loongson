Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 08:22:03 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:15159 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816822Ab3EQGV6izu87 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 May 2013 08:21:58 +0200
Received: from 172.24.2.119 (EHLO szxeml207-edg.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.4-GA FastPath queued)
        with ESMTP id BCG74938;
        Fri, 17 May 2013 14:21:45 +0800 (CST)
Received: from SZXEML403-HUB.china.huawei.com (10.82.67.35) by
 szxeml207-edg.china.huawei.com (172.24.2.56) with Microsoft SMTP Server (TLS)
 id 14.1.323.7; Fri, 17 May 2013 14:21:41 +0800
Received: from [127.0.0.1] (10.135.72.158) by szxeml403-hub.china.huawei.com
 (10.82.67.35) with Microsoft SMTP Server id 14.1.323.7; Fri, 17 May 2013
 14:21:33 +0800
Message-ID: <5195CC6B.1000607@huawei.com>
Date:   Fri, 17 May 2013 14:21:31 +0800
From:   Libo Chen <clbchenlibo.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     <ralf@linux-mips.org>, <grant.likely@linaro.org>,
        <rob.herring@calxeda.com>
CC:     <linux-mips@linux-mips.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Zefan <lizefan@huawei.com>
Subject: [PATCH] MIPS: drivers: fix clk leak
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.135.72.158]
X-CFilter-Loop: Reflected
Return-Path: <libo.chen@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36430
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


when gptu_r32 fail, we should put clk before return

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 arch/mips/lantiq/xway/gptu.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index 9861c86..4fa577c 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -169,6 +169,8 @@ static int gptu_probe(struct platform_device *pdev)
 	if (((gptu_r32(GPTU_ID) >> 8) & 0xff) != GPTU_MAGIC) {
 		dev_err(&pdev->dev, "Failed to find magic\n");
 		gptu_hwexit();
+		clk_disable(clk);
+		clk_put(clk);
 		return -ENAVAIL;
 	}

-- 
1.7.1
