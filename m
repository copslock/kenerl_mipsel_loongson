Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 12:41:07 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36322 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026402AbcDLKkqKZ6XN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 12:40:46 +0200
Received: by mail-pa0-f65.google.com with SMTP id k3so1125814pav.3
        for <linux-mips@linux-mips.org>; Tue, 12 Apr 2016 03:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hLsQ+OIGIMsDqzJPuOaRTZ9VGrxBTTAmD3lktXsY7NU=;
        b=vJkAEUFhJVnMvqn84wosGp2tefCLWzc90hd1Wvuj+Bsiy4O8T6rWDOWWUNHetSLsYa
         2v2s9jYyPWP8Y/RVw+T/cvgI5Rh4kp7fSifxi7WRFHZEpKu5LGO6YApvy0gayA1aLYXm
         EdFv3MqmZfXVmfDLC0mD8s0wZSSekqWhHjQPCjQ01xEzJmJRt/jNkt9i2GQsN3KVVTrO
         pHv5U3o/eq520U33RGyvPdeKMYxekJV86eOQBvIG53DnA8uZXVZ5VCrBuw9LgCZTKT9L
         UiDQquN27jpqjrDH+Wa6qkxF2ccJ45l3mXjQXClIK6U1tweg/z/VPEGtxmd+AEZ6WNqX
         qReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hLsQ+OIGIMsDqzJPuOaRTZ9VGrxBTTAmD3lktXsY7NU=;
        b=UCb1MrmmTjj+bx7RtepcNagiEy/taJ+OGf/Re/dv+rQHzzt7fD4m912EuyScSJOqt7
         BGnw2LDlsJ+EakZ+i/dGFsdr9DwTKQOEEWjFHLf201x5nEw+yeAd51SA/mlHk9bizTdu
         vj1UjaVA78vMHSvpLgCHCbvKL0+HxCrfqR2JpegTMpaBB9xP/m+bWWMtRT4yXoz4WFyb
         qevBoDFPYkcnkaU0mtEht34aUh79IFrySb0LcrT8Z8ttbvfz6DzOoB1cOBrQ/IWzv/Sm
         xE5kpkjFLrlxUrIt0P7oPoZcf6PnDlCqt9QPUk6RnyLATSDMgccoE/ueSBYP6xdhkO2N
         hJug==
X-Gm-Message-State: AOPr4FUtUiwgRWBjiI6Sw/f/nTBU4e8DrRGL3JpGemVMee7+CbbL0HsJKXqTDHpk5MT3Ag==
X-Received: by 10.66.40.236 with SMTP id a12mr3618566pal.58.1460457640420;
        Tue, 12 Apr 2016 03:40:40 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id m87sm42588365pfj.38.2016.04.12.03.40.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 03:40:39 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V1 2/5] cpufreq: Loongson1: Replace kzalloc() with kcalloc()
Date:   Tue, 12 Apr 2016 18:40:16 +0800
Message-Id: <1460457619-14786-2-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
References: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52960
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
index 57fae9b..4c3087f 100644
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
