Received:  by oss.sgi.com id <S553863AbRAKArh>;
	Wed, 10 Jan 2001 16:47:37 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:7926 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553803AbRAKArM>;
	Wed, 10 Jan 2001 16:47:12 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0B0ibC02174;
	Wed, 10 Jan 2001 16:44:37 -0800
Message-ID: <3A5D02C6.FA7B9B06@mvista.com>
Date:   Wed, 10 Jan 2001 16:48:06 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: CPU Nevada
References: <3A5CDC3A.FE21F363@mvista.com> <012301c07b67$19b95c40$0deca8c0@Ulysses>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Kevin D. Kissell" wrote:
> 
> C'mon Pete, it's obviously a typo!   It predates my involvement
> with the code - hell, I never even knew that "Nevada" was the
> QED code name for the R5200 family before I started hacking
> on the MIPS Linux kernel, even though I had an R5230 system
> in my lab.  The "6" is probably shifted left one position from
> "R5260", which was, I believe, the first chip of the Nevada
> family to ship.

That's what I figured, but hey, it doesn't hurt to make sure.  I'm
working with a 5231 and wanted to make sure I don't need to add another
cpu type.

Pete

> ----- Original Message -----
> From: "Pete Popov" <ppopov@mvista.com>
> To: <linux-mips@oss.sgi.com>
> Sent: Wednesday, January 10, 2001 11:03 PM
> Subject: CPU Nevada
> 
> >
> > I can't find any information on a CPU Nevada, which supposedly is a 56x0
> > type. Is "R56x0 CONFIG_CPU_NEVADA" really meant to be "R52x0
> > CONFIG_CPU_NEVADA"?  The product id code of 0x2800 matches the QED 52xx
> > processors (at least the 5231) -- I can't find anything on a 56x0 CPU.
> >
> > Pete
