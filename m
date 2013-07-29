Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jul 2013 23:30:08 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:57020 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831317Ab3G2V30ch1ML (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jul 2013 23:29:26 +0200
Received: by mail-pd0-f176.google.com with SMTP id q10so2739593pdj.7
        for <multiple recipients>; Mon, 29 Jul 2013 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=h6rIvBVU3qfh+J/PJpKR87KZm0Quzlto578o85ZR9+I=;
        b=I5imQztcqtTDfMyJ4CqSC67G+ZiMMesys9couip9WIvZgzOAO2t3vXDixMeJUY8Vgn
         3CTIi9djJaGxem7nsN7tO7pQFvGxxbk34ojs4kBpYIcz0m++q4bvaIRKMt+Z9nnL7g96
         FJ3oAWA/57PORH6yoYO2IDWkC7Ioa333v387t4TD5zNUqNBU7kbfFraXDrTjjURpunEk
         OJLZlG3mYPpl6EQ6i4cHQiybPs6YrtzvBvogXnRMIYDsOovbjLd1D2sH0tpKTiZO2zqT
         JzqK2XBQjGXMQ8Z4d5tIa6BVPNTi1OmGDInSx7355nVBtLNycz5Y4rvczm3GH3WUUrT+
         xnXw==
X-Received: by 10.68.198.101 with SMTP id jb5mr53084007pbc.127.1375133359581;
        Mon, 29 Jul 2013 14:29:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id r7sm22758610pao.18.2013.07.29.14.29.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 14:29:17 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r6TLTF7o018863;
        Mon, 29 Jul 2013 14:29:15 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r6TLTEWb018862;
        Mon, 29 Jul 2013 14:29:14 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/2] OCTEON GPIO support.
Date:   Mon, 29 Jul 2013 14:29:08 -0700
Message-Id: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The Cavium, OCTEON is a MIPS based SoC.  Here we add support for its
on-chip GPIO lines.

Changes from v1: Cleaned up variable names, messages and added some
comments as suggested by Linus Walleij.

The second patch depends on the first, but is in code maintained by
Ralf.  It may be best to mrege both of these together, perhaps from
the GPIO tree, with Ralf's Acked-by.

David Daney (2):
  MIPS: OCTEON: Select ARCH_REQUIRE_GPIOLIB
  gpio MIPS/OCTEON: Add a driver for OCTEON's on-chip GPIO pins.

 arch/mips/Kconfig                               |   1 +
 arch/mips/include/asm/mach-cavium-octeon/gpio.h |  21 ++++
 drivers/gpio/Kconfig                            |   8 ++
 drivers/gpio/Makefile                           |   1 +
 drivers/gpio/gpio-octeon.c                      | 157 ++++++++++++++++++++++++
 5 files changed, 188 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/gpio.h
 create mode 100644 drivers/gpio/gpio-octeon.c

-- 
1.7.11.7
