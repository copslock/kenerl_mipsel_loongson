Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 18:29:30 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:44737 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491030Ab1FLQ3W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 18:29:22 +0200
Received: by wwb17 with SMTP id 17so3479588wwb.24
        for <linux-mips@linux-mips.org>; Sun, 12 Jun 2011 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=QQVp2N+8EUwAxBccBR7g0aF5Z488waL9RQSbC6PsEoY=;
        b=Bp/P8oneGmDaDGzeFEyuWwgHmPHgKkPFM0htR87foUWtmqfmXuWzl9lgWQl5JtJdju
         FDZKwGfU7vmK+MmZYW+b7uYxyaNBHytm3UphCal7IHq3mY17t0jszndqAEWvdBYn09TL
         p1YjB3xOHsPlhVNxWBE1w8YfYFibKBqiQukLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LR+sshx2NhI8Q0ayoTeCfV7sZbqB28wVQa7GT4ICQMryxkM/8tKBZ0q7tdHfb8MJfw
         95+cNiwtxmkmETqVFYSB99SPw7Xie4wZExSUBD+YCUqSU36QYU9gbpT7/9StJ2dcIvr8
         VFEWKsdcTfcDq/5cy+qYJ0w09TotJvgw3hXJU=
Received: by 10.227.199.139 with SMTP id es11mr3792781wbb.46.1307896154976;
        Sun, 12 Jun 2011 09:29:14 -0700 (PDT)
Received: from localhost.localdomain (188-22-11-39.adsl.highway.telekom.at [188.22.11.39])
        by mx.google.com with ESMTPS id o38sm3587978wba.54.2011.06.12.09.29.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 09:29:13 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2 0/3] MIPS: Alchemy: USB updates and more cleanups
Date:   Sun, 12 Jun 2011 18:29:07 +0200
Message-Id: <1307896150-29429-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.3
X-archive-position: 30340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10170

Here goes V2 of the Alchemy USB rework.

Changes since V1:
- fixed a few mistakes in patch #1 and made it a bit smaller.

Patch overview:
#1 moves the fiddling with the various USB control bits out of the
  host drivers into a separate file.  The host drivers simply call
  a function to enable/disable a USB block (OHCI/EHCI/UDC/OTG,..),
  and the core file takes care of the details.
  This file mainly exists for the Au1200 and Au1300 which have a
  bunch of separate registers which control various aspects of the
  USB subsystem.  I don't want the USB host glues to know about
  the implementation details of each chip variant.

#2 rewrites USB setup to detect chip variant at runtime and register
  the appropriate platform devices.

#3 does some more header cleanups.

Run and PM tested on DB1200.

Manuel Lauss (3):
  MIPS: Alchemy: abstract USB block control register access
  MIPS: Alchemy: rewrite USB platform setup.
  MIPS: Alchemy: more base address cleanup

 arch/mips/alchemy/common/Makefile              |    2 +-
 arch/mips/alchemy/common/dma.c                 |   12 +-
 arch/mips/alchemy/common/platform.c            |  195 ++++++--------
 arch/mips/alchemy/common/power.c               |   42 ---
 arch/mips/alchemy/common/usb.c                 |  331 ++++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1200/platform.c  |   52 ++--
 arch/mips/alchemy/devboards/db1x00/platform.c  |   40 ++--
 arch/mips/alchemy/devboards/pb1100/platform.c  |   20 +-
 arch/mips/alchemy/devboards/pb1200/platform.c  |   42 ++--
 arch/mips/alchemy/devboards/pb1500/platform.c  |   22 +-
 arch/mips/alchemy/devboards/pb1550/platform.c  |   40 ++--
 arch/mips/alchemy/xxs1500/platform.c           |   12 +-
 arch/mips/include/asm/mach-au1x00/au1000.h     |  242 +++--------------
 arch/mips/include/asm/mach-au1x00/au1xxx_psc.h |   26 --
 arch/mips/include/asm/mach-db1x00/db1x00.h     |    8 +-
 arch/mips/include/asm/mach-pb1x00/pb1200.h     |    8 +-
 arch/mips/include/asm/mach-pb1x00/pb1550.h     |    8 +-
 drivers/usb/host/ehci-au1xxx.c                 |   77 +-----
 drivers/usb/host/ohci-au1xxx.c                 |  110 +-------
 19 files changed, 597 insertions(+), 692 deletions(-)
 create mode 100644 arch/mips/alchemy/common/usb.c

-- 
1.7.5.3
