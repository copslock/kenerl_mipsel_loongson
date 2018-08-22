Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2018 22:43:44 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:55553
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeHVUnlVwx9T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Aug 2018 22:43:41 +0200
Received: by mail-wm0-x242.google.com with SMTP id f21-v6so3137546wmc.5
        for <linux-mips@linux-mips.org>; Wed, 22 Aug 2018 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=J57nBDuGXn5MkfMLUm0177RSJZQNZvRsAWiDYTsT0LI=;
        b=HdCAqgDfJ3hqOLjcElWIoYnL7Wrsrduyjh825IavLAdP/fhdb8nNpCVaUP5PFzc7kg
         qXVNYTTKwVx7dCjq9FQFRvmpge7W3eUmSb7ArAzlq5JjW3eStsxm7t9jh3IBhCtyynCV
         f6j53VkKw/sRXk8I8XrFZLccW7gkufnZVdQQ9xPbFjXLHbx/pRpbtGje+WaLCcuEuXoQ
         NRlWLvw0NCTjAOBLzWdo0eI1ix4eROz/s/879ODU8PXK4O0Yx0Bym7GJhMV9sbyEzOHS
         WRypwbjChQd6GYAFSZ22qD9bYK8ULn9ArrDhNLeG0PF/PfQgXRgcTIZAvGAI/pku+Wfx
         veDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=J57nBDuGXn5MkfMLUm0177RSJZQNZvRsAWiDYTsT0LI=;
        b=WFCEX6NKLMP79xnOck3B9elPBMCbe2gLJtTzdW1XyjhYDvJHujtdXclKerAbwOiKub
         7gjA4aTJ1lOREed90Ms429bL37gy+hHub/AXPT66s++Wj9kBGD1wa8uwCAGQI09/sxZ2
         cRrBjEFMAZnePxBtm0BO25gVxGISadO088azgoHO0YSJYI4k/f+XssOzVL4aXgUUJmFW
         +/WkFyTmN3DkQojZxNktRYhVJYqIM2NS3DujFlNvzsmMYxQxoFolcrKx7sqn9Jzd2Ooq
         W96kxQ1KMcHRYnqVENHh+A/k4uDvaK1pXgXc+h3k/TvHa4UIbNCijHU+ZL5xo54j2CjK
         QVdA==
X-Gm-Message-State: APzg51AT2wvZr5FrRLV+qp3CJ7I0Zxdst1WJzmr37Q6NltzsVuyEhRx8
        5h1wXORLoReBtZUzBU+vCrUOYg==
X-Google-Smtp-Source: ANB0VdYxLK+aviJhkdOqJXI7G4Bdo4jTq7tBqqfct3UqnWST6dsJQf21CpVUVYd7qO8ujfdp5yj/iQ==
X-Received: by 2002:a1c:af53:: with SMTP id y80-v6mr3125292wme.55.1534970615845;
        Wed, 22 Aug 2018 13:43:35 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p200300EC2BD836007CE5606DACB185FD.dip0.t-ipconnect.de. [2003:ec:2bd8:3600:7ce5:606d:acb1:85fd])
        by smtp.gmail.com with ESMTPSA id o81-v6sm2170144wmo.28.2018.08.22.13.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 13:43:35 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: Add rt3352 SPI_CS1 pinmux
Date:   Wed, 22 Aug 2018 22:38:06 +0200
Message-Id: <1534970286-3758-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@kresin.me
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

The rt3352 has a pin that can be used as second spi chip select,
watchdog reset or GPIO. The pinmux setup was missing the definition of
said pin.

The pin is configured via the same bit on rt5350, so reuse the existing
macro.

Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 arch/mips/ralink/rt305x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index 93d472c..0f2264e 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -49,6 +49,10 @@ static struct rt2880_pmx_func rgmii_func[] = { FUNC("rgmii", 0, 40, 12) };
 static struct rt2880_pmx_func rt3352_lna_func[] = { FUNC("lna", 0, 36, 2) };
 static struct rt2880_pmx_func rt3352_pa_func[] = { FUNC("pa", 0, 38, 2) };
 static struct rt2880_pmx_func rt3352_led_func[] = { FUNC("led", 0, 40, 5) };
+static struct rt2880_pmx_func rt3352_cs1_func[] = {
+	FUNC("spi_cs1", 0, 45, 1),
+	FUNC("wdg_cs1", 1, 45, 1),
+};
 
 static struct rt2880_pmx_group rt3050_pinmux_data[] = {
 	GRP("i2c", i2c_func, 1, RT305X_GPIO_MODE_I2C),
@@ -75,6 +79,7 @@ static struct rt2880_pmx_group rt3352_pinmux_data[] = {
 	GRP("lna", rt3352_lna_func, 1, RT3352_GPIO_MODE_LNA),
 	GRP("pa", rt3352_pa_func, 1, RT3352_GPIO_MODE_PA),
 	GRP("led", rt3352_led_func, 1, RT5350_GPIO_MODE_PHY_LED),
+	GRP("spi_cs1", rt3352_cs1_func, 2, RT5350_GPIO_MODE_SPI_CS1),
 	{ 0 }
 };
 
-- 
2.7.4
