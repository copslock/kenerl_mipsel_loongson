Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 17:45:40 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.154]:29497 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492549Ab0D1Ppe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 17:45:34 +0200
Received: by fg-out-1718.google.com with SMTP id e12so1910453fga.6
        for <multiple recipients>; Wed, 28 Apr 2010 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=paUDiRkyc4+40o5+sTvZGgbdonxLHpJHcpfJGKC/uAI=;
        b=neqzIQIXw+QiL/cOYfwmz07bPMev9DxwWD/jcaFsYmhGBFTXz8TvkX3a2SlgeiaAPj
         KfIlb6DUA7/zxIFyEBFte6qKm+dnmT+gbYDYdwt+C4Fhp3/T29YTWjli1qBQbPYAvgUH
         KmN9Xgo9yWjuVQu0llq63wLuw+YJ7Vp6CtyLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=vnPkgZNgHV8D6ztTteIN9xJ6cBc0JQsQKsR6V6nZmT0Zemmz/+QKcZ5RRoK0upBk0y
         HrB6BURA6k0YrlGwqwfW45kk2LKfNkcedezXyOvh6Bx7gNXzGrx1HKKhEDTWK3JbB53f
         +9duJVM9PyiRYBEl5A4vLakpGpHGwu8AGviG8=
Received: by 10.87.74.15 with SMTP id b15mr8228554fgl.11.1272469532577;
        Wed, 28 Apr 2010 08:45:32 -0700 (PDT)
Received: from [192.168.2.210] ([202.201.14.140])
        by mx.google.com with ESMTPS id e11sm8933135fga.18.2010.04.28.08.45.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Apr 2010 08:45:30 -0700 (PDT)
Subject: Re: [PATCH] mips/traps: use CKSEG1ADDR for uncache handler
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20100427205330.GA1390@Chamillionaire.breakpoint.cc>
References: <20100427205330.GA1390@Chamillionaire.breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 28 Apr 2010 23:45:22 +0800
Message-ID: <1272469522.26380.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2010-04-27 at 22:53 +0200, Sebastian Andrzej Siewior wrote:
> since "MIPS: Calculate proper ebase value for 64-bit kernels" my mips
> toy did not boot anymore.
> Before that commit we always touched xkphys/shared as ebase and computed
> xphsys/unchached for that area. After that commit ebase become 32bit
> compat address and convert does not work anymore. So I guess now want to
> touch the 32bit compat unmapped & uncached area for this. CKSEG1ADDR
> does just in 32bit and 64bit.
> 

Just tested it in 32bit and 64bit kernel on my YeeLoong netbook, both of
them work well.

BTW: there is another patch[1] sent to this mailing list Yesterday,
differ from your method, it tries to provide a TO_UNCAC() for 32bit
kernel, but seems yours is lighter.

[1] http://patchwork.linux-mips.org/project/linux-mips/list/
  [1/2] MIPS: Fixup and cleanup of TO_PHYS(), TO_CAC(), TO_UNCAC()
  http://patchwork.linux-mips.org/patch/1146/
  [2/2] MIPS: Cleanup of set_uncached_handler()
  http://patchwork.linux-mips.org/patch/1147/

Regards,
	Wu Zhangjin

> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> ---
>  arch/mips/kernel/traps.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 4e00f9b..1b57f18 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1557,12 +1557,7 @@ static char panic_null_cerr[] __cpuinitdata =
>  void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
>  	unsigned long size)
>  {
> -#ifdef CONFIG_32BIT
> -	unsigned long uncached_ebase = KSEG1ADDR(ebase);
> -#endif
> -#ifdef CONFIG_64BIT
> -	unsigned long uncached_ebase = TO_UNCAC(ebase);
> -#endif
> +	unsigned long uncached_ebase = CKSEG1ADDR(ebase);
>  
>  	if (!addr)
>  		panic(panic_null_cerr);
