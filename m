Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 23:35:02 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55009 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903693Ab2EKVe6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 23:34:58 +0200
Received: by pbbrq13 with SMTP id rq13so4299231pbb.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=2y5JOHEBUNo5USfmK4ohiBESGo70CFV3+UtlD6sM4Bw=;
        b=iAJCsnvn+6GRrfVVUlsx/yWycolFtP0nPKeo+Yah7Z1DcfhBzdyszgLfIqBv+d0F/W
         p6+3N75SQOiPnWiqZeUq4ONXzM/0qKHSUjOp3gLn9kX2K+h3O0ssKh3UXMoc5EUgnG3h
         5077N+yUfWiUT7BNSJXv6IK2lsPpsKbyw65Qmnk8UV+uZ8PXpMOAk49JO52F2nBKQI3s
         L7aIg+CTtR+fBpq0QfwEJbluvtKlT6NCGpCgVEPumn58ixVX7Ve0z0AoAMJA8rr/uWRf
         7hBQg1GBg/YB8gVWPi38vaJ5B7MCWckbuNpCdCAi+/p4G8OsS7/dEurfsilJ301ddoOP
         RJ/g==
Received: by 10.68.238.4 with SMTP id vg4mr10556213pbc.147.1336772091755;
        Fri, 11 May 2012 14:34:51 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ov3sm13885902pbb.35.2012.05.11.14.34.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 14:34:51 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4BLYnr7017282;
        Fri, 11 May 2012 14:34:49 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4BLYmLM017280;
        Fri, 11 May 2012 14:34:48 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] MIPS/spi: New driver for SPI master controller for OCTEON SOCs.
Date:   Fri, 11 May 2012 14:34:44 -0700
Message-Id: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Several members of the OCTEON family have on-chips SPI master
controller hardware, so here is a driver for it.

I split the register definitions out to a separate patch so that they
live with all the other similar files for other OCTEON hardware blocks
in arch/mips/include/asm/octeon.  This does leave the question of who
should merge these.  I don't have a preference, could be Ralf's
Linux/MIPS tree or via the SPI maintainers.

Tested by driving an at25 eeprom.

David Daney (2):
  MIPS: OCTEON: Add register definitions for SPI host hardware.
  spi: Add SPI master controller for OCTEON SOCs.

 .../devicetree/bindings/spi/spi-octeon.txt         |   33 ++
 arch/mips/include/asm/octeon/cvmx-mpi-defs.h       |  328 +++++++++++++++++
 drivers/spi/Kconfig                                |    7 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-octeon.c                           |  369 ++++++++++++++++++++
 5 files changed, 738 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-octeon.txt
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mpi-defs.h
 create mode 100644 drivers/spi/spi-octeon.c

-- 
1.7.2.3
