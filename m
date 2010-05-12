Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 19:13:20 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:50751 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492221Ab0ELRNP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 19:13:15 +0200
Received: by fxm17 with SMTP id 17so302412fxm.36
        for <multiple recipients>; Wed, 12 May 2010 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=34WVnblBImJZLD6LA5PzykPxABWBeOY/ELPrgSzhFvg=;
        b=FGo4uEM56I8/5AP06addza8Vg/PWHNJfMaCAzBykt2zVEmjktBL3I4Juu1mBt+ueJt
         NS4ETX/+ZAOXSNoPcGRSZ8gVHarxyK7QttxFoVfgWpiykurqf2jRaHGxYqkKkuJD+dZW
         JJe1IydJbtKuthCezPMfCt8DHsggn4JbIVTfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=py/m9ivEozeGWid7VIP9VJ0iUFiVtzkiT7rvChKpt7YReSlyijXleu1F5KxbZKdBlK
         OzWgvphJ3+I3V/Cwm2u+OVtBnlCcYetYjlsHYej6Z6eCwNvw7I+pVcGDKbm2zmysLl+n
         z6F/K6Qomko9vg5LGkxkRsOiJ6S7vUAXgpPQY=
Received: by 10.204.134.211 with SMTP id k19mr424998bkt.48.1273684388067;
        Wed, 12 May 2010 10:13:08 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id d5sm113606bkd.19.2010.05.12.10.13.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 10:13:05 -0700 (PDT)
Message-ID: <4BEAE19D.40502@gmail.com>
Date:   Wed, 12 May 2010 10:13:01 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Wu Zhangjin <wuzhangjin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 9/9] tracing: MIPS: cleanup of the address space checking
References: <cover.1273669419.git.wuzhangjin@gmail.com> <86404e31ca5c4c33b785bad7f6223ac775f4f879.1273669419.git.wuzhangjin@gmail.com>
In-Reply-To: <86404e31ca5c4c33b785bad7f6223ac775f4f879.1273669419.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/12/2010 06:23 AM, Wu Zhangjin wrote:
> From: Wu Zhangjin<wuzhangjin@gmail.com>
>
> This patch adds an inline function in_module() to check which space the
> instruction pointer in, kernel space or module space.
>
> Note: This may not work when the kernel is compiled with -msym32.
>

The kernel is always compiled with -msym32, so the patch is a bit pointless.



> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
> ---
>   arch/mips/kernel/ftrace.c |   17 ++++++++++++++---
>   1 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 628e90b..37f15b6 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -17,6 +17,17 @@
>   #include<asm/cacheflush.h>
>   #include<asm/uasm.h>
>
> +/*
> + * If the Instruction Pointer is in module space (0xc0000000), return true;
> + * otherwise, it is in kernel space (0x80000000), return false.
> + *
> + * FIXME: This may not work when the kernel is compiled with -msym32.
> + */
> +static inline int in_module(unsigned long ip)
> +{
> +	return ip&  0x40000000;
> +}
> +

How about (untested):


static inline int in_module(unsigned long ip)
{
	return ip < _text || ip > _etext;
}


But why do we even care?  Can't we just probe the function prologue and 
determine from that what needs to be done?

David Daney

>   #ifdef CONFIG_DYNAMIC_FTRACE
>
>   #define JAL 0x0c000000		/* jump&  link: ip -->  ra, jump to target */
> @@ -78,7 +89,7 @@ int ftrace_make_nop(struct module *mod,
>   	 * We have compiled module with -mlong-calls, but compiled the kernel
>   	 * without it, we need to cope with them respectively.
>   	 */
> -	if (ip&  0x40000000) {
> +	if (in_module(ip)) {
>   #if defined(KBUILD_MCOUNT_RA_ADDRESS)&&  defined(CONFIG_32BIT)
>   		/*
>   		 * lui v1, hi_16bit_of_mcount        -->  b 1f (0x10000005)
> @@ -117,7 +128,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>   	unsigned long ip = rec->ip;
>
>   	/* ip, module: 0xc0000000, kernel: 0x80000000 */
> -	new = (ip&  0x40000000) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
> +	new = in_module(ip) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
>
>   	return ftrace_modify_code(ip, new);
>   }
> @@ -188,7 +199,7 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
>   	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 20), but for
>   	 * kernel, move to the instruction "move ra, at"(offset is 12)
>   	 */
> -	ip = self_addr - ((self_addr&  0x40000000) ? 20 : 12);
> +	ip = self_addr - (in_module(self_addr) ? 20 : 12);
>
>   	/*
>   	 * search the text until finding the non-store instruction or "s{d,w}
