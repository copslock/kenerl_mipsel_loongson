Received:  by oss.sgi.com id <S553801AbRAYCwK>;
	Wed, 24 Jan 2001 18:52:10 -0800
Received: from [12.44.186.158] ([12.44.186.158]:47861 "EHLO hermes.mvista.com")
	by oss.sgi.com with ESMTP id <S553792AbRAYCvw>;
	Wed, 24 Jan 2001 18:51:52 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0P2mkI20510;
	Wed, 24 Jan 2001 18:48:46 -0800
Message-ID: <3A6F94E0.4AB07CEB@mvista.com>
Date:   Wed, 24 Jan 2001 18:52:16 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     carlson@sibyte.com
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: floating point on Nevada cpu
References: <3A6F8F66.6258801@mvista.com> <0101241833281Q.00834@plugh.sibyte.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Justin Carlson wrote:
> 
> On Wed, 24 Jan 2001, Pete Popov wrote:
> > This simple test fails on a Nevada (5231) cpu:
> >
> > int main()
> > {
> >     float x1,x2,x3;
> >
> >     x1 = 7.5;
> >     x2 = 2.0;
> >     x3 = x1/x2;
> >     printf("x3 = %f\n", x3);
> > }
> >
> 
> Ummm...care to tell *how* it fails?

Here it is:

sh-2.03# ./fl
x3 = 0.000000


I'm running a test9 based kernel, but the same kernel compiled for my
Indigo2 produces the right result.  Also, the uptime commands complains
with:


Unknown HZ value! (2147483647) Assume 100.


At the console, I get "Setting flush to zero for uptime."  So, I took a
look at arch/mips/kernel/traps.c and the kernel retries the instruction
with denormalized instructions flushed to zero. However, the 5200
signals an unimplemented operation even if the FS bit is set. 

In any case, the first simple test doesn't run into the "flush to zero"
problem but the result is still bad.

Pete
