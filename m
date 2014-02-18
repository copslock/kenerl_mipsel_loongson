Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2014 19:39:13 +0100 (CET)
Received: from mail-ea0-f169.google.com ([209.85.215.169]:53991 "EHLO
        mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823911AbaBRSjHdr7pj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Feb 2014 19:39:07 +0100
Received: by mail-ea0-f169.google.com with SMTP id h10so8188358eak.28
        for <linux-mips@linux-mips.org>; Tue, 18 Feb 2014 10:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sokHbN1W/dQk5FGhTIQ6yIWZJuiZ2HKEtMKrj8xClPU=;
        b=WiM8sQPvq4O7f7vKaM4sxBlX2T3tncWTar6rJ9NEoS8481Nv+5JknqHxYtEb+9I5p4
         tNJX+eA/juJ76L/m6GWn+ENpaqRS++5TumWm8FT9L61fpUVfSi8qrcBKiToqwGjSKskm
         orMI3ce0OznTNQa1Yb5B7jZOezOgc60xmbRZ0DVaYMpmiSTIOX6j7mxJH694OQiDf45+
         +aj0AuwzeOPZZKw3DCA/Jk7yYp534Fo9+HLLUIicJM35rj/nJ317YE0gwf8VBlldu/xY
         U6xg5ppf857ck2KLqI2ZEqE1L5XiEYa5KpjvVn+yXarD85oZcrgQqxtsIedVtuh0ta92
         O1Yg==
X-Received: by 10.15.23.194 with SMTP id h42mr35190206eeu.32.1392748742252;
        Tue, 18 Feb 2014 10:39:02 -0800 (PST)
Received: from localhost.localdomain (p54B21680.dip0.t-ipconnect.de. [84.178.22.128])
        by mx.google.com with ESMTPSA id j42sm73785779eep.21.2014.02.18.10.39.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2014 10:39:01 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 0/3] MIPS: Alchemy: single kernel for all devboards
Date:   Tue, 18 Feb 2014 19:38:52 +0100
Message-Id: <1392748735-16745-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.5.5
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39335
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

Thanks,
        Manuel Lauss

Manuel Lauss (3):
  MIPS: extend DMA_MAYBE_COHERENT logic to DMA_NONCOHERENT use
  MIPS: Alchemy: determine cohereny at runtime based on cpu type
  MIPS: Alchemy: unify Devboard support.

 arch/mips/Kconfig                    |   1 +
 arch/mips/alchemy/Kconfig            |  22 ++-----
 arch/mips/alchemy/Platform           |  16 ++---
 arch/mips/alchemy/common/setup.c     |  10 +++
 arch/mips/alchemy/devboards/Makefile |   4 +-
 arch/mips/alchemy/devboards/db1000.c |  47 ++++----------
 arch/mips/alchemy/devboards/db1200.c |   9 +++
 arch/mips/alchemy/devboards/db1235.c |  94 ---------------------------
 arch/mips/alchemy/devboards/db1300.c |   6 +-
 arch/mips/alchemy/devboards/db1550.c |  10 ++-
 arch/mips/alchemy/devboards/db1xxx.c | 121 +++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/io.h           |   4 +-
 arch/mips/mm/c-r4k.c                 |   6 +-
 arch/mips/mm/cache.c                 |   4 +-
 arch/mips/pci/pci-alchemy.c          |   5 +-
 drivers/spi/spi-au1550.c             |   9 +++
 16 files changed, 197 insertions(+), 171 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/db1235.c
 create mode 100644 arch/mips/alchemy/devboards/db1xxx.c

-- 
1.8.5.5
