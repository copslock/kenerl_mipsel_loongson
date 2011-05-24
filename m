Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 10:02:07 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:56567 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491161Ab1EXICC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2011 10:02:02 +0200
Received: by fxm14 with SMTP id 14so5835764fxm.36
        for <multiple recipients>; Tue, 24 May 2011 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=0sTwJL3U03GV4AzS0C6BOcg8ba0wvXGPIxl36eaUCJg=;
        b=IXRnnsdQEZjm866Rk0fYh6e5sjPPc6NtLeSENcLh2QuEbNIN34DY71FoCKiOFTrwdy
         DP6OsYpevLbeNg2BObaKii8l1ZCQaRWS69kw5ecinsPx8BnMPvEh4YGUOCACnB6Jjkok
         aHDJJf3f9EB7A9P/q/rCRnr0XNs3dzRdBK/8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aeT9M8t7EAKQu/OUxOqeOjs9+a6yUHhBmYfZjYm/LY5GX2pmp8jjU+UcGTH2V/xNgO
         mO0x5SI10Ubry6jprLxYjp7pMieBqIC0WV7zCx+XnWMSlIrqF1UIxycNKSjg1GzM2faj
         yXc2wJMoImEowkpWhX5qzcHLyl0elfWT+h84k=
Received: by 10.223.62.146 with SMTP id x18mr397111fah.54.1306224116752;
        Tue, 24 May 2011 01:01:56 -0700 (PDT)
Received: from localhost.localdomain (178-191-7-145.adsl.highway.telekom.at [178.191.7.145])
        by mx.google.com with ESMTPS id r13sm2605211fax.8.2011.05.24.01.01.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 01:01:55 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 0/3] MIPS: Alchemy: USB updates and more cleanups
Date:   Tue, 24 May 2011 10:01:48 +0200
Message-Id: <1306224111-1478-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

These 3 patches are part of the series Ralf applied to be queued for
2.6.40, but at the time they didn't apply because of patch which
now went in through the USB tree.

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

If possible, please consider for 2.6.40!

Thanks,
     Manuel Lauss

Manuel Lauss (3):
  MIPS: Alchemy: abstract USB block control register access
  MIPS: Alchemy: rewrite USB platform setup.
  MIPS: Alchemy: more base address cleanup

 arch/mips/alchemy/common/Makefile              |    2 +-
 arch/mips/alchemy/common/dma.c                 |   12 +-
 arch/mips/alchemy/common/platform.c            |  195 ++++++--------
 arch/mips/alchemy/common/power.c               |   42 ---
 arch/mips/alchemy/common/usb.c                 |  345 ++++++++++++++++++++++++
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
 19 files changed, 611 insertions(+), 692 deletions(-)
 create mode 100644 arch/mips/alchemy/common/usb.c

-- 
1.7.5.rc3
