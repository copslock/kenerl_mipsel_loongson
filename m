Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 09:47:12 +0100 (CET)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35150 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013480AbaKLIrKzZvwC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 09:47:10 +0100
Received: by mail-pd0-f170.google.com with SMTP id z10so11902799pdj.29
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 00:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ollv7ocTNmfvs+uNP7BWiEPGHCjic9GdD/wztlhKTd8=;
        b=ehKCQzfLaWKhLKAmxYC7ap8QLB81dq215aAWDwe2fc2egoJHMGWEBePTP1xm86UMu/
         UGg26tgOA52fb26qu46cXq1m+ljFxRnsU8EdZPsyDSFpjZXPS529cFHlXPLfVArazHvS
         LalySrDzkzy1fuc+/kznXN1x0C9eps71IYT2mad9Hbpc49+7zpHlGhU+7udEjymzYF1t
         K5vd17URUpEs8WQDSQKfef8Px7/FviOcd8piZCPR5H2TtfLbp24rVaZze0QWVic2QIA4
         JL/nZL3vYDvXFGn7k7kUHkzXHBAOUj5NOP5ge55QmwUNJAWXkuQeRH+wxXaInkn9FtQ5
         zZTg==
X-Received: by 10.66.226.235 with SMTP id rv11mr45250234pac.41.1415782024838;
        Wed, 12 Nov 2014 00:47:04 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id p10sm18804833pds.63.2014.11.12.00.47.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 00:47:04 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH/RFC 0/8] UART driver support for BMIPS multiplatform kernels
Date:   Wed, 12 Nov 2014 00:46:25 -0800
Message-Id: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44028
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

Use the pxa serial driver to support BCM7xxx's UARTs; add code to allow
native-endian operation on both LE and BE systems.  Enable OF_EARLYCON
in the pxa driver.

After applying these changes I am able to build a multiplatform kernel
that boots to the prompt on BCM6328 (bcm63xx_uart) and BCM7346 (pxa).


Kevin Cernekee (7):
  serial: core: Add big_endian flag
  of: Add helper function to check MMIO register endianness
  serial: pxa: Add fifo-size and {big,native}-endian properties
  serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
  serial: pxa: Update DT binding documentation
  serial: earlycon: Set uart_port->big_endian based on DT properties
  serial: pxa: Add OF_EARLYCON support

Tushar Behera (1):
  tty: Fallback to use dynamic major number

 .../devicetree/bindings/serial/mrvl-serial.txt     | 34 +++++++++++-
 drivers/of/base.c                                  | 23 ++++++++
 drivers/of/fdt.c                                   |  9 +++-
 drivers/tty/serial/Kconfig                         |  2 +-
 drivers/tty/serial/earlycon.c                      |  3 +-
 drivers/tty/serial/pxa.c                           | 62 +++++++++++++++++++++-
 drivers/tty/tty_io.c                               | 19 +++++--
 include/linux/of.h                                 |  6 +++
 include/linux/serial_core.h                        |  5 +-
 9 files changed, 152 insertions(+), 11 deletions(-)

-- 
2.1.1
