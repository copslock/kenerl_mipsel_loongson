Received:  by oss.sgi.com id <S42220AbQGWT67>;
	Sun, 23 Jul 2000 12:58:59 -0700
Received: from m3bhNs1n20.midsouth.rr.com ([24.24.110.20]:44814 "EHLO
        GroundZero.enchanted.net") by oss.sgi.com with ESMTP
	id <S42207AbQGWT56>; Sun, 23 Jul 2000 12:57:58 -0700
Received: from talisman.enchanted.net (root@talisman.enchanted.net [10.20.30.50])
	by GroundZero.enchanted.net (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id OAA20677;
	Sun, 23 Jul 2000 14:56:15 -0500
Received: (from awrasman@localhost)
	by talisman.enchanted.net (8.11.0.Beta1/8.11.0.Beta1/Debian 8.11.0-1) id e6NJuE617866;
	Sun, 23 Jul 2000 14:56:14 -0500
From:   "A. Wrasman" <awrasman@enchanted.net>
Date:   Sun, 23 Jul 2000 14:56:14 -0500
To:     Ralf Baechle <ralf@uni-koblenz.de>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Okay, lost
Message-ID: <20000723145613.A17858@enchanted.net>
Reply-To: wrasman@cs.utk.edu
References: <20000717205303.A14220@enchanted.net> <20000718052309.B12440@bacchus.dhis.org> <14708.55755.682163.57386@calypso.engr.sgi.com> <20000719140505.A12322@bacchus.dhis.org> <20000719210555.A15023@enchanted.net> <20000720141319.A26191@bacchus.dhis.org> <20000722123548.A785@enchanted.net> <20000723030324.A2710@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000723030324.A2710@bacchus.dhis.org>; from ralf@uni-koblenz.de on Sun, Jul 23, 2000 at 03:03:24AM +0200
X-Url:  http://www.cs.utk.edu/~wrasman
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jul 23, 2000 at 03:03:24AM +0200, Ralf Baechle wrote:
> On Sat, Jul 22, 2000 at 12:35:49PM -0500, A. Wrasman wrote:
> 
> > Well removed the 2 extra cards from the box. Still no go.
> 
> Thanks.
> 
> I suspect that there is some magic configuration which crashes.  Since
> hardware doesn't make the difference it might also be the PROM version.
> Basically I believe that under certain circumstances the kernel overwrites
> PROM data structures or vice versa or there is (yet another ...) ARC
> firmware bug which results in a crash.

I've got version 5.3 of the prom for IP22. Of course SGI is doing some update of the support section of their site this weekend
so I can't even poke around to see what updates have come out, since I have't patched IRIX 6.2 in over 2 years on this box.

How can I go about troubleshooting the kernel at this point? The odd thing is a 2.2.14 (and an older 2.2.1) kernel all work fine.

Since most of the work is now being done on the 2.4 kernel it would be nice to get nearer to what the development is being done on.

> 
>   Ralf
