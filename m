Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 22:55:03 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38381 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011950AbaJTUzBdGJfv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 22:55:01 +0200
Received: by mail-pa0-f50.google.com with SMTP id kx10so5887827pab.23
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+TiHzdDgCEoOlsvm4cuRpb+qTYPgTx2xT0oFApNm7os=;
        b=cM7frNX92DxmQOx90kbUm28Ol8Xtka/14CCHRoFWUaMbLRZwrdqCcbNhBtkBo1twBj
         W2jXlqvk5uWJn+a6yx/synhCrf9s/PFNYGJZfTg54NBA2JUpHMbyPzXAZ1/Q+8nHgwfP
         pQodVZF5xu9RJsV6PdBwOCDEQHIeDpy7KFxyZ5iFEo6H08PR2NJBG+3IRYH0mbaSDpKb
         Yk+4WHR3TRrgwHHts9UMsn5UthADDJCFnG+I3+7RPWqQWS5x8EZhWLuMmR32o5Hs9lzp
         Umet84J0WojKFSkNpuf/vkNayIOsqPWEV+Uo+MOrkDs01ahiM+v3FVt+SIMfimtUrdyK
         jwkA==
X-Received: by 10.66.140.102 with SMTP id rf6mr30252884pab.1.1413838494343;
        Mon, 20 Oct 2014 13:54:54 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fr7sm9954083pdb.79.2014.10.20.13.54.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 13:54:53 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V2 0/9] bcm63xx_uart and of-serial updates
Date:   Mon, 20 Oct 2014 13:53:59 -0700
Message-Id: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

In the course of bringing up a new platform[1] that uses this hardware,
I made a couple of improvements:

 - Allow the driver to be built for targets that do not define
   CONFIG_BCM63xx (as mine doesn't)
 - Use devm_ioremap_resource() to simplify the initialization code
 - Allow OF earlycon to be hardwired "on" in the kernel build, so it can
   eventually replace the MIPS EARLY_PRINTK scheme
 - Update documentation; fix typos/grammar


V1->V2:

 - Add acks from Florian
 - Rebase on tty-next (3.18-rc1)
 - bcm63xx_uart: add patches 3,4,6
 - Rework my earlycon change (patches 7,8) to use a config option
   instead of a function call

[1] https://github.com/cernekee/linux/commits/bcm3384


Kevin Cernekee (9):
  tty: serial: bcm63xx: Allow bcm63xx_uart to be built on other
    platforms
  tty: serial: bcm63xx: Update the Kconfig help text
  tty: serial: bcm63xx: Fix typo in MODULE_DESCRIPTION
  Documentation: DT: Add entries for bcm63xx UART
  tty: serial: bcm63xx: Enable DT earlycon support
  tty: serial: bcm63xx: Eliminate unnecessary request/release functions
  tty: serial: of-serial: Suppress warnings if OF earlycon is invoked
    twice
  tty: serial: of-serial: Allow OF earlycon to default to "on"
  MAINTAINERS: Add entry for rp2 (Rocketport Express/Infinity) driver

 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 34 ++++++++++++++
 MAINTAINERS                                        |  6 +++
 drivers/of/fdt.c                                   | 17 +++++--
 drivers/tty/serial/Kconfig                         | 30 +++++++++----
 drivers/tty/serial/bcm63xx_uart.c                  | 52 +++++++++++++---------
 include/linux/serial_bcm63xx.h                     |  2 -
 6 files changed, 106 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

-- 
2.1.1
