Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 14:12:04 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:51511 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492534AbZKFNL5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 14:11:57 +0100
Received: by pxi26 with SMTP id 26so367449pxi.21
        for <multiple recipients>; Fri, 06 Nov 2009 05:11:51 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NSJd8ftbFo3hu1fY+0crJZHR4X5MoT+MxFjoKPQEsig=;
        b=FhJtdiPC50gWtHalwvydX+oJtg/E80YhR9qdO/MAH3rKeCM5BwTtvPEaNt6z22JsTq
         SiI8r+K1Y6HthiMyHH9H9xiTsd6yCEAJG68oHFP48+HEe5bfZjsxVTgqcfA1plgvkOmc
         28kC4YnJDSRxZ6uQOlBvCKoJL0vLjI4fZjp7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nXANXSUEouJ+kF1p9EuzLo5+cFCmiJyKhGjGN/P9Lh62yfAAFzOdfCW6vlngOdEFQY
         aIrrKEYNbqJCXr6M3/DfAUj2SD2k0eecM7QgKuh4kRFargIs8+9njb0aFyqF+eI2O+AN
         o7jsE0EKtSvJymJeNfusiJGZoggsB3KKWNbRc=
Received: by 10.114.162.5 with SMTP id k5mr6714339wae.10.1257513111101;
        Fri, 06 Nov 2009 05:11:51 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm26431pxi.7.2009.11.06.05.11.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 05:11:50 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, zhangfx@lemote.com,
	yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH -queue v1 0/7] support for lemote loongson2f machines
Date:	Fri,  6 Nov 2009 21:11:25 +0800
Message-Id: <cover.1257510612.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset add basic support for lemote loongson2f machines, including
fuloong2f mini box, yeeloong2f netbook and mengloong2f netbook.

All of the lemote loongson2f family machines utilize the 2f revision of
loongson processor and the AMD cs5536 south bridge. The differences among these
machines are very small, the most important part should be the reset/shutdown
logic. so, it's possible to share the same kernel image among them, this
patchset really does it!

And of course, there are some other differences between the box and the
netbook:

1. the netbook has a sm712 video card, whose driver is not in the mainline yet,
if you only need the X window, there is an existing driver in X.  but if you
need a console, please add the sm712 video driver in the next patchset.
This video driver is not ready to upstream but we will try to push it
into drivers/staging asap.

2. the netbook has an Embedded Controller(kb3310b), which helps to do
reset/shutdown management, power supply/battery management, hotkey management,
display management and so forth. The corresponding platform drivers
will come later.

3. the netbook has a rtl8187b wifi netcard, there is an existing driver in the
mainline, but the performance is not good(and seems no rfkill support there), a
better one is maintained outside the mainline and it's not that easy to
upstream, but we will try it later.

And what about the common parts among them:

1. cpufreq support

the cpu frequency of loongson2f is software configurable(8 levels), and there
is an existing external mfgpt timer provided by cs5536, So, a cpufreq dirver
for loongson2f is also ready there, will come later.

2. standby support

also benefit from the above feature of loongson2f, when we put loongson2f into
ZERO frequency(wait mode), it will save about 2w for us, and wait there until
an external interrupt take place. So, it's possible to add standby support to
loongson2f family machines. the relative patches will also come later.

(This -v1 patch incorporates the feedbacks from Ralf & Arnaud Patard, the main
 change is putting all of the loongson2f machines into lemote-2f and hope this
 will make the linux distributions happy!)

Thanks & Regards,
	Wu Zhangjin

Wu Zhangjin (7):
  [loongson] lemote-2f: add lemote loongson2f family machines support
  [loongson] lemote-2f: rtc: enable legacy RTC driver
  [loongson] lemote-2f: add basic cs5536 vsm support
  [loongson] lemote-2f: add pci support
  [loongson] lemote-2f: add irq support
  [loongson] lemote-2f: add reset and shutdown support
  [loongson] lemote-2f: add defconfig file

 arch/mips/Kconfig                                  |    2 +-
 arch/mips/Makefile                                 |    1 +
 arch/mips/configs/lemote2f_defconfig               | 1794 ++++++++++++++++++++
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
 arch/mips/loongson/lemote-2f/reset.c               |  163 ++
 arch/mips/pci/Makefile                             |    3 +-
 arch/mips/pci/fixup-lemote2f.c                     |  162 ++
 arch/mips/pci/ops-fuloong2e.c                      |  154 --
 arch/mips/pci/ops-loongson2.c                      |  208 +++
 25 files changed, 4068 insertions(+), 156 deletions(-)
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
