Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 00:34:00 +0200 (CEST)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:32891
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993879AbdFZWdxlaeqt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 00:33:53 +0200
Received: by mail-qk0-x243.google.com with SMTP id p21so1919603qke.0;
        Mon, 26 Jun 2017 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nBhSEjwkPZ01WxEOGkFtj7mq9wlB+uB47Dh+fptLmW8=;
        b=SIdTkcoMb9lxLTCmRSiwcf9aHa9U4v8awBETnDtAkTa3bZYRTskKvIDkn+BM3ngTQ0
         u6fwGj0Dr8UKX/DDWECF6RJIQ0mBcWWqsw0oYslLEbYjHAyDTiBjeUua5N/GKzJ353we
         oJowaanF52IOR634BsI4b/g6Ve76vgSbhbMH/9FXaDZpkIWCGLXotebU+gW6d/IwFQsn
         h2zjiVu65FDIi3X+HmXtpdM9yGLwv7Xfivp/D/MFsupiuDttmX6S/pBAVcw6qpFW9JhN
         p/3u4JjtRu8Ve0kgT3ZCA9CamRSowNSIknOmquLITbYn7ZgA8gVYZDdtLKtPq4E34ai8
         M+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nBhSEjwkPZ01WxEOGkFtj7mq9wlB+uB47Dh+fptLmW8=;
        b=RAaCbsYqqeAs2sXVxSfYEllqaMTC8QkBkzrY7XNJfeHQKttCdRuuqa9h61fpdHYYvC
         2kEmEQhXFzGAt3Ix8PMSqx8rMwFi4PrKK1IEPECD719rdwn58+zekmyp+kw9t7LlBVy5
         sSX76uwYn0UIHORiQSZ0kSx3OptR+0S7nDRtpFuolNsNWLBU7FO2g3mYwXjkl1lzJ7HL
         ojn8jrXZQ9xQsXlszTA6iZU6luAfkgNJfy6XzrViqgfNQnOzSdY2Ys13slLZKNQL9CgY
         T+ShmtAT0NXsikqoQm9CmtiUDiFGhYHqtuK8kvJPVN3krde47sqMkolIIRoWYfFW1B5m
         gv9Q==
X-Gm-Message-State: AKS2vOx1wSlGVPQKb18QrVtNSldyf1CwIMjgqtXI/Z1dHt8iV45PG6j/
        YYQbVz7nubF0kA==
X-Received: by 10.55.170.212 with SMTP id t203mr2868059qke.200.1498516427833;
        Mon, 26 Jun 2017 15:33:47 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id j65sm965542qkf.38.2017.06.26.15.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 15:33:47 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
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
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-mips@linux-mips.org (open list:BROADCOM BCM47XX MIPS ARCHITECTURE),
        linux-pm@vger.kernerl.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 0/4] Broadcom STB S2/S3/S5 support for ARM and MIPS
Date:   Mon, 26 Jun 2017 15:32:40 -0700
Message-Id: <20170626223248.14199-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58812
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
