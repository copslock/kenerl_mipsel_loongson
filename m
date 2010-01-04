Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 10:17:20 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:36824 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492628Ab0ADJRQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 10:17:16 +0100
Received: by yxe42 with SMTP id 42so15199460yxe.22
        for <multiple recipients>; Mon, 04 Jan 2010 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QJx9WnzhqLxc1oADgwb1wanDr6ZVP1dIYBPTHA5o8js=;
        b=ZnJry/b17TuEkFgdurTUalK2Bf2Ensnp2tnquYWDi2dbeOQV4+jJp1Sea/jwqLkKJn
         P6N6H3nMbnKdxKqnms24yYzf/iGV2oSxEjghTiwk9PJqCLUQKhYLfc9MEc6uRaQ1Cdp8
         zwwVBiuFWPZNUXMMQ+P+4s9NuyS2WhhKsnXxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aKUiJrPt7SH22AQYqML+PazBtvv69gfyYo7fgTTiVbbGHksn4myIZ74c6WEkMue7/8
         F8R1WidVVqcSZZn1cf8KDcU60avSTLWh8LAuVgblzQL8Ev27OGuttcrvpP4jUU2LK44i
         Lj87LDIOuzCEjQiMKQ6a1W2z5Eg7VP9bupdT8=
Received: by 10.151.24.13 with SMTP id b13mr34359500ybj.197.1262596629795;
        Mon, 04 Jan 2010 01:17:09 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm6122077ywh.16.2010.01.04.01.17.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 01:17:08 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 00/10] Misc updates of Loongson support 
Date:   Mon,  4 Jan 2010 17:16:42 +0800
Message-Id: <cover.1262586650.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
X-archive-position: 25498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2259

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset introduces the following changes:

	o Loongson: Lemote-2F: Get the machine type from PMON_VER
	  Allows the users of the old lemote 2f family machines to run the latest
	  kernel without passing the machtype= kernel command line.

	o Loongson: Lemote-2F: USB: Not Emulate Non-Posted Writes
	  When copying large amounts of data between usb devices and hard disk, the
	  usb device will disconnect, this patch fixes it.

	o Loongson: Convert loongson_halt() to use unreachable()
	  Use unreachable() instead of "while(1);"

	o Loongson: Remove the serial port output of compressed kernel support
	  The compressed kernel support is stable enough for loongson, no need to
	  print debug info, which will save several bytes and speedup the booting a
	  little.

	o Misc Cleanups
	  Loongson: Move prom_argc and prom_argv into prom_init_cmdline()
	  Loongson: Cleanup of the environment variables
	  Loongson: arch/mips/Makefile: add missing whitespace
	  Loongson: mem.c: Fixup of the indentation

	o Loongson: Change the Email address of Wu Zhangjin
	  my old Email address wuzj@lemote.com is not usable, use wuzhangjin@gmail.com instead.

	o Loongson: Lemote-2F: update defconfig
	  Update the defconfig for the latest kernel supports

Best Regards,
		Wu Zhangjin

Wu Zhangjin (10):
  Loongson: Lemote-2F: Get the machine type from PMON_VER
  Loongson: Lemote-2F: USB: Not Emulate Non-Posted Writes
  Loongson: Convert loongson_halt() to use unreachable()
  Loongson: Remove the serial port output of compressed kernel support
  Loongson: Move prom_argc and prom_argv into prom_init_cmdline()
  Loongson: Cleanup of the environment variables
  Loongson: arch/mips/Makefile: add missing whitespace
  Loongson: mem.c: Fixup of the indentation
  Loongson: Change the Email address of Wu Zhangjin
  Loongson: Lemote-2F: update defconfig

 arch/mips/Kconfig                                  |    2 +-
 arch/mips/Makefile                                 |    6 +-
 arch/mips/boot/compressed/Makefile                 |    2 +-
 arch/mips/boot/compressed/decompress.c             |    4 +-
 arch/mips/configs/lemote2f_defconfig               |  964 ++++++++++++++------
 arch/mips/include/asm/ftrace.h                     |    2 +-
 .../asm/mach-loongson/cpu-feature-overrides.h      |    2 +-
 .../include/asm/mach-loongson/cs5536/cs5536_vsm.h  |    2 +-
 arch/mips/include/asm/mach-loongson/loongson.h     |    5 +-
 arch/mips/include/asm/mach-loongson/machine.h      |    4 +-
 arch/mips/include/asm/mach-loongson/mem.h          |    2 +-
 arch/mips/include/asm/mach-loongson/pci.h          |   13 +-
 arch/mips/kernel/ftrace.c                          |    2 +-
 arch/mips/kernel/mcount.S                          |    2 +-
 arch/mips/loongson/common/cmdline.c                |    9 +-
 arch/mips/loongson/common/cs5536/cs5536_acc.c      |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_ehci.c     |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_ide.c      |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_isa.c      |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c    |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_ohci.c     |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_pci.c      |    2 +-
 arch/mips/loongson/common/early_printk.c           |    2 +-
 arch/mips/loongson/common/env.c                    |   29 +-
 arch/mips/loongson/common/init.c                   |    2 +-
 arch/mips/loongson/common/machtype.c               |   12 +-
 arch/mips/loongson/common/mem.c                    |    7 +-
 arch/mips/loongson/common/platform.c               |    2 +-
 arch/mips/loongson/common/pm.c                     |    2 +-
 arch/mips/loongson/common/reset.c                  |    7 +-
 arch/mips/loongson/common/serial.c                 |    2 +-
 arch/mips/loongson/common/time.c                   |    4 +-
 arch/mips/loongson/common/uart_base.c              |    2 +-
 arch/mips/loongson/fuloong-2e/reset.c              |    4 +-
 arch/mips/loongson/lemote-2f/Makefile              |    1 +
 arch/mips/loongson/lemote-2f/machtype.c            |   45 +
 arch/mips/loongson/lemote-2f/pm.c                  |    2 +-
 arch/mips/loongson/lemote-2f/reset.c               |    2 +-
 arch/mips/oprofile/op_model_loongson2.c            |    2 +-
 arch/mips/pci/fixup-lemote2f.c                     |    2 +-
 arch/mips/pci/ops-loongson2.c                      |    4 +-
 arch/mips/power/cpu.c                              |    4 +-
 arch/mips/power/hibernate.S                        |    4 +-
 drivers/staging/sm7xx/smtc2d.c                     |    2 +-
 drivers/staging/sm7xx/smtc2d.h                     |    2 +-
 drivers/staging/sm7xx/smtcfb.c                     |    2 +-
 drivers/staging/sm7xx/smtcfb.h                     |    2 +-
 47 files changed, 807 insertions(+), 377 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/machtype.c
