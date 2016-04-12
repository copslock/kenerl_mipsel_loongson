Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 12:41:31 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33087 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006613AbcDLKkta1ljN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 12:40:49 +0200
Received: by mail-pf0-f196.google.com with SMTP id e190so1193918pfe.0
        for <linux-mips@linux-mips.org>; Tue, 12 Apr 2016 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6YvZe9wSyIjYTuGiGP13UjBSFORD63mMN0VGvR1/yCw=;
        b=K9YCvTpGx7nOafA/trKBNbXh/szJuboJh3oMqTxYoN9ws6B6m22Zm/m7dhDMW0MoqY
         AL8yuoDT4F2PHcc2h9GycQX7wy6K5CajhIeuG7y2giOfd4WN038ivKAGMAkkezL7xXvv
         K0QWRlKdE02nwcCuQVvVAEDxAdIM2l0bwSISWuYpYD8ukj2BiWps1KoWZXj9w6b4SkOC
         lc/8XEjY7iYfyTsdJdXM/335fmh14fj1YxMtrEhoCLigdgomtznWSwGMTbgoB5RjoYzs
         t6WewPm88M2Sr4bxbU9AFOvlCH+/TSeYwrXJXlxG+vyA6TkdQhdASIq6v5W/urpPuBQz
         HlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6YvZe9wSyIjYTuGiGP13UjBSFORD63mMN0VGvR1/yCw=;
        b=ch1wEhQx3gOiRR498HrJwZl0/i/tjohOiwp8lmaPhEv52h9wseM+tji9epaXTZ7g8d
         h9Kj4JTnl6QzEK1gvgNicGrXKt3Po49GoItR8SbW5Ipa58gxDwZPS1WVeDQ6qBA3kHFo
         nYUlFL+ilQ2oPwsEcHqU0AvxevFso679tj1JfCEigTfDrsgcssIOmzmVOfl+eNaeF1Hb
         03F5kwmXRify+GhU/wl7BFVxL/cQMeGofBl5GmQRx9s4P/JRjDyWvy3S4l1rcW645Umr
         8MNcSazwDXIixUT/GsJe2ij4cjtJt4akjzugS1Lr7tN9ZcIxpFhLHGJagKE7iO00KdAi
         LuIw==
X-Gm-Message-State: AOPr4FUeOkf/QeDLIa6+cdbRGF5lnpr8zpRP1lqQ8WxKDjKN4Ia4NvRUYuSHuFFYlmYFmQ==
X-Received: by 10.98.71.156 with SMTP id p28mr3505044pfi.139.1460457643657;
        Tue, 12 Apr 2016 03:40:43 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id m87sm42588365pfj.38.2016.04.12.03.40.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 03:40:42 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V1 3/5] cpufreq: Loongson1: Use dev_get_platdata() to get platform_data
Date:   Tue, 12 Apr 2016 18:40:17 +0800
Message-Id: <1460457619-14786-3-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
References: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch uses dev_get_platdata() to get the platform_data
instead of referencing it directly.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/cpufreq/loongson1-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index 4c3087f..1b63b4a 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -134,7 +134,7 @@ static int ls1x_cpufreq_remove(struct platform_device *pdev)
 
 static int ls1x_cpufreq_probe(struct platform_device *pdev)
 {
-	struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
+	struct plat_ls1x_cpufreq *pdata = dev_get_platdata(&pdev->dev);
 	struct clk *clk;
 	int ret;
 
-- 
1.9.1
