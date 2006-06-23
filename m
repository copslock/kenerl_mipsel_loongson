Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 10:57:19 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:2529 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133455AbWFWJ5J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 10:57:09 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id E9587C03E;
	Fri, 23 Jun 2006 11:56:58 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id C2ECB1BC07E;
	Fri, 23 Jun 2006 11:57:00 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 2045A1A18AE;
	Fri, 23 Jun 2006 11:57:01 +0200 (CEST)
Date:	Fri, 23 Jun 2006 11:57:03 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [patch 0/8] au1xxx: make linux-mips more useful for au1200 users
Message-ID: <20060623095703.GA30980@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

Hi Ralf, list!

I would like the following patches merged:
[patch 1/8] au1xxx: psc fixes + add au1200 adresses
[patch 2/8] au1xxx: I2C fixes
[patch 3/8] au1xxx: I2C support for au1200
[patch 4/8] au1xxx: dbdma, no sleeping under spin_lock
[patch 5/8] au1xxx: export dbdma functions
[patch 6/8] au1xxx: oss sound support for au1200
[patch 7/8] au1xxx: compile fixes for OHCI for au1200
[patch 8/8] au1xxx: pcmcia: fix __init called from non-init

You might have a problem with 7/8, others should be fine.

Oh... and the diffstat:
 arch/mips/au1000/common/dbdma.c           |    6 +++++-
 drivers/i2c/busses/Kconfig                |    6 +++---
 drivers/i2c/busses/i2c-au1550.c           |   18 ++++++++++++------
 drivers/pcmcia/au1000_db1x00.c            |    2 +-
 drivers/usb/host/ohci-au1xxx.c            |    6 ++++--
 include/asm-mips/mach-au1x00/au1xxx_psc.h |    9 +++++++--
 sound/oss/Kconfig                         |    5 +++--
 sound/oss/au1550_ac97.c                   |    2 ++
 8 files changed, 37 insertions(+), 17 deletions(-)


Comments, flames?


	Domen
