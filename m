Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 16:36:44 +0100 (CET)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:41063
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdKWPghoTb9X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2017 16:36:37 +0100
Received: by mail-pl0-x244.google.com with SMTP id u14so2848439plm.8;
        Thu, 23 Nov 2017 07:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=34pxe1h3YY0OI+duX/k0TnvmNUgI5sFQGvwOcS1TX2s=;
        b=b+9sQT4rLbVBLAoyhB62WXj+9RrY8EJnrXm+JAe7bHEgmTNo/K2H66QC5Q9xDdTlfX
         vQvn59Sjqa3x3SnDA9dq/b0kzkHM6C1c2YqWv8GQerfs0huJ8HOxEcXoS31iHcFrRgY5
         vhsIDX2ShuDgcsxZ6Xh+/jvGVVB/g617pc4b8/h6ehhJ4FiXpRFVbbAozFUBcwHwrXzN
         r8tAOqgwuTlGD7Y7ocGLPXoVxJRLO/G0pkFRlS8nUI7axeZ0r726ti4wPaZVHDcSCIA0
         m+XExhWGKcDjkUTO/UwARvWo5Q0VKR55KziFAF5ODtBwz8U0MeCpXE4uvc+Iv2y9mL6D
         gqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=34pxe1h3YY0OI+duX/k0TnvmNUgI5sFQGvwOcS1TX2s=;
        b=iV6X4Dx69jtcwtbQ+FTTAIp7wqZtcp4X7qSYHec3k1O48lWf2e68PQxijgUmaOFnbU
         TqRgelNn9UU/aP0upXt3EEdrC3iddN5UhZZcVFfQ+ftkaPRjQ5+RMp8CE3MG3pq0mkhW
         /jQyu6BR/va8rHvq5PI8LW+YC0AbVLa6cxS04ainvBbX1a4wvmyJEC2L/SOyVw3e2+TZ
         KxfJtwtuy3nbwKp10mr5W1OTnFLs0uhYTAcx4w1RGKidsOD0Y5W8Maw77CnmJwA9JFWA
         qADxVcmjxfonrErgLCx3AzgsJZo4gcddrbNr0iWjunoKX67iZL0qWJU0BzQ2nfaS+Scy
         vyIw==
X-Gm-Message-State: AJaThX6IePccbqnbD15ISXuYegjvko8kN/AgZgsaDiJBqCgMJQSB2FIV
        0n56v9UROuoREwnG8UMXDUWUNg==
X-Google-Smtp-Source: AGs4zMY7Tv8FhM3vC/yZNqiPkPCwAAAHCA1erCtCC9QFgJZoZYJX6xTAdVJ/Xzi7u7T/6nevfAroVA==
X-Received: by 10.84.131.35 with SMTP id 32mr19985429pld.347.1511451391291;
        Thu, 23 Nov 2017 07:36:31 -0800 (PST)
Received: from localhost.localdomain ([103.16.68.147])
        by smtp.gmail.com with ESMTPSA id 69sm35189045pft.11.2017.11.23.07.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Nov 2017 07:36:29 -0800 (PST)
From:   Arvind Yadav <arvind.yadav.cs@gmail.com>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: ralink: ix platform_get_irq's error checking
Date:   Thu, 23 Nov 2017 21:06:10 +0530
Message-Id: <4b30004af37521b2102a4eda7c15f7257437ac85.1511451256.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <arvind.yadav.cs@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61058
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
 arch/mips/ralink/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index d4469b2..913dc84b 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -109,7 +109,7 @@ static int rt_timer_probe(struct platform_device *pdev)
 	}
 
 	rt->irq = platform_get_irq(pdev, 0);
-	if (!rt->irq) {
+	if (rt->irq < 0) {
 		dev_err(&pdev->dev, "failed to load irq\n");
 		return -ENOENT;
 	}
-- 
2.7.4
