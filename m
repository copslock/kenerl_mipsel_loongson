Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 04:48:19 +0200 (CEST)
Received: from m50-132.163.com ([123.125.50.132]:58180 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006657AbcDNCsPvwgrW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Apr 2016 04:48:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=zmjvkGCK9cl9dxpbLY
        wgljnqLHp0pzoajC0e68EFGCs=; b=oe5JUfOPOoLQl4zdqO+es0U9esXLs8feX4
        pP2KLm5afc5Z2WZJKEZQqhH5TMPGIW8qOqtywjABynD9Runr3MeuC3r/mfhDFpP3
        uE5M8DUPpcxwZA8IBQJFKBS4hV62Cq0wU97hOVqU6d3wmhUUM7E8SvOQV/B7v8ae
        s3UbVewx8=
Received: from zhaoxiuzeng-VirtualBox.spreadtrum.com (unknown [112.95.225.98])
        by smtp2 (Coremail) with SMTP id DNGowABHsP4hAw9XO5mJAw--.15034S2;
        Thu, 14 Apr 2016 10:40:45 +0800 (CST)
From:   zengzhaoxiu@163.com
To:     linux-kernel@vger.kernel.org
Cc:     Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@samba.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Bruce Allan <bruce.w.allan@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        David Herrmann <dh.herrmann@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Duson Lin <dusonlin@emc.com.tw>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ingo Molnar <mingo@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Julian Calaby <julian.calaby@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-crypto@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux@lists.openrisc.net,
        linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Martin Kepplinger <martink@posteo.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Nazarewicz <mina86@mina86.com>, netdev@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Pingchao Yang <pingchao.yang@intel.com>, qat-linux@intel.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Sasha Levin <sasha.levin@oracle.com>,
        Scott Wood <oss@buserror.net>, sparclinux@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Torsten Duwe <duwe@lst.de>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Ulrik De Bie <ulrik.debie-os@e2big.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "wim.coekaerts@oracle.com" <wim.coekaerts@oracle.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Yury Norov <yury.norov@gmail.com>,
        =?UTF-8?q?=E6=B4=AA=E4=B8=80=E7=AB=B9?= <sam.hung@emc.com.tw>
Subject: [PATCH V3 00/29] bitops: add parity functions
Date:   Thu, 14 Apr 2016 10:36:41 +0800
Message-Id: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.5.0
X-CM-TRANSID: DNGowABHsP4hAw9XO5mJAw--.15034S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrWDury7Zr4UWrWrCw1Utrb_yoWxXF18pF
        4DCrn5Cry8GryIyFsxtFn29F1ftayrKFWagrya934kA3Z7tryjyFsYkw47Aw1qyanrtr1I
        gFnxurWDW3WvvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdo7NUUUUU=
X-Originating-IP: [112.95.225.98]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/1tbiJQ1LgFUL-E972AAAst
Return-Path: <zengzhaoxiu@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zengzhaoxiu@163.com
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

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

When I do "grep parity -r linux", I found many parity calculations
distributed in many drivers.

This patch series does:
  1. provide generic and architecture-specific parity calculations
  2. remove drivers' local parity calculations, use bitops' parity
     functions instead
  3. replace "hweightN(x) & 1" with "parityN(x)" to improve readability,
     and improve performance on some CPUs that without popcount support

I did not use GCC's __builtin_parity* functions, based on the following reasons:
  1. I don't know where to identify which version of GCC from the beginning
     supported __builtin_parity for the architecture.
  2. For the architecture that doesn't has popcount instruction, GCC instead use
     "call __paritysi2" (__paritydi2 for 64-bits). So if use __builtin_parity, we must
     provide __paritysi2 and __paritydi2 functions for these architectures.
     Additionally, parity4,8,16 might be "__builtin_parity(x & mask)", but the "& mask"
     operation is totally unnecessary.
  3. For the architecture that has popcount instruction, we do the same things.
  4. For powerpc, sparc, and x86, we do runtime patching to use popcount instruction
     if the CPU support.

I have compiled successfully with x86_64_defconfig, i386_defconfig, pseries_defconfig
and sparc64_defconfig.

Changes to v2:
- Add constant PARITY_MAGIC (proposals by Sam Ravnborg)
- Add include/asm-generic/bitops/popc-parity.h (proposals by Chris Metcalf)
- Tile uses popc-parity.h directly
- Mips uses popc-parity.h if has usable __builtin_popcount
- Add few comments in powerpc's and sparc's parity.S
- X86, remove custom calling convention

Changes to v1:
- Add runtime patching for powerpc, sparc, and x86
- Avr32 use grenric parity too
- Fix error in ssfdc's patch, and add commit message
- Don't change the original code composition of drivers/iio/gyro/adxrs450.c
- Directly assignement to phy_cap.parity in drivers/scsi/isci/phy.c

Regards,

=== diffstat ===

Zhaoxiu Zeng (29):
  bitops: add parity functions
  Include generic parity.h in some architectures' bitops.h
  Add alpha-specific parity functions
  Add blackfin-specific parity functions
  Add ia64-specific parity functions
  Tile and MIPS (if has usable __builtin_popcount) use popcount parity
    functions
  Add powerpc-specific parity functions
  Add sparc-specific parity functions
  Add x86-specific parity functions
  sunrpc: use parity8
  mips: use parity functions in cerr-sb1.c
  bch: use parity32
  media: use parity8 in vivid-vbi-gen.c
  media: use parity functions in saa7115
  input: use parity32 in grip_mp
  input: use parity64 in sidewinder
  input: use parity16 in ams_delta_serio
  scsi: use parity32 in isci's phy
  mtd: use parity16 in ssfdc
  mtd: use parity functions in inftlcore
  crypto: use parity functions in qat_hal
  mtd: use parity16 in sm_ftl
  ethernet: use parity8 in sun/niu.c
  input: use parity8 in pcips2
  input: use parity8 in sa1111ps2
  iio: use parity32 in adxrs450
  serial: use parity32 in max3100
  input: use parity8 in elantech
  ethernet: use parity8 in broadcom/tg3.c

 arch/alpha/include/asm/bitops.h              |  27 +++++
 arch/arc/include/asm/bitops.h                |   1 +
 arch/arm/include/asm/bitops.h                |   1 +
 arch/arm64/include/asm/bitops.h              |   1 +
 arch/avr32/include/asm/bitops.h              |   1 +
 arch/blackfin/include/asm/bitops.h           |  31 ++++++
 arch/c6x/include/asm/bitops.h                |   1 +
 arch/cris/include/asm/bitops.h               |   1 +
 arch/frv/include/asm/bitops.h                |   1 +
 arch/h8300/include/asm/bitops.h              |   1 +
 arch/hexagon/include/asm/bitops.h            |   1 +
 arch/ia64/include/asm/bitops.h               |  31 ++++++
 arch/m32r/include/asm/bitops.h               |   1 +
 arch/m68k/include/asm/bitops.h               |   1 +
 arch/metag/include/asm/bitops.h              |   1 +
 arch/mips/include/asm/bitops.h               |   7 ++
 arch/mips/mm/cerr-sb1.c                      |  67 ++++---------
 arch/mn10300/include/asm/bitops.h            |   1 +
 arch/openrisc/include/asm/bitops.h           |   1 +
 arch/parisc/include/asm/bitops.h             |   1 +
 arch/powerpc/include/asm/bitops.h            |  11 +++
 arch/powerpc/lib/Makefile                    |   2 +-
 arch/powerpc/lib/parity_64.S                 | 142 +++++++++++++++++++++++++++
 arch/powerpc/lib/ppc_ksyms.c                 |   5 +
 arch/s390/include/asm/bitops.h               |   1 +
 arch/sh/include/asm/bitops.h                 |   1 +
 arch/sparc/include/asm/bitops_32.h           |   1 +
 arch/sparc/include/asm/bitops_64.h           |  18 ++++
 arch/sparc/kernel/sparc_ksyms_64.c           |   6 ++
 arch/sparc/lib/Makefile                      |   2 +-
 arch/sparc/lib/parity.S                      | 128 ++++++++++++++++++++++++
 arch/tile/include/asm/bitops.h               |   2 +
 arch/x86/include/asm/arch_hweight.h          |   5 +
 arch/x86/include/asm/arch_parity.h           | 117 ++++++++++++++++++++++
 arch/x86/include/asm/bitops.h                |   4 +-
 arch/xtensa/include/asm/bitops.h             |   1 +
 drivers/crypto/qat/qat_common/qat_hal.c      |  32 ++----
 drivers/iio/gyro/adxrs450.c                  |   4 +-
 drivers/input/joystick/grip_mp.c             |  16 +--
 drivers/input/joystick/sidewinder.c          |  24 +----
 drivers/input/mouse/elantech.c               |  10 +-
 drivers/input/mouse/elantech.h               |   1 -
 drivers/input/serio/ams_delta_serio.c        |   8 +-
 drivers/input/serio/pcips2.c                 |   2 +-
 drivers/input/serio/sa1111ps2.c              |   2 +-
 drivers/media/i2c/saa7115.c                  |  17 +---
 drivers/media/platform/vivid/vivid-vbi-gen.c |   9 +-
 drivers/mtd/inftlcore.c                      |  17 +---
 drivers/mtd/sm_ftl.c                         |   5 +-
 drivers/mtd/ssfdc.c                          |  31 ++----
 drivers/net/ethernet/broadcom/tg3.c          |   6 +-
 drivers/net/ethernet/sun/niu.c               |  10 +-
 drivers/scsi/isci/phy.c                      |  15 +--
 drivers/tty/serial/max3100.c                 |   2 +-
 include/asm-generic/bitops.h                 |   1 +
 include/asm-generic/bitops/arch_parity.h     |  39 ++++++++
 include/asm-generic/bitops/const_parity.h    |  36 +++++++
 include/asm-generic/bitops/parity.h          |   7 ++
 include/asm-generic/bitops/popc-parity.h     |  32 ++++++
 include/linux/bitops.h                       |  10 ++
 lib/bch.c                                    |  14 +--
 net/sunrpc/auth_gss/gss_krb5_keys.c          |   6 +-
 62 files changed, 745 insertions(+), 235 deletions(-)
 create mode 100644 arch/powerpc/lib/parity_64.S
 create mode 100644 arch/sparc/lib/parity.S
 create mode 100644 arch/x86/include/asm/arch_parity.h
 create mode 100644 include/asm-generic/bitops/arch_parity.h
 create mode 100644 include/asm-generic/bitops/const_parity.h
 create mode 100644 include/asm-generic/bitops/parity.h
 create mode 100644 include/asm-generic/bitops/popc-parity.h

-- 
2.5.0
