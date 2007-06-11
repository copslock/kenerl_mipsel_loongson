Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2007 14:10:20 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.168]:16292 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20024015AbXFKNKB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Jun 2007 14:10:01 +0100
Received: by ug-out-1314.google.com with SMTP id m3so1568807ugc
        for <linux-mips@linux-mips.org>; Mon, 11 Jun 2007 06:08:58 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        b=i226MN5HjnxBWY7RMvf++jbc94XzR+2LPNC5uMjpotbNu+ebWJFZC9nTHjjnO/iaN5fHa2xIvwSoj8F1SPa68DseImsGcCksv1xnx5GHwvTwS40yS13yjTJVEELoi4wGUlhjSs/tDD21IQihveqgP5UdzA20atBZbPABstUQ1j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=Leu79fyTFfaUGSbh7um9aWHHgJcu9GBg/MJbUPqfiRwn/T2kNsXKPGrO5ZTncQQGkbXr+A3xmaFu+AE4CaDFjUl8eD3t8No+HlLMhAHBOJH8/WPR8EjEhCkrBYRCpzef4kj/1uTFr4CCnJhhqzPKWnIyX/9ept9acY0s8l7vBwo=
Received: by 10.82.112.3 with SMTP id k3mr10874534buc.1181567338466;
        Mon, 11 Jun 2007 06:08:58 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id c25sm13861088ika.2007.06.11.06.08.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jun 2007 06:08:54 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 0623923F76F; Mon, 11 Jun 2007 15:08:55 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Remove obsolete board support
Date:	Mon, 11 Jun 2007 15:08:52 +0200
Message-Id: <11815673353523-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.2.1
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patchset finishes to remove deprecated board support.

It should simplify a bit the hrtimer migration work.

Please consider,

		Franck

---

 arch/mips/Kconfig                           |   66 --
 arch/mips/Makefile                          |   31 -
 arch/mips/configs/atlas_defconfig           | 1481 ---------------------------
 arch/mips/configs/ocelot_c_defconfig        |  982 ------------------
 arch/mips/configs/sead_defconfig            |  651 ------------
 arch/mips/mips-boards/atlas/Makefile        |   20 -
 arch/mips/mips-boards/atlas/atlas_gdb.c     |   97 --
 arch/mips/mips-boards/atlas/atlas_int.c     |  271 -----
 arch/mips/mips-boards/atlas/atlas_setup.c   |   92 --
 arch/mips/mips-boards/generic/console.c     |   22 -
 arch/mips/mips-boards/generic/init.c        |   22 +-
 arch/mips/mips-boards/generic/reset.c       |   20 -
 arch/mips/mips-boards/generic/time.c        |   16 +-
 arch/mips/mips-boards/sead/Makefile         |   26 -
 arch/mips/mips-boards/sead/sead_int.c       |  117 ---
 arch/mips/mips-boards/sead/sead_setup.c     |   81 --
 arch/mips/momentum/ocelot_c/Makefile        |    8 -
 arch/mips/momentum/ocelot_c/cpci-irq.c      |  100 --
 arch/mips/momentum/ocelot_c/dbg_io.c        |  121 ---
 arch/mips/momentum/ocelot_c/irq.c           |  107 --
 arch/mips/momentum/ocelot_c/ocelot_c_fpga.h |   61 --
 arch/mips/momentum/ocelot_c/platform.c      |  183 ----
 arch/mips/momentum/ocelot_c/prom.c          |  183 ----
 arch/mips/momentum/ocelot_c/reset.c         |   58 --
 arch/mips/momentum/ocelot_c/setup.c         |  362 -------
 arch/mips/momentum/ocelot_c/uart-irq.c      |   91 --
 arch/mips/pci/Makefile                      |    2 -
 arch/mips/pci/fixup-atlas.c                 |   91 --
 arch/mips/pci/fixup-ocelot-c.c              |   41 -
 arch/mips/pci/pci-ocelot-c.c                |  145 ---
 include/asm-mips/bootinfo.h                 |    2 +-
 include/asm-mips/mach-atlas/mc146818rtc.h   |   60 --
 include/asm-mips/mips-boards/atlas.h        |   80 --
 include/asm-mips/mips-boards/atlasint.h     |  115 ---
 include/asm-mips/mips-boards/generic.h      |   10 +-
 include/asm-mips/mips-boards/sead.h         |   36 -
 include/asm-mips/mips-boards/seadint.h      |   35 -
 include/asm-mips/serial.h                   |   26 -
 include/asm-mips/war.h                      |    6 +-
 39 files changed, 11 insertions(+), 5907 deletions(-)
 delete mode 100644 arch/mips/configs/atlas_defconfig
 delete mode 100644 arch/mips/configs/ocelot_c_defconfig
 delete mode 100644 arch/mips/configs/sead_defconfig
 delete mode 100644 arch/mips/mips-boards/atlas/Makefile
 delete mode 100644 arch/mips/mips-boards/atlas/atlas_gdb.c
 delete mode 100644 arch/mips/mips-boards/atlas/atlas_int.c
 delete mode 100644 arch/mips/mips-boards/atlas/atlas_setup.c
 delete mode 100644 arch/mips/mips-boards/sead/Makefile
 delete mode 100644 arch/mips/mips-boards/sead/sead_int.c
 delete mode 100644 arch/mips/mips-boards/sead/sead_setup.c
 delete mode 100644 arch/mips/momentum/ocelot_c/Makefile
 delete mode 100644 arch/mips/momentum/ocelot_c/cpci-irq.c
 delete mode 100644 arch/mips/momentum/ocelot_c/dbg_io.c
 delete mode 100644 arch/mips/momentum/ocelot_c/irq.c
 delete mode 100644 arch/mips/momentum/ocelot_c/ocelot_c_fpga.h
 delete mode 100644 arch/mips/momentum/ocelot_c/platform.c
 delete mode 100644 arch/mips/momentum/ocelot_c/prom.c
 delete mode 100644 arch/mips/momentum/ocelot_c/reset.c
 delete mode 100644 arch/mips/momentum/ocelot_c/setup.c
 delete mode 100644 arch/mips/momentum/ocelot_c/uart-irq.c
 delete mode 100644 arch/mips/pci/fixup-atlas.c
 delete mode 100644 arch/mips/pci/fixup-ocelot-c.c
 delete mode 100644 arch/mips/pci/pci-ocelot-c.c
 delete mode 100644 include/asm-mips/mach-atlas/mc146818rtc.h
 delete mode 100644 include/asm-mips/mips-boards/atlas.h
 delete mode 100644 include/asm-mips/mips-boards/atlasint.h
 delete mode 100644 include/asm-mips/mips-boards/sead.h
 delete mode 100644 include/asm-mips/mips-boards/seadint.h
