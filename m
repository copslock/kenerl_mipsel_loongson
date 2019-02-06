Return-Path: <SRS0=AiVX=QN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889D2C169C4
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 09:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B07207E0
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 09:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfBFJMZ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:12:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfBFJMY (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 6 Feb 2019 04:12:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1C89C058CA8;
        Wed,  6 Feb 2019 09:12:23 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CE5C18E2A;
        Wed,  6 Feb 2019 09:12:14 +0000 (UTC)
Date:   Wed, 6 Feb 2019 10:12:11 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu,
        Xiao Guangrong <guangrong.xiao@gmail.com>
Subject: Re: [PATCH v2 01/27] KVM: Call kvm_arch_memslots_updated() before
 updating memslots
Message-ID: <20190206101211.253cfbd9.cohuck@redhat.com>
In-Reply-To: <20190205205443.1059-2-sean.j.christopherson@intel.com>
References: <20190205205443.1059-1-sean.j.christopherson@intel.com>
        <20190205205443.1059-2-sean.j.christopherson@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 06 Feb 2019 09:12:24 +0000 (UTC)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue,  5 Feb 2019 12:54:17 -0800
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> kvm_arch_memslots_updated() is at this point in time an x86-specific
> hook for handling MMIO generation wraparound.  x86 stashes 19 bits of
> the memslots generation number in its MMIO sptes in order to avoid
> full page fault walks for repeat faults on emulated MMIO addresses.
> Because only 19 bits are used, wrapping the MMIO generation number is
> possible, if unlikely.  kvm_arch_memslots_updated() alerts x86 that
> the generation has changed so that it can invalidate all MMIO sptes in
> case the effective MMIO generation has wrapped so as to avoid using a
> stale spte, e.g. a (very) old spte that was created with generation==0.
> 
> Given that the purpose of kvm_arch_memslots_updated() is to prevent
> consuming stale entries, it needs to be called before the new generation
> is propagated to memslots.  Invalidating the MMIO sptes after updating
> memslots means that there is a window where a vCPU could dereference
> the new memslots generation, e.g. 0, and incorrectly reuse an old MMIO
> spte that was created with (pre-wrap) generation==0.
> 
> Fixes: e59dbe09f8e6 ("KVM: Introduce kvm_arch_memslots_updated()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/mips/include/asm/kvm_host.h    | 2 +-
>  arch/powerpc/include/asm/kvm_host.h | 2 +-
>  arch/s390/include/asm/kvm_host.h    | 2 +-
>  arch/x86/include/asm/kvm_host.h     | 2 +-
>  arch/x86/kvm/mmu.c                  | 4 ++--
>  arch/x86/kvm/x86.c                  | 4 ++--
>  include/linux/kvm_host.h            | 2 +-
>  virt/kvm/arm/mmu.c                  | 2 +-
>  virt/kvm/kvm_main.c                 | 7 +++++--
>  9 files changed, 15 insertions(+), 12 deletions(-)

Not an x86 person, but I think that makes sense.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
