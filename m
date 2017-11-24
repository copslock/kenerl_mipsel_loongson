Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Nov 2017 03:08:45 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:36684
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbdKXCIidw7Gm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Nov 2017 03:08:38 +0100
Received: by mail-pf0-x241.google.com with SMTP id i15so14174009pfa.3;
        Thu, 23 Nov 2017 18:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6DEPr4nhganPYVgOtBdyAtKjZii999Lf1GixBf0Js8s=;
        b=uzLrty7+f6LRxquGQbI9djk3Hi0AkILHb2I3B0lE+gAc6cobKRxJcbf/mMSegFcwn7
         5KESC4EyvDjPpgFg2044WnJwbc8tKKk0vjcza3sFCGesv2i8gXQuCsZ+h+m6zVQiP/KE
         SO5CnBijymsvYnX3HacZfEuSHKinomxaqphZU3EWVYpWGkAK9UKgbU74xwl7+MGbRXjh
         B7wKX1U9VyTlsaT7TC/CuXMOc+zw71obWWpyryyFG1EbiDnutrrzKEYfAsO3d7rRRp+M
         pj74zI3Q52vmQ8rRYOiY1OQK+Ln6J7AZW8hZKmD7WHRhOvfazY/rKylOE6KGhIpeQhDU
         OmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6DEPr4nhganPYVgOtBdyAtKjZii999Lf1GixBf0Js8s=;
        b=lrdDwKRvULPqSFlpghFkSolgKd1UJrf2H4oSv3xpgeuCxS6MfpXvNX7MJCLlznLJ8a
         wydWROREk2doutNjROoxjNbXagy9ZeqIA+ex8zkV4LnrUxzMv+fJaZXc7Se3/GUnM0TN
         dFtgfqP0lf5txBazaiIsKp/wfEzRBJADLL3aozPipQmswL92O71dmwv5nGSHX1ziknL6
         zv1hFfklpkxRHaD+hPvhyky4hhIDsIHQkVB7uTqrKi2shNvSmFc0+Gm0YedxY/B6+bju
         OUgWej9zt8j42NqGHOZQDYZzgmLt6U6IoRmI7IPHhhYErD677kgcmrK/ldZXbsoEV9cJ
         eUow==
X-Gm-Message-State: AJaThX6o/1c8egBFpBto43UWZ269UBq69j6TAFB8MvDvrkb751xEWbXj
        v39oNrqPeZ3xl71kL3XhSBY=
X-Google-Smtp-Source: AGs4zMZd4EcUrj50M2qxWbXIr1JDEyev/Z9VlIJa/DiBO7aob8R0ilr9CAl61MF7PkwirPNt0iW58Q==
X-Received: by 10.98.205.5 with SMTP id o5mr24836016pfg.39.1511489311948;
        Thu, 23 Nov 2017 18:08:31 -0800 (PST)
Received: from localhost.localdomain ([103.16.68.147])
        by smtp.gmail.com with ESMTPSA id y83sm36717490pfd.66.2017.11.23.18.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Nov 2017 18:08:30 -0800 (PST)
From:   Arvind Yadav <arvind.yadav.cs@gmail.com>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: ralink: Fix platform_get_irq's error checking
Date:   Fri, 24 Nov 2017 07:38:20 +0530
Message-Id: <d8c2d652f7959049e402103586f9c78236632f82.1511489143.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <arvind.yadav.cs@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arvind.yadav.cs@gmail.com
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

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2: Subject spelling was not correct. change FIX in place
                of 'ix'.
changes in v3: Return rt->irq instead of -ENOENT.

 arch/mips/ralink/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index d4469b2..4f46a45 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -109,9 +109,9 @@ static int rt_timer_probe(struct platform_device *pdev)
 	}
 
 	rt->irq = platform_get_irq(pdev, 0);
-	if (!rt->irq) {
+	if (rt->irq < 0) {
 		dev_err(&pdev->dev, "failed to load irq\n");
-		return -ENOENT;
+		return rt->irq;
 	}
 
 	rt->membase = devm_ioremap_resource(&pdev->dev, res);
-- 
2.7.4
