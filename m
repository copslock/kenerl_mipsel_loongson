Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2016 13:57:05 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34642 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026367AbcDKL4bcoQWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Apr 2016 13:56:31 +0200
Received: by mail-pa0-f65.google.com with SMTP id hb4so14117307pac.1
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2016 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SxYFCkG68O0wtftcGd7Zdmu4foAEQ9g9nfO1l/D4smo=;
        b=aDME35xAHYg965Kg9fH7jcbvZ3SepqMf5mNy48xT+PkwO7qddeCcuZFNbk/RxJbibX
         rKAkM42onc9jEIynpgXNT7E8LdsLgGyyFmEG/cdtVWxHWgfEYJOet7yCDjYO5N8DsTjH
         SoEhDBx+88ugM6ZmKjmYFzZQeE3bfWLzjYCyBRPKRSnwJJoO8qnNIDIbbeTqbnWYg0ik
         bJ2GRK4J6yVTc5WKukr1b/uAKyy+FFAQlv8NXcEtajLWgdfEH2k2tHsV8DGfX/FoyTez
         iWdniJd1Oa4hNmfRXAr66BGFbb7UB0XDYfGepslPWouQ2PE4SioDlNTgpHVfGa4SPj1G
         xEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SxYFCkG68O0wtftcGd7Zdmu4foAEQ9g9nfO1l/D4smo=;
        b=b0/Wsn2AxblhdV+U5N1UyEEGoXQhyLeKvixbEx6SjXREodaRGRuSV8d2URWVQ2XeXG
         oma9RRVGq6bFZy8MKhATAukZyiWpmdCjWpo0amYwQmqaVErL9Y9sQ2DZt9Nz3tBOpPyM
         omqReIz174NPhmn/aCjAP0g290nAq9IarHL/aFFJgqFH9kagxZYiVPFDiXrZRgTb10NV
         FMGYqFAWWbvI9lwabH1/oXrjCSzUAjabDltQMfZxoDFa3CXMQaSujTlLxH+W6H7LPtld
         +15ga6XnjtncCaQOrXWyiUJecLcXZohiogLXUxJjfAbsU/VC/OsuqQSE7bQwmHizJFr2
         F5EA==
X-Gm-Message-State: AOPr4FVtoevfF7IBzYinnU0wg8/vDiNMZU0OQD5o6Y/VFJYl1Y6P3BUgZ3WP6kt6In4vIA==
X-Received: by 10.66.156.232 with SMTP id wh8mr14962342pab.153.1460375785405;
        Mon, 11 Apr 2016 04:56:25 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id o71sm35814708pfj.68.2016.04.11.04.56.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 04:56:24 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 3/5] cpufreq: Loongson1: Use dev_get_platdata() to get platform_data
Date:   Mon, 11 Apr 2016 19:55:57 +0800
Message-Id: <1460375759-20705-3-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52948
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
index 2d83744..f0d40fd 100644
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
