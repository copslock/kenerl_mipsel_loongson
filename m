Received:  by oss.sgi.com id <S553800AbRCNTwl>;
	Wed, 14 Mar 2001 11:52:41 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:30192 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553779AbRCNTwY>;
	Wed, 14 Mar 2001 11:52:24 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f2EJlV326000;
	Wed, 14 Mar 2001 11:47:31 -0800
Message-ID: <3AAFCB24.E7910A9B@mvista.com>
Date:   Wed, 14 Mar 2001 11:48:52 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Daniel Jacobowitz <dan@debian.org>, linux-mips@oss.sgi.com
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org> <20010314202058.B1911@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:

> > If it does, I can probably whip up a -mmad patch to binutils to allow
> > those opcodes - or I could introduce -mnevada, or whatever the
> > appropriate term would be, to mean "r8000 with the mad* extensions".
> > In fact, that would probably be easiest, and sounds like the most
> > correct.
> 
> Don't think of the r8000; the kernel only uses the -mcpu=r8000 option
> because the Nevada CPUs have _somewhat_ similar scheduling properties
> to the R8000.  This of it as an independant ISA expension which can
> be used with an arbitrary MIPS processor - even a R3000 processor.
> 

Although -mmad is generic, why do we need it for kernel compiling?  If no good
reason, I propose to remove -mmad from the Makefile for Nevada chip.

Of course, we still need to fix the -mmad implying -m4650 bug ...

Jun
