Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 00:23:30 +0200 (CEST)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:58245 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012031AbaJUWX3OZSWN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 00:23:29 +0200
Received: by mail-pd0-f179.google.com with SMTP id r10so2215668pdi.38
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 15:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sqsiLEnV7IK9IjnMO9vUSFtwefR0UaCt9WfkhYJspOk=;
        b=AVAAVX16scT07W8IEH0rNohBB2t1RxtfXAlty1hNkWxxbkF2wxa43k+7139yuCuYH+
         m4RtNSbb6vQCHaYCC6UKm4MIMuSfHCNpz8QZQNFsv+U/g7p8ArlmDdPbPhIggfisWawB
         nbD/gkT7m8PG4/8BKZ2US3BAElIlzZwPhoDgeFt07DoseRRvB1p5f13KC1X2y/btfUSk
         6mQgRWz4EAT5Zr6j20jNEIWfNS+rjAprw0DXG0LS1A9Z3fX8PVywxbrNocAon6V0oHlZ
         vwE2K1txuM8beRP0bKfjANcuy6FAPoidsLm1+hhfkFiAUo0pS370u5UmTBa1Khoym7Q/
         q5Fg==
X-Received: by 10.70.35.111 with SMTP id g15mr77476pdj.155.1413930202491;
        Tue, 21 Oct 2014 15:23:22 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id al4sm12702816pbc.19.2014.10.21.15.23.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 15:23:21 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz
Cc:     robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de,
        geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V3 00/10] bcm63xx_uart and of-serial updates
Date:   Tue, 21 Oct 2014 15:22:56 -0700
Message-Id: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43436
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

V2->V3:

Change DT clock node based on review feedback (thanks Arnd!)

Rebase on Linus' master branch


Kevin Cernekee (10):
  tty: serial: bcm63xx: Allow bcm63xx_uart to be built on other
    platforms
  tty: serial: bcm63xx: Add support for unnamed clock outputs from DT
  tty: serial: bcm63xx: Update the Kconfig help text
  tty: serial: bcm63xx: Fix typo in MODULE_DESCRIPTION
  Documentation: DT: Add entries for bcm63xx UART
  tty: serial: bcm63xx: Enable DT earlycon support
  tty: serial: bcm63xx: Eliminate unnecessary request/release functions
  tty: serial: of-serial: Suppress warnings if OF earlycon is invoked
    twice
  tty: serial: of-serial: Allow OF earlycon to default to "on"
  MAINTAINERS: Add entry for rp2 (Rocketport Express/Infinity) driver

 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 30 ++++++++++++
 MAINTAINERS                                        |  6 +++
 drivers/of/fdt.c                                   | 17 +++++--
 drivers/tty/serial/Kconfig                         | 30 ++++++++----
 drivers/tty/serial/bcm63xx_uart.c                  | 55 +++++++++++++---------
 include/linux/serial_bcm63xx.h                     |  2 -
 6 files changed, 104 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

-- 
2.1.1
