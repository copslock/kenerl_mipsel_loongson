Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Apr 2010 11:39:59 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:59718 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491843Ab0DHJj4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Apr 2010 11:39:56 +0200
Received: by pwj3 with SMTP id 3so1789309pwj.36
        for <multiple recipients>; Thu, 08 Apr 2010 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=C7O2d7etTz1VU/R5peusrWABGHUf+r/U2rJPoDjqArg=;
        b=EqZ8pHTxtk5VITH2K5vBocev97KmACL2A13JpF8z9QrtfwQcTjebTX4r0QbsWUzP1W
         TO0E1/5uFVEMIeH/iuD7bVzrFg7PxFYiZ1EG5+gT1Fkz8HnTqK5dI9fYb8nYqNFuEF9B
         gXjChpyEA289rQw5v1txuna4MxIajMGD+7zug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=kmD7UHCQVEgQ34FdeKRuM8c02AcoFNt3ZgOa2SsOdHfn+ZdhiOwWhfgW6Ac1VEU6fN
         4y2jBjXHNwzK4wb8PsLQ/9Huy6vA41PwRV/q9FoAsNMxH9P/OZjdKSrARguSMwb1uKX4
         NVmnJvJYjlYu6XCxAb/17kCC4FFk/svU5bqD8=
Received: by 10.115.115.9 with SMTP id s9mr9955358wam.66.1270719586583;
        Thu, 08 Apr 2010 02:39:46 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3231125pzk.12.2010.04.08.02.39.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 02:39:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] MIPS: add a common mips_cyc2ns()
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralf =?ISO-8859-1?Q?R=F6sch?= <roesch.ralf@web.de>
In-Reply-To: <4BBCB7EC.5020403@caviumnetworks.com>
References: <cover.1270653461.git.wuzhangjin@gmail.com>
         <9e1889ed5fa23dfaa1ad432ebb4b8f837f6668b4.1270655886.git.wuzhangjin@gmail.com>
         <4BBCB7EC.5020403@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 08 Apr 2010 17:32:51 +0800
Message-ID: <1270719171.5709.37.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-04-07 at 09:50 -0700, David Daney wrote:
[...]
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
> 
> Have you tested that on a 32-bit kernel?  I think it may overflow for 
> many cases.
> 

Yes, I have done some basic testing ;)

Since a c0 count with 400MHz clock frequency will overflow after about
more than 1 hour with the scaling factor 10, I think it is enough for
the generic debugging, such as Ftrace, If it is not enough, perhaps we
can choose a smaller scaling factor, such as 8.

The core idea here is to get a smaller mult to let (cyc * mult) not
overflow that quickly but also not get a 'bad' precision, of course, we
can try to implement the 128bit arithmatic in 32bit system, but that may
increase the overhead(not tested it yet, perhaps will be worse than the
original getnstimeofday()).

Regards,
	Wu Zhangjin
