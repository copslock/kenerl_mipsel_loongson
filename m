Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 16:36:40 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:34770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014744AbbC3OghpA5ns (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Mar 2015 16:36:37 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2UEaDXE027260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Mar 2015 10:36:13 -0400
Received: from [10.36.112.40] (ovpn-112-40.ams2.redhat.com [10.36.112.40])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2UEa74F001942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 30 Mar 2015 10:36:10 -0400
Message-ID: <55195F56.6050604@redhat.com>
Date:   Mon, 30 Mar 2015 16:36:06 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        "Marcelo Tosatti (Redhat)" <mtosatti@redhat.com>,
        kvm <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>
CC:     linux-mips <linux-mips@linux-mips.org>,
        "Ralf (LMO)" <ralf@linux-mips.org>, Paul <paul.burton@imgtec.com>
Subject: Re: [GIT PULL] MIPS KVM Guest FPU & SIMD (MSA) Support for 4.1
References: <55192045.3080302@imgtec.com>
In-Reply-To: <55192045.3080302@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256



On 30/03/2015 12:07, James Hogan wrote:
> Hi Paolo, Marcelo,
> 
> Here is the MIPS guest FPU & SIMD (MSA) work. I've based this on 
> kvm/queue as of Friday, and it also pulls in some MIPS FP/MSA fixes
> from a branch in Ralf's MIPS tree. Hope that's okay.
> 
> Please pull
> 
> Thanks James
> 
> The following changes since commit
> b3a2a9076d3149781c8622d6a98a51045ff946e4:
> 
> KVM: nVMX: Add support for rdtscp (2015-03-26 22:33:48 -0300)
> 
> are available in the git repository at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git
> tags/kvm_mips_20150327
> 
> for you to fetch changes up to
> d952bd070f79b6dcbad52c03dbc41cbc8ba086c8:
> 
> MIPS: KVM: Wire up MSA capability (2015-03-27 21:25:22 +0000)
> 
> ---------------------------------------------------------------- 
> MIPS KVM Guest FPU & SIMD (MSA) Support
> 
> Add guest FPU and MIPS SIMD Architecture (MSA) support to MIPS KVM,
> by enabling the host FPU/MSA while in guest mode. This adds two new
> KVM capabilities, KVM_CAP_MIPS_FPU & KVM_CAP_MIPS_MSA, and supports
> the 3 FP register modes (FR=0, FR=1, FRE=1), and 128-bit MSA vector
> registers, with lazy FPU/MSA context save and restore.
> 
> Some required MIPS FP/MSA fixes are merged in from a branch in the
> MIPS tree first.
> 
> ---------------------------------------------------------------- 
> James Hogan (24): MIPS: lose_fpu(): Disable FPU when MSA enabled 
> Revert "MIPS: Don't assume 64-bit FP registers for context switch" 
> MIPS: MSA: Fix big-endian FPR_IDX implementation Merge branch
> '4.1-fp' of git://git.linux-mips.org/pub/scm/ralf/upstream-sfr into
> kvm_mips_queue MIPS: KVM: Handle MSA Disabled exceptions from
> guest MIPS: Clear [MSA]FPE CSR.Cause after notify_die() MIPS: KVM:
> Handle TRAP exceptions from guest kernel MIPS: KVM: Implement PRid
> CP0 register access MIPS: KVM: Sort kvm_mips_get_reg() registers 
> MIPS: KVM: Drop pr_info messages on init/exit MIPS: KVM: Clean up
> register definitions a little MIPS: KVM: Simplify default guest
> Config registers MIPS: KVM: Add Config4/5 and writing of Config
> registers MIPS: KVM: Add vcpu_get_regs/vcpu_set_regs callback MIPS:
> KVM: Add base guest FPU support MIPS: KVM: Emulate FPU bits in COP0
> interface MIPS: KVM: Add FP exception handling MIPS: KVM: Expose
> FPU registers MIPS: KVM: Wire up FPU capability MIPS: KVM: Add base
> guest MSA support MIPS: KVM: Emulate MSA bits in COP0 interface 
> MIPS: KVM: Add MSA exception handling MIPS: KVM: Expose MSA
> registers MIPS: KVM: Wire up MSA capability
> 
> Paul Burton (8): MIPS: Push .set mips64r* into the functions
> needing it MIPS: assume at as source/dest of MSA copy/insert
> instructions MIPS: remove MSA macro recursion MIPS: wrap cfcmsa &
> ctcmsa accesses for toolchains with MSA support MIPS: clear MSACSR
> cause bits when handling MSA FP exception MIPS: Ensure FCSR cause
> bits are clear after invoking FPU emulator MIPS: prevent FP context
> set via ptrace being discarded MIPS: disable FPU if the mode is
> unsupported
> 
> Documentation/virtual/kvm/api.txt   |  54 +++++ 
> arch/mips/include/asm/asmmacro-32.h | 128 +++++----- 
> arch/mips/include/asm/asmmacro.h    | 218 ++++++++++------- 
> arch/mips/include/asm/fpu.h         |  20 +- 
> arch/mips/include/asm/kdebug.h      |   3 +- 
> arch/mips/include/asm/kvm_host.h    | 125 +++++++--- 
> arch/mips/include/asm/processor.h   |   2 +- 
> arch/mips/include/uapi/asm/kvm.h    | 160 +++++++----- 
> arch/mips/kernel/asm-offsets.c      | 105 +++----- 
> arch/mips/kernel/genex.S            |  15 +- 
> arch/mips/kernel/ptrace.c           |  30 ++- 
> arch/mips/kernel/r4k_fpu.S          |   2 +- 
> arch/mips/kernel/traps.c            |  35 ++- 
> arch/mips/kvm/Makefile              |   8 +- 
> arch/mips/kvm/emulate.c             | 332
> ++++++++++++++++++++++++- arch/mips/kvm/fpu.S                 | 122
> ++++++++++ arch/mips/kvm/locore.S              |  38 +++ 
> arch/mips/kvm/mips.c                | 472
> +++++++++++++++++++++++++++++++++++- arch/mips/kvm/msa.S
> | 161 ++++++++++++ arch/mips/kvm/stats.c               |   4 + 
> arch/mips/kvm/tlb.c                 |   6 + 
> arch/mips/kvm/trap_emul.c           | 199 ++++++++++++++- 
> include/uapi/linux/kvm.h            |   2 + 23 files changed, 1876
> insertions(+), 365 deletions(-) create mode 100644
> arch/mips/kvm/fpu.S create mode 100644 arch/mips/kvm/msa.S
> 

Pulled, thanks.  I'm now going through the other pending MIPS patches
and applying them.

Paolo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGV9TAAoJEL/70l94x66DNiMIAKIAeSR3RRH6eU1ZdAlW8wG2
MCxs4ls8vilJKe+JStIi04FfVWHARvccJXrJajo1U2YMDzsAxEr8myJ+AFKiEIFC
JJv5D0L09qYqC0Baqfv0KWwcyNL2NS6FQ3Nw1+gsQhjoAFmD55mc0cGiljh2dNWq
zKox0a8fd+8PCY39h671bj+WsC9UtK7NdSro0kUl2BtCww8Cumwl4Uk370+Ng3Kx
blEjtpaJd4QCM7WobDM9pj9fPiROaYB682FSbLTSBAf5PD9pbnYN8mKIS3vJVZRS
Gme1WpSUGOC1Mlc0nyvauCd9DYLBBHLTAm0q4vh7GXbRPcJ9u+yi61qIWRYNmUQ=
=leS8
-----END PGP SIGNATURE-----
