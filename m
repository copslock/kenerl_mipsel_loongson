Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2009 13:11:30 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:48863 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023309AbZFFMKP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Jun 2009 13:10:15 +0100
Received: by bwz25 with SMTP id 25so2099679bwz.0
        for <multiple recipients>; Sat, 06 Jun 2009 05:10:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YyjbgjTyz3acaWQu5y7dI6L+F3fjTFf3hAnlAYcsNHs=;
        b=aeGIalO5EQ1XTs5OS3EqUd9T6ui1M+dEb5qZR9zfi+o8SXiDme2wUCbnkrQ3yegklq
         a8TacwaYd2rzO3cakN5es64xXUOybLGzJ6USJGBX940yF9GClCPUPn/aptmZQhQiKE9W
         AJXjU1nEU6ELRE+ts2p83NI0WbNQTPPtTI5fE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rD2jKNaKKRxeXbfrxgJiTZ/iHYDy2029fqekoRJse7w3YIuGrIE0YW5viNOanQVDAq
         1Bm9vM/YJxxJR6Cdgdxo7rZB2N1OKf2w8o5KspMySfQBflEgoL7JAw4Bm4aKf1o5x2U9
         PbRpWrKO+R3bdfp4ZDSk/s7lYqOEnIh9evme0=
Received: by 10.86.59.18 with SMTP id h18mr4917462fga.71.1244290208705;
        Sat, 06 Jun 2009 05:10:08 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id e11sm4489485fga.11.2009.06.06.05.10.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 05:10:08 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/5] Alchemy GPIO rewrite v7
Date:	Sat,  6 Jun 2009 14:09:53 +0200
Message-Id: <1244290198-27162-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Rewrite Alchemy GPIO support to be compatible with the Linux
GPIO framework, both with and without gpiolib.  For a list of
reasons, see blurb in patch #2.

Patches #3-#5 replace a few open-coded GPIO accesses in the board
files with calls to the new gpio functions.

Tested on DB1200 and a custom Au1200 platform.

History:
v7 - fix config variable evaluation bug in alchemy/Makefile
     renamed gpio-au1000.c to gpiolib-au1000.c because it's only supposed
      to be built when gpiolib is used.
     lots of build- and bugfixes in patches #3, #5
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
 arch/mips/alchemy/common/Makefile                |    9 +-
 arch/mips/alchemy/common/gpio.c                  |  201 -------
 arch/mips/alchemy/common/gpiolib-au1000.c        |  130 +++++
 arch/mips/alchemy/common/reset.c                 |    5 +-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   12 +-
 arch/mips/alchemy/devboards/pb1000/board_setup.c |   10 +-
 arch/mips/alchemy/devboards/pb1100/board_setup.c |    3 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   10 +-
 arch/mips/alchemy/devboards/pm.c                 |    3 +-
 arch/mips/alchemy/mtx-1/board_setup.c            |   24 +-
 arch/mips/alchemy/xxs1500/board_setup.c          |   21 +-
 arch/mips/include/asm/mach-au1x00/au1000_gpio.h  |   56 --
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h  |  604 ++++++++++++++++++++++
 arch/mips/include/asm/mach-au1x00/gpio.h         |   35 +-
 16 files changed, 821 insertions(+), 326 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/gpio.c
 create mode 100644 arch/mips/alchemy/common/gpiolib-au1000.c
 delete mode 100644 arch/mips/include/asm/mach-au1x00/au1000_gpio.h
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1000.h
