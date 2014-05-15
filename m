Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2014 20:02:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15645 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6854768AbaEOSC2NvC2B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 May 2014 20:02:28 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 91F83FA7975DA;
        Thu, 15 May 2014 19:02:18 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 15 May
 2014 19:02:21 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 15 May 2014 19:02:21 +0100
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 15 May
 2014 11:02:18 -0700
Message-ID: <53750129.6060902@imgtec.com>
Date:   Thu, 15 May 2014 11:02:17 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Richard Weinberger <richard@nod.at>
CC:     <linux-arch@vger.kernel.org>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        "John Crispin" <blogic@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 16/27] mips: Use common bits from generic tlb.h
References: <1400093999-18703-1-git-send-email-richard@nod.at> <1400093999-18703-17-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-17-git-send-email-richard@nod.at>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 05/14/2014 11:59 AM, Richard Weinberger wrote:
> It is no longer needed to define them on our own.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: John Crispin <blogic@openwrt.org>
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   arch/mips/include/asm/tlb.h | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/arch/mips/include/asm/tlb.h b/arch/mips/include/asm/tlb.h
> index 4a23493..5ea43ca 100644
> --- a/arch/mips/include/asm/tlb.h
> +++ b/arch/mips/include/asm/tlb.h
> @@ -10,13 +10,6 @@
>   		if (!tlb->fullmm)				\
>   			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
>   	}  while (0)
> -#define tlb_end_vma(tlb, vma) do { } while (0)
> -#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
> -
> -/*
> - * .. because we flush the whole mm when it fills up.
> - */
> -#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
>   
>   #define UNIQUE_ENTRYHI(idx)						\
>   		((CKSEG0 + ((idx) << (PAGE_SHIFT + 1))) |		\

I would like to know why these functions are eliminated (don't find any 
clue).
Is it just because there will be a generic one or the calls would be 
eliminated?
And if there are generic - can I tune it later?

Explanation of Q:  MIPS R6 architecture has now TLBINV instruction which 
eliminates TLB elements only for specific ASID (read here - "mm_struct") 
and I would like to use it for efficiency in tlb_flush()/flush_tlb_mm.
(Not sure about tlb_end_vma()/ __tlb_remove_tlb_entry() yet)

- Leonid.
