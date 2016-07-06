Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2016 14:21:28 +0200 (CEST)
Received: from m12-15.163.com ([220.181.12.15]:36877 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990505AbcGFMVBi0VxT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jul 2016 14:21:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QRPyc
        a+6TAyXNfaLGnbFTznlt8tur5w53QfRo7nmOi0=; b=qOyfk/MPd8c7UVrxATK7R
        ngtcIW+Mk0jZF/KBQZeWCMGAGCWx15Xph+W57j3Yu5xzHbAM9+ScqSvXZaHyaf3c
        O5T4C7de2ZoXydGxZw9rOlUsxYNLJs1g0MjGb3uZNY0PfRfM3ofIEGmSCxhqZKe7
        fpFud2rS1nVMY7qKUpGIK0=
Received: from localhost.localdomain.localdomain (unknown [49.77.207.185])
        by smtp11 (Coremail) with SMTP id D8CowADHP8eo93xXBlUsCg--.60930S2;
        Wed, 06 Jul 2016 20:20:56 +0800 (CST)
From:   weiyj_lk@163.com
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        linux-mips@linux-mips.org, linux-pm@vger.kernel.org
Subject: [PATCH -next] CPUFREQ: Loongson1: Fix return value check in ls1x_cpufreq_probe()
Date:   Wed,  6 Jul 2016 12:20:55 +0000
Message-Id: <1467807655-31952-1-git-send-email-weiyj_lk@163.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: D8CowADHP8eo93xXBlUsCg--.60930S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4DAr4DXF13uF13Ar1DKFg_yoWktFXE93
        43Wr1agr4Uu3Z2qFyjkr4YyrW3JasF9r40gr40y393tFWjkry5tr93Ar1DWFWfWw4UKFy3
        uwna9F1UCr13GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn92-UUUUUU==
X-Originating-IP: [49.77.207.185]
X-CM-SenderInfo: pzhl5yxbonqiywtou0bp/1tbivwie1lWBS0QsEwAAsb
Return-Path: <weiyj_lk@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54230
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

In case of error, the function clk_get_parent() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/cpufreq/loongson1-cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index be89416..b3a62d0 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -162,18 +162,18 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	cpufreq->clk = clk;
 
 	clk = clk_get_parent(clk);
-	if (IS_ERR(clk)) {
+	if (!clk) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->clk));
-		return PTR_ERR(clk);
+		return -ENODEV;
 	}
 	cpufreq->mux_clk = clk;
 
 	clk = clk_get_parent(clk);
-	if (IS_ERR(clk)) {
+	if (!clk) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->mux_clk));
-		return PTR_ERR(clk);
+		return -ENODEV;
 	}
 	cpufreq->pll_clk = clk;
