Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 11:35:20 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:38322
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991087AbdHBJfMGvzzy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2017 11:35:12 +0200
Received: by mail-wr0-x241.google.com with SMTP id g32so3220159wrd.5;
        Wed, 02 Aug 2017 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sKe4t73fqMlbJBeRiH7r37sGZ29hVAjZDOVg1z+J8kg=;
        b=t1gzdHgtDUoFTdE2JyYF7TQgJGiGHXeE9iNK+wHG9cOHW/GdQ13hxrYNbQD50Zm8Hn
         f7BFcLmUlzzwEOLcM/cNSk+ODm6I4JyoIddjIXVvmGscBFQR0gweW97YJPF0P+6xQaJc
         Qb8pS8l+KdkiVTUjAdnKxHICt2hcD0HWIOhwtqQMoz+0TCpZtuYX0XBk8ru+KmXJKRIN
         Y+fzuXm+dBYrDAG6gnvPBP904WuHtVsBTIG33X81ScKbvpzE+KyPm9OiOVLK+9HeCu8Y
         i73EBjTUUNypfGyqJJTITpzVODznqpQB7pRpBRE4GkUkfyEltfIatVNk54pBZu7vIt4z
         i+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sKe4t73fqMlbJBeRiH7r37sGZ29hVAjZDOVg1z+J8kg=;
        b=lBXXyoOKDOjvJ8Xz1lK8NjBYqlMRusREYtEqDBLTQ0cW8a0vcGZMHz1ZJvGPujYoy0
         T/p+QbZ1hEuIluDwsb77IMtDB/+Flv7fdaq647zNno9MRx+coqtTb/f6n+txMe2CoCBF
         bRYZ/TKqcQ0EKe54GXJb3PUmx+Paxen17oD6Q46Nr03DByoCyrJ8aEBgfCJUkOGaQIDG
         wEyjfGyuQwGcWPSXAkgjxiHTJ6SpRFGsZeuvLohSpfDK8KxMOQ3hT3lX5LkeEuxdRhJs
         HX0YaLUVEo2OVVZjlMKREzuObTNtkFsm9UeJWMn3wR0a69uBbauSgboV5AE5cTY4uKvo
         hwNA==
X-Gm-Message-State: AIVw1111xz6Za97q1T/DA4MD+r+Fos9RnydkTa6/6U9U63HD9aidD9Lt
        xLVu7jDvkPX751LsKHU=
X-Received: by 10.223.169.2 with SMTP id u2mr16103817wrc.288.1501666506460;
        Wed, 02 Aug 2017 02:35:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 91sm32058876wrg.83.2017.08.02.02.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2017 02:35:06 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 0/8] MIPS: BCM63XX: add and use clkdev lookup support
Date:   Wed,  2 Aug 2017 11:34:21 +0200
Message-Id: <20170802093429.12572-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59316
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

This patchset adds and uses clckdev lookup support to name input clocks
in various drivers more closely to their functions, or simplify their
usage.

Since most of these patches touch arch/mips, it probably makes most
sense to go through the MIPS tree.

The HSSPI driver was already updated previously to support a "pll"
input with ff18e1ef04e2 ("spi/bcm63xx-hsspi: allow providing clock rate
through a second clock"), so there is no need to touch it.

This patch series is part of an effort to modernize BCM63XX and clean up
its drivers to eventually make them usable with BMIPS and device tree.

Jonas Gorski (8):
  MIPS: BCM63XX: add clkdev lookup support
  MIPS: BCM63XX: provide periph clock as refclk for uart
  tty/bcm63xx_uart: use refclk for the expected clock name
  tty/bcm63xx_uart: allow naming clock in device tree
  MIPS: BCM63XX: provide enet clocks as "enet" to the ethernet devices
  bcm63xx_enet: just use "enet" as the clock name
  MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
  MIPS: BMIPS: name the refclk clock for uart

 .../bindings/serial/brcm,bcm6345-uart.txt          |   6 +
 arch/mips/Kconfig                                  |   1 +
 arch/mips/bcm63xx/clk.c                            | 181 ++++++++++++++++-----
 arch/mips/boot/dts/brcm/bcm3368.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm63268.dtsi              |   2 +
 arch/mips/boot/dts/brcm/bcm6328.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6358.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6362.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6368.dtsi               |   2 +
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |   5 +-
 drivers/tty/serial/bcm63xx_uart.c                  |   6 +-
 11 files changed, 168 insertions(+), 43 deletions(-)

-- 
2.13.2
