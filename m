Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 11:39:29 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:35509 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014094AbbLQKjYGB0Ha (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Dec 2015 11:39:24 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (Postfix) with ESMTPS id D7CD6146E77;
        Thu, 17 Dec 2015 10:39:18 +0000 (UTC)
Received: from [10.36.112.65] (ovpn-112-65.ams2.redhat.com [10.36.112.65])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tBHAdES6005425
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 17 Dec 2015 05:39:16 -0500
Subject: Re: [PATCH 00/16] MIPS: KVM: Misc trivial cleanups
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
Cc:     Gleb Natapov <gleb@kernel.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <567290D2.70207@redhat.com>
Date:   Thu, 17 Dec 2015 11:39:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50674
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



On 17/12/2015 00:49, James Hogan wrote:
> This patchset contains a bunch of miscellaneous cleanups (which are
> mostly trivial) for MIPS KVM & MIPS headers, such as:
> - Style/whitespace fixes
> - General cleanup and removal of dead code.
> - Moving/refactoring of general MIPS definitions out of arch/mips/kvm/
>   and into arch/mips/include/asm/ so they can be shared with the rest of
>   arch/mips. Specifically COP0 register bits, exception codes, cache
>   ops, & instruction opcodes.
> - Add MAINTAINERS entry for MIPS KVM.
> 
> Due to the interaction with other arch/mips/ code, I think it makes
> sense for these to go via the MIPS tree.

No objection.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I think I'd use s8/u8 instead of int8_t/uint8_t in patch 15, but really
that's just me.  I'm fine either way, and that's really the only comment
I have on the series. :)

Paolo

> James Hogan (16):
>   MIPS: KVM: Trivial whitespace and style fixes
>   MIPS: KVM: Drop some unused definitions from kvm_host.h
>   MIPS: Move definition of DC bit to mipsregs.h
>   MIPS: KVM: Drop unused kvm_mips_host_tlb_inv_index()
>   MIPS: KVM: Convert EXPORT_SYMBOL to _GPL
>   MIPS: KVM: Refactor added offsetof()s
>   MIPS: KVM: Make kvm_mips_{init,exit}() static
>   MIPS: Move Cause.ExcCode trap codes to mipsregs.h
>   MIPS: Update trap codes
>   MIPS: Use EXCCODE_ constants with set_except_vector()
>   MIPS: Break down cacheops.h definitions
>   MIPS: KVM: Use cacheops.h definitions
>   MIPS: Move KVM specific opcodes into asm/inst.h
>   MIPS: KVM: Add missing newline to kvm_err()
>   MIPS: KVM: Consistent use of uint*_t in MMIO handling
>   MAINTAINERS: Add KVM for MIPS entry
> 
>  MAINTAINERS                       |   8 +++
>  arch/mips/Kconfig                 |   3 +-
>  arch/mips/include/asm/cacheops.h  | 106 ++++++++++++++++++++--------------
>  arch/mips/include/asm/kvm_host.h  |  39 +------------
>  arch/mips/include/asm/mipsregs.h  |  34 +++++++++++
>  arch/mips/include/uapi/asm/inst.h |   3 +-
>  arch/mips/kernel/cpu-bugs64.c     |   8 +--
>  arch/mips/kernel/traps.c          |  52 ++++++++---------
>  arch/mips/kvm/callback.c          |   2 +-
>  arch/mips/kvm/dyntrans.c          |  10 +---
>  arch/mips/kvm/emulate.c           | 118 ++++++++++++++++----------------------
>  arch/mips/kvm/interrupt.c         |   8 +--
>  arch/mips/kvm/locore.S            |  12 ++--
>  arch/mips/kvm/mips.c              |  38 ++++++------
>  arch/mips/kvm/opcode.h            |  22 -------
>  arch/mips/kvm/tlb.c               |  77 +++++++------------------
>  arch/mips/kvm/trap_emul.c         |   1 -
>  17 files changed, 245 insertions(+), 296 deletions(-)
>  delete mode 100644 arch/mips/kvm/opcode.h
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> 
