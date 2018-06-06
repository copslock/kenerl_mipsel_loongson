Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2018 21:37:47 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:55570
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994717AbeFFThklNlA5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2018 21:37:40 +0200
Received: by mail-wm0-x241.google.com with SMTP id v16-v6so13619280wmh.5;
        Wed, 06 Jun 2018 12:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JMcpTpgnoFQhAbEmluph/LVOeKNavOPVvKyXmU6PJXw=;
        b=kHb2PlUhN/UnIKjFR2lY/8cTLvA1peaEcE9l0WWUniQq9XX2e0pRj+zHsI+afpwRpt
         t0wSoNwuoE3fd6P9ULVfz/Tz2LtJW6YgHcCZQK13yEVWsuP5XPCFfVS3ZX6wrTx1E+vM
         Y5AWBpSaz2IKeUF97bplb1KV6WYjSTOI6n/u/evZYAnu0zsD89Kl5YNxxEUyLqqyrNmG
         zNH4rzPPeyB3nREoONcKFuTJj9iLyh05HRqbhpOZ60pe1OICbkXOYdJUEGTG0RnxXbq8
         1bq+KI6VPR7T+isO0fNM8GQmDQ8VnWJKbZ6onDlnrbY9fAf+DkPEEfv628i5n3reNKG3
         05QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=JMcpTpgnoFQhAbEmluph/LVOeKNavOPVvKyXmU6PJXw=;
        b=k722QfdmbpSeNq2jcu2lWHPcsXehwO3aMoBJqy4BCbawMe7WG8od8EAwncg9Nz+W/r
         PyEfbMb3eb57IPb9NftXBWhSzvCYlIsC6cXQtcXfUkgyjtXxjJnl5HW2YLkkxueRi9Ur
         zyw2FV0SDdNugaCZoKhwNxzskRxunrvxRT9CPrs20mw6Wa3z6OKNqeQvz/9GB62pM3Zo
         u9EyN+AhGlVWiLewBtWjRTe6uk9wjeKpLZ6SOnBLvim+XBo1PmJkWzhxW857GRFx0Y3D
         94WJkXk3BL0+0J7xjaixauUDG2xkNYwvPIwuJB3WlbIbH2m3KGnKC4ohYQWq0sSZolbl
         3kBA==
X-Gm-Message-State: APt69E0Yy+Cv38Kpb+qauWgjRTUfiaJYCvKiVbv1VCh3e/Nvk7wgWgVP
        SLoVfkPlwY40/pGJ0xWKqu8=
X-Google-Smtp-Source: ADUXVKKUflISX871SWBsxk2kfF+xT0U8+pgS1yfmKcdR1wA2F4mWL9ew1gZ22KXalofT6wDyjjQeDQ==
X-Received: by 2002:a1c:3fc2:: with SMTP id m185-v6mr2537206wma.37.1528313855096;
        Wed, 06 Jun 2018 12:37:35 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id e2-v6sm10376059wro.97.2018.06.06.12.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:37:34 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 5CE0E10C2B80; Wed,  6 Jun 2018 21:37:33 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MIPS: Ci20: Enable SPI/GPIO driver
Date:   Wed,  6 Jun 2018 21:37:29 +0200
Message-Id: <20180606193730.15087-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Update the Ci20's defconfig to enable the JZ4780's SPI/GPIO driver.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/configs/ci20_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index 0ddef6ad2652..0c08c7675b42 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -93,6 +93,8 @@ CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_JZ4780=y
+CONFIG_SPI=y
+CONFIG_SPI_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_INGENIC=y
 # CONFIG_HWMON is not set
-- 
2.11.0
