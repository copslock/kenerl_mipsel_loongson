Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 17:18:30 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:49400 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021958AbZFCQSX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 17:18:23 +0100
Received: by fxm23 with SMTP id 23so114368fxm.0
        for <multiple recipients>; Wed, 03 Jun 2009 09:18:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=E3vPhhu+trF5Om9wV6hJgzmgn+L1lOg0SURl2EAo5AU=;
        b=TTS6SuaxZJfcJ+mF8lEfGvHUSVaFDfIuKeatNiISA+9KcYwEFOCr4mG64dkF8qzLyH
         OuPCkqfSCrQrJgdO+wroIGJj6rCgYiKcRu3kJSWW4y3cTWRkAMu7yFMjAa6bCDugQYdo
         5/L4WiZG5FYeTHMjDQHuBwXKe+YbPst0fO8iY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YTAkg2NdcOnUP8nv6meAqSdHJsCp2wkY9OIFX7uuido1OWqCUSrTEfPGAA8ntPkSyX
         xKKkDzyW85ItyzTTbjkgDOeq5m0RwZnvsN6sW0NsuMXw3m+kHaux1deokocJXwR9G4jN
         vUl+q7wH/4pNJNt4W/XNvNALWZ9s1iuDHyU3k=
Received: by 10.103.182.3 with SMTP id j3mr722757mup.115.1244045897015;
        Wed, 03 Jun 2009 09:18:17 -0700 (PDT)
Received: from localhost.localdomain (p5496DB58.dip.t-dialin.net [84.150.219.88])
        by mx.google.com with ESMTPS id u26sm37723mug.22.2009.06.03.09.18.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 09:18:16 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/5] Alchemy GPIO rewrite v6
Date:	Wed,  3 Jun 2009 18:18:03 +0200
Message-Id: <1244045888-16259-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Rewrite Alchemy GPIO support to be compatible with the Linux
GPIO framework, both with and without gpiolib.  For a list of
justifications, see blurb in patch #2.
Patches #3-#5 replace a few open-coded GPIO accesses in the board
files with calls to the new gpio functions.

Tested on DB1200 and a custom Au1200 platform.

v6 - renamed gpio.[ch] to gpio-au1000.[ch], since this code only affects
     pre-Au1300 chips.  Should make integration of Au1300 GPIO a bit
     easier.
v5 - fix gpio1 bug in inlined gpio_get_value()
v4 - GPIO2 shared interrupt management, styling.
v3 - fixed thinko in alchemy_gpio2_set_value (16->32 bit)
v2 - added gpio_to_irq and irq_to_gpio, some renaming.

Manuel Lauss (5):
  Alchemy: remove unused au1000_gpio.h header
  Alchemy: rewrite GPIO support.
  Alchemy: mtx-1: use linux gpio api.
  Alchemy: xxs1500: use linux gpio api.
  Alchemy: devboards: convert to gpio calls.

 arch/mips/Makefile                               |    5 +-
 arch/mips/alchemy/Kconfig                        |   19 +-
 arch/mips/alchemy/common/Makefile                |   11 +-
 arch/mips/alchemy/common/gpio-au1000.c           |  130 +++++
 arch/mips/alchemy/common/gpio.c                  |  201 -------
 arch/mips/alchemy/common/reset.c                 |    5 +-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |    8 +-
 arch/mips/alchemy/devboards/pb1000/board_setup.c |   10 +-
 arch/mips/alchemy/devboards/pb1100/board_setup.c |    3 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   10 +-
 arch/mips/alchemy/devboards/pm.c                 |    2 +-
 arch/mips/alchemy/mtx-1/board_setup.c            |   24 +-
 arch/mips/alchemy/xxs1500/board_setup.c          |   21 +-
 arch/mips/include/asm/mach-au1x00/au1000_gpio.h  |   56 --
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h  |  604 ++++++++++++++++++++++
 arch/mips/include/asm/mach-au1x00/gpio.h         |   35 +-
 16 files changed, 818 insertions(+), 326 deletions(-)
 create mode 100644 arch/mips/alchemy/common/gpio-au1000.c
 delete mode 100644 arch/mips/alchemy/common/gpio.c
 delete mode 100644 arch/mips/include/asm/mach-au1x00/au1000_gpio.h
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1000.h
