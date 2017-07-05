Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2017 22:02:44 +0200 (CEST)
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:56536 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993876AbdGEUChYzY3s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jul 2017 22:02:37 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id AB730181D341F;
        Wed,  5 Jul 2017 20:02:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: word20_8ab228b149b1d
X-Filterd-Recvd-Size: 3331
Received: from joe-laptop.perches.com (unknown [47.151.132.55])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Jul 2017 20:02:32 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-m68k@lists.linux-m68k.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org
Subject: [PATCH 00/18] treewide: Move storage class before return type
Date:   Wed,  5 Jul 2017 13:02:09 -0700
Message-Id: <cover.1499284835.git.joe@perches.com>
X-Mailer: git-send-email 2.10.0.rc2.1.g053435c
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

Move the inline/asmlinkage keywords before the return types
Add a checkpatch test for this too.

Joe Perches (18):
  checkpatch: improve the STORAGE_CLASS test
  ARM: KVM: Move asmlinkage before type
  ARM: HP Jornada 7XX: Move inline before return type
  CRIS: gpio: Move inline before return type
  FRV: tlbflush: Move asmlinkage before return type
  ia64: Move inline before return type
  ia64: sn: pci: Move inline before type
  m68k: coldfire: Move inline before return type
  MIPS: SMP: Move asmlinkage before return type
  sh: Move inline before return type
  x86/efi: Move asmlinkage before return type
  drivers: s390: Move static and inline before return type
  drivers: tty: serial: Move inline before return type
  USB: serial: safe_serial: Move __inline__ before return type
  video: fbdev: intelfb: Move inline before return type
  video: fbdev: omap: Move inline before return type
  ARM: samsung: usb-ohci: Move inline before return type
  ALSA: opl4: Move inline before return type

 arch/arm/include/asm/kvm_hyp.h                 |  8 ++++----
 arch/arm/mach-sa1100/jornada720_ssp.c          |  2 +-
 arch/cris/arch-v10/drivers/gpio.c              |  4 ++--
 arch/frv/include/asm/tlbflush.h                |  8 ++++----
 arch/ia64/kernel/mca.c                         |  2 +-
 arch/ia64/sn/pci/pcibr/pcibr_ate.c             |  2 +-
 arch/ia64/sn/pci/tioce_provider.c              |  4 ++--
 arch/m68k/coldfire/intc-simr.c                 |  4 ++--
 arch/mips/include/asm/smp.h                    |  2 +-
 arch/sh/mm/cache-sh5.c                         |  2 +-
 arch/x86/include/asm/efi.h                     |  4 ++--
 drivers/s390/net/ctcm_main.c                   |  2 +-
 drivers/s390/net/qeth_l3_main.c                |  2 +-
 drivers/tty/serial/ioc3_serial.c               |  4 ++--
 drivers/tty/serial/ioc4_serial.c               |  4 ++--
 drivers/usb/serial/safe_serial.c               |  2 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c       |  2 +-
 drivers/video/fbdev/omap/lcdc.c                |  6 +++---
 include/linux/platform_data/usb-ohci-s3c2410.h |  2 +-
 scripts/checkpatch.pl                          | 12 ++++++++++--
 sound/drivers/opl4/opl4_lib.c                  |  2 +-
 21 files changed, 44 insertions(+), 36 deletions(-)

-- 
2.10.0.rc2.1.g053435c
