Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2013 16:50:52 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:10705 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822672Ab3LQPuqntlG0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Dec 2013 16:50:46 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rBHFnnu3011770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 17 Dec 2013 10:49:49 -0500
Received: from deneb.redhat.com (ovpn-113-103.phx2.redhat.com [10.3.113.103])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id rBHFn9Ao022379;
        Tue, 17 Dec 2013 10:49:10 -0500
From:   Mark Salter <msalter@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH v2 00/10] Kconfig: cleanup SERIO_I8042 dependencies
Date:   Tue, 17 Dec 2013 10:48:43 -0500
Message-Id: <1387295333-24684-1-git-send-email-msalter@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <msalter@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msalter@redhat.com
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

This patch series removes the messy dependencies from SERIO_I8042
by having it depend on one variable (ARCH_MAY_HAVE_PC_SERIO) and
having architectures which need it select that variable in
arch/*/Kconfig.

New architectures are unlikely to need SERIO_I8042, so this avoids
having an ever growing list of architectures to exclude. If an
architecture without i8042 support isn't excluded through the
dependency list for SERIO_I8042 or through explicit disabling in
a config, it will likely panic on boot with something similar to
this (from arm64):

[   27.426181] [<ffffffc000403b1c>] i8042_flush+0x88/0x10c
[   27.426251] [<ffffffc00084cc2c>] i8042_init+0x58/0xe8
[   27.426320] [<ffffffc000080bec>] do_one_initcall+0xc4/0x14c
[   27.426404] [<ffffffc000820970>] kernel_init_freeable+0x1a4/0x244
[   27.426480] [<ffffffc0005a894c>] kernel_init+0x18/0x148
[   27.426561] Code: d2800c82 f2bf7c02 f2dff7e2 f2ffffe2 (39400042) 
[   27.426789] ---[ end trace ac076843cf0f383e ]---
[   27.426875] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

This is v2 of the patch series. Changes from version 1:

  o Added acks. arm, ia64, and sh are only ones without acks.
  o Moved select of ARCH_MIGHT_HAVE_PC_SERIO to board-specific
    Kconfigs for arm and sh.
    
A tree with these patches is at:

   git://github.com/mosalter/linux.git (serio-i8042-v2 branch)


Mark Salter (10):
  alpha: select ARCH_MIGHT_HAVE_PC_SERIO
  arm: select ARCH_MIGHT_HAVE_PC_SERIO
  ia64: select ARCH_MIGHT_HAVE_PC_SERIO
  mips: select ARCH_MIGHT_HAVE_PC_SERIO
  powerpc: select ARCH_MIGHT_HAVE_PC_SERIO
  sh: select ARCH_MIGHT_HAVE_PC_SERIO for SH_CAYMAN
  sparc: select ARCH_MIGHT_HAVE_PC_SERIO
  unicore32: select ARCH_MIGHT_HAVE_PC_SERIO
  x86: select ARCH_MIGHT_HAVE_PC_SERIO
  Kconfig: cleanup SERIO_I8042 dependencies

 arch/alpha/Kconfig               |  1 +
 arch/arm/mach-footbridge/Kconfig |  1 +
 arch/ia64/Kconfig                |  1 +
 arch/mips/Kconfig                |  1 +
 arch/powerpc/Kconfig             |  1 +
 arch/sh/boards/Kconfig           |  1 +
 arch/sparc/Kconfig               |  1 +
 arch/unicore32/Kconfig           |  1 +
 arch/x86/Kconfig                 |  1 +
 drivers/input/serio/Kconfig      | 11 ++++++++---
 10 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.8.3.1
