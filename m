Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Nov 2017 20:04:14 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:51843 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991359AbdKCTEGHQDB8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Nov 2017 20:04:06 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 03 Nov 2017 19:03:49 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 3 Nov 2017
 11:55:18 -0700
Date:   Fri, 3 Nov 2017 18:56:20 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [GIT PULL] MIPS fixes for 4.14
Message-ID: <20171103185620.GW15235@jhogan-linux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0VNbQffo0Gc48lc+"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509735826-298555-7165-184998-14
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186556
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_RULE7568M
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--0VNbQffo0Gc48lc+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

In Ralf's apparent absence I've collected together some important MIPS
fixes that haven't made it into 4.14 yet, along with various imgtec.com
-> mips.com email address changes (imgtec email addresses for those in
MIPS will stop working very soon).

They've been in linux-next for 1-2 days and undergone the usual MIPS
automated build, boot & runtime testing over the last day or so without
any new failures.

Please do consider pulling.

Thanks
James

The following changes since commit 0b07194bb55ed836c2cc7c22e866b87a14681984:

  Linux 4.14-rc7 (2017-10-29 13:58:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_fixes_4.14

for you to fetch changes up to ca208b5f19cb2a298804d0c17ac5a9bf194f0b28:

  MIPS: Update email address for Marcin Nowakowski (2017-11-02 10:58:43 +0000)

----------------------------------------------------------------
MIPS fixes for 4.14

A selection of important MIPS fixes for 4.14, and some MAINTAINERS /
email address updates:

- Update imgtec.com -> mips.com email addresses (this trivially updates
  comments in quite a few files, as well as MAINTAINERS)
- Update Pistachio SoC maintainership
- Fix NI 169445 build (new platform in 4.14)
- Fix EVA regression (4.14)
- Fix SMP-CPS build & preemption regressions (4.14)
- Fix SMP/hotplug deadlock & race (deadlock reintroduced 4.13)
- Fix ebpf_jit error return (4.13)
- Fix SMP-CMP build regressions (4.11 and 4.14)
- Fix bad UASM microMIPS encoding (3.16)
- Fix CM definitions (3.15)

----------------------------------------------------------------
Aleksandar Markovic (2):
      MIPS: Update RINT emulation maintainer email address
      MIPS: Update Goldfish RTC driver maintainer email address

Gustavo A. R. Silva (1):
      MIPS: microMIPS: Fix incorrect mask in insn_table_MM

James Hartley (1):
      MAINTAINERS: Update Pistachio platform maintainers

James Hogan (2):
      MIPS: generic: Fix NI 169445 its build
      MIPS: smp-cmp: Fix vpe_id build error

Jason A. Donenfeld (1):
      MIPS: smp-cmp: Use right include for task_struct

Marcin Nowakowski (1):
      MIPS: Update email address for Marcin Nowakowski

Matt Redfearn (4):
      MIPS: Fix exception entry when CONFIG_EVA enabled
      MIPS: generic: Fix compilation error from include asm/mips-cpc.h
      MIPS: SMP: Fix deadlock & online race
      MIPS: CPS: Fix use of current_cpu_data in preemptible code

Paul Burton (2):
      Update MIPS email addresses
      MIPS: Fix CM region target definitions

Wei Yongjun (1):
      MIPS: bpf: Fix a typo in build_one_insn()

 .mailmap                                         |  6 ++++++
 Documentation/ABI/testing/sysfs-class-remoteproc |  4 ++--
 MAINTAINERS                                      | 15 +++++++--------
 arch/mips/generic/Makefile                       |  2 +-
 arch/mips/generic/Platform                       |  2 +-
 arch/mips/generic/board-ni169445.its.S           |  2 +-
 arch/mips/generic/board-sead3.c                  |  2 +-
 arch/mips/generic/init.c                         |  4 ++--
 arch/mips/generic/irq.c                          |  2 +-
 arch/mips/generic/kexec.c                        |  2 +-
 arch/mips/generic/proc.c                         |  2 +-
 arch/mips/generic/yamon-dt.c                     |  2 +-
 arch/mips/include/asm/dsemul.h                   |  2 +-
 arch/mips/include/asm/maar.h                     |  2 +-
 arch/mips/include/asm/mach-malta/malta-dtshim.h  |  2 +-
 arch/mips/include/asm/mach-malta/malta-pm.h      |  2 +-
 arch/mips/include/asm/machine.h                  |  2 +-
 arch/mips/include/asm/mips-cm.h                  |  6 +++---
 arch/mips/include/asm/mips-cpc.h                 |  2 +-
 arch/mips/include/asm/mips-cps.h                 |  2 +-
 arch/mips/include/asm/mips-gic.h                 |  2 +-
 arch/mips/include/asm/msa.h                      |  2 +-
 arch/mips/include/asm/pm-cps.h                   |  2 +-
 arch/mips/include/asm/smp-cps.h                  |  2 +-
 arch/mips/include/asm/stackframe.h               |  8 ++++----
 arch/mips/include/asm/yamon-dt.h                 |  2 +-
 arch/mips/kernel/cmpxchg.c                       |  2 +-
 arch/mips/kernel/cps-vec-ns16550.S               |  2 +-
 arch/mips/kernel/cps-vec.S                       |  2 +-
 arch/mips/kernel/elf.c                           |  2 +-
 arch/mips/kernel/mips-cm.c                       |  2 +-
 arch/mips/kernel/mips-cpc.c                      |  2 +-
 arch/mips/kernel/pm-cps.c                        |  2 +-
 arch/mips/kernel/probes-common.h                 |  2 +-
 arch/mips/kernel/relocate.c                      |  2 +-
 arch/mips/kernel/smp-cmp.c                       |  6 +++---
 arch/mips/kernel/smp-cps.c                       |  4 ++--
 arch/mips/kernel/smp.c                           | 24 +++++++++++++++++-------
 arch/mips/mm/sc-debugfs.c                        |  2 +-
 arch/mips/mm/uasm-micromips.c                    |  2 +-
 arch/mips/mti-malta/malta-dt.c                   |  2 +-
 arch/mips/mti-malta/malta-dtshim.c               |  2 +-
 arch/mips/mti-malta/malta-pm.c                   |  2 +-
 arch/mips/net/ebpf_jit.c                         |  2 +-
 arch/mips/pci/pci-generic.c                      |  2 +-
 arch/mips/tools/generic-board-config.sh          |  2 +-
 drivers/auxdisplay/img-ascii-lcd.c               |  2 +-
 drivers/clk/imgtec/clk-boston.c                  |  2 +-
 drivers/clk/ingenic/cgu.c                        |  2 +-
 drivers/clk/ingenic/cgu.h                        |  2 +-
 drivers/clk/ingenic/jz4740-cgu.c                 |  2 +-
 drivers/clk/ingenic/jz4780-cgu.c                 |  2 +-
 drivers/cpuidle/cpuidle-cps.c                    |  2 +-
 drivers/power/reset/piix4-poweroff.c             |  4 ++--
 54 files changed, 92 insertions(+), 77 deletions(-)

--0VNbQffo0Gc48lc+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAln8u80ACgkQbAtpk944
dnqR+A/9HmM/HUfpKppQJC/zka9L5TkOev5je6K5FqFLqCxEXdp06Z1K3twbOAzq
l0LQOaJVSSsorsh+OLgaCW+itsm01FLFIGUJRe5RztbwBRVa/ne8MMZ1B+qrL3YU
AolAOlcbuHcu3jUJ5zv9Fs5Ee/dZslXKZcVkcHW8HYz4SDn56s+TBcKJySb29S6g
sYc7I6FQvJx+3aQ54Zz8Ph8M6wFbL2pBKErBu+m7ndox+pwMTpsg9af3Skb4nrr0
s90Pf+fwcj4+PIRvC3CIC1n5K/SxKGSGimSHxpWvwiCykJWYxvn7kmS/cxeV09jx
zPWlUIZ9RiWKAndHNgJ8gJ+26i8YvzqUQgQ/EaK7xrvau9XhEpcjmYOfZl5wfT3B
fmHfTXEMlxqEFLkPqvrzN/MmcLS5IOOULY/xvEt2GGWW+hdImF6WbTFy5YylvoHv
uLIBd9V3G2DKa2ZK2behfb0/uT3FHEtyXFUvX2eJru816XAmQyZkoNX1PbcWZSqm
cwxah3rAGsjeLI9PPSdkSFq6I9CN4/x9wLccXta4+V/rsFN11tPXDZrvNskID7kP
/xSYUvNgLVF2kHVQD+cgiHuB7FMm0ivYPx2gW1ZZ82FqYV6L4VW0sVVn+vCLfU1N
R7Wa077ApRNWXgovI/KPl+BuXLqISQ+iDOLkAZZ+psw5vBso4Vc=
=L0Y6
-----END PGP SIGNATURE-----

--0VNbQffo0Gc48lc+--
