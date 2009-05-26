Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 20:00:15 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:59083 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024627AbZEZTAK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2009 20:00:10 +0100
Received: by pxi17 with SMTP id 17so3785849pxi.22
        for <multiple recipients>; Tue, 26 May 2009 12:00:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=4piWnmiEsT/Kf0AR+YqGVJCQkF352e9w0zJVPwCKl0g=;
        b=XdEBYNCgW9OhS5ej8yomNJJsHZxT3p5/LbLkV0CfzlOh+FEgxsfqrNQtfGm2d/x+Gr
         px/5YxklF1WVlx6FYxH2cngIpbCHs2nM9+iDOThDLzU4rLbNS52IF+O4HuqdXZ/rROBq
         WInQkN++Lxjta/VUSJsveQ4pi4Mffm0ttsT8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xdlONHTkyrmSuLPCi9BvhYPWNPS9wo+tDhGyRuhFj//oanZRzuldQ2M2rf3/DlU433
         TezXwrgio8YWgqyT7xJy3ArgrmODGKA4vjhquuSIbvD9qHW3KHaExOoygfRUdbigpD0n
         L7da54/F/EE4IbetwEexPOwfVspVDKe/8Tje4=
Received: by 10.114.167.3 with SMTP id p3mr16663263wae.92.1243364401729;
        Tue, 26 May 2009 12:00:01 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id m31sm11762121wag.31.2009.05.26.11.59.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 12:00:00 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v2 00/23] loongson-based machines support
Date:	Wed, 27 May 2009 02:59:28 +0800
Message-Id: <cover.1243362545.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

This patch series introduces support for loongson-based machines, including
source code tuning for old fuloong-2e support, and the whole new support for
fuloong-2f and yeeloong-2f. these three different machines are all made by
Lemote (http://www.lemote.com).

fuloong-2e is a mini PC, use a loongson-2e cpu, an cpu-inbuilt FPGA-based north
bridge(bonito64 compatiable) and a VIA686B sourth bridge.

fuloong-2f is also a mini PC, but it use a loongson-2f cpu, which has an
built-in DDR2 and PCIX controller, The PCIX controller has a similar
programming interface with FPGA-based northbridge of loongson-2e. and
fuloong-2f use AMD CS5536 as its south bridge.

yeeloong-2f is a mini laptop(netbook), has the basic architecture with
fuloong-2f, but it has an extra EC(embedded controller) which are used to do
power management, keyboard controlling and something else.

and gdium is also a mini laptop, but made by dexxon. it uses a loongson-2f cpu,
but has no south bridge. currently, there is no support for gdium in this set,
but this set is scalable enough to add gdium and even the other new
loongson-based machines support:

1. new cpu revisions support

arch/mips/Kconfig
	config CPU_LOONGSONX
		bool           ^ 2,3...
		select CPU_SUPPORTS_32BIT_KERNEL
		select CPU_SUPPORTS_64BIT_KERNEL
		select CPU_SUPPORTS_HIGHMEM
		...
	config SYS_HAS_CPU_LOONGSON2X
		bool                   ^^ 2E,2F,2G...3A...
	config CPU_LOONGSON2X
		bool "Loongson 2X"
		depends on SYS_HAS_CPU_LOONGSON2X
		select CPU_LOONGSONX           ^^ 2E,2F,2G...3A...
		...                ^ 2,3...

arch/mips/include/asm/mach-loongson/loongson.h
arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
	...

2. new machines support

arch/mips/Makefile
	load-$(CONFIG_[MACH_NAME]) += [kernel_load_address]

arch/mips/loongson/Kconfig
	config [MACH_NAME]
		bool "introduction of [MACH_NAME]"
		select ...
		select SYS_HAS_CPU_LOONGSON2X
		select ...                 ^^2E,2F,2G...3A...

arch/mips/loongson/[mach_name]
	reset.c
	irq.c
	...

arch/mips/include/asm/mach-loongson/machine.h

This -v2 patch series incorporates feedback I received on -v1 of these series,
the changes include:

   * updated to the latest master branch of git://git.linux-mips.org/pub/scm.
   the current git branch for this set is:

       git://dev.lemote.com/rt4ls.git linux-loongson-dev-to-ralf

   * two patches are discussed and tuned in progress, including FUJTU disk
   fixup and Alsa memory map fixup. so, I hope these patches can be added later
   after the basic support are accepted.

   * updating of STD support

Wu Zhangjin (23):
  fix-warning: incompatible argument type of pci_fixup_irqs
  fix-warning: incompatible argument type of virt_to_phys
  change the naming methods
  remove reference to bonito64.h
  divide the files to the smallest logic unit
  replace tons of magic numbers by understandable symbols
  clean up the early printk support for fuloong(2e)
  enable Real Time Clock Support for fuloong(2e)
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
  add gcc 4.4 support for MIPS and loongson
  add default kernel config file for loongson-based machines
  add a default kernel configration for yeeloong-7inch laptop
  Hibernation Support in mips system

 arch/mips/Kconfig                                  |   90 +-
 arch/mips/Makefile                                 |   21 +-
 arch/mips/configs/fulong_defconfig                 | 1912 --------------
 arch/mips/configs/fuloong2e_defconfig              | 1977 +++++++++++++++
 arch/mips/configs/fuloong2f_defconfig              | 2630 +++++++++++++++++++
 arch/mips/configs/yeeloong2f-7inch_defconfig       | 1720 +++++++++++++
 arch/mips/configs/yeeloong2f_defconfig             | 2641 ++++++++++++++++++++
 arch/mips/include/asm/clock.h                      |   64 +
 arch/mips/include/asm/compiler.h                   |   10 +
 arch/mips/include/asm/delay.h                      |   58 +-
 .../asm/mach-lemote/cpu-feature-overrides.h        |   59 -
 arch/mips/include/asm/mach-lemote/dma-coherence.h  |   66 -
 arch/mips/include/asm/mach-lemote/mc146818rtc.h    |   36 -
 arch/mips/include/asm/mach-lemote/pci.h            |   30 -
 arch/mips/include/asm/mach-lemote/war.h            |   25 -
 arch/mips/include/asm/mach-loongson/cmdline.h      |    9 +
 .../asm/mach-loongson/cpu-feature-overrides.h      |   59 +
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
 arch/mips/include/asm/suspend.h                    |    2 +-
 arch/mips/include/asm/txx9/generic.h               |    2 +-
 arch/mips/include/asm/txx9/jmr3927.h               |    2 +-
 arch/mips/include/asm/txx9/rbtx4927.h              |    2 +-
 arch/mips/include/asm/txx9/rbtx4938.h              |    2 +-
 arch/mips/include/asm/txx9/tx4938.h                |    2 +-
 arch/mips/include/asm/txx9/tx4939.h                |    4 +-
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/asm-offsets.c                     |   13 +
 arch/mips/kernel/i8259.c                           |    2 +
 arch/mips/kernel/loongson2f_freq.c                 |  223 ++
 arch/mips/lemote/lm2e/Makefile                     |    7 -
 arch/mips/lemote/lm2e/bonito-irq.c                 |   74 -
 arch/mips/lemote/lm2e/dbg_io.c                     |  146 --
 arch/mips/lemote/lm2e/irq.c                        |  143 --
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
 arch/mips/loongson/common/cs5536/cs5536_acc.c      |  156 ++
 arch/mips/loongson/common/cs5536/cs5536_ehci.c     |  166 ++
 arch/mips/loongson/common/cs5536/cs5536_flash.c    |  452 ++++
 arch/mips/loongson/common/cs5536/cs5536_ide.c      |  194 ++
 arch/mips/loongson/common/cs5536/cs5536_isa.c      |  376 +++
 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c    |  257 ++
 arch/mips/loongson/common/cs5536/cs5536_ohci.c     |  168 ++
 arch/mips/loongson/common/cs5536/cs5536_otg.c      |  138 +
 arch/mips/loongson/common/cs5536/cs5536_pci.c      |  126 +
 arch/mips/loongson/common/cs5536/cs5536_udc.c      |  143 ++
 arch/mips/loongson/common/early_printk.c           |   28 +
 arch/mips/loongson/common/init.c                   |   57 +
 arch/mips/loongson/common/irq.c                    |  132 +
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
 arch/mips/pci/fixup-jmr3927.c                      |    2 +-
 arch/mips/pci/fixup-lemote2f.c                     |  171 ++
 arch/mips/pci/fixup-lm2e.c                         |  242 --
 arch/mips/pci/fixup-malta.c                        |    2 +-
 arch/mips/pci/fixup-mpc30x.c                       |    2 +-
 arch/mips/pci/fixup-pmcmsp.c                       |    2 +-
 arch/mips/pci/fixup-pnx8550.c                      |    2 +-
 arch/mips/pci/fixup-rbtx4927.c                     |    2 +-
 arch/mips/pci/fixup-rbtx4938.c                     |    2 +-
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
 arch/mips/pci/pci-tx4938.c                         |    2 +-
 arch/mips/pci/pci-tx4939.c                         |    4 +-
 arch/mips/power/Makefile                           |    1 +
 arch/mips/power/cpu.c                              |   34 +
 arch/mips/power/hibernate.S                        |   61 +
 arch/mips/txx9/generic/pci.c                       |    2 +-
 drivers/rtc/rtc-cmos.c                             |    8 +-
 drivers/video/Kconfig                              |   23 +
 drivers/video/Makefile                             |    1 +
 drivers/video/smi/Makefile                         |    8 +
 drivers/video/smi/smtc2d.c                         |  979 ++++++++
 drivers/video/smi/smtc2d.h                         |  530 ++++
 drivers/video/smi/smtcfb.c                         | 1141 +++++++++
 drivers/video/smi/smtcfb.h                         |  793 ++++++
 138 files changed, 19011 insertions(+), 3225 deletions(-)
 delete mode 100644 arch/mips/configs/fulong_defconfig
 create mode 100644 arch/mips/configs/fuloong2e_defconfig
 create mode 100644 arch/mips/configs/fuloong2f_defconfig
 create mode 100644 arch/mips/configs/yeeloong2f-7inch_defconfig
 create mode 100644 arch/mips/configs/yeeloong2f_defconfig
 create mode 100644 arch/mips/include/asm/clock.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
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
