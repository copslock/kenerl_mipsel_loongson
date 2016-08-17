Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2016 12:22:43 +0200 (CEST)
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38853 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992483AbcHQKWgyDMuC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Aug 2016 12:22:36 +0200
Received: by mail-wm0-f45.google.com with SMTP id o80so222888386wme.1
        for <linux-mips@linux-mips.org>; Wed, 17 Aug 2016 03:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=um7/q4UJE9MqefKT1lXbn/eQAe4xMnQkMAiM5SvaVoo=;
        b=W3mlHcM8xjbEtau57LlH7zORb9X3VPGSDBqdu2UjITOzizqMZyhQ2MYEjEgR5Brz7d
         Wtj3uc2ATiusxrAeEbn7xvOwN/j7t/xnDn3xEPdQFyW3gwvkkmmVU7O+abN2MXKZO4/v
         QCxKDyv6AdbLGIZvEF27g5jILPTVEZglGGh6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=um7/q4UJE9MqefKT1lXbn/eQAe4xMnQkMAiM5SvaVoo=;
        b=gnJmC7VwlOgrteW2J/D8PTtdxfipdZkp9JKyuaWEdLIVcm+2BoKTHKEu8VOahNA3Pr
         IX2pokWms/XXfZQ5EO++6wuQk+KIEnigYHonFlA9Sfgwq1y3aozMEv2lgyf0xOrTB0US
         EWkgkQjtCxCsdlAc9g3tT1OxHKjT3/UsAH82GYkaImZwiTUpEx19FAWkhv24oPLcaU5H
         9E+sehlC94MRAWmnM+BMnMQUI/BqczMJSOTodR68TSSxHw2P81frpOtgKuEBgwtaVf8J
         Y3swl2MxjQd8pUPbbwqHbJ7fCPg3287WLZIAQ3iinho26UCiOHDNmZrrwsVM6jl0cDda
         o7hw==
X-Gm-Message-State: AEkoouuV1Dchh52gVAmEfnmV216q/WZ4DaTkU+8UfUhGLPZy4JtkB1Lmi6bpnB09FBZoLsQ7
X-Received: by 10.194.77.174 with SMTP id t14mr46963314wjw.146.1471429351508;
        Wed, 17 Aug 2016 03:22:31 -0700 (PDT)
Received: from localhost.localdomain (lft31-1-88-121-166-205.fbx.proxad.net. [88.121.166.205])
        by smtp.gmail.com with ESMTPSA id 190sm25938835wmk.13.2016.08.17.03.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Aug 2016 03:22:31 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     mingo@kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 3/3] clocksource/drivers/mips-gic-timer: Make gic_clocksource_of_init return int
Date:   Wed, 17 Aug 2016 12:21:35 +0200
Message-Id: <1471429296-9053-3-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1471429296-9053-1-git-send-email-daniel.lezcano@linaro.org>
References: <57B439B0.8010901@linaro.org>
 <1471429296-9053-1-git-send-email-daniel.lezcano@linaro.org>
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

From: Paul Gortmaker <paul.gortmaker@windriver.com>

In commit d8152bf85d2c057fc39c3e20a4d623f524d9f09c:
  ("clocksource/drivers/mips-gic-timer: Convert init function to return error")

several return values were added to a void function resulting in:

 clocksource/mips-gic-timer.c: In function 'gic_clocksource_of_init':
 clocksource/mips-gic-timer.c:175:3: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c:183:4: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c:190:3: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c:195:3: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c:200:3: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c:211:2: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c: At top level:
 clocksource/mips-gic-timer.c:213:1: warning: comparison of distinct pointer types lacks a cast [enabled by default]
 clocksource/mips-gic-timer.c: In function 'gic_clocksource_of_init':
 clocksource/mips-gic-timer.c:183:18: warning: ignoring return value of 'PTR_ERR', declared with attribute warn_unused_result [-Wunused-result]

Given that the addition of the return values was intentional, it seems
that the conversion of the containing function from void to int was
simply overlooked.

Fixes: d8152bf85d2c ("clocksource/drivers/mips-gic-timer: Convert init function to return error")
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/mips-gic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 1572c7a..2577a2f 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -176,7 +176,7 @@ void __init gic_clocksource_init(unsigned int frequency)
 	gic_start_count();
 }
 
-static void __init gic_clocksource_of_init(struct device_node *node)
+static int __init gic_clocksource_of_init(struct device_node *node)
 {
 	struct clk *clk;
 	int ret;
-- 
1.9.1
