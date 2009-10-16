Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 08:17:51 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:63187 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492984AbZJPGRo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 08:17:44 +0200
Received: by pxi17 with SMTP id 17so681893pxi.21
        for <multiple recipients>; Thu, 15 Oct 2009 23:17:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=nash+YJjyOdm0O9Fp+Vj/3Du2njW34TTEwBUz4m/OC4=;
        b=gRTnVfesiEHzzlqtfOTLzkjDTbF/s5MHeObuW1ZvhAClGynV5LFMYptMmcL962kYSe
         f9VOOx1lxKnGwUOKQCSYO8Trpsa8sAkG2tcFi3TIXHBzVgaV7YDGWz9wuETtPtwtnnrD
         AdnKf6Pqmd1ljhwU0XE2i3FJXlObrRe+3TWLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wLfipSV+4gsyKIug8DId+Haw4DnA3MwAF3YTDn5Q1EwACUBV9GRVb3ybvpblQiiWwQ
         GrDnPsbFkkReAtI4gThAP8+pv6S35IrlSvV5Tho+smnhob/wh3FaqFT1AEykB1nNC+90
         CxKq+8U2xSUzVZSGucr0vVgQTNVbup0QtvcxM=
Received: by 10.114.69.18 with SMTP id r18mr1206816waa.209.1255673854358;
        Thu, 15 Oct 2009 23:17:34 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm591698pzk.3.2009.10.15.23.17.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 23:17:33 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 0/7] [loongson] A few Cleanups for fuloong2e
Date:	Fri, 16 Oct 2009 14:17:13 +0800
Message-Id: <cover.1255672832.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patchset cleans up the fuloong2e support and do some necessary preparation
for the coming loongson2f family machines' support.

Wu Zhangjin (7):
  [loongson] fuloong2e: Cleanup the Kconfig
  [loongson] mem.c: Register reserved memory pages
  [loongson] early_printk: fix the variable type of uart_base
  [loongosn] add a new serial port debug function
  [loongson] add serial port support
  [loongson] remove reference from bonito64
  [loongson] fuloong2e: update config file

 arch/mips/configs/fuloong2e_defconfig          |   93 ++++++++----
 arch/mips/include/asm/mach-loongson/dbg.h      |   17 +++
 arch/mips/include/asm/mach-loongson/loongson.h |  182 ++++++++++++++++++++++--
 arch/mips/include/asm/mach-loongson/machine.h  |    2 +-
 arch/mips/include/asm/mach-loongson/pci.h      |    6 +-
 arch/mips/include/asm/mips-boards/bonito64.h   |    5 -
 arch/mips/loongson/Kconfig                     |   52 ++++----
 arch/mips/loongson/common/Makefile             |    7 +-
 arch/mips/loongson/common/bonito-irq.c         |    8 +-
 arch/mips/loongson/common/dbg.c                |   34 +++++
 arch/mips/loongson/common/early_printk.c       |   10 +-
 arch/mips/loongson/common/init.c               |    2 +-
 arch/mips/loongson/common/irq.c                |   12 +-
 arch/mips/loongson/common/mem.c                |    8 +
 arch/mips/loongson/common/pci.c                |   12 +-
 arch/mips/loongson/common/reset.c              |    2 +-
 arch/mips/loongson/common/serial.c             |   71 +++++++++
 arch/mips/loongson/fuloong-2e/irq.c            |    4 +-
 arch/mips/loongson/fuloong-2e/reset.c          |    4 +-
 arch/mips/pci/Makefile                         |    2 +-
 arch/mips/pci/fixup-fuloong2e.c                |    5 +-
 arch/mips/pci/ops-bonito64.c                   |    7 -
 arch/mips/pci/ops-fuloong2e.c                  |  160 +++++++++++++++++++++
 23 files changed, 586 insertions(+), 119 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/dbg.h
 create mode 100644 arch/mips/loongson/common/dbg.c
 create mode 100644 arch/mips/loongson/common/serial.c
 create mode 100644 arch/mips/pci/ops-fuloong2e.c
