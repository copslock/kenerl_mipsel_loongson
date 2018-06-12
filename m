Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 16:05:58 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992614AbeFLOFu4N1TI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jun 2018 16:05:50 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AB40208B0;
        Tue, 12 Jun 2018 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528812343;
        bh=j5iKiSpxqZKgmrz0nQSCcLZ0rty8j0RMhAcIA6QYLIs=;
        h=Date:From:To:Cc:Subject:From;
        b=GfUJ6adZlhZCy6go/tVEMLeukg2bAaXlqmOGL0zsXKgZe9hxAu6EzdeUZqlKJMz9A
         phh/oR2yxjWbVkvyk7qt4JWzScPSDe+mjG8nvdC5Qxu63X/TDnuezG/gCJ/LkghDou
         bJkTa/kcCqCZZJzAZvG6EmS1K3PlJAyFHImy8tPg=
Date:   Tue, 12 Jun 2018 15:05:39 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS changes for 4.18
Message-ID: <20180612140538.GA12192@jamesdev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here are the main MIPS changes for 4.18, along with a MAINTAINERS update
to make Paul Burton a MIPS co-maintainer, as I soon won't have access to
much MIPS hardware, nor enough time to properly maintain MIPS on my own.

A merge conflict is expected in arch/mips/boot/dts/xilfpga/Makefile
between mainline commit a5a92abbce56 ("MIPS: xilfpga: Stop generating
useless dtb.o") and commit fca3aa166422 ("MIPS: dts: Avoid unneeded
built-in.a in DTS dirs") in this branch. The mainline commit should take
precedence, dropping the conflicting obj- line.

Please pull,

Thanks
James

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_4.=
18

for you to fetch changes up to 9ed8b56b80c11ef7c25230b93f2c486fe6b41c4d:

  MAINTAINERS: Add Paul Burton as MIPS co-maintainer (2018-06-11 13:37:49 +=
0100)

----------------------------------------------------------------
MIPS changes for 4.18

These are the main MIPS changes for 4.18. Rough overview:

 (1) MAINTAINERS: Add Paul Burton as MIPS co-maintainer

 (2) Misc: Generic compiler intrinsics, Y2038 improvements, Perf+MT fixes

 (3) Platform support: Netgear WNR1000 V3, Microsemi Ocelot integrated
     switch, Ingenic watchdog cleanups

Maintainers:

 - Add Paul Burton as MIPS co-maintainer

Miscellaneous:

 - Use generic GCC library routines from lib/
   - Add notrace to generic ucmpdi2 implementation
   - Rename compiler intrinsic selects to GENERIC_LIB_*
   - vmlinuz: Use generic ashldi3

 - y2038: Convert update/read_persistent_clock() to *_clock64()
   - sni: Remove read_persistent_clock()

 - perf: Fix perf with MT counting other threads
   - Probe for per-TC perf counters in cpu-probe.c
   - Use correct VPE ID for VPE tracing

Minor cleanups:

 - Avoid unneeded built-in.a in DTS dirs

 - sc-debugfs: Re-use kstrtobool_from_user

 - memset.S: Reinstate delay slot indentation

 - VPE: Fix spelling "uneeded" -> "Unneeded"

Platform support:

BCM47xx:

 - Add support for Netgear WNR1000 V3

 - firmware: Support small NVRAM partitions

 - Use __initdata for LEDs platform data

Ingenic:

 - Watchdog driver & platform code improvements:
   - Disable clock after stopping counter
   - Use devm_* functions
   - Drop module remove function
   - Move platform reset code to restart handler in driver
   - JZ4740: Convert watchdog instantiation to DT
   - JZ4780: Fix watchdog DT node
   - qi_lb60_defconfig: Enable watchdog driver

Microsemi:

 - Ocelot: Add support for integrated switch
   - pcb123: Connect phys to ports

----------------------------------------------------------------
Alexandre Belloni (2):
      MIPS: mscc: Add switch to ocelot
      MIPS: mscc: Connect phys to ports on ocelot_pcb123

Andy Shevchenko (1):
      MIPS: Re-use kstrtobool_from_user()

Antony Pavlov (1):
      MIPS: Use generic GCC library routines from lib/

Baolin Wang (3):
      MIPS: sni: Remove the read_persistent_clock()
      MIPS: Convert read_persistent_clock() to read_persistent_clock64()
      MIPS: Convert update_persistent_clock() to update_persistent_clock64()

Colin Ian King (1):
      MIPS: VPE: Fix spelling mistake: "uneeded" -> "unneeded"

James Hogan (1):
      MAINTAINERS: Add Paul Burton as MIPS co-maintainer

Maciej W. Rozycki (1):
      MIPS: ptrace: Make FPU context layout comments match reality

Masahiro Yamada (1):
      MIPS: dts: Avoid unneeded built-in.a in DTS dirs

Matt Redfearn (7):
      lib: Rename compiler intrinsic selects to GENERIC_LIB_*
      MIPS: vmlinuz: Use generic ashldi3
      MIPS: Probe for MIPS MT perf counters per TC
      MIPS: perf: More robustly probe for the presence of per-tc counters
      MIPS: perf: Use correct VPE ID when setting up VPE tracing
      MIPS: perf: Fix perf with MT counting other threads
      MIPS: memset.S: Reinstate delay slot indentation

Palmer Dabbelt (1):
      Add notrace to lib/ucmpdi2.c

Paul Cercueil (8):
      watchdog: JZ4740: Disable clock after stopping counter
      watchdog: JZ4740: Use devm_* functions
      watchdog: JZ4740: Register a restart handler
      watchdog: JZ4740: Drop module remove function
      MIPS: JZ4740: dts: Add bindings for the jz4740-wdt driver
      MIPS: JZ4780: dts: Fix watchdog node
      MIPS: qi_lb60: Enable the jz4740-wdt driver
      MIPS: JZ4740: Drop old platform reset code

Rafa=C5=82 Mi=C5=82ecki (3):
      MIPS: BCM47XX: Add support for Netgear WNR1000 V3
      firmware: bcm47xx_nvram: Support small (0x6000 B) NVRAM partitions
      MIPS: BCM47XX: Use __initdata for the bcm47xx_leds_pdata

 .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  7 +-
 MAINTAINERS                                        |  2 +
 arch/mips/Kconfig                                  |  5 ++
 arch/mips/bcm47xx/board.c                          |  2 +
 arch/mips/bcm47xx/buttons.c                        |  9 +++
 arch/mips/bcm47xx/leds.c                           | 11 ++-
 arch/mips/boot/compressed/Makefile                 | 11 ++-
 arch/mips/boot/dts/brcm/Makefile                   |  2 +-
 arch/mips/boot/dts/cavium-octeon/Makefile          |  2 +-
 arch/mips/boot/dts/ingenic/Makefile                |  2 +-
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |  8 ++
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |  5 +-
 arch/mips/boot/dts/lantiq/Makefile                 |  2 +-
 arch/mips/boot/dts/mscc/Makefile                   |  2 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi                | 88 ++++++++++++++++++=
+++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts          | 20 +++++
 arch/mips/boot/dts/mti/Makefile                    |  2 +-
 arch/mips/boot/dts/netlogic/Makefile               |  2 +-
 arch/mips/boot/dts/pic32/Makefile                  |  2 +-
 arch/mips/boot/dts/ralink/Makefile                 |  2 +-
 arch/mips/boot/dts/xilfpga/Makefile                |  2 +-
 arch/mips/configs/qi_lb60_defconfig                |  2 +
 arch/mips/dec/time.c                               | 12 +--
 arch/mips/include/asm/cpu-features.h               |  7 ++
 arch/mips/include/asm/cpu.h                        |  2 +
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |  1 +
 arch/mips/include/asm/mach-jz4740/platform.h       |  1 -
 arch/mips/include/asm/mc146818-time.h              |  4 +-
 arch/mips/include/asm/mipsregs.h                   |  5 ++
 arch/mips/include/asm/time.h                       |  9 ---
 arch/mips/jz4740/platform.c                        | 16 ----
 arch/mips/jz4740/reset.c                           | 31 --------
 arch/mips/kernel/cpu-probe.c                       | 12 +++
 arch/mips/kernel/perf_event_mipsxx.c               | 91 ++++++++++--------=
----
 arch/mips/kernel/ptrace.c                          |  4 +-
 arch/mips/kernel/ptrace32.c                        |  4 +-
 arch/mips/kernel/time.c                            | 15 ----
 arch/mips/kernel/vpe.c                             |  2 +-
 arch/mips/lasat/ds1603.c                           | 11 ++-
 arch/mips/lasat/sysctl.c                           | 12 ++-
 arch/mips/lib/Makefile                             |  3 +-
 arch/mips/lib/ashldi3.c                            | 30 -------
 arch/mips/lib/ashrdi3.c                            | 32 --------
 arch/mips/lib/cmpdi2.c                             | 28 -------
 arch/mips/lib/lshrdi3.c                            | 30 -------
 arch/mips/lib/memset.S                             | 28 +++----
 arch/mips/lib/ucmpdi2.c                            | 22 ------
 arch/mips/loongson64/common/time.c                 |  2 +-
 arch/mips/mm/sc-debugfs.c                          |  9 +--
 arch/mips/mti-malta/malta-time.c                   |  2 +-
 arch/mips/oprofile/op_model_mipsxx.c               |  2 -
 arch/mips/sibyte/swarm/rtc_m41t81.c                |  8 +-
 arch/mips/sibyte/swarm/rtc_xicor1241.c             |  8 +-
 arch/mips/sibyte/swarm/setup.c                     | 18 +++--
 arch/mips/sni/time.c                               |  6 --
 arch/riscv/Kconfig                                 |  6 +-
 drivers/firmware/broadcom/bcm47xx_nvram.c          |  2 +-
 drivers/watchdog/jz4740_wdt.c                      | 42 ++++------
 lib/Kconfig                                        | 12 +--
 lib/Makefile                                       | 12 +--
 lib/ucmpdi2.c                                      |  2 +-
 61 files changed, 340 insertions(+), 393 deletions(-)
 delete mode 100644 arch/mips/lib/ashldi3.c
 delete mode 100644 arch/mips/lib/ashrdi3.c
 delete mode 100644 arch/mips/lib/cmpdi2.c
 delete mode 100644 arch/mips/lib/lshrdi3.c
 delete mode 100644 arch/mips/lib/ucmpdi2.c

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWx/TMQAKCRA1zuSGKxAj
8lS9AP0c1/JpZU+hXTP2h1qn2kjOPCEHVqm+aIKsxKA4gD88RwEA/bBjb0QfGJ8I
Ha1EdIUZvcn9tUZP7tLhhHP6R5aQXQo=
=n3IU
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
