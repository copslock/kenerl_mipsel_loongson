Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2015 12:04:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7327 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007052AbbI1KEAQ9uCf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Sep 2015 12:04:00 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9C6ABE169FEA8;
        Mon, 28 Sep 2015 11:03:51 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 28 Sep 2015 11:03:53 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.88) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 28 Sep 2015 11:03:52 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] MIPS VDSO support
Date:   Mon, 28 Sep 2015 11:03:46 +0100
Message-ID: <1443434629-14325-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.88]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi,

This series adds a proper VDSO to the kernel on MIPS. The first commit
adds the basic VDSO, replacing the current signal return trampoline
page. The following commits add user implementations of gettimeofday() and
clock_gettime() which can make use of either the CP0 count or the GIC
user-mode visible section.

A tree with these changes can be found at [1]. It's based on v4.3-rc3

Use of the time functions relies on glibc modifications. A patch for
this can be found in my repository at [2] and I will soon post it to the glibc
mailing list.

[1]: http://git.linux-mips.org/cgit/mchandras/linux.git/log/?h=4.3-vdso
[2]: https://github.com/hwoarang/glibc/tree/2.22-vdso

Alex Smith (3):
  MIPS: Initial implementation of a VDSO
  irqchip: irq-mips-gic: Provide function to map GIC user section
  MIPS: VDSO: Add implementations of gettimeofday() and clock_gettime()

 arch/mips/Kbuild                     |   1 +
 arch/mips/Kconfig                    |   5 +
 arch/mips/include/asm/abi.h          |   5 +-
 arch/mips/include/asm/clocksource.h  |  29 ++++
 arch/mips/include/asm/elf.h          |   7 +
 arch/mips/include/asm/processor.h    |   8 +-
 arch/mips/include/asm/vdso.h         | 139 +++++++++++++++--
 arch/mips/include/uapi/asm/Kbuild    |   2 +-
 arch/mips/include/uapi/asm/auxvec.h  |  17 ++
 arch/mips/kernel/csrc-r4k.c          |  44 ++++++
 arch/mips/kernel/signal.c            |  12 +-
 arch/mips/kernel/signal32.c          |   7 +-
 arch/mips/kernel/signal_n32.c        |   5 +-
 arch/mips/kernel/vdso.c              | 198 ++++++++++++++---------
 arch/mips/vdso/.gitignore            |   4 +
 arch/mips/vdso/Makefile              | 142 +++++++++++++++++
 arch/mips/vdso/elf.S                 |  68 ++++++++
 arch/mips/vdso/genvdso.c             | 294 +++++++++++++++++++++++++++++++++++
 arch/mips/vdso/genvdso.h             | 188 ++++++++++++++++++++++
 arch/mips/vdso/gettimeofday.c        | 232 +++++++++++++++++++++++++++
 arch/mips/vdso/sigreturn.S           |  49 ++++++
 arch/mips/vdso/vdso.h                |  84 ++++++++++
 arch/mips/vdso/vdso.lds.S            | 103 ++++++++++++
 drivers/clocksource/mips-gic-timer.c |   7 +-
 drivers/irqchip/irq-mips-gic.c       |  27 +++-
 include/linux/irqchip/mips-gic.h     |  24 ++-
 26 files changed, 1572 insertions(+), 129 deletions(-)
 create mode 100644 arch/mips/include/asm/clocksource.h
 create mode 100644 arch/mips/include/uapi/asm/auxvec.h
 create mode 100644 arch/mips/vdso/.gitignore
 create mode 100644 arch/mips/vdso/Makefile
 create mode 100644 arch/mips/vdso/elf.S
 create mode 100644 arch/mips/vdso/genvdso.c
 create mode 100644 arch/mips/vdso/genvdso.h
 create mode 100644 arch/mips/vdso/gettimeofday.c
 create mode 100644 arch/mips/vdso/sigreturn.S
 create mode 100644 arch/mips/vdso/vdso.h
 create mode 100644 arch/mips/vdso/vdso.lds.S

-- 
2.5.3
