Received:  by oss.sgi.com id <S553678AbQKOBoc>;
	Tue, 14 Nov 2000 17:44:32 -0800
Received: from u-210.karlsruhe.ipdial.viaginterkom.de ([62.180.18.210]:34820
        "EHLO u-210.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553671AbQKOBoU>; Tue, 14 Nov 2000 17:44:20 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870081AbQKOBn6>;
        Wed, 15 Nov 2000 02:43:58 +0100
Date:   Wed, 15 Nov 2000 02:43:58 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@oss.sgi.com
Subject: Re: Build failure for R3000 DECstation
Message-ID: <20001115024358.A3182@bacchus.dhis.org>
References: <20001115004122.G927@bacchus.dhis.org> <Pine.GSO.3.96.1001115014410.11897A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1001115014410.11897A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Nov 15, 2000 at 01:58:21AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 15, 2000 at 01:58:21AM +0100, Maciej W. Rozycki wrote:

> > In any case, for uniprocessor non-ll/sc machines there is also a better
> > solution availble with no syscalls at all.  It's easy to implement, just
> > use the fact that any exception will change the values of k0/k1.  That of
> > course breaks silently on SMP.
> 
>  Can you guarantee it???  Well I can guarantee k0 and k1 won't change when
> least expected. ;-)  AFAIK, the only fact guaranteed is that exception
> handlers do not preserve the values of the scratch registers, but it does
> not mean the last value written there is always different from what was
> there upon a handler's entry... 

Make that change k0 to a non-zero value.  So a R3000 UP spinlock can look
like:

	move	k0, zero
	li	t0, 1
0:	sw	t0, spin
	bnez	k0, 0b

	[critical section]

	sw	zero, spin

  Ralf

(Who should write thousant times ``I shall not post with a phone in my hand'')
