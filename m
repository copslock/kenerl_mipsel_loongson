Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2009 20:15:53 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:61636 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493519AbZJGSP0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2009 20:15:26 +0200
Received: by ewy12 with SMTP id 12so10566863ewy.0
        for <multiple recipients>; Wed, 07 Oct 2009 11:15:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Cpm0WWLpEPEWkeJM2tXve3idRQTxBAQWPHrVLhgCrGg=;
        b=pLIUFGQm7RZF7Yz9yYW/J/y7olZ8+gRgbW7WHl4CHv9d2j1h5Nuf4tApqWROGyfi2C
         XSTuyq+O/AnMu+zTJWpHPAUkJRWkpMnoVYy595A92QW78SCl12gB5M8hdAu85Rs3Drld
         Z/n5qpIeoONPtKY6WMRL4N8Az1eZGgfRiZ8uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eKr1FgAdJM16gADFURfAub8GK8GI+mUNt6jjJ1FttF/Gvx2cVc5DQwwg8ArLeJAP1E
         KD39YoZ3bDmPP4Kr22lIykrBM/IaocHp9WdDZWAyf3Tct277RwGqzyKeU7FOHQ0AXujo
         6JaT5Fp927pOPpWEGxQRYr0mwaA+/WxKpqstY=
Received: by 10.216.87.75 with SMTP id x53mr80696wee.13.1254939317768;
        Wed, 07 Oct 2009 11:15:17 -0700 (PDT)
Received: from localhost.localdomain (p5496B5E8.dip.t-dialin.net [84.150.181.232])
        by mx.google.com with ESMTPS id f13sm94596gvd.21.2009.10.07.11.15.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 11:15:17 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH -queue 0/4] Alchemy: another round of IRQ changes
Date:	Wed,  7 Oct 2009 20:15:11 +0200
Message-Id: <1254939315-8158-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Here's another round of Alchemy IRQ changes, intended to be applied on
top of the alchemy pcmcia changes in Ralf's linux-queue.git tree.

Major theme is to stop the name-sharing of certain Alchemy interrupt
sources.  Some parts of the alchemy core code currently rely on
specially-named irq constants in order to save code (platform.c, and
time.c for instance);  however the au1000.h header is full of
compile-time checks for a certain CPU subtype.

Eventually I'd like to get rid of all CONFIG_SOC_AU1??? checks in
au1000.h altogether (for easier Au1300 integration);  preferably
also in the vast majority of the alchemy common code. But I'm not
really convinced any more that it is at all possible.

Patch overview:
#1  tries to get rid of the special case for the usb device interrupt,
    rather than adding #ifdefs for each cpu subtype with this
    particular usb device ip, i opted to use the hardware to do the
    prioritization.

    I'm not sure whether this really is equivalent to the previous
    solution since I neither have the hardware nor a driver for the
    Au1000 UDC.

#2  changes the rtcmatch2 (system timer) irq priority to high.
    not strictly related, but it fit into the irq upddate theme.

#3  re-introduces the alchemy cpu subtype detector, it's required
    by changes in #4.

#4  does the constant renaming: irq sources are prefixed with a
    cpu subtype string, and gpio int sources get the "_INT" postfix
    (they're interrupt sources, not gpio numbers after all).

Run-tested on the DB1200, and known to build for all db1x00/pb1x00,
xxs1500, mtx-1.

Please apply (and test if you have any of the other boards).
Thanks!
	Manuel Lauss


Manuel Lauss (4):
  Alchemy: remove USB_DEV_REQ_INT prioritization hack
  Alchemy: higher priority for system timer.
  Alchemy: simple cpu subtype detector
  Alchemy: Stop IRQ name sharing

 arch/mips/alchemy/common/dbdma.c                 |   61 ++-
 arch/mips/alchemy/common/dma.c                   |   36 +-
 arch/mips/alchemy/common/irq.c                   |  322 +++++-----
 arch/mips/alchemy/common/platform.c              |    8 +-
 arch/mips/alchemy/common/time.c                  |   35 +-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   64 ++-
 arch/mips/alchemy/devboards/db1x00/platform.c    |   52 +-
 arch/mips/alchemy/devboards/pb1000/board_setup.c |    2 +-
 arch/mips/alchemy/devboards/pb1100/board_setup.c |    8 +-
 arch/mips/alchemy/devboards/pb1100/platform.c    |    6 +-
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    4 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   20 +-
 arch/mips/alchemy/devboards/pb1500/platform.c    |    6 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   10 +-
 arch/mips/alchemy/devboards/pb1550/platform.c    |    8 +-
 arch/mips/alchemy/mtx-1/board_setup.c            |   26 +-
 arch/mips/alchemy/xxs1500/board_setup.c          |   24 +-
 arch/mips/include/asm/mach-au1x00/au1000.h       |  704 +++++++++++-----------
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h  |   76 +--
 19 files changed, 788 insertions(+), 684 deletions(-)
