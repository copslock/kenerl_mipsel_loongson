Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 10:12:22 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34570 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041871AbcFCIMBoUJfm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 10:12:01 +0200
Received: by mail-wm0-f67.google.com with SMTP id n184so21129279wmn.1;
        Fri, 03 Jun 2016 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcTXDq/hBbu0EE253FVkRQISZ0pU+M1vXXJq+6UKqyg=;
        b=Qo4vjkv94+g0J7K3uuN0dU71px99zqD6py+27gH5e8VTyQ8An94abhdzvN1a99H22Y
         fYoBsTenBQ0bez9CMQbItKYa7Lcp3NVsW4TVIzKsrfolsKWpvOs+O9dvdKm5T40FDoWQ
         ivp5x53xFg3ipV1l6CwX/W+5Xl64JbdAPj0NGBAMq+3TYvfMKJ0hGyXBKE83+gt/R8c3
         ECWJdkb6CCpt13/egtNTt8jorYXJQri0bogsQqLG5w0b60pTHv/Ehmsy/Db0QD9/blBX
         pPxuSJpB5xQSAuzb2fXSclakEzczrd+uuzX9F3oscgdSwJosJKC0Y2ZJ+VSIwKLc43RX
         g3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcTXDq/hBbu0EE253FVkRQISZ0pU+M1vXXJq+6UKqyg=;
        b=apmkQtnZNanCnVzHMx+vgoAQc1Vce2tQIqqzTrdcR+o9oqllaneUm2cnKitMjL9Kr8
         j7tCXk0aXBCzyONqdYGghQescxjGM8koCb2pltSIHeCZUqnK4Yb2Z2caW9tFXw1S6n5z
         PS24ncuhbQEBviL+tso8r3eDUrLh6LEfl8PpaAykrDViKMnZCAQsqDRfrjagO8ZRLEYq
         fZt7SJbBqXNcVv2n9425kV50jfjmOz4h2A4gMmvLiQANicBfUknF/fY8VHwQUktX+mMs
         vAa18gphUKdlRl3qxs7Kjc79glnhctfcum+csYCGuwdkBbR/yLwZprEujsyFfdzbzWuT
         RqCA==
X-Gm-Message-State: ALyK8tKlUm0x1Cf+1jVA26U1hGIIriEkh0N18JC5oM7i/wfcVVxUz0hqMjddZNtCrIhhow==
X-Received: by 10.28.147.19 with SMTP id v19mr26252598wmd.13.1464941516496;
        Fri, 03 Jun 2016 01:11:56 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id x124sm5078158wmg.24.2016.06.03.01.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 01:11:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/3] MIPS: BMIPS: Add BCM6345 support
Date:   Fri,  3 Jun 2016 10:12:03 +0200
Message-Id: <1464941524-3992-2-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1464941524-3992-1-git-send-email-noltari@gmail.com>
References: <1464941524-3992-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53777
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

BCM6345 has only one CPU, so SMP support must be disabled.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
 arch/mips/bmips/setup.c                             | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index 4a7e030..1936e8a 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -4,7 +4,7 @@ Required properties:
 
 - compatible: "brcm,bcm3384", "brcm,bcm33843"
               "brcm,bcm3384-viper", "brcm,bcm33843-viper"
-              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
+              "brcm,bcm6328", "brcm,bcm6345", "brcm,bcm6358", "brcm,bcm6368",
               "brcm,bcm63168", "brcm,bcm63268",
               "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
               "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index f146d12..b0d339d 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -95,6 +95,14 @@ static void bcm6328_quirks(void)
 		bcm63xx_fixup_cpu1();
 }
 
+static void bcm6345_quirks(void)
+{
+	/*
+	 * BCM6345 has only one CPU and no SMP support
+	 */
+	bmips_smp_enabled = 0;
+}
+
 static void bcm6358_quirks(void)
 {
 	/*
@@ -113,6 +121,7 @@ static const struct bmips_quirk bmips_quirk_list[] = {
 	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
 	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
 	{ "brcm,bcm6328",		&bcm6328_quirks			},
+	{ "brcm,bcm6345",		&bcm6345_quirks			},
 	{ "brcm,bcm6358",		&bcm6358_quirks			},
 	{ "brcm,bcm6368",		&bcm6368_quirks			},
 	{ "brcm,bcm63168",		&bcm6368_quirks			},
-- 
2.1.4
