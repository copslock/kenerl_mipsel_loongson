Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 21:54:40 +0100 (CET)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:58790 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013563AbaKLUyiR9emK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 21:54:38 +0100
Received: by mail-pd0-f174.google.com with SMTP id p10so12917870pdj.19
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BHuLM3LanXiBAFyeZ4vbNd6QsxRGVwcN4EuWnfR5Uo0=;
        b=sAABLGddDLd0QKTNLNJ2TphTu4l0p+6tLwWrg2lflFYAMTevVPIvJrnD4jyPoQoss9
         MLyJiY4i3aG3px08uYYkLheGf2Ej9sE6FSmyYvWYB49wqHNYcucRnf4WgIXlEHm79WcG
         RCU1etbDeR5qlvxXXSaMV90Uvwlea3jyyP7sI4hXYOZiRbmn+GsGQYzq12/m83GubZOb
         a/lG5EgNh1a84+WMqb0+qrZZ3k+zzK9N7g9wQPxkcG6xqwqOiyRaDzojFW1/wC3UzZYM
         fOy6t2hfHPIEmyxUP9JFCxpVDoa14ewQtlp7QTUFf/p5rUTYaduoN1KqHw+ZYR3+IDgB
         IIkw==
X-Received: by 10.68.143.226 with SMTP id sh2mr50304712pbb.62.1415825671909;
        Wed, 12 Nov 2014 12:54:31 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id z15sm23050495pdi.6.2014.11.12.12.54.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 12:54:30 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, grant.likely@linaro.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V2 00/10] UART driver support for BMIPS multiplatform kernels
Date:   Wed, 12 Nov 2014 12:53:57 -0800
Message-Id: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44075
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

V1->V2:

Add a new UPIO_MEM32BE iotype instead of a separate big_endian flag.

Change some of the of_*_is_* APIs to return bool, where appropriate.

Fix a few minor comment issues.


Kevin Cernekee (9):
  serial: core: Add big-endian iotype
  of: Fix of_device_is_compatible() comment
  of: Change of_device_is_available() to return bool
  of: Add helper function to check MMIO register endianness
  serial: pxa: Add fifo-size and {big,native}-endian properties
  serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
  serial: pxa: Update DT binding documentation
  serial: earlycon: Set UPIO_MEM32BE based on DT properties
  serial: pxa: Add OF_EARLYCON support

Tushar Behera (1):
  tty: Fallback to use dynamic major number

 .../devicetree/bindings/serial/mrvl-serial.txt     | 34 +++++++++++-
 drivers/of/base.c                                  | 47 ++++++++++++----
 drivers/of/fdt.c                                   |  9 ++-
 drivers/tty/serial/Kconfig                         |  2 +-
 drivers/tty/serial/earlycon.c                      |  4 +-
 drivers/tty/serial/pxa.c                           | 64 +++++++++++++++++++++-
 drivers/tty/serial/serial_core.c                   |  2 +
 drivers/tty/tty_io.c                               | 19 ++++++-
 include/linux/of.h                                 | 12 +++-
 include/linux/serial_core.h                        | 15 ++---
 10 files changed, 176 insertions(+), 32 deletions(-)

-- 
2.1.1
