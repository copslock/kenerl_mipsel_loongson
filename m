Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 17:57:54 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:41450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992212AbcJYP5qvtvtj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Oct 2016 17:57:46 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A90B730;
        Tue, 25 Oct 2016 15:57:40 +0000 (UTC)
Received: from [10.36.112.46] (ovpn-112-46.ams2.redhat.com [10.36.112.46])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9PFvYc0028560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 25 Oct 2016 11:57:37 -0400
Subject: Re: [PATCH 0/3] KVM: MIPS: Miscellaneous 4.9 fixes
To:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
References: <cover.c0ced53ae71e1272ec1aaa16007e9eebb1c0eac6.1477320903.git-series.james.hogan@imgtec.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        stable@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <844c4f82-3279-4a19-d87a-2fb036d7410d@redhat.com>
Date:   Tue, 25 Oct 2016 17:57:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <cover.c0ced53ae71e1272ec1aaa16007e9eebb1c0eac6.1477320903.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 25 Oct 2016 15:57:40 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55578
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



On 25/10/2016 17:08, James Hogan wrote:
> A few more fixes intended for v4.9. Patches 2 & 3 are tagged for stable.
> 
> - The first fixes lazy user ASID regeneration which was introduced in
>   4.9-rc1 and still wasn't quite right for SMP hosts.
> 
> - The second is a minor incorrect behaviour in ERET emulation when both
>   ERL and EXL are set (i.e. unlikely to hit in practice), which has been
>   wrong since MIPS KVM was added in v3.10.
> 
> - The third fixes a slightly risky completion of an MMIO load in branch
>   delay slot, where it'll try and read guest code outside of the proper
>   context. Currently we should only be able to hit this if the MMIO load
>   in branch delay slot is in guest TLB mapped (i.e. kernel module) code.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> Cc: stable@vger.kernel.org
> 
> James Hogan (3):
>   KVM: MIPS: Fix lazy user ASID regenerate for SMP
>   KVM: MIPS: Make ERET handle ERL before EXL
>   KVM: MIPS: Precalculate MMIO load resume PC
> 
>  arch/mips/include/asm/kvm_host.h |  7 ++++---
>  arch/mips/kvm/emulate.c          | 32 +++++++++++++++++++-------------
>  arch/mips/kvm/mips.c             |  5 ++++-
>  arch/mips/kvm/mmu.c              |  4 ----
>  4 files changed, 27 insertions(+), 21 deletions(-)
> 

Applied to kvm/master, thanks.
