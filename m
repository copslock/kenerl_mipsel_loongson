Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Sep 2010 07:11:40 +0200 (CEST)
Received: from mail.perches.com ([173.55.12.10]:1755 "EHLO mail.perches.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490961Ab0ILFLO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Sep 2010 07:11:14 +0200
Received: from Joe-Laptop.home (unknown [192.168.1.162])
        by mail.perches.com (Postfix) with ESMTP id 0E68224368;
        Sat, 11 Sep 2010 22:10:52 -0700 (PDT)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Eric Miao <eric.y.miao@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Haavard Skinnemoen <hskinnemoen@atmel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Avi Kivity <avi@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Alexander Graf <agraf@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tom Tucker <tom@opengridcomputing.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Roland Dreier <rolandd@cisco.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        David Brownell <dbrownell@users.sourceforge.net>,
        Geoff Levand <geoff@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Liam Girdwood <lrg@slimlogic.co.uk>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, cbe-oss-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 00/11] treewide: Remove pr_<level> uses with KERN_<level>
Date:   Sat, 11 Sep 2010 22:10:48 -0700
Message-Id: <cover.1284267142.git.joe@perches.com>
X-Mailer: git-send-email 1.7.3.rc1
X-archive-position: 27747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9212

Most of these are pr_debug(KERN_<foo>.
pr_<level>(KERN_<level> is unnecessary.

Joe Perches (11):
  arch/arm: Remove pr_<level> uses of KERN_<level>
  arch/avr32: Remove pr_<level> uses of KERN_<level>
  arch/microblaze: Remove pr_<level> uses of KERN_<level>
  arch/mips: Remove pr_<level> uses of KERN_<level>
  arch/powerpc: Remove pr_<level> uses of KERN_<level>
  arch/x86: Remove pr_<level> uses of KERN_<level>
  drivers/infiniband: Remove pr_<level> uses of KERN_<level>
  drivers/net/skfp: Remove pr_<level> uses of KERN_<level>
  drivers/staging/msm: Remove pr_<level> uses of KERN_<level>
  drivers/usb/gadget: Remove pr_<level> uses of KERN_<level>
  sound: Remove pr_<level> uses of KERN_<level>

 arch/arm/mach-pxa/cpufreq-pxa2xx.c       |    3 +-
 arch/avr32/mach-at32ap/at32ap700x.c      |    4 +-
 arch/microblaze/kernel/exceptions.c      |   16 ++----
 arch/mips/kernel/irq-gic.c               |    2 +-
 arch/mips/pci/pci-rc32434.c              |    2 +-
 arch/powerpc/kvm/emulate.c               |    4 +-
 arch/powerpc/sysdev/pmi.c                |    2 +-
 arch/x86/kernel/apb_timer.c              |    4 +-
 drivers/infiniband/hw/amso1100/c2_intr.c |    4 +-
 drivers/net/skfp/skfddi.c                |   84 +++++++++++++++---------------
 drivers/staging/msm/staging-devices.c    |    2 +-
 drivers/usb/gadget/r8a66597-udc.c        |    2 +-
 sound/ppc/snd_ps3.c                      |    2 +-
 sound/soc/s3c24xx/s3c-dma.c              |    3 +-
 14 files changed, 64 insertions(+), 70 deletions(-)

-- 
1.7.3.rc1
