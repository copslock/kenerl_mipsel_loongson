Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 23:37:30 +0200 (CEST)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:34808
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994874AbdFPVhX3s-oC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 23:37:23 +0200
Received: by mail-wr0-x243.google.com with SMTP id y25so5502009wrd.1;
        Fri, 16 Jun 2017 14:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xrobN+Uk8axrqe0A2B/UJi7ycnCvzBQciNSAQJ0IPbE=;
        b=dU0sounHGkkygGHZWop4UkSfwTao1veH1RyaJ/kz9CwAwLuHd8HYzohYxkgVIbnbsj
         sIHVjzTAJbo4lVfMoNldKMq5zyX9ZKuybWk752Mr1+PmQCMuB7Zpb5ElaWJTJITihO0X
         pBs/zsNRzuGvOxm0BReK9QnpVVXCLBaI5/nbrSNXYJo3tHuTiLpycMtxuSsWUzSallCr
         dC8eLVq8SIV1kwWlrwtB82rix5dVyW13mKlu1Dgqo45tiJHJSG3+nEhPdvJjbNHmslZI
         gMlLO2PmHXO3NuoXYM3UhDQAtZlQooFfEDfrLfXo3rQmx2KyIGXBi842XmEzSxuduADQ
         4VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xrobN+Uk8axrqe0A2B/UJi7ycnCvzBQciNSAQJ0IPbE=;
        b=Gd3pGQ32h0ZtC/yTOZL6OMDLdx813uzypm00xpprVgXgBBQKWvndg5TDPwkRMCVZVd
         +CjEJqR4Ao977Y9vZUfH0YTHmmHaHjaOWDp1UFk9xk97yBhOYzKDzTnVdAJvA5fkoEQg
         c+0SXcyITEEZZd/a8aWS9PhWugrHarDzblwuAGZbuitNwKw/b9wiPPJ1EFYDDPYBlnNp
         bUBwLlOJcPg+5/ld4nfBTuXRsjDxcnOXkQllHfLwS+3wrwlWZCqDz5y3c93KJ57sJTmu
         +htK7C0Qf+HQ+XQaM5PhDJJcGRszpr84BBg0Z0KjB79FBJM4oKb/oHi0kZ2Fy2Hv63Ks
         cw8g==
X-Gm-Message-State: AKS2vOzkIvm8TwSbHCXGyrx0RUuKF35WHsNDEPPErG4OU0N20knbqaaJ
        D8HZCw58oXBgxg==
X-Received: by 10.223.157.25 with SMTP id k25mr9184542wre.156.1497649037884;
        Fri, 16 Jun 2017 14:37:17 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id w17sm2576546wra.34.2017.06.16.14.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 14:37:17 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
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
        ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list),
        linux-mips@linux-mips.org (open list:BROADCOM BCM47XX MIPS ARCHITECTURE),
        linux-pm@vger.kernerl.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/5] Broadcom STB S2/S3/S5 support for ARM and MIPS
Date:   Fri, 16 Jun 2017 14:36:58 -0700
Message-Id: <20170616213703.21487-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58580
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

Brian Norris (1):
  soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)

Florian Fainelli (3):
  dt-bindings: Update Broadcom STB binding
  soc: bcm: brcmstb: Add Kconfig entry point for power management
  dt-bindings: Document MIPS Broadcom STB power management nodes

Justin Chen (1):
  soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS)

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |   6 +-
 .../devicetree/bindings/mips/brcm/soc.txt          |  77 ++
 drivers/soc/bcm/Kconfig                            |   2 +
 drivers/soc/bcm/brcmstb/Kconfig                    |   9 +
 drivers/soc/bcm/brcmstb/Makefile                   |   1 +
 drivers/soc/bcm/brcmstb/pm/Makefile                |   2 +
 drivers/soc/bcm/brcmstb/pm/aon_defs.h              | 113 +++
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                | 836 +++++++++++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm-mips.c               | 461 ++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm.h                    |  89 +++
 drivers/soc/bcm/brcmstb/pm/s2-arm.S                |  76 ++
 drivers/soc/bcm/brcmstb/pm/s2-mips.S               | 200 +++++
 drivers/soc/bcm/brcmstb/pm/s3-mips.S               | 146 ++++
 13 files changed, 2017 insertions(+), 1 deletion(-)
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
