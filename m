Received:  by oss.sgi.com id <S553991AbRBNAls>;
	Tue, 13 Feb 2001 16:41:48 -0800
Received: from sgigate.SGI.COM ([204.94.209.1]:4920 "EHLO dea.waldorf-gmbh.de")
	by oss.sgi.com with ESMTP id <S553987AbRBNAli>;
	Tue, 13 Feb 2001 16:41:38 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1D6IP806517;
	Mon, 12 Feb 2001 22:18:25 -0800
Date:   Mon, 12 Feb 2001 22:18:25 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Pete Popov <ppopov@mvista.com>
Cc:     carlson@sibyte.com,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: irq.c
Message-ID: <20010212221825.B2239@bacchus.dhis.org>
References: <3A843C2D.525643E7@mvista.com> <0102091101190P.01909@plugh.sibyte.com> <3A84400E.82CEA4B@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A84400E.82CEA4B@mvista.com>; from ppopov@mvista.com on Fri, Feb 09, 2001 at 11:07:58AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Feb 09, 2001 at 11:07:58AM -0800, Pete Popov wrote:

> Thanks for pointing that out.  If all architectures will move to
> kernel/irq.c, then it probably makes sense to wait.  At first glance,
> mips/kernel/irq.c seems pretty close to i386/kernel/irq.c -- certainly a
> lot closer than many of the other copies.  

It was derived from a fairly recent copy of the x86 irq.c; running out of
time I never completed the rewrite.  The idea is to implement some kind
of modular interrupt mechanism which allows us to have a single piece of
code in the MIPS kernel that knows how to handle i8259 interrupt, a single
piece of code to handle GT64120 interrupts etc.  Not like the current mess
which duplicates code ad infinitum.

Aside it's also going to make the RTLinux fraction happy.

  Ralf
