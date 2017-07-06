Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 00:25:09 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:33040
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993939AbdGFWZBV9Xw7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 00:25:01 +0200
Received: by mail-wr0-x244.google.com with SMTP id x23so3580876wrb.0;
        Thu, 06 Jul 2017 15:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oZAaoTHnRT2GbMTm4IpJWcQMCQ0LWvqU6ATpsENkD00=;
        b=pJhiZfXyWX8DuBmEgQ/t2z5VKBAoOFbQ6XcoCPIIPxd0s2U+gm8tpVNabVUxSuyq1r
         o2HjypvNPlo+e25sFjMGkqOuXr6nBTbtfTv4wobQWaavprihEA+zCqPAWSUmZoq4efeo
         G9WPaRHVHYfrbDUrggkjySuH+vNOGQGxGE+7GdcaJFOzsW41B0KK2hLAi0rbKGVPXKuJ
         fievBkjMYpyrNrULHQzMfebfwjVbObfLCGh3FZR0fVn9nlzTAsSGFbHzj23xkH3w3Frn
         7m3/d6iuSrl4roTwpiS2YIrHAOeVuoH1pBuyy+r83SPFoOqQxvToA2vROnwe5DiUQSIR
         o6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oZAaoTHnRT2GbMTm4IpJWcQMCQ0LWvqU6ATpsENkD00=;
        b=JcySbXi7SSZz5atHBueoKFAR8rfglqkiOLgzOAZspgi07kQzB+9K4z4PS+iDMeT0yh
         EQcC2o/FEP7GUwKLx1zulSQCr3qrjcI5Quc9lUfbB9L5dZwFf7LuYU1ZbjRq26he96P5
         wn1bpITwYfLlzPnZpeN0XDc3BHL0qlfhE+WCqkmOSWAOUVT2wOU2QYc8dm3JxcqACoAE
         LJagtHya5vb4i7kV8yiFtkYH83AK/XFm1BcT7kl2vCdVt9d0ytOkU6xabiP7EBYSccXn
         e8mU77w/MM0DatG4lN/UAvbasj0ZP+QaOBYlKDxkTX8o7vI6eTm67evC8zrnimgNLDo0
         15cw==
X-Gm-Message-State: AIVw113DBFoxqHBQ/tQIVB2oZTzd8v3nz8Pnb31jCwAD5KfyN6UJB25+
        oW7Dz0Z1xjAE/g==
X-Received: by 10.28.199.200 with SMTP id x191mr86867wmf.94.1499379896081;
        Thu, 06 Jul 2017 15:24:56 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id o131sm1781301wmd.26.2017.07.06.15.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jul 2017 15:24:55 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-mips@linux-mips.org (open list:BROADCOM BCM47XX MIPS ARCHITECTURE),
        linux-pm@vger.kernerl.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 0/4] Broadcom STB S2/S3/S5 support for ARM and MIPS
Date:   Thu,  6 Jul 2017 15:22:21 -0700
Message-Id: <20170706222225.9758-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi,

This patch series adds support for S2/S3/S5 suspend/resume states on
ARM and MIPS based Broadcom STB SoCs.

This was submitted a long time ago by Brian, and I am now picking this
up and trying to get this included with support for our latest chips.

Provided that I can collect the necessary Acks from Rob (DT) and other
people (Rafael?) I would probably take this via the Broadcom ARM SoC
pull requests.

Thank you!

Changes in v3:

- make SRAM mapping uncached
- make SWAP_STACK + brcmstb_pm_s3_finish a single asm volatile statement
- added Rob's Acked-by to first patch

Changes in v2:

- clarify the first patch's subject (Rob)
- removed patch #2 which was creating a bisectability problem (kbuild)
- added proper AFLAGS to get s2-arm.S to build properly (kbuild)
- improved MIPS power management binding document (Rob)

Brian Norris (1):
  soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)

Florian Fainelli (2):
  dt-bindings: ARM: brcmstb: Update Broadcom STB Power Management
    binding
  dt-bindings: Document MIPS Broadcom STB power management nodes

Justin Chen (1):
  soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS)

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |   6 +-
 .../devicetree/bindings/mips/brcm/soc.txt          | 153 ++++
 drivers/soc/bcm/Kconfig                            |   2 +
 drivers/soc/bcm/brcmstb/Kconfig                    |   9 +
 drivers/soc/bcm/brcmstb/Makefile                   |   1 +
 drivers/soc/bcm/brcmstb/pm/Makefile                |   3 +
 drivers/soc/bcm/brcmstb/pm/aon_defs.h              | 113 +++
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                | 836 +++++++++++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm-mips.c               | 461 ++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm.h                    |  89 +++
 drivers/soc/bcm/brcmstb/pm/s2-arm.S                |  76 ++
 drivers/soc/bcm/brcmstb/pm/s2-mips.S               | 200 +++++
 drivers/soc/bcm/brcmstb/pm/s3-mips.S               | 146 ++++
 13 files changed, 2094 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/bcm/brcmstb/Kconfig
 create mode 100644 drivers/soc/bcm/brcmstb/pm/Makefile
 create mode 100644 drivers/soc/bcm/brcmstb/pm/aon_defs.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-arm.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-mips.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-arm.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-mips.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s3-mips.S

-- 
2.9.3
