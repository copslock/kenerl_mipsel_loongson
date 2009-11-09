Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 17:05:46 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:59067 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492371AbZKIQFk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 17:05:40 +0100
Received: by ewy12 with SMTP id 12so3401199ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 08:05:35 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Z/+HKZozATHVUyYzrIbkdhWprQDkkQJxlvuRjCNi6Do=;
        b=iduZwEAJy87cnyEppEtWdm+33kqu21x3T1LVPevM3Se5vQcSbfLo2MzM56TBgIKSVs
         QgYMa6XHwDmFs30x7hjp+vbd8Q6Y7DHxcB7PP8KCzXGh+cXW2Nwm5o+vLKT3bR5x3yHp
         w44D72KLJ/YU7TKHT+96zwRwOTD2/17roEsL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DzpFllJNzu0E8+AX9ZOe/5mJsg6/XddrPExz6NKghAEhhOMfijrolPxaQqBeCT4v1I
         m3LuMB3K81a7gBkAdFSFCEzlF10tHPp6GVClsFFrqdW/9OHwOjSR9ft/sM9cuzi6XIm2
         GwrZdxFsjsPa0wAUXIExJNzL4d8OWwWJLShg4=
Received: by 10.216.87.16 with SMTP id x16mr2628000wee.106.1257782732828;
        Mon, 09 Nov 2009 08:05:32 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id t12sm9166424gvd.22.2009.11.09.08.05.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 08:05:31 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-mips@linux-mips.org
Subject: [PATCH v2 0/7] add support for lemote loongson2f machines
Date:	Tue, 10 Nov 2009 00:05:21 +0800
Message-Id: <cover.1257781987.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset add basic support for lemote loongson2f family machines(fuloong2f
mini pc, yeeloong netbook).

If you use the default config file: arch/mips/configs/lemote2f_defconfig, and
pass the suitable command line argument to the kernel when booting, you will be
possible to run the same kernel image on fuloong2f mini pc and yeeloong
netbook.

for example, if you pass "machtype=8.9" to kernel when booting, it will run
well on yeeloong netbook. the default machtype is 2f-box, so, you can run the
kernel on fuloong2f directly. In the future, we will pass the machtype argument
by PMON directly, and then the linux distributions will only need to build one
kernel image, and will make it work on all of lemote loongson2f family
machines.

The main change from the v1 version:
    o [loongson] lemote-2f: add reset support
      use "switch...case..." statements instead of the array to make the stuff
      only for lemote2f family machines and also save some memory.

The whole patchset have been pushed into this branch:

git://dev.lemote.com/rt4ls.git linux-loongson/dev/for-upstream

Thanks & Regards,
       Wu Zhangjin

Wu Zhangjin (7):
  [loongson] lemote-2f: add a LEMOTE_MACH2F kernel option
  [loongson] lemote-2f: rtc: enable legacy RTC driver
  [loongson] lemote-2f: add basic cs5536 vsm support
  [loongson] lemote-2f: add pci support
  [loongson] lemote-2f: add irq support
  [loongson] lemote-2f: add reset support
  [loongson] lemote-2f: add defconfig file

 arch/mips/Kconfig                                  |    2 +-
 arch/mips/Makefile                                 |    1 +
 arch/mips/configs/lemote2f_defconfig               | 1836 ++++++++++++++++++++
 .../mips/include/asm/mach-loongson/cs5536/cs5536.h |  305 ++++
 .../include/asm/mach-loongson/cs5536/cs5536_pci.h  |  153 ++
 .../include/asm/mach-loongson/cs5536/cs5536_vsm.h  |   31 +
 arch/mips/include/asm/mach-loongson/loongson.h     |    7 +
 arch/mips/include/asm/mach-loongson/machine.h      |    7 +
 arch/mips/loongson/Kconfig                         |   32 +
 arch/mips/loongson/Makefile                        |    6 +
 arch/mips/loongson/common/Makefile                 |    6 +
 arch/mips/loongson/common/cs5536/Makefile          |    8 +
 arch/mips/loongson/common/cs5536/cs5536_acc.c      |  148 ++
 arch/mips/loongson/common/cs5536/cs5536_ehci.c     |  158 ++
 arch/mips/loongson/common/cs5536/cs5536_ide.c      |  185 ++
 arch/mips/loongson/common/cs5536/cs5536_isa.c      |  316 ++++
 arch/mips/loongson/common/cs5536/cs5536_ohci.c     |  153 ++
 arch/mips/loongson/common/cs5536/cs5536_pci.c      |   87 +
 arch/mips/loongson/lemote-2f/Makefile              |    5 +
 arch/mips/loongson/lemote-2f/irq.c                 |  130 ++
 arch/mips/loongson/lemote-2f/reset.c               |  172 ++
 arch/mips/pci/Makefile                             |    3 +-
 arch/mips/pci/fixup-lemote2f.c                     |  162 ++
 arch/mips/pci/ops-fuloong2e.c                      |  154 --
 arch/mips/pci/ops-loongson2.c                      |  208 +++
 25 files changed, 4119 insertions(+), 156 deletions(-)
 create mode 100644 arch/mips/configs/lemote2f_defconfig
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_pci.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_vsm.h
 create mode 100644 arch/mips/loongson/common/cs5536/Makefile
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_acc.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_ehci.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_ide.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_isa.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_ohci.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_pci.c
 create mode 100644 arch/mips/loongson/lemote-2f/Makefile
 create mode 100644 arch/mips/loongson/lemote-2f/irq.c
 create mode 100644 arch/mips/loongson/lemote-2f/reset.c
 create mode 100644 arch/mips/pci/fixup-lemote2f.c
 delete mode 100644 arch/mips/pci/ops-fuloong2e.c
 create mode 100644 arch/mips/pci/ops-loongson2.c
