Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 17:07:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48818 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992111AbdAPQH3sJa92 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 17:07:29 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C97082B35C51E;
        Mon, 16 Jan 2017 16:07:19 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 16 Jan
 2017 16:07:23 +0000
Date:   Mon, 16 Jan 2017 16:07:23 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <jiang.biao2@zte.com.cn>
CC:     <linux-mips@linux-mips.org>, <pbonzini@redhat.com>,
        <rkrcmar@redhat.com>, <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 20/30] KVM: MIPS/MMU: Invalidate GVA PTs on ASID changes
Message-ID: <20170116160723.GA19393@jhogan-linux.le.imgtec.org>
References: <201701111154365057441@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <201701111154365057441@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56337
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

Hi,

On Wed, Jan 11, 2017 at 11:54:36AM +0800, jiang.biao2@zte.com.cn wrote:
> ＞ +void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags)
> ＞ +{
>
> ＞ +    if (flags & KMF_GPA) {
>
> ＞ +        /* all of guest virtual address space could be affected */
> ＞ +        if (flags & KMF_KERN)
> ＞ +            /* useg, kseg0, seg2/3 */
> ＞ +            kvm_mips_flush_gva_pgd(pgd, 0, 0x7fffffff)
> ＞ +        else
> ＞ +            /* useg */
> ＞ +            kvm_mips_flush_gva_pgd(pgd, 0, 0x3fffffff)
> ＞ +    } else {
> ＞ +        /* useg */
> ＞ +        kvm_mips_flush_gva_pgd(pgd, 0, 0x3fffffff)
> ＞ +
> ＞ +        /* kseg2/3 */
> ＞ +        if (flags & KMF_KERN)
> ＞ +            kvm_mips_flush_gva_pgd(pgd, 0x60000000, 0x7fffffff)
> ＞ +    }
> ＞ +}
>
>
>
>
> Is it maybe better to replace the hard code *0x7fffffff*, *0x60000000*, *0x3fffffff* with marco?

I did consider it. E.g. there are definitions in kvm_host.h:

#define KVM_GUEST_KUSEG			0x00000000UL
#define KVM_GUEST_KSEG0			0x40000000UL
#define KVM_GUEST_KSEG1			0x40000000UL
#define KVM_GUEST_KSEG23		0x60000000UL

and conditional definitions in asm/addrspace.h:

64-bit:
#define CKSEG0				_CONST64_(0xffffffff80000000)
#define CKSEG1				_CONST64_(0xffffffffa0000000)
#define CKSSEG				_CONST64_(0xffffffffc0000000)
#define CKSEG3				_CONST64_(0xffffffffe0000000)

32-bit:
#define KUSEG				0x00000000
#define KSEG0				0x80000000
#define KSEG1				0xa0000000
#define KSEG2				0xc0000000
#define KSEG3				0xe0000000

#define CKUSEG				0x00000000
#define CKSEG0				0x80000000
#define CKSEG1				0xa0000000
#define CKSEG2				0xc0000000
#define CKSEG3				0xe0000000

So (u32)CKSEG0 - 1, KVM_GUEST_KSEG23, and KVM_GUEST_KSEG0 - 1 would have
worked, but given that the ranges sometimes cover multiple segments it
just seemed more readable to use the hex literals rather than a
sprinkling of opaque definitions from different places.

Thanks for reviewing!

Cheers
James
