Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 19:53:14 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47050 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007227AbaLRSxMYQNRp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 19:53:12 +0100
Received: by mail-ie0-f169.google.com with SMTP id y20so1710818ier.28
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 10:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=o4MrN5JqtLmTyDA6ZceScjSOZxHscRhW8YDmgM4/zuM=;
        b=UI0ZwOz8okrK3n5VsdlGziTw/vT0B2o02LM7Iy4Czk7PHzgOcExQYVajvDUuTAAWoY
         qg/kS+99URsS7lTKtowxxcPY9ex1UEvrNBOTZZu/AZaj2lxPNnEaZ+HAEm59szOdwsnG
         IexmosFUBBfRJB5kWTg40hOXRv6DbMfQ8suUcg4zRToEgxdnEusLn0kMeiWMfNHynd1T
         536mebC1qHqNXymTRPJgXRAgRdadGRgIQSZJ2rH5xpQpRnjb6yDyivrf571ZQFq9lXo8
         4RT0bCfhOJc8dOIYHznPYZonquALH4NtoMdSPnSyFzSnXn47/7cTs2XY5L4x7hmJ+KaD
         oyKg==
X-Received: by 10.42.237.211 with SMTP id kp19mr3277697icb.70.1418928786396;
        Thu, 18 Dec 2014 10:53:06 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id 71sm3498088ios.42.2014.12.18.10.53.05
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 10:53:05 -0800 (PST)
Message-ID: <54932291.1040509@gmail.com>
Date:   Thu, 18 Dec 2014 10:53:05 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 24/67] MIPS: asm: spinlock: Replace sub instruction
 with addiu
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-25-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-25-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44807
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

On 12/18/2014 07:09 AM, Markos Chandras wrote:
> sub $reg, imm is not a real MIPS instruction. The assembler replaces
> that with 'addi $reg, -imm'.

That is a bug right there.  We cannot have faulting instructions like 
this in the kernel.

> However, addi has been removed from R6,
> so we replace the 'sub' instruction with 'addiu' instead.
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/include/asm/spinlock.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
> index f63b3543c1a4..c82fc0eefbec 100644
> --- a/arch/mips/include/asm/spinlock.h
> +++ b/arch/mips/include/asm/spinlock.h
> @@ -277,7 +277,7 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
>   		do {
>   			__asm__ __volatile__(
>   			"1:	ll	%1, 0(%2)# arch_read_unlock	\n"
> -			"	sub	%1, 1				\n"
> +			"	addiu	%1, -1				\n"

Instead, how about fixing the real bug by s/sub/subu/.

Would that work for R6 too?  If so, just do that.

>   			"	sc	%1, 0(%2)			\n"
>   			: "+m" (rw->lock), "=&r" (tmp)
>   			: "r" (&rw->lock)
>
