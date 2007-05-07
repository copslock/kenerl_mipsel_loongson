Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2007 12:09:28 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.238]:6482 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021936AbXEGLJ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 May 2007 12:09:26 +0100
Received: by wx-out-0506.google.com with SMTP id s14so746125wxc
        for <linux-mips@linux-mips.org>; Mon, 07 May 2007 04:09:24 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        b=e9Ozlg3N9t0ZelpehxEXXoI3bsVUsrWzTXjVrtkZbcikBRtjFbJdh0jZU8mU9SnG+qGgeYD5kRkNgp4as52wfA9bgGA57slaEPFZgeGgD1gzRn3ZUK0y9jdvw33em6hbTCh97B/EvPqwk2LDkFLMs5mPmq5DUzP+eYNgdPEPqDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=ZC01Um9s5tEdiAOqfVuy2AWPV+2ZtyrsgxuDT6XDQ2T+GexvaHj2yNxxcEZvU/+mB5RtptYGp2uRpzLs9wLUlTSZcPxBfToI5cRsqpYSAOiT66Fvg7hpXOn1mcbsi9GXp1J3XNBVJf8BNpTMWT4SNkwBriD0asWiE1ZsWpNqoSw=
Received: by 10.90.63.16 with SMTP id l16mr4787601aga.1178536164513;
        Mon, 07 May 2007 04:09:24 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id m6sm10187529wrm.2007.05.07.04.09.21;
        Mon, 07 May 2007 04:09:23 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 32E9C23F76E; Mon,  7 May 2007 13:11:13 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org
Subject: [RFC 0/3] Remove Momentum Jaguar and Ocelot G board supports
Date:	Mon,  7 May 2007 13:11:10 +0200
Message-Id: <11785362732731-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.3
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14972
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

Please consider,

		Franck

---

 arch/mips/Kconfig                               |   51 +--
 arch/mips/Makefile                              |   20 -
 arch/mips/configs/jaguar-atx_defconfig          |  897 ---------------------
 arch/mips/configs/ocelot_g_defconfig            |  981 -----------------------
 arch/mips/mm/highmem.c                          |   21 -
 arch/mips/mm/init.c                             |    3 -
 arch/mips/momentum/Kconfig                      |    6 -
 arch/mips/momentum/jaguar_atx/Makefile          |   12 -
 arch/mips/momentum/jaguar_atx/dbg_io.c          |  125 ---
 arch/mips/momentum/jaguar_atx/irq.c             |   94 ---
 arch/mips/momentum/jaguar_atx/ja-console.c      |  101 ---
 arch/mips/momentum/jaguar_atx/jaguar_atx_fpga.h |   54 --
 arch/mips/momentum/jaguar_atx/platform.c        |  208 -----
 arch/mips/momentum/jaguar_atx/prom.c            |  210 -----
 arch/mips/momentum/jaguar_atx/reset.c           |   56 --
 arch/mips/momentum/jaguar_atx/setup.c           |  475 -----------
 arch/mips/momentum/ocelot_g/Makefile            |    6 -
 arch/mips/momentum/ocelot_g/dbg_io.c            |  121 ---
 arch/mips/momentum/ocelot_g/gt-irq.c            |  212 -----
 arch/mips/momentum/ocelot_g/irq.c               |  101 ---
 arch/mips/momentum/ocelot_g/ocelot_pld.h        |   30 -
 arch/mips/momentum/ocelot_g/prom.c              |   84 --
 arch/mips/momentum/ocelot_g/reset.c             |   47 --
 arch/mips/momentum/ocelot_g/setup.c             |  267 ------
 arch/mips/pci/Makefile                          |    2 -
 arch/mips/pci/fixup-jaguar.c                    |   43 -
 arch/mips/pci/fixup-ocelot-g.c                  |   37 -
 arch/mips/pci/pci-ocelot-g.c                    |   97 ---
 28 files changed, 3 insertions(+), 4358 deletions(-)

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
