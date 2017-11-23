Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 16:45:36 +0100 (CET)
Received: from mail-pl0-x241.google.com ([IPv6:2607:f8b0:400e:c01::241]:33469
        "EHLO mail-pl0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990596AbdKWPpaSBN8X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2017 16:45:30 +0100
Received: by mail-pl0-x241.google.com with SMTP id a12so2869039pll.0;
        Thu, 23 Nov 2017 07:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tlLmODJWqmLbPug9p7noCXbfyxIX1fEVmWo6/i0Gf34=;
        b=RLjh3IZigOzTzH0QBNjik7htbRa3+L3NDXWA5JxelTBM32hUgjrsY4g5HHUkjT16Vo
         w0FxD2nZ1QYeh7IhJXqIcmhFeVHvVV8BhLYlwH/cVpzRXD8TPqQQWO0E0YDxpArnslcx
         UT0mNtXKbE90bTIC0U1MjCYZJ9r7uaY7hJX+l/XND9ZVuxgoM309Pxo70/z1ChRZKnig
         Igk3SMmpzUoXvA6E7CT9QZSA4FvTUkE1ALZG0OUPsJXk73cYAwAAy+u30IKLC3Ox5+kX
         VbwpX5qxe8Bu3fLj8KS3Vgh3zvPm7dmo1tZoBrOVnV2Zg2imgIoGBUuJDPXZtsaRavk/
         rmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tlLmODJWqmLbPug9p7noCXbfyxIX1fEVmWo6/i0Gf34=;
        b=Ht27SLU/90BvXjJ4QwCyw0RG+rqwfYLbbl41D4JkYYHDdZwOocOXlXNrve6HMZEOB0
         KfLDn/oaf6Z+j2QN/SYtwuhjDU3cQRtyRwABWBWuTREo2u4/pGQE+aXAYE8p9OmQCa/h
         bqYZJf0vhDWZGFkQvwLBkxDqkhVzzT+ew8I8XmSiIERjKg/9qTLJVOaJvy8xA/WJRnRp
         WS3g4wCj/J6FNoKXwTL42EqWgBdnCy0vQAyPXWky0WDT7DWvegEI8TFEVAROrxmjbqhl
         cPufAyMhx4AyXpeOlCQ78B+EUWk6Dr2rAzSTicvGn7fplHtUcwGd4+mcBevoVYxer9E5
         BMTg==
X-Gm-Message-State: AJaThX5io15fcoG3xEWO6RyEo7PgtpLz3nU6yh+maNclV5AHgItg0E6F
        teZ7I0JXT3M7V7T/iHJjQo4=
X-Google-Smtp-Source: AGs4zMa3AC5ayG6CbnFGx/Rb1Nj+xvIQYdKJuV0SyrWoxubWHGFxoJHJXzamf659A2V2Tv9qTCnO6w==
X-Received: by 10.159.216.131 with SMTP id s3mr25047652plp.434.1511451924259;
        Thu, 23 Nov 2017 07:45:24 -0800 (PST)
Received: from localhost.localdomain ([103.16.68.147])
        by smtp.gmail.com with ESMTPSA id o123sm33715716pfb.102.2017.11.23.07.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Nov 2017 07:45:23 -0800 (PST)
From:   Arvind Yadav <arvind.yadav.cs@gmail.com>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v2] MIPS: ralink: Fix platform_get_irq's error checking
Date:   Thu, 23 Nov 2017 21:15:10 +0530
Message-Id: <4b30004af37521b2102a4eda7c15f7257437ac85.1511451615.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <arvind.yadav.cs@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61059
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
