Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MI92N16640
	for linux-mips-outgoing; Fri, 22 Feb 2002 10:09:02 -0800
Received: from coplin19.mips.com ([80.63.7.130])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MI8w916637
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 10:08:58 -0800
Received: (from kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) id g1MH8pX13027;
	Fri, 22 Feb 2002 18:08:51 +0100
Date: Fri, 22 Feb 2002 18:08:51 +0100
From: Kjeld Borch Egevang <kjelde@mips.com>
Message-Id: <200202221708.g1MH8pX13027@coplin19.mips.com>
To: <linux-mips@oss.sgi.com>
Subject: Re: ieee754_csr is the problem (Re: lazy fpu switch irrelavant to no-fpu  case?
In-Reply-To: <006701c1bb87$b2b6fb80$0deca8c0@Ulysses>
References: <3C75B181.C5A065A1@mvista.com> <3C75C19C.13BB0FCC@mvista.com> <006701c1bb87$b2b6fb80$0deca8c0@Ulysses>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

In mips.test, you wrote:
>This is what I get for processing my mail in-order.
>I just got done writing a message asking if the
>ieee_754_csr issue might be at the root of your
>problem.
>
>Anyway, rather than create an array of the damned
>things, I would think that the "best" thing to do would
>be to merge the "abstract" IEEE CSR with the
>simulated MIPS CSR (by adding the "noq" and
>"nod" bits in otherwise unused/reserved bit positions),
>and using the thread-local CSR copy for all of the
>ieee_754_csr manipulations, much as I did for
>the FP registers.  That would be a bit more intrusive
>than your proposed hack, however, and only slightly
>more efficient.

I've been wondering: Why was the CSR copy made in the first place?

/Kjeld

-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
