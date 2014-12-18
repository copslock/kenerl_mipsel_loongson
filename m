Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 19:50:38 +0100 (CET)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:44833 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007366AbaLRSufnv0ih (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 19:50:35 +0100
Received: by mail-ig0-f173.google.com with SMTP id r2so1387375igi.12
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EHW+CMO9wyjI6baNy68zJ5YcpgpV8j2t+3E77DcfYAg=;
        b=Kviyt95SXO6xTzuBsFBtVwS8SIswY9YP+lXMsFYau904zrDnZo5qs2qoL/yg+lQHs5
         Rxk7DsRLyA1H4BxjcNFA3IBWUKgH88/ZQ6wCzo2xeEa1uCrMaYTNWhe3sDe2hY4hCTp+
         X8JMz+ZRvB4GovA64Bql5NsXevPaT/ihxItm9TsTPmxzNFovyQKpS8SMFoHRcAjgPUbU
         IPtJXN+F4S414eUIkYb1YVku4OCkkE6ZvuQsek0iUHeKxOi8esDMrkCHkGYzMznMKhWF
         hR5rabHNUzxVxHiF7StlAMVILLGYCb/Z4Nyt4mZarDUW6P0PDbIEPR1bnK699BwEG3md
         LIkg==
X-Received: by 10.50.67.102 with SMTP id m6mr4049663igt.4.1418928629546;
        Thu, 18 Dec 2014 10:50:29 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id c204sm3502322ioc.16.2014.12.18.10.50.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 10:50:28 -0800 (PST)
Message-ID: <549321F3.1090704@gmail.com>
Date:   Thu, 18 Dec 2014 10:50:27 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA constrains
 for MIPS R6 support
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44806
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
> MIPS R6 changed the opcodes for LL/SC instructions and reduced the
> offset field to 9-bits. This has some undesired effects with the "m"
> constrain since it implies a 16-bit immediate. As a result of which,
> add a register ("r") constrain as well to make sure the entire address
> is loaded to a register before the LL/SC operations. Also use macro
> to set the appropriate ISA for the asm blocks
>

Has support for MIPS R6 been added to GCC?

If so, that should include a proper constraint to be used with the new 
offset restrictions.  We should probably use that, instead of forcing to 
a "r" constraint.


> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/include/asm/atomic.h | 50 +++++++++++++++++++++---------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
> index 6dd6bfc607e9..8669e0ec97e3 100644
> --- a/arch/mips/include/asm/atomic.h
> +++ b/arch/mips/include/asm/atomic.h
> @@ -60,13 +60,13 @@ static __inline__ void atomic_##op(int i, atomic_t * v)				\
>   										\
>   		do {								\
>   			__asm__ __volatile__(					\
> -			"	.set	arch=r4000			\n"	\
> -			"	ll	%0, %1		# atomic_" #op "\n"	\
> +			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
> +			"	ll	%0, 0(%3)	# atomic_" #op "\n"	\
>   			"	" #asm_op " %0, %2			\n"	\
> -			"	sc	%0, %1				\n"	\
> +			"	sc	%0, 0(%3)			\n"	\
>   			"	.set	mips0				\n"	\
>   			: "=&r" (temp), "+m" (v->counter)			\
> -			: "Ir" (i));						\
> +			: "Ir" (i), "r" (&v->counter));				\

You lost the "m" constraint, but are still modifying memory.  There is 
no "memory" clobber here, so we are no longer correctly describing what 
is happening.
