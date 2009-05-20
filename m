Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:21:39 +0100 (BST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:62313 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025106AbZETVVd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:21:33 +0100
Received: by pxi17 with SMTP id 17so624771pxi.22
        for <multiple recipients>; Wed, 20 May 2009 14:21:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=AC8AuDAkvc9lbvfIdCYQWHKb29R0eqlC7jeSq4qpj80=;
        b=D/BotSETK9bQ7Nv/ggQozlr+Pv3IBnF9gDEFOZduQFsCadUQ0rYh9lRnkJ7Uj1TsZq
         /J5moUVSXvnS1OuCJJNIkr183SDed+Vt9x9pk9Zkm/OQuBU2F3jT++fSuL6EbyQvAS+g
         SuWf9QyRu52lZ9IouZJx0HWmnRZ4h9yEu1j3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=M3ciSEcsDVCqbylxK/YQJOwrESvUJhJrn4mPjdcuXVz6qF/ZsOrUn7PbJT2DKiuPcV
         JsB7v4UGYxZ0qHFxNE3TBfpJXiCaG4kCuIMAMgXC/bJuuX8p9ta2GrykptjyIhc264dk
         I5116by1z46UJSPiUDgTYbZxgZLG3dGTNDrX8=
Received: by 10.142.223.4 with SMTP id v4mr636072wfg.11.1242854485591;
        Wed, 20 May 2009 14:21:25 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 30sm2825644wff.29.2009.05.20.14.21.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:21:24 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-support 00/27] linux PATCHes of loongson-based machines
Date:	Thu, 21 May 2009 05:21:00 +0800
Message-Id: <cover.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Dear all,

I have cleaned up the source code of loongson-based machines support and
updated it to linux-2.6.29.3, the latest result is put to the following git
repository:

   git://dev.lemote.com/rt4ls.git  to-ralf
	or
   http://dev.lemote.com/cgit/rt4ls.git/log/?h=to-ralf

this job is based on the to-mips branch of Yanhua's
git://dev.lemote.com/linux_loongson.git and the lm2e-fixes branch of Philippe's
git://git.linux-cisco.org/linux-mips.git. thanks goes to them.

and also, thanks goes to Erwen and heihaier for testing the latest branch, and
thanks ralf, zhangLe, john and the other guyes for reviewing the old branch and
giving good suggestions.

the most differences between this branch and the old branch include:

   * all of these patches are checked by script/checkpatch.pl, only a few
   warnings left.

   * the cs5536 part have been cleaned up deeply. the old pcireg.h is removed
   via using the include/linux/pci_regs.h instead. and the old cs5536_vsm.c is
   divided to several modules, one file one module.

   * the source code in driver/video/smi in cleaned up a lot, two trashy header
   files are removed, and several trashy functions are removed, lots of coding
   style errors and warnings are cleaned up.

   * gcc 4.4 support, including 32bit and 64bit, and also it is gcc 4.3
   compatiable

I have tested it in 32bit and 64bit with gcc 4.3 on fuloong(2e), fuloong(2f),
yeeloong(2f), all of them work well, and also test it in 32bit and 64bit with
gcc 4.4 on fuloong(2f), works normally. Erwen and heihaier have tested it in
64bit with gcc 4.4 on a yeeloong laptop.

* the current source code architecture

$ tree arch/mips/loongson/
arch/mips/loongson/
|-- Kconfig
|-- Makefile
|-- common
|   |-- Makefile
|   |-- bonito-irq.c
|   |-- clock.c
|   |-- cmdline.c
|   |-- cs5536
|   |   |-- Makefile
|   |   |-- cs5536_acc.c
|   |   |-- cs5536_ehci.c
|   |   |-- cs5536_flash.c
|   |   |-- cs5536_ide.c
|   |   |-- cs5536_isa.c 
|   |   |-- cs5536_mfgpt.c  --> cs5536 mfgpt timer
|   |   |-- cs5536_ohci.c
|   |   |-- cs5536_otg.c
|   |   |-- cs5536_pci.c    --> cs5536_pci_conf_read4/write4
|   |   `-- cs5536_udc.c
|   |-- early_printk.c
|   |-- init.c
|   |-- irq.c
|   |-- mem.c
|   |-- misc.c
|   |-- pci.c
|   |-- reset.c
|   |-- rtc.c
|   |-- serial.c
|   |-- setup.c
|   `-- time.c
|-- fuloong-2e
|   |-- Makefile
|   |-- irq.c
|   `-- reset.c
|-- fuloong-2f
|   |-- Makefile
|   |-- irq.c
|   `-- reset.c
`-- yeeloong-2f
    |-- Makefile
    |-- init.c
    |-- irq.c
    `-- reset.c

$ tree arch/mips/include/asm/mach-loongson/
arch/mips/include/asm/mach-loongson/
|-- cmdline.h
|-- cpu-feature-overrides.h
|-- cs5536
|   |-- cs5536.h
|   |-- cs5536_mfgpt.h
|   |-- cs5536_pci.h
|   `-- cs5536_vsm.h
|-- dma-coherence.h
|-- loongson.h
|-- machine.h    --> merged from the old board-name/machine.h
|-- mc146818rtc.h
|-- mem.h
|-- pci.h
`-- war.h

* PCI relative files:

arch/mips/pci/fixup-fuloong2e.c  arch/mips/pci/fixup-lemote2f.c
arch/mips/pci/ops-loongson2.c                        ^^^^^^^^| 
		  |^^^^^^^	        fuloong2f & yeeloong2f
                  have preserved a position for gdium

* Video card Driver(SMI) for yeeloong2f

$ drivers/video/smi/
|-- Makefile
|-- smtc2d.c
|-- smtc2d.h
|-- smtcfb.c
`-- smtcfb.h

* STD support for MIPS

$ arch/mips/power/
|-- Makefile
|-- cpu.c
`-- hibernate.S

* Oprofile support for loongson2

arch/mips/oprofile/op_model_loongson2.c

* cpufrq support for loongson2f

arch/mips/kerenl/loongson2f_freq.c
arch/mips/loongson/common/clock.c

* gcc 4.4 support for MIPS

arch/mips/include/asm/compiler.h
arch/mips/include/asm/delay.h
arch/mips/include/asm/div64.h

* gcc 4.4 support for loongson2e/2f

arch/mips/Makefile


Wu Zhangjin (27):
  fix-warning: incompatible argument type of pci_fixup_irqs
  fix-warning: incompatible argument type of virt_to_phys
  fix-error: incompatiable argument type of clear_user
  change the naming methods
  remove reference to bonito64.h
  divide the files to the smallest logic unit
  replace tons of magic numbers by understandable symbols
  clean up the early printk support for fuloong(2e)
  enable Real Time Clock Support for fuloong(2e)
  add loongson-specific cpu-feature-overrides.h
  split the loongson-specific part out
  add basic loongson-2f support
  add basic fuloong(2f) support
  enable serial port support of loongson-based machines
  add basic yeeloong(2f) laptop support
  Add Siliconmotion 712 framebuffer driver
  define Loongson2F arch specific phys prot access
  Loongson2 specific OProfile driver
  flush posted write to irq
  CS5536 MFGPT as system clock source support
  Loongson2F cpufreq support
  Hibernation Support in mips system
  Alsa memory maps fixup on mips systems
  fixup for FUJITSU disk
  Flush RAS and BTB for CPU predictively execution
  add default kernel config file for loongson-based machines
  add gcc 4.4 support for MIPS and loongson

 .gitignore                                         |    1 +
 arch/mips/Kconfig                                  |   92 +-
 arch/mips/Makefile                                 |   21 +-
 arch/mips/configs/fulong_defconfig                 | 1912 --------------
 arch/mips/configs/fuloong2e_defconfig              | 1977 +++++++++++++++
 arch/mips/configs/fuloong2f_defconfig              | 2630 +++++++++++++++++++
 arch/mips/configs/yeeloong2f_defconfig             | 2641 ++++++++++++++++++++
 arch/mips/include/asm/clock.h                      |   64 +
 arch/mips/include/asm/compiler.h                   |   10 +
 arch/mips/include/asm/delay.h                      |   58 +-
 arch/mips/include/asm/div64.h                      |   24 +-
 arch/mips/include/asm/mach-lemote/dma-coherence.h  |   66 -
 arch/mips/include/asm/mach-lemote/mc146818rtc.h    |   36 -
 arch/mips/include/asm/mach-lemote/pci.h            |   30 -
 arch/mips/include/asm/mach-lemote/war.h            |   25 -
 arch/mips/include/asm/mach-loongson/cmdline.h      |    9 +
 .../asm/mach-loongson/cpu-feature-overrides.h      |   58 +
 .../mips/include/asm/mach-loongson/cs5536/cs5536.h |  382 +++
 .../asm/mach-loongson/cs5536/cs5536_mfgpt.h        |   26 +
 .../include/asm/mach-loongson/cs5536/cs5536_pci.h  |  174 ++
 .../include/asm/mach-loongson/cs5536/cs5536_vsm.h  |   59 +
 .../mips/include/asm/mach-loongson/dma-coherence.h |   70 +
 arch/mips/include/asm/mach-loongson/loongson.h     |  311 +++
 arch/mips/include/asm/mach-loongson/machine.h      |   87 +
 arch/mips/include/asm/mach-loongson/mc146818rtc.h  |   36 +
 arch/mips/include/asm/mach-loongson/mem.h          |   31 +
 arch/mips/include/asm/mach-loongson/pci.h          |   59 +
 arch/mips/include/asm/mach-loongson/war.h          |   25 +
 arch/mips/include/asm/mips-boards/bonito64.h       |    5 -
 arch/mips/include/asm/page.h                       |    5 +-
 arch/mips/include/asm/pci.h                        |    2 +-
 arch/mips/include/asm/pgtable.h                    |   13 +
 arch/mips/include/asm/stackframe.h                 |   14 +
 arch/mips/include/asm/suspend.h                    |    2 +
 arch/mips/include/asm/uaccess.h                    |    2 +-
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/asm-offsets.c                     |   13 +
 arch/mips/kernel/i8259.c                           |    2 +
 arch/mips/kernel/loongson2f_freq.c                 |  223 ++
 arch/mips/lemote/lm2e/Makefile                     |    7 -
 arch/mips/lemote/lm2e/bonito-irq.c                 |   74 -
 arch/mips/lemote/lm2e/dbg_io.c                     |  146 --
 arch/mips/lemote/lm2e/irq.c                        |  144 --
 arch/mips/lemote/lm2e/mem.c                        |   23 -
 arch/mips/lemote/lm2e/pci.c                        |   97 -
 arch/mips/lemote/lm2e/prom.c                       |   97 -
 arch/mips/lemote/lm2e/reset.c                      |   41 -
 arch/mips/lemote/lm2e/setup.c                      |  111 -
 arch/mips/loongson/Kconfig                         |  135 +
 arch/mips/loongson/Makefile                        |   23 +
 arch/mips/loongson/common/Makefile                 |   37 +
 arch/mips/loongson/common/bonito-irq.c             |   78 +
 arch/mips/loongson/common/clock.c                  |  166 ++
 arch/mips/loongson/common/cmdline.c                |   85 +
 arch/mips/loongson/common/cs5536/Makefile          |   25 +
 arch/mips/loongson/common/cs5536/cs5536_acc.c      |  155 ++
 arch/mips/loongson/common/cs5536/cs5536_ehci.c     |  165 ++
 arch/mips/loongson/common/cs5536/cs5536_flash.c    |  450 ++++
 arch/mips/loongson/common/cs5536/cs5536_ide.c      |  193 ++
 arch/mips/loongson/common/cs5536/cs5536_isa.c      |  376 +++
 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c    |  258 ++
 arch/mips/loongson/common/cs5536/cs5536_ohci.c     |  167 ++
 arch/mips/loongson/common/cs5536/cs5536_otg.c      |  137 +
 arch/mips/loongson/common/cs5536/cs5536_pci.c      |  126 +
 arch/mips/loongson/common/cs5536/cs5536_udc.c      |  142 ++
 arch/mips/loongson/common/early_printk.c           |   28 +
 arch/mips/loongson/common/init.c                   |   57 +
 arch/mips/loongson/common/irq.c                    |  134 +
 arch/mips/loongson/common/mem.c                    |  116 +
 arch/mips/loongson/common/misc.c                   |   15 +
 arch/mips/loongson/common/pci.c                    |  109 +
 arch/mips/loongson/common/reset.c                  |   38 +
 arch/mips/loongson/common/rtc.c                    |   54 +
 arch/mips/loongson/common/serial.c                 |   64 +
 arch/mips/loongson/common/setup.c                  |   74 +
 arch/mips/loongson/common/time.c                   |   34 +
 arch/mips/loongson/fuloong-2e/Makefile             |    7 +
 arch/mips/loongson/fuloong-2e/irq.c                |   58 +
 arch/mips/loongson/fuloong-2e/reset.c              |   26 +
 arch/mips/loongson/fuloong-2f/Makefile             |    5 +
 arch/mips/loongson/fuloong-2f/irq.c                |   53 +
 arch/mips/loongson/fuloong-2f/reset.c              |   65 +
 arch/mips/loongson/yeeloong-2f/Makefile            |    5 +
 arch/mips/loongson/yeeloong-2f/init.c              |   71 +
 arch/mips/loongson/yeeloong-2f/irq.c               |   53 +
 arch/mips/loongson/yeeloong-2f/reset.c             |   40 +
 arch/mips/oprofile/Makefile                        |    1 +
 arch/mips/oprofile/common.c                        |    5 +
 arch/mips/oprofile/op_model_loongson2.c            |  186 ++
 arch/mips/pci/Makefile                             |    4 +-
 arch/mips/pci/fixup-au1000.c                       |    2 +-
 arch/mips/pci/fixup-capcella.c                     |    2 +-
 arch/mips/pci/fixup-cobalt.c                       |    2 +-
 arch/mips/pci/fixup-emma2rh.c                      |    2 +-
 arch/mips/pci/fixup-excite.c                       |    2 +-
 arch/mips/pci/fixup-fuloong2e.c                    |  243 ++
 arch/mips/pci/fixup-ip32.c                         |    2 +-
 arch/mips/pci/fixup-lemote2f.c                     |  171 ++
 arch/mips/pci/fixup-lm2e.c                         |  242 --
 arch/mips/pci/fixup-malta.c                        |    2 +-
 arch/mips/pci/fixup-mpc30x.c                       |    2 +-
 arch/mips/pci/fixup-pmcmsp.c                       |    2 +-
 arch/mips/pci/fixup-pnx8550.c                      |    2 +-
 arch/mips/pci/fixup-rc32434.c                      |    2 +-
 arch/mips/pci/fixup-sni.c                          |    2 +-
 arch/mips/pci/fixup-tb0219.c                       |    2 +-
 arch/mips/pci/fixup-tb0226.c                       |    2 +-
 arch/mips/pci/fixup-tb0287.c                       |    2 +-
 arch/mips/pci/fixup-wrppmc.c                       |    2 +-
 arch/mips/pci/fixup-yosemite.c                     |    2 +-
 arch/mips/pci/ops-bonito64.c                       |   19 +-
 arch/mips/pci/ops-loongson2.c                      |  213 ++
 arch/mips/pci/pci-bcm1480.c                        |    2 +-
 arch/mips/pci/pci-bcm47xx.c                        |    2 +-
 arch/mips/pci/pci-ip27.c                           |    2 +-
 arch/mips/pci/pci-lasat.c                          |    2 +-
 arch/mips/pci/pci-sb1250.c                         |    2 +-
 arch/mips/power/Makefile                           |    1 +
 arch/mips/power/cpu.c                              |   51 +
 arch/mips/power/hibernate.S                        |   78 +
 arch/mips/txx9/generic/pci.c                       |    2 +-
 drivers/ide/amd74xx.c                              |   19 +
 drivers/rtc/rtc-cmos.c                             |    8 +-
 drivers/video/Kconfig                              |   23 +
 drivers/video/Makefile                             |    1 +
 drivers/video/smi/Makefile                         |    8 +
 drivers/video/smi/smtc2d.c                         |  979 ++++++++
 drivers/video/smi/smtc2d.h                         |  530 ++++
 drivers/video/smi/smtcfb.c                         | 1141 +++++++++
 drivers/video/smi/smtcfb.h                         |  793 ++++++
 include/linux/suspend.h                            |    3 +-
 sound/core/pcm_native.c                            |    9 +
 sound/core/sgbuf.c                                 |    9 +
 sound/pci/Kconfig                                  |    1 -
 134 files changed, 17383 insertions(+), 3161 deletions(-)
 delete mode 100644 arch/mips/configs/fulong_defconfig
 create mode 100644 arch/mips/configs/fuloong2e_defconfig
 create mode 100644 arch/mips/configs/fuloong2f_defconfig
 create mode 100644 arch/mips/configs/yeeloong2f_defconfig
 create mode 100644 arch/mips/include/asm/clock.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/mc146818rtc.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/pci.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/war.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cmdline.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_pci.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_vsm.h
 create mode 100644 arch/mips/include/asm/mach-loongson/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-loongson/loongson.h
 create mode 100644 arch/mips/include/asm/mach-loongson/machine.h
 create mode 100644 arch/mips/include/asm/mach-loongson/mc146818rtc.h
 create mode 100644 arch/mips/include/asm/mach-loongson/mem.h
 create mode 100644 arch/mips/include/asm/mach-loongson/pci.h
 create mode 100644 arch/mips/include/asm/mach-loongson/war.h
 create mode 100644 arch/mips/kernel/loongson2f_freq.c
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
 create mode 100644 arch/mips/loongson/common/clock.c
 create mode 100644 arch/mips/loongson/common/cmdline.c
 create mode 100644 arch/mips/loongson/common/cs5536/Makefile
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_acc.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_ehci.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_flash.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_ide.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_isa.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_ohci.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_otg.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_pci.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_udc.c
 create mode 100644 arch/mips/loongson/common/early_printk.c
 create mode 100644 arch/mips/loongson/common/init.c
 create mode 100644 arch/mips/loongson/common/irq.c
 create mode 100644 arch/mips/loongson/common/mem.c
 create mode 100644 arch/mips/loongson/common/misc.c
 create mode 100644 arch/mips/loongson/common/pci.c
 create mode 100644 arch/mips/loongson/common/reset.c
 create mode 100644 arch/mips/loongson/common/rtc.c
 create mode 100644 arch/mips/loongson/common/serial.c
 create mode 100644 arch/mips/loongson/common/setup.c
 create mode 100644 arch/mips/loongson/common/time.c
 create mode 100644 arch/mips/loongson/fuloong-2e/Makefile
 create mode 100644 arch/mips/loongson/fuloong-2e/irq.c
 create mode 100644 arch/mips/loongson/fuloong-2e/reset.c
 create mode 100644 arch/mips/loongson/fuloong-2f/Makefile
 create mode 100644 arch/mips/loongson/fuloong-2f/irq.c
 create mode 100644 arch/mips/loongson/fuloong-2f/reset.c
 create mode 100644 arch/mips/loongson/yeeloong-2f/Makefile
 create mode 100644 arch/mips/loongson/yeeloong-2f/init.c
 create mode 100644 arch/mips/loongson/yeeloong-2f/irq.c
 create mode 100644 arch/mips/loongson/yeeloong-2f/reset.c
 create mode 100644 arch/mips/oprofile/op_model_loongson2.c
 create mode 100644 arch/mips/pci/fixup-fuloong2e.c
 create mode 100644 arch/mips/pci/fixup-lemote2f.c
 delete mode 100644 arch/mips/pci/fixup-lm2e.c
 create mode 100644 arch/mips/pci/ops-loongson2.c
 create mode 100644 arch/mips/power/Makefile
 create mode 100644 arch/mips/power/cpu.c
 create mode 100644 arch/mips/power/hibernate.S
 create mode 100644 drivers/video/smi/Makefile
 create mode 100644 drivers/video/smi/smtc2d.c
 create mode 100644 drivers/video/smi/smtc2d.h
 create mode 100644 drivers/video/smi/smtcfb.c
 create mode 100644 drivers/video/smi/smtcfb.h
