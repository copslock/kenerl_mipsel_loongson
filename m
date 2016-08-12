Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 14:37:38 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:55536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993337AbcHLMhcElT5Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Aug 2016 14:37:32 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 765AB550B1;
        Fri, 12 Aug 2016 12:37:25 +0000 (UTC)
Received: from potion (dhcp-1-206.brq.redhat.com [10.34.1.206])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u7CCbMmN031457;
        Fri, 12 Aug 2016 08:37:23 -0400
Received: by potion (sSMTP sendmail emulation); Fri, 12 Aug 2016 14:37:22 +0200
Date:   Fri, 12 Aug 2016 14:37:22 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/4] MIPS: KVM: Fix MMU/TLB management issues
Message-ID: <20160812123721.GE8001@potion>
References: <cover.e70247d7d77e67a2331e65b6b7fd3894508e5d28.1470911944.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.e70247d7d77e67a2331e65b6b7fd3894508e5d28.1470911944.git-series.james.hogan@imgtec.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 12 Aug 2016 12:37:25 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2016-08-11 11:52+0100, James Hogan:
> These patches fix several issues in the management of MIPS KVM TLB
> faults:
> 
> 1) kvm_mips_handle_mapped_seg_tlb_fault() misbehaves for virtual address
>    zero, which can be hit if the guest creates such a mapping and
>    accesses it in a way unexpected for the commpage (e.g. a CACHE
>    instruction).
> 
> 2) kvm_mips_handle_mapped_seg_tlb_fault() doesn't range check the gfn,
>    allowing a high mapping by the guest to overflow the guest_pmap[].
> 
> 3) kvm_mips_handle_kseg0_tlb_fault() has an off by one in its gfn range
>    check, which could allow an odd sized guest_pmap[] to be overflowed.
> 
> 4) some callers of kvm_mips_handle_kseg0_tlb_fault() and
>    kvm_mips_handle_mapped_seg_tlb_fault() don't correctly propagate
>    errors upwards.
> 
> They're all marked for stable but won't apply cleanly before v4.8-rc1
> due to recent changes. I have backports ready though.

Applied, thanks.
