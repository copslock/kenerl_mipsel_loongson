Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 12:36:52 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:61010 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492604AbZJHKgk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 12:36:40 +0200
Received: by pzk35 with SMTP id 35so720471pzk.22
        for <multiple recipients>; Thu, 08 Oct 2009 03:36:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=H58fUuuj9w7s+5yngK1ozqhYof3T4bH5/X/GJlIhRdw=;
        b=Xvp1QZ2P7ToX3bAgsY/ASm+w9hmy/TCabJRlAv3L8R/K2S4cpNA+umoCY3wyemHw6Y
         hubJZ8pUSx0Y97XGK+0xqgFv95em/z1UoectjS0PJZgLoqqJ2j57uabAq3EaVZZ8J4BE
         kMfspH3BFxrLhDyrReepO0tmIuXtIH0oTCe4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=I4jf+imgPA4uh1PM9r5W87OhAqdDr0+DGLpXEix32gsa51DoGiIg+XF1m1+VoSivu3
         8OBFbO+IsBaNGVQBtV75sIr587nOjpU6P5gdrxPSP5RvZRk4pXek+wdifWiKI6pd1nsG
         H145eclQCRJQS6vvrjaJH5MmJaWFFy79vzKdg=
Received: by 10.114.30.7 with SMTP id d7mr1968730wad.30.1254998192795;
        Thu, 08 Oct 2009 03:36:32 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm554896pxi.8.2009.10.08.03.36.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 03:36:32 -0700 (PDT)
Subject: Re: [PATCH] MIPS: fix pfn_valid() for FLAGMEM
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <4ACDB7CB.4030209@ru.mvista.com>
References: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com>
	 <4ACDB7CB.4030209@ru.mvista.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 08 Oct 2009 18:36:25 +0800
Message-Id: <1254998185.14496.24.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

> > When CONFIG_FLAGMEM enabled, STD/Hiberation will fail on YeeLoong
> >   
> 
>    You surely meant FLATMEM here and the subject.
> 
> > laptop, This patch fix it:
> >   
> 
>    Fixes.
> 

Thanks, will resend a new one later.

> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> >   
> [...]
> > diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> > index f266295..16903a6 100644
> > --- a/arch/mips/include/asm/page.h
> > +++ b/arch/mips/include/asm/page.h
> > @@ -168,13 +168,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
> >  
> >  #ifdef CONFIG_FLATMEM
> >  
> > -#define pfn_valid(pfn)							\
> > -({									\
> > -	unsigned long __pfn = (pfn);					\
> > -	/* avoid <linux/bootmem.h> include hell */			\
> > -	extern unsigned long min_low_pfn;				\
> > -									\
> > -	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
> > +#define pfn_valid(pfn)				\
> > +({						\
> > +	extern int is_pfn_valid(unsigned long); \
> > +	is_pfn_valid(pfn);			\
> >   
> 
>    Why not just define pfn_valid() as *extern* function in this case?
> 
> > diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
> > index f5c7375..48a4d2a 100644
> > --- a/arch/mips/mm/page.c
> > +++ b/arch/mips/mm/page.c
> > @@ -689,3 +689,20 @@ void copy_page(void *to, void *from)
> >  }
> >  
> >  #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
> > +
> > +#ifdef CONFIG_FLATMEM
> > +int is_pfn_valid(unsigned long pfn)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < boot_mem_map.nr_map; i++) {
> > +		if (boot_mem_map.map[i].type == BOOT_MEM_RAM) {
> > +			if ((pfn >= PFN_DOWN(boot_mem_map.map[i].addr)) &&
> > +				((pfn) <= (PFN_UP(boot_mem_map.map[i].addr +
> >   
> 
>    Not <?
> 

Just checked it again, here should be <.

Regards,
	Wu Zhangjin
