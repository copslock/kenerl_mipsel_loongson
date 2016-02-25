Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 01:45:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60872 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007825AbcBYApDciR0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 01:45:03 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 8B29C21EA346D;
        Thu, 25 Feb 2016 00:44:53 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 25 Feb 2016
 00:44:56 +0000
Date:   Thu, 25 Feb 2016 00:40:36 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, <stable@kernel.org>
Subject: Re: [PATCH] MIPS: tlbex: Fix bugs in tlbchange handler
In-Reply-To: <1456324384-18118-2-git-send-email-chenhc@lemote.com>
Message-ID: <alpine.DEB.2.00.1602250029390.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com> <1456324384-18118-2-git-send-email-chenhc@lemote.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 24 Feb 2016, Huacai Chen wrote:

> If a tlb miss triggered when EXL=1, tlb refill exception is treated as
> tlb invalid exception, so tlbp may fails. In this situation, CP0_Index
> register doesn't contain a valid value. This may not be a problem for
> VTLB since it is fully-associative. However, FTLB is set-associative so
> not every tlb entry is valid for a specific address. Thus, we should
> use tlbwr instead of tlbwi when tlbp fails.

 Can you please explain exactly why this change is needed?  You're 
changing pretty generic code which has worked since forever.  So why is a 
change suddenly needed?  Our kernel entry/exit code has been written such 
that no mapped memory is accessed with EXL=1 so no TLB exception is 
expected to ever happen in these circumstances.  So what's your scenario 
you mean to address?  Your patch description does not explain it.

> @@ -1913,7 +1935,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
>  	uasm_i_ori(p, ptr, ptr, sizeof(pte_t));
>  	uasm_i_xori(p, ptr, ptr, sizeof(pte_t));
>  	build_update_entries(p, tmp, ptr);
> +	uasm_i_mfc0(p, ptr, C0_INDEX);
> +	uasm_il_bltz(p, r, ptr, label_tail_miss);
> +	uasm_i_nop(p);
>  	build_tlb_write_entry(p, l, r, tlb_indexed);
> +	uasm_il_b(p, r, label_leave);
> +	uasm_i_nop(p);
> +	uasm_l_tail_miss(l, *p);
> +	build_tlb_write_entry(p, l, r, tlb_random);
>  	uasm_l_leave(l, *p);
>  	build_restore_work_registers(p);
>  	uasm_i_eret(p); /* return from trap */

 Specifically you're causing a performance hit here, which is a fast path, 
for everyone.  If you have a scenario that needs this change, then please 
make it conditional on the circumstances and keep the handler unchanged in 
all the other cases.

  Maciej
