Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2011 11:18:59 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:35603 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491144Ab1GHJSw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2011 11:18:52 +0200
Received: by fxd20 with SMTP id 20so1399533fxd.36
        for <multiple recipients>; Fri, 08 Jul 2011 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=WZvublSYLPiRlnCcZWhnnSced3gVTAFwfxq4YVzQqLo=;
        b=O5cxLEOaFTwSOih/drl0sTlh7ZNDGYRzr56CoLKAMfVI4bb7KQP9xjm3TffZhwNCMW
         9wgN05PBXDLwsVvSrSuTYmlkk/LIkkz1ni9X0Z66tmzBZzGgrxy/gCL0/a2lYm0HV17z
         CKxc2nJiH4RN1KfFOSJx5h2W2lZW0po7jorPs=
Received: by 10.223.75.138 with SMTP id y10mr2768895faj.36.1310116726932;
        Fri, 08 Jul 2011 02:18:46 -0700 (PDT)
Received: from localhost.localdomain (188-22-147-55.adsl.highway.telekom.at [188.22.147.55])
        by mx.google.com with ESMTPS id k26sm7260413fak.24.2011.07.08.02.18.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jul 2011 02:18:45 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 0/5] MIPS: Alchemy: misc updates
Date:   Fri,  8 Jul 2011 11:18:38 +0200
Message-Id: <1310116723-8632-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5978

[This is a resend of previous patches grouped together]

Misc. updates to various Alchemy parts:
#1: remove hardcoded MAC DMA base from the driver and pass it via
    platform resource information instead.
#2: include the Au1100 in au1000 suspend code
#3: centralize USB block control, to simplify the glues and as a
    preparatory step for Au1300 USB support
#4: do usb setup based on runtime cpu type detection, to get rid of
    a few per-subtype #defines.
#5: with USB out of the way, the rest of the per-subtype peripheral
    base addresses can be removed in favour of a single list.

All run-tested (except 1 and 2 due to lack of hardware) on
DB1200 and DB1300.
Please consider for 3.1.

Manuel Lauss (5):
  net: au1000_eth: pass MACDMA address through platform resource info.
  MIPS: Alchemy: include Au1100 in PM code.
  MIPS: Alchemy: abstract USB block control register access
  MIPS: Alchemy: rewrite USB platform setup.
  MIPS: Alchemy: more base address cleanup

 arch/mips/alchemy/common/Makefile              |    2 +-
 arch/mips/alchemy/common/dma.c                 |   12 +-
 arch/mips/alchemy/common/platform.c            |  225 +++++++---------
 arch/mips/alchemy/common/power.c               |   64 +----
 arch/mips/alchemy/common/usb.c                 |  337 ++++++++++++++++++++++++
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
 drivers/net/au1000_eth.c                       |   48 +++-
 drivers/net/au1000_eth.h                       |    2 +-
 drivers/usb/host/ehci-au1xxx.c                 |   77 +-----
 drivers/usb/host/ohci-au1xxx.c                 |  110 +-------
 21 files changed, 675 insertions(+), 722 deletions(-)
 create mode 100644 arch/mips/alchemy/common/usb.c

-- 
1.7.6
