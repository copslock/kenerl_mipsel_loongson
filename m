Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2009 02:13:18 +0100 (BST)
Received: from mail-pz0-f134.google.com ([209.85.222.134]:47742 "EHLO
	mail-pz0-f134.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021959AbZEYBNJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2009 02:13:09 +0100
Received: by pzk40 with SMTP id 40so2710415pzk.22
        for <multiple recipients>; Sun, 24 May 2009 18:13:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=HNUdyDy5TmVlOMVqEBjkVsWC8HZwP17i3gy8Ga2nUeA=;
        b=O0ZJPL7A4aBr7b4wym0KcjjsOjnvCkB8IV+7pxM1nPpG6zADjb7nQY/iQ2sQT3L2HG
         GnK+Sq6Fg3cA3+uoafYpRHVB2YALG5kN5cH5QxKD3F7eUHj/LqCUtdIMGwlt6qKhKnqW
         ODeOY2OdF5S4vwysrF/rs9alf2JFqQeARDwkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=GYSmR6ilfVqBbOJUCtnithUiWiwzsdMjVMwwYaV79ST15DP5S0EmcSqiUkqulvB3gW
         igXxwczuQRcfK/La9JBeqqKcXKqYOTbG68bge9oBVpRi7Cw0DVhlrW4MvbePmgithrXw
         Sw4WPVmax8RaGXooyNfeXwhq3Vfsuhv4HcOr8=
Received: by 10.115.47.1 with SMTP id z1mr13701441waj.133.1243213982384;
        Sun, 24 May 2009 18:13:02 -0700 (PDT)
Received: from ?192.168.2.242? ([202.201.14.140])
        by mx.google.com with ESMTPS id k35sm13494962waf.22.2009.05.24.18.12.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 18:13:01 -0700 (PDT)
Subject: Re: [PATCH 25/30] loongson: Hibernation Support in mips system
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Pavel Machek <pavel@ucw.cz>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Erwan Lerale <erwan@thiscow.com>, huhb@lemote.com
In-Reply-To: <20090524194124.GA1337@ucw.cz>
References: <1242426488.10164.173.camel@falcon>
	 <20090524194124.GA1337@ucw.cz>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Mon, 25 May 2009 09:12:45 +0800
Message-Id: <1243213965.8872.9.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-05-24 at 21:41 +0200, Pavel Machek wrote:
> Hi!
> 

sorry, this is an old version without check via scripts/checkpatch.pl,
please ignore it, the latest version goes here:

[loongson-PATCH-v1 22/27] Hibernation Support in mips system

and the above one is also out of date, can not apply to the latest
linux-mip development git repo(-rc7).  so, please also ignore it, i am
working on a new version of it in the latest linux-mips git tree. and
will apply the existing feedbacks from the mailing list.

thanks!
Wu Zhangjin

> > >From d4776f4891b9be96d357910f62d9ebaf898a3015 Mon Sep 17 00:00:00 2001
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > Date: Sat, 16 May 2009 04:51:26 +0800
> > Subject: [PATCH 25/30] loongson: Hibernation Support in mips system
> 
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index d73f084..8bde363 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -677,6 +677,9 @@ core-y			+= arch/mips/kernel/ arch/mips/mm/
> > arch/mips/math-emu/
> >  
> >  drivers-$(CONFIG_OPROFILE)	+= arch/mips/oprofile/
> >  
> > +# suspend and hibernation support
> > +drivers-$(CONFIG_PM)	+= arch/mips/power/
> > +
> 
> Do all config combinations compile?
> 
> > @@ -3,4 +3,6 @@
> >  
> >  /* Somewhen...  Maybe :-)  */
> >  
> > +static inline int arch_prepare_suspend(void) { return 0; }
> > +
> 
> And kill the somewhen comment?
> 
> > @@ -326,3 +327,15 @@ void output_octeon_cop2_state_defines(void)
> >  	BLANK();
> >  }
> >  #endif
> > +
> > +#ifdef CONFIG_HIBERNATION
> > +void output_pbe_defines(void)
> > +{
> > + 	COMMENT(" Linux struct pbe offsets. ");
> > + 	OFFSET(PBE_ADDRESS , pbe, address);
> > + 	OFFSET(PBE_ORIG_ADDRESS  , pbe, orig_address);
> > + 	OFFSET(PBE_NEXT  , pbe, next);
> > + 	DEFINE(PBE_SIZE  , sizeof(struct pbe));
> > + 	BLANK();
> > +}
> > +#endif
> 
> What is this? please delete spaces before ,.
> 
> 
> 
> 
> > diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
> > new file mode 100644
> > index 0000000..e45ec45
> > --- /dev/null
> > +++ b/arch/mips/power/hibernate.S
> > @@ -0,0 +1,78 @@
> > +#incldue <linux/linkage.h>
> > +#include <asm/asm-offsets.h>
> > +#include <asm/regdef.h>
> > +#include <asm/asm.h>
> > +
> > +.text 
> > +LEAF(swsusp_arch_suspend)
> > +	 PTR_LA t0, saved_ra
> > +	 PTR_S ra, (t0)
> > +	 PTR_LA t0, saved_sp
> > +	 PTR_S sp, (t0)
> > +	 PTR_LA t0, saved_fp
> > +	 PTR_S fp, (t0)
> > +	 PTR_LA t0, saved_gp
> > +	 PTR_S gp, (t0)
> > +	 PTR_LA t0, saved_s0
> > +	 PTR_S s0, (t0) 
> > +	 PTR_LA t0, saved_s1
> > +	 PTR_S s1, (t0)
> > +	 PTR_LA t0, saved_s2
> > +	 PTR_S s2, (t0)
> > +	 PTR_LA t0, saved_s3
> > +	 PTR_S s3, (t0)
> > +	 PTR_LA t0, saved_s4
> > +	 PTR_S s4, (t0)
> > +	 PTR_LA t0, saved_s5
> > +	 PTR_S s5, (t0)
> > +	 PTR_LA t0, saved_s6
> > +	 PTR_S s6, (t0)
> > +	 PTR_LA t0, saved_s7
> > +	 PTR_S s7, (t0)
> > +	 PTR_LA t0, saved_a0
> > +	 PTR_S a0, (t0)
> > +	 PTR_LA t0, saved_a1
> > +	 PTR_S a1, (t0)
> > +	 PTR_LA t0, saved_a2
> > +	 PTR_S a2, (t0)
> > +	 PTR_LA t0, saved_v1
> > +	 PTR_S v1, (t0)
> > +	 j swsusp_save
> > +	 nop
> > +END(swsusp_arch_suspend)
> > +
> > +LEAF(swsusp_arch_resume)
> > +	PTR_L t0, restore_pblist
> > +0: 
> > +	PTR_L t1, PBE_ADDRESS(t0)   /* source */
> > + 	PTR_L t2, PBE_ORIG_ADDRESS(t0) /* destination */
> > + 	PTR_ADDIU t3, t1, _PAGE_SIZE
> > +1: 
> > +	REG_L t8, (t1)
> > + 	REG_S t8, (t2)
> > + 	PTR_ADDIU t1, t1, SZREG
> > + 	PTR_ADDIU t2, t2, SZREG
> > + 	bne t1, t3, 1b
> > + 	PTR_L t0, PBE_NEXT(t0)
> > + 	bnez t0, 0b
> > +	//flush cache and tlb. no need?I am not sure.
> 
> Avoid c++ comments... and yes, I guess you should flush cache/tlb.
> 
