Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Aug 2016 20:16:00 +0200 (CEST)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33575 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992607AbcH0SPxzUkmj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Aug 2016 20:15:53 +0200
Received: by mail-pa0-f67.google.com with SMTP id vy10so6415692pac.0;
        Sat, 27 Aug 2016 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=cp7pWRJsMSyGuUHjgMvlw9SgKgA7Nqhh6S+Uyu9tnxM=;
        b=eAB4G0DomUkJgsgjA0KrjGRBvXXBplAd2o5zYHCMzG0jEtMgBGVcjbDMqSpNxHXVyy
         mzlxVyXIQ7PTV/kb2f8STqPJKgmwKj8Q+vSGEbyu9m6cZcZFTkkvaMNMIPwMpuUgwaPF
         M7zlfipPZB69uByIWWMzozvnCUMx32VNconj+RpPxZilvdy5TStCsfZWwqm0rnVFSuQp
         2lUSSbCDP6Amaa5HSV8hfrji5aEROX/GvcoefZAQmdyqragym5ByWf+TlZMX2MKDuGTb
         pznOW0LUxSVbo8F21NCbHrcUGKY+4lcOLv8CMMpeMfcJDZVdGl6Tlys0U/fNh4atWPv8
         r5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=cp7pWRJsMSyGuUHjgMvlw9SgKgA7Nqhh6S+Uyu9tnxM=;
        b=bGgS7nd1RnaphLN+/6jIZXlgvSZ7DQxOiOprytaSWgmkCye50TfJ0zCYKfohoKKACF
         tHU+AtG9PuvIpv3iAoCWrl8x/c49evRQLOc+kqdKj/rPCBmsdm/p6+24d5wpK7M/1QOI
         QGYzwfG6lQubOcBgiAW4jzPmb6GMddLpo85sKNCP9To8h9Yop+GDimcbSL1iGCE2FCJC
         NA/qT3fZOeZbAPWb2QCrHIeOuwo0P4ZFEp3j1iKk8CoTAxwZuUq18I0rGX+Z0hTVYa0a
         qhEJVN00D0nZ3ChNDCoOfT7wlt2jAx4aN2BFSUeNVt+yqQx3EMSZtLMmcpUN4kGHqrSn
         0lNA==
X-Gm-Message-State: AE9vXwOjG9b38MZjxMFTL21J9XYBAkyjVtKtBaYgbXAXMzIY+u9Vduther1xlLpkbuXrtg==
X-Received: by 10.66.2.135 with SMTP id 7mr17131917pau.136.1472321747890;
        Sat, 27 Aug 2016 11:15:47 -0700 (PDT)
Received: from localhost.localdomain ([1.22.68.54])
        by smtp.gmail.com with ESMTPSA id y6sm37747529pav.1.2016.08.27.11.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:15:47 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org,
        gregkh@linuxfoundation.org, boris.brezillon@free-electrons.com,
        harvey.hunt@imgtec.com, prarit@redhat.com, f.fainelli@gmail.com,
        joshua.henderson@microchip.com, narmstrong@baylibre.com,
        linus.walleij@linaro.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v2 0/4] hw_random: Add driver for Ingenic JZ4780 SoC RNG
Date:   Sat, 27 Aug 2016 23:44:53 +0530
Message-Id: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.5.0
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

This is the v2 patch series that adds support for random number generator
present in Ingenic JZ4780 SoC.

Patch 1: Add device tree bindings for RNG in JZ4780 SoC.
Patch 2: Add Ingenic JZ4780 hardware RNG driver.
Patch 3: Add RNG to jz4780.dtsi.
Patch 4: Enable RNG in ci20_defconfig

PrasannaKumar Muralidharan (4):
  hw_random: jz4780-rng: Add devicetree bindings for RNG in JZ4780 SoC
  hw_random: jz4780-rng: Add Ingenic JZ4780 hardware RNG driver
  hw_random: jz4780-rng: Add RNG node to jz4780.dtsi
  hw_random: jz4780-rng: Enable hardware RNG in CI20 defconfig

 Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt |   12 +
 MAINTAINERS                                                  |    5 
 arch/mips/boot/dts/ingenic/jz4780.dtsi                       |    7 
 arch/mips/configs/ci20_defconfig                             |    4 
 drivers/char/hw_random/Kconfig                               |   14 +
 drivers/char/hw_random/Makefile                              |    1 
 drivers/char/hw_random/jz4780-rng.c                          |  102 +++++++++++
 7 files changed, 143 insertions(+), 2 deletions(-)
