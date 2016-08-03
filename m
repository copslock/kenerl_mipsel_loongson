Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2016 12:00:42 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34610 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993039AbcHCJ61uWdC0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2016 11:58:27 +0200
Received: by mail-wm0-f68.google.com with SMTP id q128so35471008wma.1;
        Wed, 03 Aug 2016 02:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcEs/eeYsLWR4JiWDfpaGuZJetPjf5YZuc+14YHo0qs=;
        b=IlPoX8KRUPJQNqXyY0X9XP+HYwCsYh/7qSHsWUFNNAI3tIWNhoaShyG+jrWnHzGmgT
         kmLxnBDIajxeVkDQ87LIvO8UpaJYueZGaPUiZ93eHT5MPxWWE+90Kc3f0/GUuMaLtTeI
         W3xCVEJM8ggDetbasMsucF4cItJM78j4ZFYuZ2eUFo3a/Gmna3c5Y6H4i6ed+lgJcBVI
         IKv1Aq4p0LWaYd6ALjCC2nWyakidZb1816m3HCClnBa215Ps9pbrtaTBZlLX+eacLzBQ
         iBo0Rk+GBQ1V1h/y0rUv1ev2I9gPiK8Fs//qVNCqdjkDuEgVuYWfirCv70lfhRMcN5CG
         6lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcEs/eeYsLWR4JiWDfpaGuZJetPjf5YZuc+14YHo0qs=;
        b=WorxAYKXwPQJhGznYRwHxZ4ILZVakXwnnF++poJKM29rv6/tJAjdii+JjQc1IqAtHc
         +gGW03vfwqxIGswUoVMLHues50TWAhntguoGzPP1PAPFwxXW9ld2lWUiySPoKdLijKHL
         WJjP1LfHimO7+fuz5N3DuX5vGzTMj01DHdA7IfGjNZ41nidm9GkuwMXcXOR+2YkbAS2f
         +rabk/NPbtZk+k7iIYlzf4yFhUrOcXb1X+jfLi2OEudJJTUpyxVI5fTAxI9C2IjJP3C6
         +aY7z7vfwYImZKLOWzpgmVdXQV7A4C8dwrt4oqXlPTx3fs5qBh86ZQlaj79e7fj0mqfs
         AmvA==
X-Gm-Message-State: AEkoouvm38ZKZ9xFJn6oHSyzQFyKViRvN63ymJve5Aiy6cWf6tXhM+n6KvUeVfrsUyIEkw==
X-Received: by 10.28.156.213 with SMTP id f204mr22438352wme.86.1470218301341;
        Wed, 03 Aug 2016 02:58:21 -0700 (PDT)
Received: from localhost.localdomain (219.red-83-55-40.dynamicip.rima-tde.net. [83.55.40.219])
        by smtp.gmail.com with ESMTPSA id d80sm26368107wmd.14.2016.08.03.02.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 02:58:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 6/7] MIPS: BMIPS: Add BCM6362 support
Date:   Wed,  3 Aug 2016 11:58:29 +0200
Message-Id: <1470218310-2978-6-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54408
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
