Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2005 08:33:54 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.196]:15250 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133494AbVKAIdg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Nov 2005 08:33:36 +0000
Received: by zproxy.gmail.com with SMTP id j2so970709nzf
        for <linux-mips@linux-mips.org>; Tue, 01 Nov 2005 00:34:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FBjxjaOmeJHqS0BdUh/jH+MMRqHfl6tER2i+S8EDjKGkKYoWyCk34J/RQEC0YS67/8EqhYkOhOY3QFRJ/u5Wv5Ndp5ybjVWwNb5TMEakQJldmkx/V90xoFCnN6eAzkDCCYf3mE8QwEvXOLK2Dp/8sEfFFFgL6DisM95Hrgaf4X4=
Received: by 10.37.22.77 with SMTP id z77mr4239674nzi;
        Tue, 01 Nov 2005 00:34:11 -0800 (PST)
Received: by 10.36.48.2 with HTTP; Tue, 1 Nov 2005 00:34:11 -0800 (PST)
Message-ID: <cda58cb80511010034n704ae697r@mail.gmail.com>
Date:	Tue, 1 Nov 2005 09:34:11 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [RFC] Add 4KSx support (try 2)
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <4366584C.8080503@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510310034k60b273dfm@mail.gmail.com>
	 <4365DF22.8060004@mips.com>
	 <cda58cb80510310801v2d60f60bh@mail.gmail.com>
	 <4366584C.8080503@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/10/31, Kevin D. Kissell <kevink@mips.com>:
> Franck wrote:
>
> >>There are places, for example arch/mips/mm/cache.c, but
> >>also some of the other makefiles, where you're using your
> >>new config flags to drive things where the standard
> >>CONFIG_CPU_MIPS32 (which I guess has now fragmented into
> >>CONFIG_CPU_MIPS32_R1 and CONFIG_CPU_MIPS32_R2, which would
> >>apply to the Sc and Sd respectively) would do the right thing
> >>while creating fewer source file mods.
> >>
> >
> >
> > That's correct but CONFIG_CPU_MIPS32_Rx seems to be a fallback case.
> > Don't other cpu use their own flags whereas they could just use
> > CONFIG_CPU_MIPS32_Rx flag instead ?
>
> I think that those other CPUs aren't, strictly speaking,
> MIPS32-compliant CPUs in one respect or another, so they
> end up picking up MIPS32 kernel behavior "a la carte".
> The 4KS family is a strict superset.
>

If so, that makes sense. Ralf, should I modify the patch to use
CONFIG_CPU_MIPS32_Rx flags whenever it's possible as suggest Kevin ?

Thanks
--
               Franck
