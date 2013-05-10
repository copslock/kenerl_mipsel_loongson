Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 May 2013 18:24:08 +0200 (CEST)
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36654 "EHLO
        mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819780Ab3EJQYHNnHDR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 May 2013 18:24:07 +0200
Received: by mail-ob0-f180.google.com with SMTP id xk17so2184959obc.39
        for <multiple recipients>; Fri, 10 May 2013 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lLYbzoF/EGHvOKt+qmwshwWqJdKunPXQt55XIJ9ogSQ=;
        b=nChS1hZNI1XEjeatZ3nzRzbMPtpqFghvrJD9LnPHMAw/Eby0BV4SFF9SIVyR7h+Z1B
         R47LbQmG4bTm3KCoQN7zDXtN2h/17rc2+gH4I//V1yk31SpTAMae4QYOeo1J+0Deeh8B
         cqEJ4USOEJgTHoQQmC6MIsfO6U+h6Lc7YY1HY8x8UfS+7sIIIT7wQ5bQrWWcdsIXHlys
         D7WQDTKzm4t3Qf97VHThbD0q2qBEHJz3O39GDKLsV9S5DHD9E1QS0SD1in7m7eYbH5Vi
         +ZmUcOVS91tW9E4GOZumXGHVr8/hW6ef7EFjOihu/nSOc4yz+mslk61hksaeMaH/CUcf
         68GA==
X-Received: by 10.182.226.234 with SMTP id rv10mr7398713obc.59.1368203040568;
        Fri, 10 May 2013 09:24:00 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nt17sm3306498obb.13.2013.05.10.09.23.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 09:23:59 -0700 (PDT)
Message-ID: <518D1F1D.2080504@gmail.com>
Date:   Fri, 10 May 2013 09:23:57 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Tony Wu <tung7970@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/2] MIPS: detect sibling call in get_frame_info
References: <20130510110729.GA7499@hades>
In-Reply-To: <20130510110729.GA7499@hades>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/10/2013 04:07 AM, Tony Wu wrote:
> Given a function, get_frame_info() analyzes its instructions
> to figure out frame size and return address. get_frame_info()
> works as follows:
>
> 1. analyze up to 128 instructions if the function size is unknown
> 2. search for 'addiu/daddiu sp,sp,-immed' for frame size
> 3. search for 'sw ra,offset(sp)' for return address
> 4. end search when it sees jr/jal/jalr
>
> This leads to an issue when the given function is a sibling
> call, example given as follows.
>
> 801ca110 <schedule>:
> 801ca110:       8f820000        lw      v0,0(gp)
> 801ca114:       8c420000        lw      v0,0(v0)
> 801ca118:       080726f0        j       801c9bc0 <__schedule>
> 801ca11c:       00000000        nop
>
> 801ca120 <io_schedule>:
> 801ca120:       27bdffe8        addiu   sp,sp,-24
> 801ca124:       3c028022        lui     v0,0x8022
> 801ca128:       afbf0014        sw      ra,20(sp)
>
> In this case, get_frame_info() cannot properly detect schedule's
> frame info, and eventually returns io_schedule's info instead.
>
> This patch adds sibling call check by detecting out of range jump.

I think this is more complex than it needs to be.  Also you already 
handle the case of a sib call via a function pointer ....


>
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> ---
>   arch/mips/kernel/process.c |   22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index cfc742d..a794eb5 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -223,6 +223,9 @@ struct mips_frame_info {
>   	int		pc_offset;
>   };
>
> +#define J_TARGET(pc,target)	\
> +		(((unsigned long)(pc) & 0xf0000000) | ((target) << 2))
> +
>   static inline int is_ra_save_ins(union mips_instruction *ip)
>   {
>   	/* sw / sd $ra, offset($sp) */
> @@ -250,11 +253,25 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
>   	return 0;
>   }
>
> +static inline int is_sibling_j_ins(union mips_instruction *ip,
> +				   unsigned long func_begin, unsigned long func_end)
> +{
> +	if (ip->j_format.opcode == j_op) {
> +		unsigned long addr;
> +
> +		addr = J_TARGET(ip, ip->j_format.target);
> +		if (addr < func_begin || addr > func_end)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>   static int get_frame_info(struct mips_frame_info *info)
>   {
>   	union mips_instruction *ip = info->func;
>   	unsigned max_insns = info->func_size / sizeof(union mips_instruction);
>   	unsigned i;
> +	unsigned long func_begin, func_end;
>
>   	info->pc_offset = -1;
>   	info->frame_size = 0;
> @@ -266,10 +283,15 @@ static int get_frame_info(struct mips_frame_info *info)
>   		max_insns = 128U;	/* unknown function size */
>   	max_insns = min(128U, max_insns);
>
> +	func_begin = (unsigned long) info->func;
> +	func_end = func_begin + max_insns * sizeof(union mips_instruction);
> +
>   	for (i = 0; i < max_insns; i++, ip++) {
>
>   		if (is_jal_jalr_jr_ins(ip))
>   			break;

... here.  So why not just add an unconditional J to the list detected, 
and get rid of all the rest of the patch?


> +		if (is_sibling_j_ins(ip, func_begin, func_end))
> +			break;
>   		if (!info->frame_size) {
>   			if (is_sp_move_ins(ip))
>   				info->frame_size = - ip->i_format.simmediate;
>
