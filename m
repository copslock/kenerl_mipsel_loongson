Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8PMBwT04329
	for linux-mips-outgoing; Tue, 25 Sep 2001 15:11:58 -0700
Received: from dea.linux-mips.net (u-247-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.247])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8PMBoD04322
	for <linux-mips@oss.sgi.com>; Tue, 25 Sep 2001 15:11:50 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8PMBaJ07681;
	Wed, 26 Sep 2001 00:11:36 +0200
Date: Wed, 26 Sep 2001 00:11:36 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: tommy.christensen@eicon.com
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: Register allocation in copy_to_user
Message-ID: <20010926001136.A5828@dea.linux-mips.net>
References: <3BB0D217.80E313F5@eicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB0D217.80E313F5@eicon.com>; from tommy.christensen@eicon.com on Tue, Sep 25, 2001 at 08:51:03PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Sep 25, 2001 at 08:51:03PM +0200, tommy.christensen@eicon.com wrote:

> For some time, I have seen occasional corruption of tty-output (pty's and
> serial). This turned out to be caused by a register collision in read_chan
> ()
> in n_tty.c. In the expansion of copy_to_user, the compiler chose register
> "a0" to hold the value of local variable __cu_from. Since this register is
> modified in the asm statement, before __cu_from is used, the corruption
> occured.
> 
> I am not sure, whether this is a compiler-bug (egcs-2.91.66) or the code
> should prevent this from happening. Have the semantics about side-effects
> of asm statements changed?
> 
> Anyway, the attached patch solves this by explicitly building the arguments
> to __copy_user in the argument registers ;-) instead of moving them around.
> So it actually saves some instructions as well. And the compiler can
> generate better code since it now has more registers for temporary
> variables ...
> 
> Is this OK? It works just fine for me with a 2.4.9 kernel (VR5000).

Unfortunately I had to find that your bugreport is correct.   To make
things worse at the time when I implemented this code I used your approach
(which definately is the cleaner approach) and I ran into the same problem.

  Ralf
