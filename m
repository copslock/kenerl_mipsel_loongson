Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2004 02:02:14 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:29317 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225272AbUDMBCN>;
	Tue, 13 Apr 2004 02:02:13 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.12.10/8.12.10) with ESMTP id i3D122TM026708;
	Mon, 12 Apr 2004 21:02:02 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i3D129M20455;
	Mon, 12 Apr 2004 21:02:09 -0400
Received: from [192.168.123.106] (vpn26-5.sfbay.redhat.com [172.16.26.5])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i3D128C01852;
	Mon, 12 Apr 2004 18:02:08 -0700
Subject: Re: [PATCH] gcc 3.4 drops "accum" clobber, replace with "hi" in
	time.c
From: Eric Christopher <echristo@redhat.com>
To: "Bradley D. LaRonde" <brad@laronde.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <048e01c420f1$ad4ae3b0$8d01010a@prefect>
References: <Pine.GSO.4.10.10404122244110.8735-100000@helios.et.put.poznan.pl>
	 <20040412231309.GA702@linux-mips.org>
	 <03f301c420e7$d8de2d70$8d01010a@prefect>
	 <048e01c420f1$ad4ae3b0$8d01010a@prefect>
Content-Type: text/plain
Message-Id: <1081818125.19719.14.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Apr 2004 18:02:08 -0700
Content-Transfer-Encoding: 7bit
X-RedHat-Spam-Score: 0 
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

On Mon, 2004-04-12 at 17:53, Bradley D. LaRonde wrote:
> Uh oh, with this patch:
> 
> ...
> time.c: In function `fixed_rate_gettimeoffset':
> time.c:242: error: can't find a register in class `HI_REG' while reloading
> `asm'
> ...

> >
> >         /*
> >          * Due to possible jiffies inconsistencies, we need to check
> > @@ -339,7 +339,7 @@
> >                                 : "r" (timerhi), "m" (timerlo),
> >                                   "r" (tmp), "r" (USECS_PER_JIFFY),
> >                                   "r" (USECS_PER_JIFFY_FRAC)
> > -                               : "hi", "lo", "accum");
> > +                               : "hi", "lo", "hi");
> >                         cached_quotient = quotient;


Maybe this hunk where you use "hi" twice for the same asm statement?

-eric

-- 
Eric Christopher <echristo@redhat.com>
