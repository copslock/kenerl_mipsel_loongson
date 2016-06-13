Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2016 09:39:27 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33947 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042072AbcFMHivEqJVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2016 09:38:51 +0200
Received: by mail-wm0-f67.google.com with SMTP id n184so12596847wmn.1;
        Mon, 13 Jun 2016 00:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyNyAzWIJ/676s4wvnCG59RuzrRgkiJYBJdUJmcHlKI=;
        b=aza0fmWtV3jveDIWe38ZVBR3jf45DV9nmciUG9aYbw1P3PYnG2f5ledf3B6LymvqIu
         afSkrVFCFkXk1CSy2BhO6R9XX7XMpMg+vtSkGgQ8RHMxNF+LXjSkuOhPTPUmVkUHGWoN
         E1GzfWpTRzaunxPLX3j0hz6f1whIcgln0Myy3t8Ma+VQ9RIDwMRrVJb643dfZZoWru8U
         2eqwFkw7pGs/z9b8y84GV8fT0CD7UE0DY35X6rym5B6oTVygs5kKQqLvd2HeNhk2xeTl
         TaKR/lCUXaqRCrWc+9otztfPNWSQYfXZHoAspoOo711pvlk7i0Lnbafn0YD+v+FDMicR
         y5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyNyAzWIJ/676s4wvnCG59RuzrRgkiJYBJdUJmcHlKI=;
        b=YrSruz+X9oKip1fJFjkaEU4alNmasixRBJUm4fswxwtudFseC4Typ7QVYrW6pIOHGf
         Wm49Q2+5u+UbT4tJ+cDMw7nGQPo6ZtLTLj6Di2Rv2ndjrbwhtj3S8gJmYOptDlwQZL5V
         W3eqDA1naOx5scUwQ7UYf2n/KmE9NFAWzEVkqRCpT+/8lI+Hb7ru1O+3gMNHFuPJj5Ct
         KiomqjaoRfu0XppHhx6qH7KIhif8mnQ/oQsnlE/h8Sx10LqwQjr+qDT7L6BEO2N57AQ6
         8RhcjAWg9FHd2OTWvmtdPUkybDHAxQWQxFGeMrspnJsSHKrO/XZAPTAS5/FUuOiuvFhn
         VI9A==
X-Gm-Message-State: ALyK8tJmt90K18v1766QdjBGqZsxi/1MH4N8XmaC351nyAjVX5NGsXvVw+ma9VnTcTGn7g==
X-Received: by 10.28.41.4 with SMTP id p4mr9833460wmp.33.1465803525817;
        Mon, 13 Jun 2016 00:38:45 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id g4sm5833759wju.30.2016.06.13.00.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 00:38:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 3/6] MIPS: BMIPS: Add BCM3368 support
Date:   Mon, 13 Jun 2016 09:38:51 +0200
Message-Id: <1465803534-25840-3-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1465803534-25840-1-git-send-email-noltari@gmail.com>
References: <1465803534-25840-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54026
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

BCM3368 has a shared TLB which conflicts with current SMP support, so it must
be disabled for now.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
 arch/mips/bmips/setup.c                             | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index 4a7e030..65bc572 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -2,7 +2,7 @@
 
 Required properties:
 
-- compatible: "brcm,bcm3384", "brcm,bcm33843"
+- compatible: "brcm,bcm3368", "brcm,bcm3384", "brcm,bcm33843"
               "brcm,bcm3384-viper", "brcm,bcm33843-viper"
               "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
               "brcm,bcm63168", "brcm,bcm63268",
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index f146d12..4fbd2f1 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -98,7 +98,7 @@ static void bcm6328_quirks(void)
 static void bcm6358_quirks(void)
 {
 	/*
-	 * BCM6358 needs special handling for its shared TLB, so
+	 * BCM3368/BCM6358 need special handling for their shared TLB, so
 	 * disable SMP for now
 	 */
 	bmips_smp_enabled = 0;
@@ -110,6 +110,7 @@ static void bcm6368_quirks(void)
 }
 
 static const struct bmips_quirk bmips_quirk_list[] = {
+	{ "brcm,bcm3368",		&bcm6358_quirks			},
 	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
 	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
 	{ "brcm,bcm6328",		&bcm6328_quirks			},
-- 
2.1.4
