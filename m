Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 10:03:11 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:45071 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492008AbZKDJDE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 10:03:04 +0100
Received: by pwi11 with SMTP id 11so3157807pwi.24
        for <multiple recipients>; Wed, 04 Nov 2009 01:02:56 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZN38nZ0EjfzOp0YuZCAATrHZqDUosCdKCeABKnb2VsI=;
        b=iYZiFLX6yCFyPMjuwQ3+Y6KnQxbVmaaiKoA0xNnrdWW7vhzGeq+8HlNf9cc7IKxvHR
         2Oj/2+gIrdgHIi7/OnTNF9X98iBN5/DzdM+3SdAC2Tbu/s9/YKWeZSya3d7//PM//57Z
         UWjLGvZJdXAKglh0htt7W7irI37pGbg/AxYF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=H3Ki0AWBK6VH9brXJ3DMWBS+ebc+Nt11dKXycR7UqTG2B/KB/VDSP9YvX+oqZCAlfH
         SPuqzhMixjhWVCqLDWNfI1Z3i0quNWcTMmpVahKwXOHylxJGxwi12auSDhuY/4STn1lu
         J38Ud7FtcRSONUAj9AoWtOJogUQRei/A00H/s=
Received: by 10.114.165.18 with SMTP id n18mr1625220wae.154.1257325376532;
        Wed, 04 Nov 2009 01:02:56 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm498846pzk.7.2009.11.04.01.02.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 01:02:56 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com
Subject: [PATCH -queue v0 0/6] add support for Lemote's fuloong2f
Date:	Wed,  4 Nov 2009 17:02:44 +0800
Message-Id: <cover.1257324485.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patchset add the basic support for fuloong2f machine made by Lemote.

fuloong2f is a loongson2f based machine, it use the 2F revision of loongson
processor and AMD cs5536 south bridge.

The 2E revision of loongson processor is supported by the mainline kernel yet,
what we added here is the 2F specific support, including a new address window
configuration module support and the cpu frequency configuration support.

And for the AMD cs5536 south bridge, we add relative source code to virtualize
the PCI configure space to allow it can be accessed as a normal multi-function
PCI device which follows the PCI-2.2 spec.

Besides, the rtc and oprofile support for fuloong2f are also added.

Regards,
	Wu Zhangjin

Wu Zhangjin (6):
  [loongson] add basic loongson-2f support
  [loongson] oprofile: avoid do_IRQ for perfcounter when the interrupt
    is from bonito
  [loongson] add basic cs5536 vsm support
  [loongson] add basic fuloong2f support
  [loongson] rtc: enable legacy RTC driver on fuloong2f
  [loongson] add default config file for fuloong2f

 arch/mips/Kconfig                                  |   20 +-
 arch/mips/Makefile                                 |    3 +
 arch/mips/configs/fuloong2f_defconfig              | 1608 ++++++++++++++++++++
 .../mips/include/asm/mach-loongson/cs5536/cs5536.h |  305 ++++
 .../include/asm/mach-loongson/cs5536/cs5536_pci.h  |  153 ++
 .../include/asm/mach-loongson/cs5536/cs5536_vsm.h  |   31 +
 .../mips/include/asm/mach-loongson/dma-coherence.h |    4 +
 arch/mips/include/asm/mach-loongson/loongson.h     |   84 +-
 arch/mips/include/asm/mach-loongson/machine.h      |    8 +-
 arch/mips/include/asm/mach-loongson/mem.h          |   25 +-
 arch/mips/include/asm/mach-loongson/pci.h          |   28 +-
 arch/mips/loongson/Kconfig                         |   33 +
 arch/mips/loongson/Makefile                        |    6 +
 arch/mips/loongson/common/Makefile                 |    6 +
 arch/mips/loongson/common/bonito-irq.c             |    5 +
 arch/mips/loongson/common/cs5536/Makefile          |    8 +
 arch/mips/loongson/common/cs5536/cs5536_acc.c      |  150 ++
 arch/mips/loongson/common/cs5536/cs5536_ehci.c     |  160 ++
 arch/mips/loongson/common/cs5536/cs5536_ide.c      |  187 +++
 arch/mips/loongson/common/cs5536/cs5536_isa.c      |  322 ++++
 arch/mips/loongson/common/cs5536/cs5536_ohci.c     |  155 ++
 arch/mips/loongson/common/cs5536/cs5536_pci.c      |   89 ++
 arch/mips/loongson/common/init.c                   |   18 +
 arch/mips/loongson/common/mem.c                    |   17 +
 arch/mips/loongson/common/pci.c                    |    8 +
 arch/mips/loongson/fuloong-2f/Makefile             |    5 +
 arch/mips/loongson/fuloong-2f/irq.c                |  114 ++
 arch/mips/loongson/fuloong-2f/reset.c              |   68 +
 arch/mips/oprofile/op_model_loongson2.c            |    3 +
 arch/mips/pci/Makefile                             |    3 +-
 arch/mips/pci/fixup-fuloong2f.c                    |  171 +++
 arch/mips/pci/ops-fuloong2e.c                      |  154 --
 arch/mips/pci/ops-loongson2.c                      |  207 +++
 33 files changed, 3991 insertions(+), 167 deletions(-)
 create mode 100644 arch/mips/configs/fuloong2f_defconfig
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
 create mode 100644 arch/mips/loongson/fuloong-2f/Makefile
 create mode 100644 arch/mips/loongson/fuloong-2f/irq.c
 create mode 100644 arch/mips/loongson/fuloong-2f/reset.c
 create mode 100644 arch/mips/pci/fixup-fuloong2f.c
 delete mode 100644 arch/mips/pci/ops-fuloong2e.c
 create mode 100644 arch/mips/pci/ops-loongson2.c
