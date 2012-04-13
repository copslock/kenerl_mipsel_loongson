Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2012 02:11:24 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:37984 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903723Ab2DMAKg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2012 02:10:36 +0200
Received: by obhx4 with SMTP id x4so4183552obh.36
        for <multiple recipients>; Thu, 12 Apr 2012 17:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=bC4GJP9mmGo2NYu1OQTbSJSb+b5LsEbu1xHlNlCPJao=;
        b=BrB2wzcK4eu6WGmJpe3ztQ1Dp1HxHuv5JNszAjbl4dwz8b+5oTHeqGII2Bg9Aw/w8F
         HHin60lMLn6k1aQGltJY5lzrVdYxan8JXyZw06BERwrl+JttN77iEAv8nfwtwdj6HRes
         UyFXOq7ACq6vNVu60wMchkNHQEpmioe41fpiDiGa4L5fpWGesV4hoeIFOFq3KMCW79Gz
         YfH2N54/SPGhN82sLO++jgDEs6wdXD0rVwUobrja1a6L7DAltC2VqPy5dbTUKMJXOH/N
         wiAZfHfic/8VwG2gUHvquWM5SihLbR2YIJvW89rzBANJDC+wjxMkDSDlS6UdOh5B5z0K
         wG5A==
Received: by 10.60.7.196 with SMTP id l4mr287475oea.8.1334275830272;
        Thu, 12 Apr 2012 17:10:30 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id h2sm8478985obn.20.2012.04.12.17.10.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 17:10:29 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3D0APbq007824;
        Thu, 12 Apr 2012 17:10:25 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3D0AMEI007823;
        Thu, 12 Apr 2012 17:10:22 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>, ralf@linux-mips.org,
        linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@stericsson.com>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] gpio/MIPS/OCTEON: Add GPIO support for OCTEON.
Date:   Thu, 12 Apr 2012 17:10:18 -0700
Message-Id: <1334275820-7791-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

There are two patches needed to add OCTEON GPIO support:

1) Select ARCH_REQUIRE_GPIOLIB.  This allows standard I2C GPIO
expanders to function, as well as being a prerequisite for the driver
for the on-chip pins.

2) The on-chip pin driver.

I'm not sure the best way to merge these, they are part MIPS and part
GPIO.  Via either maintainer is fine by me.

Thanks,


David Daney (2):
  MIPS: OCTEON: Select ARCH_REQUIRE_GPIOLIB
  gpio/MIPS/OCTEON: Add a driver for OCTEON's on-chip GPIO pins.

 arch/mips/Kconfig                               |    1 +
 arch/mips/include/asm/mach-cavium-octeon/gpio.h |   21 +++
 drivers/gpio/Kconfig                            |    8 +
 drivers/gpio/Makefile                           |    1 +
 drivers/gpio/gpio-octeon.c                      |  166 +++++++++++++++++++++++
 5 files changed, 197 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/gpio.h
 create mode 100644 drivers/gpio/gpio-octeon.c

-- 
1.7.2.3
