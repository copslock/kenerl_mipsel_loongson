Received:  by oss.sgi.com id <S553920AbQJaVod>;
	Tue, 31 Oct 2000 13:44:33 -0800
Received: from u-142.karlsruhe.ipdial.viaginterkom.de ([62.180.10.142]:43532
        "EHLO u-142.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553776AbQJaVoZ>; Tue, 31 Oct 2000 13:44:25 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869087AbQJaSW5>;
        Tue, 31 Oct 2000 19:22:57 +0100
Date:   Tue, 31 Oct 2000 19:22:57 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: userspace spinlocks
Message-ID: <20001031192257.B28909@bacchus.dhis.org>
References: <20001030151736.C2687@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001030151736.C2687@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Oct 30, 2000 at 03:17:36PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 30, 2000 at 03:17:36PM +0100, Florian Lohoff wrote:

> Hi,
> while compiling db2 i got the configure warning "spinlocks not implemented
> for this compiler/architecture" - I guess as we do not currently have
> SMP machines (except the ones ralf is working on) we dont have a problem,
> but how should the spinlocks be implemented ?

Think multithreadeding.  We do have the problem on every machine.

> I mean - normally "ll" and "sc" are needed - But those are not
> available on R3000 - And spinning in an ll/sc loop and emulating
> them with exceptions isnt that fast.

The assumption is that spinlocks have low contention so we don't loop.

Face it - the R3000 is completly idiotic processor to use in multiprocessor
systems.  Early R3000 SMP systems as built by SGI in the 80's did use
special external hardware to implement atomic operations.  Any atomic
operation was very expensive.  An old way to implement threadsafe atomic
operations is the sysmips(MIPS_ATOMIC_SET) interface, essentially a
syscall that implements atomic set-and-exchange functionality.  Something
that only continues to live as a compatibility relict.

We don't support R3000 SMP but multithreading turns out to be a similar
problem.  Computer science offers a number of algorithems which only
require atomic stores.  Their common problem is that they're aproximately
O(n^2) in the average or O(n) and have memory requirements proprortional
to n.  All in all it comes down to the fact that they're frighteningly
useless for realworld use.

For all this reasons I've choosen to simply implement userspace locking
by simply emulating ll/sc where not available.

If somebody really thinks the performance of this operations is a problem
well, our implementation is hardly optimal.

> OTOH - Where are they normally implemented ? libc ? macro ? Could
> there be a runtime linking thing with a cpu detection wether we 
> have ll/sc or not ?

Typical databases carry their own locking routines which are very well
tuned toward the behaviour of the database.

  Ralf
