Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 23:56:08 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:41042 "EHLO
        mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491829Ab0E0V4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 23:56:04 +0200
Received: by pzk3 with SMTP id 3so185937pzk.24
        for <multiple recipients>; Thu, 27 May 2010 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=neLEGNsfjfM+h0kZl38yaLA7sfZ4WvXyjaR4FxBdLas=;
        b=GVgzcv9WUgaEjyQ0ztTyri7o9YbrBFaIk+Ahnp/zJLzujaD5NqXSwC+oPfG5oxS55J
         eSUJlDNtAPK2lEcxHMd7Yk3Xg/FPN9c+EN6xjLe+/Kv1aFvtnRUF+tg/+B3JxeJTwTF+
         Za8nGGZQP+4Y+ZGiVbna4T4H2btNoh/HdAVzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=P9OnLirIbTKCl4saeR7gV1srX80J0/iqI89VoAUFluLzL6JTqoAz2jQZYdPfbwIYpW
         QITeXP884YhTX4XeKlrEK9yaLx2gBTb2OqZ4JWwRPyZPD4vsQHxJW5i3+CJ6XZvtumtb
         bGiGCd8wC8Xchc2LchAjEm4mLiml5ipaoqunY=
Received: by 10.143.26.41 with SMTP id d41mr7790132wfj.316.1274997357237;
        Thu, 27 May 2010 14:55:57 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id x34sm932451wfi.16.2010.05.27.14.55.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 14:55:56 -0700 (PDT)
Message-ID: <4BFEEA6A.4030400@gmail.com>
Date:   Thu, 27 May 2010 14:55:54 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 02/12] MIPS: use generic atomic64 in non-64bit kernels
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-3-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-3-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> 64bit kernel has already had its atomic64 functions. Except for that, we
> use the generic spinlocked version. The atomic64 types and related
> functions are needed for the Linux performance counter subsystem.
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>

Acked-by: David Daney <ddaney@caviumnetworks.com>

> ---
>   arch/mips/Kconfig              |    1 +
>   arch/mips/include/asm/atomic.h |    4 ++++
>   2 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index cdaae94..ef3d8ca 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -4,6 +4,7 @@ config MIPS
>   	select HAVE_GENERIC_DMA_COHERENT
>   	select HAVE_IDE
>   	select HAVE_OPROFILE
> +	select GENERIC_ATOMIC64 if !64BIT
>   	select HAVE_ARCH_KGDB
>   	select HAVE_FUNCTION_TRACER
>   	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
> index 59dc0c7..23990cb 100644
> --- a/arch/mips/include/asm/atomic.h
> +++ b/arch/mips/include/asm/atomic.h
> @@ -782,6 +782,10 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
>    */
>   #define atomic64_add_negative(i, v) (atomic64_add_return(i, (v))<  0)
>
> +#else /* ! CONFIG_64BIT */
> +
> +#include<asm-generic/atomic64.h>
> +
>   #endif /* CONFIG_64BIT */
>
>   /*
