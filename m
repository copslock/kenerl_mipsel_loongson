Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 12:07:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18776 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014352AbbC3KHH6iUIM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Mar 2015 12:07:07 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6A8A141F8E4C;
        Mon, 30 Mar 2015 11:07:03 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 30 Mar 2015 11:07:03 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 30 Mar 2015 11:07:03 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 416A2C4EC8AD3;
        Mon, 30 Mar 2015 11:07:01 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 30 Mar 2015 11:07:03 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Mar
 2015 11:07:02 +0100
Message-ID: <55192045.3080302@imgtec.com>
Date:   Mon, 30 Mar 2015 11:07:01 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     "Paolo Bonzini (Redhat)" <pbonzini@redhat.com>,
        "Marcelo Tosatti (Redhat)" <mtosatti@redhat.com>,
        kvm <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>
CC:     linux-mips <linux-mips@linux-mips.org>,
        "Ralf (LMO)" <ralf@linux-mips.org>, Paul <paul.burton@imgtec.com>
Subject: [GIT PULL] MIPS KVM Guest FPU & SIMD (MSA) Support for 4.1
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="ug1NfWSlKWMPTe73sj7mTQ8gpW1ReaaHg"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46593
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

--ug1NfWSlKWMPTe73sj7mTQ8gpW1ReaaHg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Marcelo,

Here is the MIPS guest FPU & SIMD (MSA) work. I've based this on
kvm/queue as of Friday, and it also pulls in some MIPS FP/MSA fixes from
a branch in Ralf's MIPS tree. Hope that's okay.

Please pull

Thanks
James

The following changes since commit b3a2a9076d3149781c8622d6a98a51045ff946=
e4:

  KVM: nVMX: Add support for rdtscp (2015-03-26 22:33:48 -0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git tags/=
kvm_mips_20150327

for you to fetch changes up to d952bd070f79b6dcbad52c03dbc41cbc8ba086c8:

  MIPS: KVM: Wire up MSA capability (2015-03-27 21:25:22 +0000)

----------------------------------------------------------------
MIPS KVM Guest FPU & SIMD (MSA) Support

Add guest FPU and MIPS SIMD Architecture (MSA) support to MIPS KVM, by
enabling the host FPU/MSA while in guest mode. This adds two new KVM
capabilities, KVM_CAP_MIPS_FPU & KVM_CAP_MIPS_MSA, and supports the 3 FP
register modes (FR=3D0, FR=3D1, FRE=3D1), and 128-bit MSA vector register=
s,
with lazy FPU/MSA context save and restore.

Some required MIPS FP/MSA fixes are merged in from a branch in the MIPS
tree first.

----------------------------------------------------------------
James Hogan (24):
      MIPS: lose_fpu(): Disable FPU when MSA enabled
      Revert "MIPS: Don't assume 64-bit FP registers for context switch"
      MIPS: MSA: Fix big-endian FPR_IDX implementation
      Merge branch '4.1-fp' of git://git.linux-mips.org/pub/scm/ralf/upst=
ream-sfr into kvm_mips_queue
      MIPS: KVM: Handle MSA Disabled exceptions from guest
      MIPS: Clear [MSA]FPE CSR.Cause after notify_die()
      MIPS: KVM: Handle TRAP exceptions from guest kernel
      MIPS: KVM: Implement PRid CP0 register access
      MIPS: KVM: Sort kvm_mips_get_reg() registers
      MIPS: KVM: Drop pr_info messages on init/exit
      MIPS: KVM: Clean up register definitions a little
      MIPS: KVM: Simplify default guest Config registers
      MIPS: KVM: Add Config4/5 and writing of Config registers
      MIPS: KVM: Add vcpu_get_regs/vcpu_set_regs callback
      MIPS: KVM: Add base guest FPU support
      MIPS: KVM: Emulate FPU bits in COP0 interface
      MIPS: KVM: Add FP exception handling
      MIPS: KVM: Expose FPU registers
      MIPS: KVM: Wire up FPU capability
      MIPS: KVM: Add base guest MSA support
      MIPS: KVM: Emulate MSA bits in COP0 interface
      MIPS: KVM: Add MSA exception handling
      MIPS: KVM: Expose MSA registers
      MIPS: KVM: Wire up MSA capability

Paul Burton (8):
      MIPS: Push .set mips64r* into the functions needing it
      MIPS: assume at as source/dest of MSA copy/insert instructions
      MIPS: remove MSA macro recursion
      MIPS: wrap cfcmsa & ctcmsa accesses for toolchains with MSA support=

      MIPS: clear MSACSR cause bits when handling MSA FP exception
      MIPS: Ensure FCSR cause bits are clear after invoking FPU emulator
      MIPS: prevent FP context set via ptrace being discarded
      MIPS: disable FPU if the mode is unsupported

 Documentation/virtual/kvm/api.txt   |  54 +++++
 arch/mips/include/asm/asmmacro-32.h | 128 +++++-----
 arch/mips/include/asm/asmmacro.h    | 218 ++++++++++-------
 arch/mips/include/asm/fpu.h         |  20 +-
 arch/mips/include/asm/kdebug.h      |   3 +-
 arch/mips/include/asm/kvm_host.h    | 125 +++++++---
 arch/mips/include/asm/processor.h   |   2 +-
 arch/mips/include/uapi/asm/kvm.h    | 160 +++++++-----
 arch/mips/kernel/asm-offsets.c      | 105 +++-----
 arch/mips/kernel/genex.S            |  15 +-
 arch/mips/kernel/ptrace.c           |  30 ++-
 arch/mips/kernel/r4k_fpu.S          |   2 +-
 arch/mips/kernel/traps.c            |  35 ++-
 arch/mips/kvm/Makefile              |   8 +-
 arch/mips/kvm/emulate.c             | 332 ++++++++++++++++++++++++-
 arch/mips/kvm/fpu.S                 | 122 ++++++++++
 arch/mips/kvm/locore.S              |  38 +++
 arch/mips/kvm/mips.c                | 472 ++++++++++++++++++++++++++++++=
+++++-
 arch/mips/kvm/msa.S                 | 161 ++++++++++++
 arch/mips/kvm/stats.c               |   4 +
 arch/mips/kvm/tlb.c                 |   6 +
 arch/mips/kvm/trap_emul.c           | 199 ++++++++++++++-
 include/uapi/linux/kvm.h            |   2 +
 23 files changed, 1876 insertions(+), 365 deletions(-)
 create mode 100644 arch/mips/kvm/fpu.S
 create mode 100644 arch/mips/kvm/msa.S


--ug1NfWSlKWMPTe73sj7mTQ8gpW1ReaaHg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGSBFAAoJEGwLaZPeOHZ60OwQALc/26qbNFun/0rUznjPUWzL
k4sSfqyQY4z2A5Ons1MEtOIZNbh9XysAs/RPWKVxt1Wgnb5JpP+ENQ2C2UZ+KTBS
cru2ClLuYc4pAZwMJ5Tx4s8vWREhj9qI9HJL0eBdpuu1ArdoXpIgDauyA7CsPbnU
FJagSNzRSAQnBcJZGL7H7qLVIFpoB1nvnFeEaNkYB7swfRBrh2m2dgZlwZjUoTGF
iokxGsIQQUdTMI79w9Y4gAIuVtbq2oPWO3i5xhZbZU+ib1PxPO+dWl92iUelOWL4
bKsdo+zll7gAawnC4YdGOhJDXhZyM+aqydkLQ6uYdUpZXkQc6uqIEPa9ngxAaZW5
V7BJzOqdNElPH9Gd/dEGI+afco8BDx9HFvp/uI6R0dlOk+8ep4Coz1dS78m5pGBe
CoTSB3oSHCchlbv4NHko5Ze4KFfvi7JrueDQgcKhZyz22eGuwnzTHolbkOh7MqV7
PzR/f6vU2RPyNwW/gvAtm/2CHgMsF/C/WU9LIKX+hCYv+fNpaC0hBIs2tdRTNvA3
QCBGPtEslaKEch8ua+Cextny9Br+UfMSb9X1gzo/muY6qdyF2bC//6v3p+PYZIUt
U6Ackx4DR+xPxMKkM5lxBJHCoV3ZUVC1RPPxihe/gB+uzL8zxvv7iDlNs/+w8tac
7+n28S8lsamyhM2sfAcq
=5Yiv
-----END PGP SIGNATURE-----

--ug1NfWSlKWMPTe73sj7mTQ8gpW1ReaaHg--
