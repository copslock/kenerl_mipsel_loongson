Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Apr 2010 11:43:23 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:35603 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492422Ab0DHJnT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Apr 2010 11:43:19 +0200
Received: by pzk16 with SMTP id 16so171297pzk.22
        for <multiple recipients>; Thu, 08 Apr 2010 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=RIK+drH56veJpQFVnSiTetOsCXz26Tb2tQTWCTM2I94=;
        b=VlEZWPEDZ8QouPQ7JFOf12DKvToCdwoSXrSJEiNNsO0/PgNbEky5FA+++XwUxt7rdB
         qORJknux2igKXzfSHWi6YXCdmLnR9WzG+OK8NDcl97lu5eZPwTsFiSnBLKjBdUuTbjpf
         X83hCVmncMCvx7OJUhOdeey5JzS7X8HBSC3Bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Utr+btiY9KtyaCsmSJYz+F3a8taLT+uyextUYf4EZCD6ImrOPrvlhb+U886Cc3/AC3
         OFGoTI3WaLDxJYt1vip7GClsymULqRDGuzyhxlX/dCP3cnZ/sKhHlXvaGwVuk+tkjx5/
         PtofeWAAUc9mTlmfg3frrYP3R3px7RmXnLCXw=
Received: by 10.142.122.11 with SMTP id u11mr4214174wfc.227.1270719790973;
        Thu, 08 Apr 2010 02:43:10 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm2856495pzk.3.2010.04.08.02.43.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 02:43:10 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] MIPS: add a common mips_cyc2ns()
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralf =?ISO-8859-1?Q?R=F6sch?= <roesch.ralf@web.de>
In-Reply-To: <4BBCB750.3000002@caviumnetworks.com>
References: <cover.1270653461.git.wuzhangjin@gmail.com>
         <9e1889ed5fa23dfaa1ad432ebb4b8f837f6668b4.1270655886.git.wuzhangjin@gmail.com>
         <4BBCB750.3000002@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 08 Apr 2010 17:36:15 +0800
Message-ID: <1270719375.5709.39.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-04-07 at 09:48 -0700, David Daney wrote:
[...]
> >   arch/mips/include/asm/time.h |   38 ++++++++++++++++++++++++++++++++++++++
> >   1 files changed, 38 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
> > index c7f1bfe..898f0e0 100644
> > --- a/arch/mips/include/asm/time.h
> > +++ b/arch/mips/include/asm/time.h
> > @@ -96,4 +96,42 @@ static inline void clockevent_set_clock(struct clock_event_device *cd,
> >   	clockevents_calc_mult_shift(cd, clock, 4);
> >   }
> >
> > +static inline unsigned long long mips_cyc2ns(u64 cyc, u64 mult, u64 shift)
> > +{
> > +#ifdef CONFIG_32BIT
> > +	/*
> > +	 * To balance the overhead of 128bit-arithematic and the precision
> > +	 * lost, we choose a smaller shift to avoid the quick overflow as the
> > +	 * X86&  ARM does. please refer to arch/x86/kernel/tsc.c and
> > +	 * arch/arm/plat-orion/time.c
> > +	 */
> > +	return (cyc * mult)>>  shift;
> > +#else /* CONFIG_64BIT */
> > +	/* 64-bit arithmatic can overflow, so use 128-bit.  */
> > +#if (__GNUC__<  4) || ((__GNUC__ == 4)&&  (__GNUC_MINOR__<= 3))
> > +	u64 t1, t2, t3;
> > +	unsigned long long rv;
> > +
> > +	asm (
> > +		"dmultu\t%[cyc],%[mult]\n\t"
> > +		"nor\t%[t1],$0,%[shift]\n\t"
> > +		"mfhi\t%[t2]\n\t"
> > +		"mflo\t%[t3]\n\t"
> > +		"dsll\t%[t2],%[t2],1\n\t"
> > +		"dsrlv\t%[rv],%[t3],%[shift]\n\t"
> > +		"dsllv\t%[t1],%[t2],%[t1]\n\t"
> > +		"or\t%[rv],%[t1],%[rv]\n\t"
> > +		: [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2), [t3] "=&r" (t3)
> > +		: [cyc] "r" (cyc), [mult] "r" (mult), [shift] "r" (shift)
> > +		: "hi", "lo");
> > +	return rv;
> > +#else	/* GCC>  4.3 do it the easy way.  */
> > +	unsigned int __attribute__((mode(TI))) t = cyc;
> > +
> > +	t = (t * mult)>>  shift;
> > +	return (unsigned long long)t;
> > +#endif
> > +#endif /* CONFIG_64BIT */
> > +}
> > +
> >   #endif /* _ASM_TIME_H */
> 
> It turns out that all GCC versions can handle the inline asm way.  It 
> has also been noted that the default Debian compiler somehow has 
> problems with the 'easy way'.
> 
> Therefore, I would recommend gitting rid of the GCC version conditionals 
> and just leave the inline asm.

Ok, will only reserve the asm way in the next revision, thanks!

Regards,
	Wu Zhangjin
