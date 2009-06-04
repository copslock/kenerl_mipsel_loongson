Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 13:59:03 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:47096 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022564AbZFDM6x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 13:58:53 +0100
Received: by pzk40 with SMTP id 40so735169pzk.22
        for <multiple recipients>; Thu, 04 Jun 2009 05:58:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HrmCw4cN4+o10+KoetQWE4wpUiZre/7T0Ft7hpgNF9k=;
        b=PhPR0963D6gTRmM/77QquRWI/aac9uF2FjgCiMLpbzIdPFY8B4g/MWJLpYVCUvt0dq
         TtN2ejJlT4wWdLc0Clk4BipIvng2HgO0svRubjPliKA6oR40RwvtcNfVohCC3L2tTlbV
         oEgmBA93Y9Z/oSqqLMluAGyPh2pq+FVMYvfQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=j/SuDw0xk7sLOjn8axWPQqPZZ1wTBIGFXiUqpR/elYT4vHLHmkhzfWVaIW8qEK8Szc
         zY6hBjbDGtgDNEjGIZP2vWcx6EWwkxUJ3iO41F3IQVa9opbAqAoW2Lird6KG3C9KqOHb
         6hvP+hH/GlmZsZhXIw4qOBCjlEP89W+dMr8A0=
Received: by 10.114.134.1 with SMTP id h1mr2359837wad.63.1244120326315;
        Thu, 04 Jun 2009 05:58:46 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id k37sm2596453waf.42.2009.06.04.05.58.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 05:58:45 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v3 00/25] loongson-based machines support
Date:	Thu,  4 Jun 2009 20:58:15 +0800
Message-Id: <cover.1244119295.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23244
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

This -v3 patch series incorporates feedback I received on -v2 of these series,
the changes include:

   * update it the latest linux-mips development git repo:
       git://dev.lemote.com/rt4ls.git linux-loongson-dev-to-ralf
   * add vmlinux.32 in .gitignore
   * split environment argument handling out of cmdline.c
   * split "Hibernation support in mips system" out of this patch series, and
submmit it individually.
   * Simon Braunschmidt <sbraun@emlix.com> helped to test the SMI driver in a
non-mips machine, works well. and according to his feedback, I enabled the vga
command line argument to config the suitable screen resolution ratio
dynamically.
   * enable halt command for yeeloong-7inch laptop
   * add a machtype command line argument to share the same kernel image file
between yeeloong-7inch and yeeloong-8.9inch

Wu Zhangjin (25):
  add vmlinux.32 in .gitignore
  fix-warning: incompatible argument type of pci_fixup_irqs
  fix-warning: incompatible argument type of virt_to_phys
  change the naming methods
  remove reference to bonito64.h
  divide the files to the smallest logic unit
  replace tons of magic numbers by understandable symbols
  clean up the early printk support for fuloong(2e)
  enable Real Time Clock Support for fuloong(2e)
  split the loongson-specific part out
  split env out of cmdline.c
  add basic loongson-2f support
  add basic fuloong(2f) support
  enable serial port support of loongson-based machines
  add basic yeeloong(2f) laptop support
  enable halt command for yeeloong-7inch laptop
  add a machtype kernel command line argument
  Add Siliconmotion 712 framebuffer driver
  define Loongson2F arch specific phys prot access
  Loongson2 specific OProfile driver
  flush posted write to irq
  CS5536 MFGPT as system clock source support
  Loongson2F cpufreq support
  add gcc 4.4 support for MIPS and loongson
  add default kernel config file for loongson-based machines

 .gitignore                                         |    1 +
 Documentation/kernel-parameters.txt                |    4 +
 arch/mips/Kconfig                                  |   87 +-
 arch/mips/Makefile                                 |   18 +-
 arch/mips/configs/fulong_defconfig                 | 1912 --------------
 arch/mips/configs/fuloong2e_defconfig              | 1977 +++++++++++++++
 arch/mips/configs/fuloong2f_defconfig              | 2630 +++++++++++++++++++
 arch/mips/configs/yeeloong2f-7inch_defconfig       | 1720 +++++++++++++
 arch/mips/configs/yeeloong2f_defconfig             | 2641 ++++++++++++++++++++
 arch/mips/include/asm/compiler.h                   |   10 +
 arch/mips/include/asm/delay.h                      |   58 +-
 .../asm/mach-lemote/cpu-feature-overrides.h        |   59 -
 arch/mips/include/asm/mach-lemote/dma-coherence.h  |   66 -
 arch/mips/include/asm/mach-lemote/mc146818rtc.h    |   36 -
 arch/mips/include/asm/mach-lemote/pci.h            |   30 -
 arch/mips/include/asm/mach-lemote/war.h            |   25 -
 arch/mips/include/asm/mach-loongson/clock.h        |   64 +
 arch/mips/include/asm/mach-loongson/cmdline.h      |    9 +
 .../asm/mach-loongson/cpu-feature-overrides.h      |   59 +
 .../mips/include/asm/mach-loongson/cs5536/cs5536.h |  382 +++
 .../asm/mach-loongson/cs5536/cs5536_mfgpt.h        |   26 +
 .../include/asm/mach-loongson/cs5536/cs5536_pci.h  |  174 ++
 .../include/asm/mach-loongson/cs5536/cs5536_vsm.h  |   59 +
 .../mips/include/asm/mach-loongson/dma-coherence.h |   70 +
 arch/mips/include/asm/mach-loongson/loongson.h     |  319 +++
 arch/mips/include/asm/mach-loongson/machine.h      |   75 +
 arch/mips/include/asm/mach-loongson/machtype.h     |   32 +
 arch/mips/include/asm/mach-loongson/mc146818rtc.h  |   36 +
 arch/mips/include/asm/mach-loongson/mem.h          |   31 +
 arch/mips/include/asm/mach-loongson/pci.h          |   59 +
 arch/mips/include/asm/mach-loongson/war.h          |   25 +
 arch/mips/include/asm/mips-boards/bonito64.h       |    5 -
 arch/mips/include/asm/page.h                       |    5 +-
 arch/mips/include/asm/pci.h                        |    2 +-
 arch/mips/include/asm/pgtable.h                    |   13 +
 arch/mips/include/asm/txx9/generic.h               |    2 +-
 arch/mips/include/asm/txx9/jmr3927.h               |    2 +-
 arch/mips/include/asm/txx9/rbtx4927.h              |    2 +-
 arch/mips/include/asm/txx9/rbtx4938.h              |    2 +-
 arch/mips/include/asm/txx9/tx4938.h                |    2 +-
 arch/mips/include/asm/txx9/tx4939.h                |    4 +-
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/i8259.c                           |    2 +
 arch/mips/kernel/loongson2f_freq.c                 |  216 ++
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
 arch/mips/loongson/common/cmdline.c                |   59 +
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
 arch/mips/loongson/common/env.c                    |   59 +
 arch/mips/loongson/common/init.c                   |   54 +
 arch/mips/loongson/common/irq.c                    |  132 +
 arch/mips/loongson/common/machtype.c               |   58 +
 arch/mips/loongson/common/mem.c                    |  116 +
 arch/mips/loongson/common/pci.c                    |  109 +
 arch/mips/loongson/common/reset.c                  |   38 +
 arch/mips/loongson/common/rtc.c                    |   54 +
 arch/mips/loongson/common/serial.c                 |   66 +
 arch/mips/loongson/common/setup.c                  |   74 +
 arch/mips/loongson/common/time.c                   |   34 +
 arch/mips/loongson/fuloong-2e/Makefile             |    7 +
 arch/mips/loongson/fuloong-2e/irq.c                |   58 +
 arch/mips/loongson/fuloong-2e/reset.c              |   26 +
 arch/mips/loongson/fuloong-2f/Makefile             |    5 +
 arch/mips/loongson/fuloong-2f/irq.c                |   53 +
 arch/mips/loongson/fuloong-2f/reset.c              |   65 +
 arch/mips/loongson/yeeloong-2f/Makefile            |    5 +
 arch/mips/loongson/yeeloong-2f/init.c              |   82 +
 arch/mips/loongson/yeeloong-2f/irq.c               |   53 +
 arch/mips/loongson/yeeloong-2f/reset.c             |   90 +
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
 arch/mips/txx9/generic/pci.c                       |    2 +-
 drivers/rtc/rtc-cmos.c                             |    8 +-
 drivers/video/Kconfig                              |   23 +
 drivers/video/Makefile                             |    1 +
 drivers/video/smi/Makefile                         |    8 +
 drivers/video/smi/smtc2d.c                         |  979 ++++++++
 drivers/video/smi/smtc2d.h                         |  530 ++++
 drivers/video/smi/smtcfb.c                         | 1138 +++++++++
 drivers/video/smi/smtcfb.h                         |  793 ++++++
 137 files changed, 19054 insertions(+), 3224 deletions(-)
 delete mode 100644 arch/mips/configs/fulong_defconfig
 create mode 100644 arch/mips/configs/fuloong2e_defconfig
 create mode 100644 arch/mips/configs/fuloong2f_defconfig
 create mode 100644 arch/mips/configs/yeeloong2f-7inch_defconfig
 create mode 100644 arch/mips/configs/yeeloong2f_defconfig
 delete mode 100644 arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/mc146818rtc.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/pci.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/war.h
 create mode 100644 arch/mips/include/asm/mach-loongson/clock.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cmdline.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_pci.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_vsm.h
 create mode 100644 arch/mips/include/asm/mach-loongson/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-loongson/loongson.h
 create mode 100644 arch/mips/include/asm/mach-loongson/machine.h
 create mode 100644 arch/mips/include/asm/mach-loongson/machtype.h
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
 create mode 100644 arch/mips/loongson/common/env.c
 create mode 100644 arch/mips/loongson/common/init.c
 create mode 100644 arch/mips/loongson/common/irq.c
 create mode 100644 arch/mips/loongson/common/machtype.c
 create mode 100644 arch/mips/loongson/common/mem.c
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
 create mode 100644 drivers/video/smi/Makefile
 create mode 100644 drivers/video/smi/smtc2d.c
 create mode 100644 drivers/video/smi/smtc2d.h
 create mode 100644 drivers/video/smi/smtcfb.c
 create mode 100644 drivers/video/smi/smtcfb.h
