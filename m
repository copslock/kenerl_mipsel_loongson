Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2010 06:05:56 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:63316 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490995Ab0D0EFw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Apr 2010 06:05:52 +0200
Received: by gwb1 with SMTP id 1so596178gwb.36
        for <multiple recipients>; Mon, 26 Apr 2010 21:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=oXgufPCcdKjwF9iEZBIQTx/2ZVdoHposGJFaZSS4hF0=;
        b=wcDTumKD0iH1jI3KFoa2upTsmqFMBCLOLfW/y8a0myfr+rb6m82ESTpuF8pTFcXqqE
         EmzdEslgu6Gc1VibVQ1PX63Uy1JQkcdQaslFntFVYzxJZ7A0NnDf424Hh4eEWvPB58vX
         uGwERyp2IV3Xo41i+ZN4dcACTknWFOEoVqc1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=CqqqtlmsCozKzhZTWJMWylTRmuyySNY2edbnxDBIZHkaoWHUDdt7ccJbWZEZaSGnbQ
         JKRtZIosxUXj2SuZLyaNnblHOsfiFdg7gWE4p9qv7KER5tCy0V515txuwtHGO5rT8WE3
         stHTSj9Fz5cjuyruOaoiBe5uCJLlqxx3qbDpk=
Received: by 10.150.159.15 with SMTP id h15mr4701827ybe.27.1272341144572;
        Mon, 26 Apr 2010 21:05:44 -0700 (PDT)
Received: from [192.168.2.213] ([202.201.14.140])
        by mx.google.com with ESMTPS id 16sm1745522gxk.13.2010.04.26.21.05.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 21:05:43 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     post@pfrst.de, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <4BD62E38.10707@caviumnetworks.com>
References: <Pine.LNX.4.21.1004270049440.1248-100000@Mobile0.Peter>
         <4BD62E38.10707@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 27 Apr 2010 12:05:37 +0800
Message-ID: <1272341137.21095.55.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2010-04-26 at 17:22 -0700, David Daney wrote:
[...]
> > Some time ago we needed to handle multiple (virtual) address-spaces
> > (in TO_CAC/TO_UNCAC as well as in virt_to_phys and the like) for
> > SGI's Indigo2/R10k and Octane (neither could run a 32bit kernel).
> > So in addrspace.h we provided
> > 	#ifdef CONFIG_64BIT
> > 	static inline unsigned long kernel_physaddr(unsigned long kva)
> > 	{
> > 		if((kva&0xffffffff80000000UL)==0xffffffff80000000UL)
> > 			return CPHYSADDR(kva);
> > 		return XPHYSADDR(kva);
> > 	}
> > 	#else
> > 	#define kernel_physaddr CPHYSADDR
> > 	#endif
> > while mach-ipXX/spaces.h defined
> > 	#define TO_PHYS(x)	(             kernel_physaddr(x))
> > 	#define TO_CAC(x)	(CAC_BASE   | kernel_physaddr(x))
> > 	#define TO_UNCAC(x)	(UNCAC_BASE | kernel_physaddr(x))
> > which did the job.
> > But at that time these defines didn't meet much acceptance for general
> > use in 64bit kernels.  Now, to my amusement, some modern processor
> > (and/or system) seems to urge this kind of address-handling again  ;-)
> >
> >
> 
> FWIW, that seems cleaner than what I did (actually I didn't try my 
> code).  That should be the default definition for 64-bit kernels I think.

Should we let this stuff be a common implementation? then we can also
provide the TO_CAC(), TO_PHYS(), TO_UNCAC() to the 32bit kernel and
remove some #ifdef from the kernel, for example:

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 1a4dd65..fb8cd40 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1557,12 +1557,7 @@ static char panic_null_cerr[] __cpuinitdata =
>  void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
>         unsigned long size)
>  {
> -#ifdef CONFIG_32BIT
> -       unsigned long uncached_ebase = KSEG1ADDR(ebase);
> -#endif
> -#ifdef CONFIG_64BIT
>         unsigned long uncached_ebase = TO_UNCAC(ebase);
> -#endif
> 

And I have found lots of places have used KSEG1ADDR() in the kernel source code,
If the TO_UNCAC() for 32bit is provided, then we can also replace it by TO_UNCAC().

I will try to make a patch for it.

Regards,
	Wu Zhangjin
