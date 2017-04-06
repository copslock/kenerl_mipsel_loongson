Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 10:28:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3809 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991346AbdDFI2AfPfOK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 10:28:00 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6D93B41F8D68;
        Thu,  6 Apr 2017 10:34:10 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 06 Apr 2017 10:34:10 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 06 Apr 2017 10:34:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E89263A87637E;
        Thu,  6 Apr 2017 09:27:51 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Apr
 2017 09:27:54 +0100
Date:   Thu, 6 Apr 2017 09:27:54 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [GIT PULL] KVM: MIPS: VZ support, Octeon III, and TLBR
Message-ID: <20170406082754.GP31606@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q4RbCnAmn9VrkE5p"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--Q4RbCnAmn9VrkE5p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Paolo, Radim,

Here are the main KVM MIPS changes for 4.12, mainly to add VZ support.
Please consider pulling.

Thanks
James

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git tags/kvm_mips_4.12_1

for you to fetch changes up to dc44abd6aad22411f7f9890e39fd4753dabf0d03:

  KVM: MIPS/Emulate: Properly implement TLBR for T&E (2017-03-28 16:31:37 +0100)

----------------------------------------------------------------
KVM: MIPS: VZ support, Octeon III, and TLBR

Add basic support for the MIPS Virtualization Module (generally known as
MIPS VZ) in KVM. We primarily support the ImgTec P5600, P6600, I6400,
and Cavium Octeon III cores so far. Support is included for the
following VZ / guest hardware features:
- MIPS32 and MIPS64, r5 (VZ requires r5 or later) and r6
- TLBs with GuestID (IMG cores) or Root ASID Dealias (Octeon III)
- Shared physical root/guest TLB (IMG cores)
- FPU / MSA
- Cop0 timer (up to 1GHz for now due to soft timer limit)
- Segmentation control (EVA)
- Hardware page table walker (HTW) both for root and guest TLB

Also included is a proper implementation of the TLBR instruction for the
trap & emulate MIPS KVM implementation.

Preliminary MIPS architecture changes are applied directly with Ralf's
ack.

----------------------------------------------------------------
James Hogan (42):
      MIPS: Add defs & probing of UFR
      MIPS: Separate MAAR V bit into VL and VH for XPA
      MIPS: Probe guest CP0_UserLocal
      MIPS: Probe guest MVH
      MIPS: Add some missing guest CP0 accessors & defs
      MIPS: asm/tlb.h: Add UNIQUE_GUEST_ENTRYHI() macro
      KVM: MIPS: Implement HYPCALL emulation
      KVM: MIPS/Emulate: De-duplicate MMIO emulation
      KVM: MIPS/Emulate: Implement 64-bit MMIO emulation
      KVM: MIPS: Update kvm_lose_fpu() for VZ
      KVM: MIPS: Extend counters & events for VZ GExcCodes
      KVM: MIPS: Add VZ & TE capabilities
      KVM: MIPS: Add 64BIT capability
      KVM: MIPS: Init timer frequency from callback
      KVM: MIPS: Add callback to check extension
      KVM: MIPS: Add hardware_{enable,disable} callback
      KVM: MIPS: Add guest exit exception callback
      KVM: MIPS: Abstract guest CP0 register access for VZ
      KVM: MIPS/Entry: Update entry code to support VZ
      KVM: MIPS/TLB: Add VZ TLB management
      KVM: MIPS/Emulate: Update CP0_Compare emulation for VZ
      KVM: MIPS/Emulate: Drop CACHE emulation for VZ
      KVM: MIPS: Update exit handler for VZ
      KVM: MIPS: Implement VZ support
      KVM: MIPS: Add VZ support to build system
      KVM: MIPS/VZ: Support guest CP0_BadInstr[P]
      KVM: MIPS/VZ: Support guest CP0_[X]ContextConfig
      KVM: MIPS/VZ: Support guest segmentation control
      KVM: MIPS/VZ: Support guest hardware page table walker
      KVM: MIPS/VZ: Support guest load-linked bit
      KVM: MIPS/VZ: Emulate MAARs when necessary
      KVM: MIPS/VZ: Support hardware guest timer
      KVM: MIPS/VZ: Trace guest mode changes
      MIPS: Add Octeon III register accessors & definitions
      KVM: MIPS/Emulate: Adapt T&E CACHE emulation for Octeon
      KVM: MIPS/TLB: Handle virtually tagged icaches
      KVM: MIPS/T&E: Report correct dcache line size
      KVM: MIPS/VZ: VZ hardware setup for Octeon III
      KVM: MIPS/VZ: Emulate hit CACHE ops for Octeon III
      KVM: MIPS/VZ: Handle Octeon III guest.PRid register
      MIPS: Allow KVM to be enabled on Octeon CPUs
      KVM: MIPS/Emulate: Properly implement TLBR for T&E

 Documentation/virtual/kvm/api.txt        |   90 +-
 Documentation/virtual/kvm/hypercalls.txt |    5 +
 arch/mips/Kconfig                        |    1 +
 arch/mips/include/asm/cpu-features.h     |   10 +
 arch/mips/include/asm/cpu-info.h         |    2 +
 arch/mips/include/asm/cpu.h              |    1 +
 arch/mips/include/asm/kvm_host.h         |  467 ++++-
 arch/mips/include/asm/maar.h             |   10 +-
 arch/mips/include/asm/mipsregs.h         |   62 +-
 arch/mips/include/asm/tlb.h              |    6 +-
 arch/mips/include/uapi/asm/inst.h        |    2 +-
 arch/mips/include/uapi/asm/kvm.h         |   20 +-
 arch/mips/kernel/cpu-probe.c             |   13 +-
 arch/mips/kernel/time.c                  |    1 +
 arch/mips/kvm/Kconfig                    |   27 +-
 arch/mips/kvm/Makefile                   |    9 +-
 arch/mips/kvm/emulate.c                  |  500 +++--
 arch/mips/kvm/entry.c                    |  132 +-
 arch/mips/kvm/hypcall.c                  |   53 +
 arch/mips/kvm/interrupt.h                |    5 +
 arch/mips/kvm/mips.c                     |  120 +-
 arch/mips/kvm/mmu.c                      |   20 +
 arch/mips/kvm/tlb.c                      |  441 ++++
 arch/mips/kvm/trace.h                    |   74 +-
 arch/mips/kvm/trap_emul.c                |   73 +-
 arch/mips/kvm/vz.c                       | 3223 ++++++++++++++++++++++++++++++
 arch/mips/mm/cache.c                     |    1 +
 arch/mips/mm/init.c                      |    2 +-
 include/uapi/linux/kvm.h                 |    7 +
 29 files changed, 5010 insertions(+), 367 deletions(-)
 create mode 100644 arch/mips/kvm/hypcall.c
 create mode 100644 arch/mips/kvm/vz.c

--Q4RbCnAmn9VrkE5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY5fwDAAoJEGwLaZPeOHZ6xxQP/i8dqz0UWdSrYLUqP3a+Lsha
QbS6V3X5Dxs//RJGeNHmSVVP0qWq6h7PZzfP2mSDyfIY1xzDgQ0pOag0LyMPXq3P
iZPLZPgrGopxCSl0ZG+lHgEj+z5qya1UzqVScsGotKcUFKd7iTafgQbv9yq0g0Lq
9qNiAbt8l82ub1uAWqfBhdyBWc7vcsSzsDzEph8mb2TEwRNC68+Wnu9C6JCod/vx
JmbT6y2yMgv09tb5RHFpLfwq6yUrlyeQ3hQ+magiS0Rj4laF7nl5CS9oHnnGqjt6
ULpOKo4cWqEg4pQmGWceQUjtlV6BXRWENFNZDQr1MpM8gKSoejLzMfqAYomXvTwy
p5qdATkuCiwaZeYJ3fgWe60aHIvO+VPKoiQq1dH3JhgkfuXEFO9COJF8I7c1yGTV
RjA63HOV7iYzlH7LwzdHpM5+v3iHMd73TDnZOsdm6I+C6qZIPVAMpXm3LTgDk/Ph
HdmEARcBx4mJlv3UDu+Q70Z7G/7n0ypJlbWRxB26T86px66Kh3riA+gV4PVxUIc+
n/oDjGfU/gzzCzQzC/dsTYNl1K2KSvyMkYr8gf+BcIGkVEYEb8d9eFEPmcq1MJOU
DczU2/I1fdez6m0g87dJ/VvCu5NEvkNB/KfZ5BJNVErxFNGdBy3+shtQXLaD2M+H
lQDS6dsLAXuYe9szCOAY
=kONu
-----END PGP SIGNATURE-----

--Q4RbCnAmn9VrkE5p--
