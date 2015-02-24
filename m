Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 02:31:57 +0100 (CET)
Received: from mail-ie0-f201.google.com ([209.85.223.201]:33300 "EHLO
        mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006984AbbBXBb4IaADI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 02:31:56 +0100
Received: by iecrl12 with SMTP id rl12so7210602iec.0
        for <linux-mips@linux-mips.org>; Mon, 23 Feb 2015 17:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CjwsVX7rnqvaVCHOKOJ6pQ2/O3Zu3fpIyEcNjLFPtPQ=;
        b=VCFN7R+tM6GAxcUM2fZXm8UEbmduFDNRiC3QDcqBCEiFSgePyiXzjBh65TyERYmQ6b
         3gyv+xqQdKioR7WK2F9s5YdB7OMwkN2YgEw0ra7AwboUr5BG83CfYiqhWvf3YdM8Pw3J
         py6nkGYjqnKH0uwrHHzsmrXYmUIEhraOHX/lio+64P71JohLrD74E0FzdBuhyuZXxtC/
         gVqzIr56sbCixdQRoy7JjZqoEqzlUYoh1Fs/1RVjSLtGUGhApOyL456IXs2tIqXgJs3e
         qXu/AUZ7PSO7nL+eQkT3b0QFAfo/Q2Op9glIHqcfWwI9QpXu2cLEFoKiL5xgb5SNvuZ6
         cITQ==
X-Gm-Message-State: ALoCoQlGrFXRy5/jJQORI6c1R0Y+oo0DkaecAPD4f/72+BSQ1lim+ywHly6+e57uL7Ii3ifZPz0l
X-Received: by 10.182.148.164 with SMTP id tt4mr14028472obb.30.1424741510564;
        Mon, 23 Feb 2015 17:31:50 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e5si3716714qcg.1.2015.02.23.17.31.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2015 17:31:50 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id oSrTEdTi.1; Mon, 23 Feb 2015 17:31:50 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 24F51220728; Mon, 23 Feb 2015 17:31:49 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 0/5] MIPS: Initial IMG Pistachio SoC support
Date:   Mon, 23 Feb 2015 17:31:42 -0800
Message-Id: <1424741507-8882-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

This series adds basic support for the Imagination Technologies Pistachio
SoC.  Pistachio will boot using device-tree only.  v4.0-rc1 already includes
support for several of the peripherals on Pistachio, including MMC, SPI,
I2C, DMA, watchdog timer, PWM, and IR.  Clock and pinctrl support for
Pistachio is coming soon, as well as an initial device-tree and support
for USB and ethernet.

Patches 1 and 2 are cleanups in preparation for adding Pistachio support,
with patch 1 having been posted by Kevin late last year [1].  Patch 3
documents Pistachio's required device-tree properties/nodes and its boot
protocol.  Patch 4 adds support for Pistachio itself and finally patch 5
adds a defconfig for Pistachio.

Boot tested on an IMG Pistachio BuB ("bring-up board") and build tested
for all other affected platforms.  Based on v4.0-rc1.  A tree with these
changes is available at [2].

Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: James Hartley <james.hartley@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>

[1] http://patchwork.linux-mips.org/patch/8837/
[2] https://github.com/abrestic/linux/tree/pistachio-platform-v1

Andrew Bresticker (3):
  MIPS: Allow platforms to specify the decompressor load address
  MIPS: Document Pistachio boot protocol and device-tree bindings
  MIPS: Add support for the IMG Pistachio SoC

Govindraj Raja (1):
  MIPS: pistachio: Add an initial defconfig

Kevin Cernekee (1):
  MIPS: Create a common <asm/mach-generic/war.h>

 .../devicetree/bindings/mips/img/pistachio.txt     |  40 +++
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  27 ++
 arch/mips/boot/compressed/Makefile                 |   6 +-
 arch/mips/configs/pistachio_defconfig              | 336 +++++++++++++++++++++
 arch/mips/include/asm/mach-ar7/war.h               |  24 --
 arch/mips/include/asm/mach-ath25/war.h             |  25 --
 arch/mips/include/asm/mach-ath79/war.h             |  24 --
 arch/mips/include/asm/mach-au1x00/war.h            |  24 --
 arch/mips/include/asm/mach-bcm3384/war.h           |  24 --
 arch/mips/include/asm/mach-bcm47xx/war.h           |  24 --
 arch/mips/include/asm/mach-bcm63xx/war.h           |  24 --
 arch/mips/include/asm/mach-cobalt/war.h            |  24 --
 arch/mips/include/asm/mach-dec/war.h               |  24 --
 arch/mips/include/asm/mach-emma2rh/war.h           |  24 --
 arch/mips/include/asm/mach-generic/war.h           |  24 ++
 arch/mips/include/asm/mach-jazz/war.h              |  24 --
 arch/mips/include/asm/mach-jz4740/war.h            |  24 --
 arch/mips/include/asm/mach-lantiq/war.h            |  23 --
 arch/mips/include/asm/mach-lasat/war.h             |  24 --
 arch/mips/include/asm/mach-loongson/war.h          |  24 --
 arch/mips/include/asm/mach-loongson1/war.h         |  24 --
 arch/mips/include/asm/mach-netlogic/war.h          |  25 --
 arch/mips/include/asm/mach-paravirt/war.h          |  25 --
 arch/mips/include/asm/mach-pistachio/gpio.h        |  21 ++
 arch/mips/include/asm/mach-pistachio/irq.h         |  18 ++
 arch/mips/include/asm/mach-pnx833x/war.h           |  24 --
 arch/mips/include/asm/mach-ralink/war.h            |  24 --
 arch/mips/include/asm/mach-tx39xx/war.h            |  24 --
 arch/mips/include/asm/mach-vr41xx/war.h            |  24 --
 arch/mips/jz4740/Platform                          |   1 +
 arch/mips/pistachio/Makefile                       |   1 +
 arch/mips/pistachio/Platform                       |   8 +
 arch/mips/pistachio/init.c                         | 131 ++++++++
 arch/mips/pistachio/irq.c                          |  28 ++
 arch/mips/pistachio/time.c                         |  52 ++++
 36 files changed, 692 insertions(+), 532 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/img/pistachio.txt
 create mode 100644 arch/mips/configs/pistachio_defconfig
 delete mode 100644 arch/mips/include/asm/mach-ar7/war.h
 delete mode 100644 arch/mips/include/asm/mach-ath25/war.h
 delete mode 100644 arch/mips/include/asm/mach-ath79/war.h
 delete mode 100644 arch/mips/include/asm/mach-au1x00/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm3384/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm47xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-cobalt/war.h
 delete mode 100644 arch/mips/include/asm/mach-dec/war.h
 delete mode 100644 arch/mips/include/asm/mach-emma2rh/war.h
 create mode 100644 arch/mips/include/asm/mach-generic/war.h
 delete mode 100644 arch/mips/include/asm/mach-jazz/war.h
 delete mode 100644 arch/mips/include/asm/mach-jz4740/war.h
 delete mode 100644 arch/mips/include/asm/mach-lantiq/war.h
 delete mode 100644 arch/mips/include/asm/mach-lasat/war.h
 delete mode 100644 arch/mips/include/asm/mach-loongson/war.h
 delete mode 100644 arch/mips/include/asm/mach-loongson1/war.h
 delete mode 100644 arch/mips/include/asm/mach-netlogic/war.h
 delete mode 100644 arch/mips/include/asm/mach-paravirt/war.h
 create mode 100644 arch/mips/include/asm/mach-pistachio/gpio.h
 create mode 100644 arch/mips/include/asm/mach-pistachio/irq.h
 delete mode 100644 arch/mips/include/asm/mach-pnx833x/war.h
 delete mode 100644 arch/mips/include/asm/mach-ralink/war.h
 delete mode 100644 arch/mips/include/asm/mach-tx39xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-vr41xx/war.h
 create mode 100644 arch/mips/pistachio/Makefile
 create mode 100644 arch/mips/pistachio/Platform
 create mode 100644 arch/mips/pistachio/init.c
 create mode 100644 arch/mips/pistachio/irq.c
 create mode 100644 arch/mips/pistachio/time.c

-- 
2.2.0.rc0.207.ga3a616c
