Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2016 11:58:49 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34597 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992914AbcHCJ6YxJvl0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2016 11:58:24 +0200
Received: by mail-wm0-f67.google.com with SMTP id q128so35470915wma.1;
        Wed, 03 Aug 2016 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qyNyAzWIJ/676s4wvnCG59RuzrRgkiJYBJdUJmcHlKI=;
        b=nRYJmrnvvsdjdkEHL/TGY1jGCBvapMk8GJ6wcTUnLdRyQOZq30+5CxsDxIRZV2pAYQ
         m1oES/yuALwytv3oW+ZUZEQUm2YO8UOjqxqw0/wwOoH/neAU1z/2QMNMrAByu4GvUc4V
         ZFJkp93rtOKgM/TATglrB8fcbOS2RtcYcEJAklCkASIQKv070IQzRFjMFtfZlJNuqBnD
         q5/5WuZuLgoa8drXx6NWQA6YzXLnTUAXHY0HZzn2xB8+C8kzrsvpfklhe7GN8jNXqFOb
         5c8xXqik08O/JBIZv5NAYUb9g/C8KI6/ltrfAThKIeSrE6EVFYJAgM5IKagfjUVKYwz4
         87SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qyNyAzWIJ/676s4wvnCG59RuzrRgkiJYBJdUJmcHlKI=;
        b=DjiamT7yHA7xN9oHAaKby/MDu4SgD72kwf6FnrZVhk1TmHXYPPuxUkuq/M78MX4nZv
         /6CAjOi1zC/jFyhR+ogVu15/4i8caKrNKY+nqhurLqcWCgnpHumyRAUxu6PxXO/iCUo6
         PyG8Ryy/+AjrCmRePi/RfkMec/ljdXw/Pe0hnDEIf3PFnsMiE9rRfs26v+HTjSRHaq3x
         xhwcvEpmkG3x7oP4LylzGiDW6QXXRWbj5+C4KAesLTJp6lFLIhyTMD+o4r40Fst4URNn
         zS+7U3roD6KN/Lvql5F/y2gv/dSRkhN54jW1ghGY1E73m4Wozi628Az80o7/bif9LGxZ
         Hm1g==
X-Gm-Message-State: AEkooutkIdHR16dw1cKwuJZKt4weYR9tE+CggSWsvJmc7XQfA4GnjX8vd0lLBBU9xBZEhQ==
X-Received: by 10.28.10.21 with SMTP id 21mr69424779wmk.3.1470218299584;
        Wed, 03 Aug 2016 02:58:19 -0700 (PDT)
Received: from localhost.localdomain (219.red-83-55-40.dynamicip.rima-tde.net. [83.55.40.219])
        by smtp.gmail.com with ESMTPSA id d80sm26368107wmd.14.2016.08.03.02.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 02:58:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 4/7] MIPS: BMIPS: Add BCM3368 support
Date:   Wed,  3 Aug 2016 11:58:27 +0200
Message-Id: <1470218310-2978-4-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54403
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
