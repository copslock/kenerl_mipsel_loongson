Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 17:22:03 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:50091 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492195AbZGBPV4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 17:21:56 +0200
Received: by ewy10 with SMTP id 10so2090979ewy.0
        for <multiple recipients>; Thu, 02 Jul 2009 08:16:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2a3nIkrXSlmoDjxqLvHaZs88E733Z2LZMrZPBdHU45M=;
        b=QPhsD3XXi95z78C4ll6FO8uHKYSrEMZJmkhpbK2JwJZABUHXCnhUq/SXqUk2ekTyqu
         RjI9fEaybVMvjcimzFy1poH7wJN0oys5R4bbAjpIK/0a32LGhn+36eSBbdo7GSQeWqP6
         JA5Z2XTKDMmpObJJiVDsraXF/MGZQn/09wjDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QJQdyUkF1QsRuKNJB5lKKjEOytN/xVwmLAUh7okZFm1uXx6ROXglf1EDtqs6HFQV75
         jqzMLUlmf1Gi05BuJK0fcKP1SpzU1kGV4LuWUxk/j1nNQ+EKTY6o48laBAZNqP6hULLw
         /gOGjJ7ifRzHOII8LmgOhJFRkQcL21oBzA71g=
Received: by 10.210.19.7 with SMTP id 7mr1085417ebs.55.1246547766472;
        Thu, 02 Jul 2009 08:16:06 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 10sm60181eyd.28.2009.07.02.08.16.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 08:16:05 -0700 (PDT)
From:	Wu <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH v4 00/16] Cleanup Lemote FuLoong2e Support
Date:	Thu,  2 Jul 2009 23:15:52 +0800
Message-Id: <cover.1246546684.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch series is the -v4 version of the loongson-PATCH-v3 series, but it
only include the cleanup for fuloong2e support and necessary preparation for
future fuloong-2f and yeeloong-2f support.

The git branch of this patch series is:

	git://dev.lemote.com/rt4ls.git linux-loongson/dev/fuloong2e

	or

	http://dev.lemote.com/cgit/rt4ls.git/log/?h=linux-loongson/dev/fuloong2e

Wu Zhangjin (16):
  [loongson] eary_printk: Remove existing implementation
  [loongson] kgdb: Remove out-of-date board-specific source code
  [loongson] early_printk: add new implmentation
  [loongson] pm: Remove redundant source code
  [loongson] pm: clean up the reboot support
  [loongson] pci: use existing mips_io_port_base
  [loongson] split the implementation of prom,setup parts
  [loongson] clean up the coding style
  [loongson] pci: clean up pcimap setup
  [loongson] rtc: enable legacy RTC driver on fulong
  [loongson] add oprofile support
  [loongson] change naming methods
  [loongson] split common loongson source code out
  [loongson] add a machtype kernel command line argument
  [loongson] add gcc 4.4 support for Loongson2E
  [loongson] update the default config file for fuloong2e

 Documentation/kernel-parameters.txt                |    4 +
 arch/mips/Kconfig                                  |   52 +-
 arch/mips/Makefile                                 |   15 +-
 arch/mips/configs/fulong_defconfig                 | 1912 --------------------
 arch/mips/configs/fuloong2e_defconfig              | 1819 +++++++++++++++++++
 arch/mips/include/asm/bootinfo.h                   |   12 +
 .../asm/mach-lemote/cpu-feature-overrides.h        |   59 -
 arch/mips/include/asm/mach-lemote/dma-coherence.h  |   68 -
 arch/mips/include/asm/mach-lemote/mc146818rtc.h    |   36 -
 arch/mips/include/asm/mach-lemote/pci.h            |   30 -
 arch/mips/include/asm/mach-lemote/war.h            |   25 -
 .../asm/mach-loongson/cpu-feature-overrides.h      |   59 +
 .../mips/include/asm/mach-loongson/dma-coherence.h |   68 +
 arch/mips/include/asm/mach-loongson/loongson.h     |   67 +
 arch/mips/include/asm/mach-loongson/machine.h      |   22 +
 arch/mips/include/asm/mach-loongson/mc146818rtc.h  |   36 +
 arch/mips/include/asm/mach-loongson/mem.h          |   30 +
 arch/mips/include/asm/mach-loongson/pci.h          |   37 +
 arch/mips/include/asm/mach-loongson/war.h          |   25 +
 arch/mips/include/asm/mips-boards/bonito64.h       |    2 +-
 arch/mips/lemote/lm2e/Makefile                     |    7 -
 arch/mips/lemote/lm2e/bonito-irq.c                 |   74 -
 arch/mips/lemote/lm2e/dbg_io.c                     |  146 --
 arch/mips/lemote/lm2e/irq.c                        |  143 --
 arch/mips/lemote/lm2e/mem.c                        |   23 -
 arch/mips/lemote/lm2e/pci.c                        |   97 -
 arch/mips/lemote/lm2e/prom.c                       |   97 -
 arch/mips/lemote/lm2e/reset.c                      |   41 -
 arch/mips/lemote/lm2e/setup.c                      |  111 --
 arch/mips/loongson/Kconfig                         |   31 +
 arch/mips/loongson/Makefile                        |   11 +
 arch/mips/loongson/common/Makefile                 |   11 +
 arch/mips/loongson/common/bonito-irq.c             |   51 +
 arch/mips/loongson/common/cmdline.c                |   52 +
 arch/mips/loongson/common/early_printk.c           |   38 +
 arch/mips/loongson/common/env.c                    |   58 +
 arch/mips/loongson/common/init.c                   |   30 +
 arch/mips/loongson/common/irq.c                    |   74 +
 arch/mips/loongson/common/machtype.c               |   50 +
 arch/mips/loongson/common/mem.c                    |   35 +
 arch/mips/loongson/common/pci.c                    |   83 +
 arch/mips/loongson/common/reset.c                  |   39 +
 arch/mips/loongson/common/setup.c                  |   60 +
 arch/mips/loongson/common/time.c                   |   27 +
 arch/mips/loongson/fuloong-2e/Makefile             |    7 +
 arch/mips/loongson/fuloong-2e/irq.c                |   71 +
 arch/mips/loongson/fuloong-2e/reset.c              |   24 +
 arch/mips/oprofile/Makefile                        |    1 +
 arch/mips/oprofile/common.c                        |    4 +
 arch/mips/oprofile/op_model_loongson2.c            |  177 ++
 arch/mips/pci/Makefile                             |    2 +-
 arch/mips/pci/fixup-fuloong2e.c                    |  224 +++
 arch/mips/pci/fixup-lm2e.c                         |  242 ---
 arch/mips/pci/ops-bonito64.c                       |    4 +-
 54 files changed, 3372 insertions(+), 3151 deletions(-)
 delete mode 100644 arch/mips/configs/fulong_defconfig
 create mode 100644 arch/mips/configs/fuloong2e_defconfig
 delete mode 100644 arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/mc146818rtc.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/pci.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/war.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-loongson/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-loongson/loongson.h
 create mode 100644 arch/mips/include/asm/mach-loongson/machine.h
 create mode 100644 arch/mips/include/asm/mach-loongson/mc146818rtc.h
 create mode 100644 arch/mips/include/asm/mach-loongson/mem.h
 create mode 100644 arch/mips/include/asm/mach-loongson/pci.h
 create mode 100644 arch/mips/include/asm/mach-loongson/war.h
 delete mode 100644 arch/mips/lemote/lm2e/Makefile
 delete mode 100644 arch/mips/lemote/lm2e/bonito-irq.c
 delete mode 100644 arch/mips/lemote/lm2e/dbg_io.c
 delete mode 100644 arch/mips/lemote/lm2e/irq.c
 delete mode 100644 arch/mips/lemote/lm2e/mem.c
 delete mode 100644 arch/mips/lemote/lm2e/pci.c
 delete mode 100644 arch/mips/lemote/lm2e/prom.c
 delete mode 100644 arch/mips/lemote/lm2e/reset.c
 delete mode 100644 arch/mips/lemote/lm2e/setup.c
 create mode 100644 arch/mips/loongson/Kconfig
 create mode 100644 arch/mips/loongson/Makefile
 create mode 100644 arch/mips/loongson/common/Makefile
 create mode 100644 arch/mips/loongson/common/bonito-irq.c
 create mode 100644 arch/mips/loongson/common/cmdline.c
 create mode 100644 arch/mips/loongson/common/early_printk.c
 create mode 100644 arch/mips/loongson/common/env.c
 create mode 100644 arch/mips/loongson/common/init.c
 create mode 100644 arch/mips/loongson/common/irq.c
 create mode 100644 arch/mips/loongson/common/machtype.c
 create mode 100644 arch/mips/loongson/common/mem.c
 create mode 100644 arch/mips/loongson/common/pci.c
 create mode 100644 arch/mips/loongson/common/reset.c
 create mode 100644 arch/mips/loongson/common/setup.c
 create mode 100644 arch/mips/loongson/common/time.c
 create mode 100644 arch/mips/loongson/fuloong-2e/Makefile
 create mode 100644 arch/mips/loongson/fuloong-2e/irq.c
 create mode 100644 arch/mips/loongson/fuloong-2e/reset.c
 create mode 100644 arch/mips/oprofile/op_model_loongson2.c
 create mode 100644 arch/mips/pci/fixup-fuloong2e.c
 delete mode 100644 arch/mips/pci/fixup-lm2e.c
