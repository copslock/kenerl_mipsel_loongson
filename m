Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16BcgD17625
	for linux-mips-outgoing; Wed, 6 Feb 2002 03:38:42 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16BcbA17622
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 03:38:37 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA11977;
	Wed, 6 Feb 2002 12:37:31 +0100 (MET)
Date: Wed, 6 Feb 2002 12:37:31 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com,
   binutils@sources.redhat.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
In-Reply-To: <20020205135407.A8309@lucon.org>
Message-ID: <Pine.GSO.3.96.1020206123244.11725A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 5 Feb 2002, H . J . Lu wrote:

> 0xd724 <__pthread_alt_lock+212>:        ll      v1,0(s1)
> 0xd728 <__pthread_alt_lock+216>:        move    a1,zero
> 0xd72c <__pthread_alt_lock+220>:	bne v1,s0,0xd744 <__pthread_alt_lock+244>
> 0xd730 <__pthread_alt_lock+224>:        nop
> 0xd734 <__pthread_alt_lock+228>:        move    a1,v0
> 0xd738 <__pthread_alt_lock+232>:        sc      a1,0(s1)
> 0xd73c <__pthread_alt_lock+236>:	beqz        a1,0xd724 <__pthread_alt_lock+212>
> 0xd740 <__pthread_alt_lock+240>:        nop
> 
> There is an extra "nop" in the delay slot. I don't think gas is smart
> enough to fill the delay slot. I will put back those ".set noredor".

 The code uses the same count of cycles either way.  As you may see above,
gas was smart enough to fill the "ll" load delay slot.  Maybe it should
prefer filling the branch delay slot instead due to smaller code... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
