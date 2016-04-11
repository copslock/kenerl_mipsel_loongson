Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2016 13:56:47 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33616 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026364AbcDKL41zwW6f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Apr 2016 13:56:27 +0200
Received: by mail-pf0-f196.google.com with SMTP id e190so14759953pfe.0
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2016 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HUVw5/rSMoNxGUc4meS5EEumZ4lU1v0kXnTtK3GgZWQ=;
        b=GroZUD2k854uZ65qexfmGTe5adJqqfokLV7iAMt2h2Mr5M8E+L1oXDNm9cRknCZNyx
         Aszf6ujK/JYe/iTq3UhcSOgMuNWIVAHM626uZyaI9L7V2Jhc2CM66fSTK29FTkxnULqV
         GGkAlgJORftR8XL1x0v4W9W9LnwikbHXT7ZmXEuMpcrUpKKb30BZa5M0kT+4tHJqamr7
         Ow200g2hPEbUOxORkzKrNhEapT9sdpOcpMt373Z12kAFi1g8pYRRMzxvgdL6vYcQKUJS
         GNT0oqf/KCgLsd+W7baJmHx4j2cguHj0MVrpLyYZadW9KCzKEDoOI20PdjLxvwbk6PXC
         6StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HUVw5/rSMoNxGUc4meS5EEumZ4lU1v0kXnTtK3GgZWQ=;
        b=GRpzAJFoXl44fOB8e97oxFLnVmC6BbzP9n1/QTCoLjO4L8Yb8PzrUl2/ZPYatc2iSD
         IATQXOdIeJn8RaLJN75X5uqJWXIKBATmostyM2A1jAGBPYwAeKvslCoJi03NudojcLzj
         P8WI6cTrOXnXYYzQAsYDG+mABuOHGliYmwMb05k3JT7n80qR7Z2ZgeOyEV/gCnnqXmG4
         YcXLoD4M7QBVZpOET32rZjQgzpkusLYvHWfS1ePOHVw1o0Yz4CIiNOqUmYHVaiK58Pmn
         bGOsLmY8ZSYJtXDbcIRsozQAFqpQk3IwARniwJTKBZzPJhXUBsKOSjSf+Xh2OdFM3TtC
         lQbQ==
X-Gm-Message-State: AD7BkJLyUVV/GjbFloqfYEBU/cSrRcuhz9aFxnJ0Ne3LcHLg7P5AMelkTcLC2N5mmghPAQ==
X-Received: by 10.98.64.144 with SMTP id f16mr31741865pfd.159.1460375782202;
        Mon, 11 Apr 2016 04:56:22 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id o71sm35814708pfj.68.2016.04.11.04.56.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 04:56:21 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 2/5] cpufreq: Loongson1: Replace kzalloc() with kcalloc()
Date:   Mon, 11 Apr 2016 19:55:56 +0800
Message-Id: <1460375759-20705-2-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52947
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

This patch replaces kzalloc() with kcalloc() when allocating
frequency table, and remove unnecessary 'out of memory' message.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/cpufreq/loongson1-cpufreq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index 262581b..2d83744 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -81,13 +81,9 @@ static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
 	pll_freq = clk_get_rate(ls1x_cpufreq.pll_clk) / 1000;
 
 	steps = 1 << DIV_CPU_WIDTH;
-	freq_tbl = kzalloc(sizeof(*freq_tbl) * steps, GFP_KERNEL);
-	if (!freq_tbl) {
-		dev_err(ls1x_cpufreq.dev,
-			"failed to alloc cpufreq_frequency_table\n");
-		ret = -ENOMEM;
-		goto out;
-	}
+	freq_tbl = kcalloc(steps, sizeof(*freq_tbl), GFP_KERNEL);
+	if (!freq_tbl)
+		return -ENOMEM;
 
 	for (i = 0; i < (steps - 1); i++) {
 		freq = pll_freq / (i + 1);
@@ -106,7 +102,7 @@ static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
 	ret = cpufreq_generic_init(policy, freq_tbl, 0);
 	if (ret)
 		kfree(freq_tbl);
-out:
+
 	return ret;
 }
 
-- 
1.9.1
