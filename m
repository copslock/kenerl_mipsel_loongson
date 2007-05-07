Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2007 17:01:28 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.227]:19946 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022095AbXEGQBN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 May 2007 17:01:13 +0100
Received: by wx-out-0506.google.com with SMTP id s14so831989wxc
        for <linux-mips@linux-mips.org>; Mon, 07 May 2007 09:00:06 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        b=Fv6nPU+58COhpTk8VJpEllu7wGikLRqxu5w9IWSVZR6PTsAKIV7PIyS+pXQQ+Uk7SJSPzTuqHmooi8/VD8ypuEjHf3oH2PBanjGkxgXXUtkLgIkOaqxxj7HrwmVMyyvd+g+OQcvFzmCxsZK9b861KWOzdgXaERslIbw69eVCHK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=JetYoeFvLVvbovVayUGPcGOT7KUOeY0trES/zC01U5l14NpXzeV72i0Pm20qAy6lxiA6Y5v8EpmMeA2Rhe681jYIDQKtZ5r+FEVFie5JYbmxN7U6TM3kn8NMHbggSRUouEJjVNLvx/CTaSsBH9tKga7w21PwimjdIz4uW3X2t0Y=
Received: by 10.90.27.13 with SMTP id a13mr5253474aga.1178553606745;
        Mon, 07 May 2007 09:00:06 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id 33sm8362155wra.2007.05.07.09.00.03;
        Mon, 07 May 2007 09:00:06 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 4B35E23F76F; Mon,  7 May 2007 18:01:54 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org
Subject: [RFC 0/3] Remove Momentum Jaguar and Ocelot G board supports [take #2]
Date:	Mon,  7 May 2007 18:01:50 +0200
Message-Id: <11785537132378-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.3
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

These 2 boards have several hacks that make them annoying to
support. Specially when improving generic MIPS code.

Since they're scheduled for removal since June 2006, it should be high
time to get rid of them.

Take #2 has removed and fixed some header files as suggested by
Atsushi.

Please consider,

		Franck

---

 arch/mips/Kconfig                                |   51 +--
 arch/mips/Makefile                               |   20 -
 arch/mips/configs/jaguar-atx_defconfig           |  897 --------------------
 arch/mips/configs/ocelot_g_defconfig             |  981 ----------------------
 arch/mips/mm/highmem.c                           |    2 -
 arch/mips/mm/init.c                              |    3 -
 arch/mips/momentum/Kconfig                       |    6 -
 arch/mips/momentum/jaguar_atx/Makefile           |   12 -
 arch/mips/momentum/jaguar_atx/dbg_io.c           |  125 ---
 arch/mips/momentum/jaguar_atx/irq.c              |   94 --
 arch/mips/momentum/jaguar_atx/ja-console.c       |  101 ---
 arch/mips/momentum/jaguar_atx/jaguar_atx_fpga.h  |   54 --
 arch/mips/momentum/jaguar_atx/platform.c         |  208 -----
 arch/mips/momentum/jaguar_atx/prom.c             |  210 -----
 arch/mips/momentum/jaguar_atx/reset.c            |   56 --
 arch/mips/momentum/jaguar_atx/setup.c            |  475 -----------
 arch/mips/momentum/ocelot_g/Makefile             |    6 -
 arch/mips/momentum/ocelot_g/dbg_io.c             |  121 ---
 arch/mips/momentum/ocelot_g/gt-irq.c             |  212 -----
 arch/mips/momentum/ocelot_g/irq.c                |  101 ---
 arch/mips/momentum/ocelot_g/ocelot_pld.h         |   30 -
 arch/mips/momentum/ocelot_g/prom.c               |   84 --
 arch/mips/momentum/ocelot_g/reset.c              |   47 -
 arch/mips/momentum/ocelot_g/setup.c              |  267 ------
 arch/mips/pci/Makefile                           |    2 -
 arch/mips/pci/fixup-jaguar.c                     |   43 -
 arch/mips/pci/fixup-ocelot-g.c                   |   37 -
 arch/mips/pci/pci-ocelot-g.c                     |   97 ---
 include/asm-mips/bootinfo.h                      |    4 +-
 include/asm-mips/highmem.h                       |   42 -
 include/asm-mips/mach-ja/cpu-feature-overrides.h |   45 -
 include/asm-mips/mach-ja/spaces.h                |   20 -
 include/asm-mips/page.h                          |    4 -
 include/asm-mips/serial.h                        |   41 -
 34 files changed, 5 insertions(+), 4493 deletions(-)

 delete mode 100644 arch/mips/configs/jaguar-atx_defconfig
 delete mode 100644 arch/mips/configs/ocelot_g_defconfig
 delete mode 100644 arch/mips/momentum/Kconfig
 delete mode 100644 arch/mips/momentum/jaguar_atx/Makefile
 delete mode 100644 arch/mips/momentum/jaguar_atx/dbg_io.c
 delete mode 100644 arch/mips/momentum/jaguar_atx/irq.c
 delete mode 100644 arch/mips/momentum/jaguar_atx/ja-console.c
 delete mode 100644 arch/mips/momentum/jaguar_atx/jaguar_atx_fpga.h
 delete mode 100644 arch/mips/momentum/jaguar_atx/platform.c
 delete mode 100644 arch/mips/momentum/jaguar_atx/prom.c
 delete mode 100644 arch/mips/momentum/jaguar_atx/reset.c
 delete mode 100644 arch/mips/momentum/jaguar_atx/setup.c
 delete mode 100644 arch/mips/momentum/ocelot_g/Makefile
 delete mode 100644 arch/mips/momentum/ocelot_g/dbg_io.c
 delete mode 100644 arch/mips/momentum/ocelot_g/gt-irq.c
 delete mode 100644 arch/mips/momentum/ocelot_g/irq.c
 delete mode 100644 arch/mips/momentum/ocelot_g/ocelot_pld.h
 delete mode 100644 arch/mips/momentum/ocelot_g/prom.c
 delete mode 100644 arch/mips/momentum/ocelot_g/reset.c
 delete mode 100644 arch/mips/momentum/ocelot_g/setup.c
 delete mode 100644 arch/mips/pci/fixup-jaguar.c
 delete mode 100644 arch/mips/pci/fixup-ocelot-g.c
 delete mode 100644 arch/mips/pci/pci-ocelot-g.c
 delete mode 100644 include/asm-mips/mach-ja/cpu-feature-overrides.h
 delete mode 100644 include/asm-mips/mach-ja/spaces.h
