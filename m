Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2016 09:40:05 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32975 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042092AbcFMHiwpT9GC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2016 09:38:52 +0200
Received: by mail-wm0-f68.google.com with SMTP id r5so12598327wmr.0;
        Mon, 13 Jun 2016 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcEs/eeYsLWR4JiWDfpaGuZJetPjf5YZuc+14YHo0qs=;
        b=wJyeNDJ8ZjaDZAGUOwXUhKUmwHLMjT6IBF6o0YvGZLCgdMPl+TaiJyCpV2F0qSBf/m
         pUI8F0I9KBSK7m0PBnDNUXBKjDDp2iM8RPQQUV/t0vM9NwgRlOelZ05FucScnxC1rbi2
         pynOPE8Sf7k1qMDBarkvmZlkoNGqiDQqxiBUy6R3b4TbDR2Gk1qNo0Q1YpVKE/UvgG5Q
         7LseNvChwgES1wjycd1o3E3WEohnLq8vCIXMuX741elsNQr8D+5dwjtjw78eBJkzcogX
         Jb4WjlNBQoluBFnqJWsjrJVe7kVsGsYsogPYmNzFZw2dPy2UAfAi7EVu5yOjgpn3aZ3y
         nAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcEs/eeYsLWR4JiWDfpaGuZJetPjf5YZuc+14YHo0qs=;
        b=YGALT1bf6emB7wI/5TuxsV+3Ol9F4uM3bWB7SiWr27pWJPLRvvkZ/aRfLtCZ3BsBRc
         CdO9K0oq93OAavb750xCFjIHJcfu7GTmmQYb5ULLC0z/4eYCpEqQSlUObj+cdPe51KEL
         Dl7mNckSBLraIDQwVrcb2Q72NGhzEnLJXTC54FXxc6eOlPwy4kSOi0b/3hdzZ/BfemBH
         DxCFMNvai5f6QhOA+2mJR1pPomWIchTu9P319LgqYKiUMb5LyEb7UTrNKWGluDclmSCm
         JWDw//nWSUorlTT0kv9KwOhyXwz+a5fHcIEb2MrjIcTpDD/B82xmHZBywR6Wtt1ZMN1q
         Nxxg==
X-Gm-Message-State: ALyK8tIQmU9gnNRmNFBr70jZIOX7SJYwixd6qE4c7SRZwlY3WF+Z4ARJxo6+XpJYWu3krw==
X-Received: by 10.28.109.137 with SMTP id b9mr9907582wmi.68.1465803527490;
        Mon, 13 Jun 2016 00:38:47 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id g4sm5833759wju.30.2016.06.13.00.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 00:38:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 5/6] MIPS: BMIPS: Add BCM6362 support
Date:   Mon, 13 Jun 2016 09:38:53 +0200
Message-Id: <1465803534-25840-5-git-send-email-noltari@gmail.com>
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
X-archive-position: 54028
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

BCM6362 is a BMIPS4350 SoC which needs the same fixup as BCM6368 in order to
enable SMP support.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
 arch/mips/bmips/setup.c                             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index 65bc572..e4e1cd9 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -4,7 +4,7 @@ Required properties:
 
 - compatible: "brcm,bcm3368", "brcm,bcm3384", "brcm,bcm33843"
               "brcm,bcm3384-viper", "brcm,bcm33843-viper"
-              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
+              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6362", "brcm,bcm6368",
               "brcm,bcm63168", "brcm,bcm63268",
               "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
               "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 4fbd2f1..bde62bc 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -115,6 +115,7 @@ static const struct bmips_quirk bmips_quirk_list[] = {
 	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
 	{ "brcm,bcm6328",		&bcm6328_quirks			},
 	{ "brcm,bcm6358",		&bcm6358_quirks			},
+	{ "brcm,bcm6362",		&bcm6368_quirks			},
 	{ "brcm,bcm6368",		&bcm6368_quirks			},
 	{ "brcm,bcm63168",		&bcm6368_quirks			},
 	{ "brcm,bcm63268",		&bcm6368_quirks			},
-- 
2.1.4
