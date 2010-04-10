Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 07:53:37 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:62637 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491198Ab0DJFxe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Apr 2010 07:53:34 +0200
Received: by pzk16 with SMTP id 16so1906936pzk.22
        for <multiple recipients>; Fri, 09 Apr 2010 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=/tdnyVjdB6pSd4hkQchcX8/5I9QTxb4uzrrN2Ac6+t0=;
        b=U/Upc57LVk28iBQX2m3egkmTCjZrjRKq6bAEQeIQ5owDVodVivlRbSJeXkdVodmL+a
         pgmPaxE2xNufN9vt10W4tITMb9UzmXqNVq8gI5d8IznewSQKaWkSo+CUTXBOqxce0wJb
         TFz2BZz1xxvmGEKzyNbAgcvCwrG32r7u+JHfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=enIu3/xcpJviepLAN5r/Vle+yMedhi6QUxN+5qWWw3pJ/M3UqMqazkFSNxvw2hTky8
         F5Ihml2IzJa2d0MnJMad8bSAgzA3juLmEl1qTj4nCs7A56FEwyzL1z89f+G5zNQSBOOW
         VQ82i2N44IgkmQtgOCy+aBQ6hjJ9Ij/jNhr6g=
Received: by 10.114.186.40 with SMTP id j40mr1397300waf.93.1270878806187;
        Fri, 09 Apr 2010 22:53:26 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 23sm1599507pzk.2.2010.04.09.22.53.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 22:53:24 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] MIPS: add a common mips_cyc2ns()
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralf =?ISO-8859-1?Q?R=F6sch?= <roesch.ralf@web.de>
In-Reply-To: <1270719171.5709.37.camel@falcon>
References: <cover.1270653461.git.wuzhangjin@gmail.com>
         <9e1889ed5fa23dfaa1ad432ebb4b8f837f6668b4.1270655886.git.wuzhangjin@gmail.com>
         <4BBCB7EC.5020403@caviumnetworks.com>  <1270719171.5709.37.camel@falcon>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 10 Apr 2010 13:46:29 +0800
Message-ID: <1270878389.17333.39.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-04-08 at 17:32 +0800, Wu Zhangjin wrote:
> On Wed, 2010-04-07 at 09:50 -0700, David Daney wrote:
> [...]
> > > +static inline unsigned long long mips_cyc2ns(u64 cyc, u64 mult, u64 shift)
> > > +{
> > > +#ifdef CONFIG_32BIT
> > > +	/*
> > > +	 * To balance the overhead of 128bit-arithematic and the precision
> > > +	 * lost, we choose a smaller shift to avoid the quick overflow as the
> > > +	 * X86&  ARM does. please refer to arch/x86/kernel/tsc.c and
> > > +	 * arch/arm/plat-orion/time.c
> > > +	 */
> > > +	return (cyc * mult)>>  shift;
> > 
> > Have you tested that on a 32-bit kernel?  I think it may overflow for 
> > many cases.
> > 
> 
> Yes, I have done some basic testing ;)
> 
> Since a c0 count with 400MHz clock frequency will overflow after about
> more than 1 hour with the scaling factor 10,

Exactly, with 10, it will overflow after counting 2^51, which means it
will overflow at 3127 hours(about 130 days), which is enough.

>  I think it is enough for
> the generic debugging, such as Ftrace, If it is not enough, perhaps we
> can choose a smaller scaling factor, such as 8.

With 8, it will overflow after 12510 hours(about 521 days).

So, I will choose 8 in the next revision.

PS: ...

#include <stdio.h>

#define NSEC_PER_SEC 1000000000	/* 10^9 */
#define CLOCK_FREQ 400000000	/* 400 M*/
#define CYC2NS_SHIFT 8

int main(void)
{
	unsigned long long mult, v;
	unsigned long long ullint_max = ~0;
	unsigned long long tmp = 2ULL<<53;
	double t_ns;
	int t_h, t_d;

        v = NSEC_PER_SEC;
        v <<= CYC2NS_SHIFT;
        v += CLOCK_FREQ/2;
        v = v / CLOCK_FREQ;
        mult = v;

	printf("sizeof(unsigned long long): %d\n", sizeof(unsigned long long));
	printf("%lld (max of cycles)\n", ullint_max/mult);
	printf("%lld (2^53)\n", tmp);

	t_h = (double)tmp / CLOCK_FREQ / 3600;
	t_d = t_h / 24;
	printf("%d hours, %d days\n", t_h, t_d);

	return 0;
}

$ gcc -o clock clock.c
$ $ ./clock 
sizeof(unsigned long long): 8
28823037615171174 (max of cycles)
18014398509481984 (2^53)
12509 hours, 521 days

Regards,
	Wu Zhangjin
