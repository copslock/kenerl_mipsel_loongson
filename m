Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Apr 2016 12:57:31 +0200 (CEST)
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37317 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026228AbcDIK5YiADnn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Apr 2016 12:57:24 +0200
Received: by mail-wm0-f43.google.com with SMTP id n3so49675505wmn.0;
        Sat, 09 Apr 2016 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJ0Fm+2P183/cPIYnrPUiMVlCRDFpkrIlH9T7PnhOuw=;
        b=mAv1OHQBhAItSbgHexDsM39vjm6cRqTBzciM0CxRpA8BieTQ3qPdooa1OGL3px/E2j
         vrGJDD2WNT8kuN6uOlJwfYFVH/lURzlaEVAtHeBQl+Rio0VnUt3X0AXwntaGBCtHzdk3
         z8RsQmXIYl5b69GkGPA4rZZpu3S3STM5WtuG5VDKlaxcw1H2iknP02SidAsfey3zfXYZ
         ndwT/gTcIQJf3VkRZJbg8UJ9Rxa8JV04KIwJZ3/P/W8QrD36IgEBmzSlW9nDRIc71Knp
         WWQB6S2KVHvyQ/bGTvWSrLw6ATo+Fwk8ZO7/jEG/Vv/3al+mrkRvG+B3ITr10l7wjFVZ
         yGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJ0Fm+2P183/cPIYnrPUiMVlCRDFpkrIlH9T7PnhOuw=;
        b=XlUn3pNOT8yUrMwP+VJ69QnIXaKKaiNOQIcdphV9VmE/1SJHv+jZQ765BKWG8uvlfb
         xLfew6Zpvatp27qA84U6baheG2BUbcha7I1I8sosPIpCHfy0Rmz6g5OC4zvASP9HNSoq
         oOe86HRJXcaK0eB9inqM3rAcEJDBCALO2hMKcvmBG+9XdDX6xX/w7on2ekEbL8DG4sgw
         TZkRrGHXmbmnCzryMNwpm4LNe02meCCyRPg/ad+z+pZZGHpDNHbSIw1aZ9C2SQMq/fye
         fBvkAqKFLpMZb4i++eq08m77NzFxVnBZqUENW8/zKvMGPugpLmXxzMXdEXjeJ+ksU11/
         iaeQ==
X-Gm-Message-State: AD7BkJIvau9KdiEbdfzLA2l8KKocJLImJK2Wyt9kyuIM9cp2cdiJCsF9ml4z7DISgT/67A==
X-Received: by 10.28.136.19 with SMTP id k19mr8181922wmd.11.1460199439411;
        Sat, 09 Apr 2016 03:57:19 -0700 (PDT)
Received: from localhost.localdomain (228.Red-83-55-41.dynamicIP.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id c187sm4062831wme.16.2016.04.09.03.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 03:57:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH] bmips: add support for BCM63268
Date:   Sat,  9 Apr 2016 12:57:19 +0200
Message-Id: <1460199439-18796-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459757517-14897-1-git-send-email-noltari@gmail.com>
References: <1459757517-14897-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

This SoC is very similar to BCM63168 and Broadcom usually refers to them as
BCM63268.
Add BCM63268 and missing BCM63168 to device tree documentation.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 v3: use numerical order
 v2: keep support for BCM63168

 Documentation/devicetree/bindings/mips/brcm/soc.txt | 1 +
 arch/mips/bmips/setup.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index e58a4f6..4a7e030 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: "brcm,bcm3384", "brcm,bcm33843"
               "brcm,bcm3384-viper", "brcm,bcm33843-viper"
               "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
+              "brcm,bcm63168", "brcm,bcm63268",
               "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
               "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
 
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 38b5bd5..92d0483 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -116,6 +116,7 @@ static const struct bmips_quirk bmips_quirk_list[] = {
 	{ "brcm,bcm6358",		&bcm6358_quirks			},
 	{ "brcm,bcm6368",		&bcm6368_quirks			},
 	{ "brcm,bcm63168",		&bcm6368_quirks			},
+	{ "brcm,bcm63268",		&bcm6368_quirks			},
 	{ },
 };
 
-- 
2.1.4
