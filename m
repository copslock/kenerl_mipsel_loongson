Received:  by oss.sgi.com id <S553678AbQKODNO>;
	Tue, 14 Nov 2000 19:13:14 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:56049 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553688AbQKODM4>;
	Tue, 14 Nov 2000 19:12:56 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eAF3Ac305933;
	Tue, 14 Nov 2000 19:10:38 -0800
Message-ID: <3A11FF44.D7B8D826@mvista.com>
Date:   Tue, 14 Nov 2000 19:13:08 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@oss.sgi.com
Subject: Re: Build failure for R3000 DECstation
References: <20001115004122.G927@bacchus.dhis.org> <Pine.GSO.3.96.1001115014410.11897A-100000@delta.ds2.pg.gda.pl> <20001115024358.A3182@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Wed, Nov 15, 2000 at 01:58:21AM +0100, Maciej W. Rozycki wrote:
> 
> > > In any case, for uniprocessor non-ll/sc machines there is also a better
> > > solution availble with no syscalls at all.  It's easy to implement, just
> > > use the fact that any exception will change the values of k0/k1.  That of
> > > course breaks silently on SMP.
> >
> >  Can you guarantee it???  Well I can guarantee k0 and k1 won't change when
> > least expected. ;-)  AFAIK, the only fact guaranteed is that exception
> > handlers do not preserve the values of the scratch registers, but it does
> > not mean the last value written there is always different from what was
> > there upon a handler's entry...
> 
> Make that change k0 to a non-zero value.  So a R3000 UP spinlock can look
> like:
> 
>         move    k0, zero
>         li      t0, 1
> 0:      sw      t0, spin
>         bnez    k0, 0b
> 
>         [critical section]
> 
>         sw      zero, spin
> 
>   Ralf
> 
> (Who should write thousant times ``I shall not post with a phone in my hand'')

You should not post when you are sleepy. :-)

The above code does not work - the loop is infinite as nobody will set
k0 to 0 again if it is not zero for the first time.

In fact, I don't think you can perform automic operation ONLY based on
the knowledge whether a context switch has happened during a specified
period.  (It should be interesting to see if we can actually "prove"
it.)

I also doubt if k0 is absolutely non-zero after a context ...

Jun
