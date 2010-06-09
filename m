Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 18:59:10 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:39487 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491172Ab0FIQ7H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 18:59:07 +0200
Received: by pvg11 with SMTP id 11so2363660pvg.36
        for <multiple recipients>; Wed, 09 Jun 2010 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=hJMZSRmCABa5tCfktxmcJggIUDsGEp59nbe+8B5VxpA=;
        b=lQv6QnWorUtHOqDqoUCNUfGiYcdO2KyXs9Tom2/onsz2D2kH8s5BG0fZ9x7vWg47HS
         /wSJuikfe1I+fGkY7gUqNIG4JUJjaPW6/MbZEH+9GBLq6JUS3MHoylXQF1vufLxnIZ2h
         21AyNgySRoOf2UVzDuETtx8juymlWHz+TPNpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZvN1lAUVlU4++hunkSLC8zwbdVpCXHdEZhL0SGgEvi4qdfvWsU78cWIS+/GjHTWBzi
         PxbnSEJcAf/LE3ziZaXGLjNvCQEF363X18tO+Qsj6t78pRCYTKeGsk9SORV25MkZLma1
         f7RgaYf6XOQBD1Y2nxRgkHWhiKzqVh7nXrb7E=
Received: by 10.143.21.25 with SMTP id y25mr13243816wfi.62.1276102737906;
        Wed, 09 Jun 2010 09:58:57 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id u18sm2662934wfh.7.2010.06.09.09.58.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 09 Jun 2010 09:58:56 -0700 (PDT)
Message-ID: <4C0FC84E.8080101@gmail.com>
Date:   Wed, 09 Jun 2010 09:58:54 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org, a.p.zijlstra@chello.nl,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com,
        jamie.iles@picochip.com
Subject: Re: [PATCH v6 2/7] MIPS: use generic atomic64 in non-64bit kernels
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com> <1276058130-25851-3-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1276058130-25851-3-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 27113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6588

On 06/08/2010 09:35 PM, Deng-Cheng Zhu wrote:
> 64bit kernel has already had its atomic64 functions. Except for that, we
> use the generic spinlocked version. The atomic64 types and related
> functions are needed for the Linux performance counter subsystem.
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>

I already acked this once, so you can (should) add my...

Acked-by: David Daney <ddaney@caviumnetworks.com>


Really, this part is correct and standalone, so I think Ralf should just 
go ahead and merge it to his queue.

David Daney.

> ---
>   arch/mips/Kconfig              |    1 +
>   arch/mips/include/asm/atomic.h |    4 ++++
>   2 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index cdaae94..564e30b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -11,6 +11,7 @@ config MIPS
>   	select HAVE_FTRACE_MCOUNT_RECORD
>   	select HAVE_FUNCTION_GRAPH_TRACER
>   	select RTC_LIB if !MACH_LOONGSON
> +	select GENERIC_ATOMIC64 if !64BIT
>
>   mainmenu "Linux/MIPS Kernel Configuration"
>
> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
> index 59dc0c7..485ec36 100644
> --- a/arch/mips/include/asm/atomic.h
> +++ b/arch/mips/include/asm/atomic.h
> @@ -782,6 +782,10 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
>    */
>   #define atomic64_add_negative(i, v) (atomic64_add_return(i, (v))<  0)
>
> +#else /* !CONFIG_64BIT */
> +
> +#include<asm-generic/atomic64.h>
> +
>   #endif /* CONFIG_64BIT */
>
>   /*
