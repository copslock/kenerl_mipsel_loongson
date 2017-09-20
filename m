Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 13:14:34 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:32867
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992297AbdITLOVnSjVX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 13:14:21 +0200
Received: by mail-wm0-x242.google.com with SMTP id m127so2127305wmm.0;
        Wed, 20 Sep 2017 04:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z9cN2ATQ5QHTuTh0ekQ09K0GOyHXBfNdFBVEN+uUfXQ=;
        b=tOppH06yy/yVlgtf0LYrfLaeYIgfFpP6E4V1qk5HMmOypMJWtYJYpEm+wyqvwLDvFd
         qdhWwe+3BW5LXNpNeoKse6zMuD1moS+qXue4P2anMfgxQxsFyWBh6V1Kdn5k+Hc0baAA
         sWqZ9WpteL6rfTaxnm4dxQfv8Yqp2OoscS9zn0berBQ/3ErVOihIGO+dfL3UoNklIpkt
         0wvdWjQH3bnHEErksAOXZfJkLVeol5QD1OMcZLAy5JTTEGRM5evyfDzi6GN1KEslgYix
         UrdB667AplZkmo5CmenGX0zYJZKMRzKaDcwVj7BfU0IHqfF3qHp9riJVjaSm8HHoZi1l
         z9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z9cN2ATQ5QHTuTh0ekQ09K0GOyHXBfNdFBVEN+uUfXQ=;
        b=FPgSZZfvsVjp2euQL5lRs4fmHVNOedwy1Im5+aZxo30eOsuHkm7f/pCiX/75YBiJA+
         ygYWZ+k4oqOuwtBl0MilN1EMiDvvXRju8qdQ8U0c45a0OJb1sfPh3RmBo5yZ+0s3LATl
         WOxKd+eiy4530zUjUDC87mdRa6x1EJSaovUSo8vJbTYV5jJ0B5ChstEiDuhnKY27xF4q
         naS30LSJ3IZw3NLflVIekLnYBFZnJyNpX8fMM4gJmMAFvAN9w83VBLTS8yJfNAG8egKR
         NfZReURyhYKtV+k29/Cj9KxjGS+oHfP5slPSm0A4GmbGnPhnx0fgtai6moBDiKByk0/M
         G2PQ==
X-Gm-Message-State: AHPjjUiPYOUdQadXurs6TwzVedEn0HKhVkhDt3DTsBrTWSUgfDFB2msX
        g8AGLX1DjPDqSWIaL7SCgE5Kfg==
X-Google-Smtp-Source: AOwi7QDseebG//AoIGPoMIWW/NSjxZXBnk2bSgEDSWp8VGk2CxI7TJ/sqCxZEgAf5jfFLYywE33nhw==
X-Received: by 10.80.179.185 with SMTP id s54mr4356594edd.164.1505906055903;
        Wed, 20 Sep 2017 04:14:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id s12sm884513edd.25.2017.09.20.04.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 04:14:15 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH V2 0/8] MIPS: BCM63XX: add and use clkdev lookup support
Date:   Wed, 20 Sep 2017 13:14:00 +0200
Message-Id: <20170920111408.29711-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

This patchset adds support for clckdev lookup support to name input
clocks in various drivers more closely to their functions, or simplify
their usage.

Since most of these patches touch arch/mips, it probably makes most
sense to go through the MIPS tree.

The HSSPI driver was already updated previously to support a "pll"
input with ff18e1ef04e2 ("spi/bcm63xx-hsspi: allow providing clock rate
through a second clock"), so there is no need to touch it.

This patch series is part of an effort to modernize BCM63XX and clean up
its drivers to eventually make them usable with BMIPS and device tree.

Changes V1 -> V2:
* Drop the bcm63xx_enet patch, it will be sent again once the clkdev
  lookup is actually applied.
* Added a patch to fix refcounting in the secondary switch clocks.
* Slightly reordered patches to be ordered thematically.
* Added collected Acks / Reviews to their respective patches.

Due to none of the patches having changed between V1 and V2 I did not
add individual changelogs. These will be added if the code or commit log
text changes.

Jonas Gorski (8):
  MIPS: BCM63XX: add clkdev lookup support
  MIPS: BCM63XX: provide periph clock as refclk for uart
  tty/bcm63xx_uart: use refclk for the expected clock name
  tty/bcm63xx_uart: allow naming clock in device tree
  MIPS: BMIPS: name the refclk clock for uart
  MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
  MIPS: BCM63XX: provide enet clocks as "enet" to the ethernet devices
  MIPS: BCM63XX: split out swpkt_sar/usb clocks

 .../bindings/serial/brcm,bcm6345-uart.txt          |   6 +
 arch/mips/Kconfig                                  |   1 +
 arch/mips/bcm63xx/clk.c                            | 242 +++++++++++++++++----
 arch/mips/boot/dts/brcm/bcm3368.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm63268.dtsi              |   2 +
 arch/mips/boot/dts/brcm/bcm6328.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6358.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6362.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6368.dtsi               |   2 +
 drivers/tty/serial/bcm63xx_uart.c                  |   6 +-
 10 files changed, 218 insertions(+), 49 deletions(-)

-- 
2.13.2
