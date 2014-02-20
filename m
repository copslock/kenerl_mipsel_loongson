Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 14:59:41 +0100 (CET)
Received: from mail-ea0-f174.google.com ([209.85.215.174]:60709 "EHLO
        mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6871402AbaBTN7ja3kvh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Feb 2014 14:59:39 +0100
Received: by mail-ea0-f174.google.com with SMTP id m10so688052eaj.19
        for <linux-mips@linux-mips.org>; Thu, 20 Feb 2014 05:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Izu+iptr4n/3U5eiaT1WJz+gdrw/AiJo/VFUpkfenjM=;
        b=WXX3W+NlvohyJpd8vCChjJQwqQkn7MdFPjcyjFo+U71XauZiopvuk8T159dpLmNQ4H
         9mSsVIhWGsT8KqXjb5a6USfWKGrxe3DwpmBGVm2pMnVdGfBzP+Jexdonc83DLdrJyVzk
         NaVQaSrjD0mVqjmXApM0wM/woEXk9i8+oR0CEl88P7GTBo43lgDTbLhIrQSCOqIi8E4N
         mrwjl2lQTX9lZRclASh559VMv1ZjAhnTm2lDPTgwuoNC4ehFHU4i2b1RGDn1n9YxVz5O
         U0uFlGedN9EjwDhxtxWLXC15/53ITOH6YcEeUHIBjqj4nxQ62dojQEbARy9GSsP2kKmt
         d0ag==
X-Received: by 10.14.110.198 with SMTP id u46mr2135648eeg.20.1392904773381;
        Thu, 20 Feb 2014 05:59:33 -0800 (PST)
Received: from localhost.localdomain (p54B231AB.dip0.t-ipconnect.de. [84.178.49.171])
        by mx.google.com with ESMTPSA id n41sm14102379eeg.16.2014.02.20.05.59.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2014 05:59:32 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2 0/3] MIPS: Alchemy: single kernel for all devboards
Date:   Thu, 20 Feb 2014 14:59:21 +0100
Message-Id: <1392904764-5432-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.5.5
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

This patchset removes the last hurdles to supporting all DB/PB Develoboards
in a single kernel image.   The main issue is that on earlier chips
(Au1000, Au1500, Au1100) some peripherals, notably the USB blocks, aren't
fully dma coherent and need manual cache massaging to work properly.
For these parts DMA_NONCOHERENT is used.
Newer variants starting with the Au1550 work fine without any additional
software intervention and use DMA_COHERENT by default.

The first patch extends the already existing DMA_MAYBE_COHERENT logic to
also cover the parts which are already compiled when DMA_NONCOHERENT is
enabled.  The second patch then uses the "coherentio" variable which
DMA_MAYBE_COHERENT exports and sets it based on CPU subtype.
The third patch finally unifies support for all Alchemy devboards.

I'm not really sure if patch #1 is even the correct way to do it; however
based on my understanding of what DMA_MAYBE_COHERENT is supposed to do I
actually thought that it's a logical extension.  But I'm not sure and
don't have a MALTA board to test it on.  Hence the RFC.

v2: new defconfig replacing two oobsolete ones, some function renaming

Thanks,
        Manuel Lauss


Manuel Lauss (3):
  MIPS: extend DMA_MAYBE_COHERENT logic to DMA_NONCOHERENT use
  MIPS: Alchemy: determine cohereny at runtime based on cpu type
  MIPS: Alchemy: unify Devboard support.

 arch/mips/Kconfig                    |   1 +
 arch/mips/alchemy/Kconfig            |  22 +-
 arch/mips/alchemy/Platform           |  16 +-
 arch/mips/alchemy/common/setup.c     |  10 +
 arch/mips/alchemy/devboards/Makefile |   4 +-
 arch/mips/alchemy/devboards/db1000.c |  47 +---
 arch/mips/alchemy/devboards/db1200.c |   9 +
 arch/mips/alchemy/devboards/db1235.c |  94 --------
 arch/mips/alchemy/devboards/db1300.c |   6 +-
 arch/mips/alchemy/devboards/db1550.c |  10 +-
 arch/mips/alchemy/devboards/db1xxx.c | 121 ++++++++++
 arch/mips/configs/db1000_defconfig   | 359 -----------------------------
 arch/mips/configs/db1235_defconfig   | 434 -----------------------------------
 arch/mips/configs/db1xxx_defconfig   | 248 ++++++++++++++++++++
 arch/mips/include/asm/io.h           |   4 +-
 arch/mips/mm/c-r4k.c                 |   6 +-
 arch/mips/mm/cache.c                 |   4 +-
 arch/mips/pci/pci-alchemy.c          |   5 +-
 drivers/spi/spi-au1550.c             |   9 +
 19 files changed, 445 insertions(+), 964 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/db1235.c
 create mode 100644 arch/mips/alchemy/devboards/db1xxx.c
 delete mode 100644 arch/mips/configs/db1000_defconfig
 delete mode 100644 arch/mips/configs/db1235_defconfig
 create mode 100644 arch/mips/configs/db1xxx_defconfig

-- 
1.8.5.5
