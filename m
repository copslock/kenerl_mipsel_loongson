Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 12:56:34 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33488 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993264AbcHLK41QaOd5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 12:56:27 +0200
Received: by mail-pa0-f65.google.com with SMTP id vy10so1336266pac.0;
        Fri, 12 Aug 2016 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Aba/KDmLseRBDGJSqoRmg/K6GGWSOAQ4AqKNSGDMbM8=;
        b=fH1R9M4OzkYaMZz3gsh0PfRQJmAUzh+Tirw7cSp044jR+lS+o+V+Ln3AAlUOwWTucc
         7bCOlW/rJt+D/N7TZcD6a63qq6yg9aEy/dwve5uJ3o/yx9QpKSoAnF9AlaEjPK8QFOlU
         nX6TDU3EfsjvNdOJ2j6o19EZRjEM3FbgxLj9Go5UWXT4/IsVmb+E0qTvGby3yB6F1xPD
         Pv0ZwhLtvnt5/fOvBj/9EI03KjYXOH1scTYyoIFAgMToJBC/OJnjdlRz3OKWxLH2bNwC
         u628AxpJLJOcqIRUl34v8hH7YC+tAt6soAvCTa/gTSjoxNy2eDAIWVzkpiDwQBh/kuEu
         IT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Aba/KDmLseRBDGJSqoRmg/K6GGWSOAQ4AqKNSGDMbM8=;
        b=k4rLVrh0MDoSQjdluTlh3yI1DzCPRaSDToQ7MbW98mZrUmVDYiuqwU+hzGox18nK++
         dWOnb6VMCOk6YtW+fj8/ajMZlQ1K659w00sJkiKXpwVqaCMnptDaguhLyT7sM0IPuCaQ
         P8Ty+PnCDdtFXDbfaU7CkiiZDhcyPQNu6QmlaYyuSuwcIIFvugoY1wSmbRllLttFhZp6
         c9W1Jlx1MNFQ+D7Nl89AyOnyQcBxKhhwku5amThudwqsC785QE7XPlyyIaQkfHBbKIgl
         lr2HqzcY2Skd6Dx7BzWL/IM2DH0HNLj5cSyVNIGPfa29N8ZoOlrHxDeHC8GMuIkA8BdU
         vSYw==
X-Gm-Message-State: AEkoouvEQoMfzZBE1cOz6O+h02cnj+hBukK46P6WBvu8Hj5NFIGFQaLDQyO7So9/4XYlZA==
X-Received: by 10.66.230.195 with SMTP id ta3mr26104630pac.89.1470999380940;
        Fri, 12 Aug 2016 03:56:20 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 191sm12076172pfx.68.2016.08.12.03.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 03:56:18 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: Loongson1B: Change the OSC clock name
Date:   Fri, 12 Aug 2016 18:56:03 +0800
Message-Id: <1470999363-9978-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54506
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

This patch changes the OSC clock name to "osc_clk".

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/loongson32/common/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 4d12e36..fb60602 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -69,7 +69,7 @@ void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
 /* CPUFreq */
 static struct plat_ls1x_cpufreq ls1x_cpufreq_pdata = {
 	.clk_name	= "cpu_clk",
-	.osc_clk_name	= "osc_33m_clk",
+	.osc_clk_name	= "osc_clk",
 	.max_freq	= 266 * 1000,
 	.min_freq	= 33 * 1000,
 };
-- 
1.9.1
