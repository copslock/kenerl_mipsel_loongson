Received:  by oss.sgi.com id <S553830AbQKROOF>;
	Sat, 18 Nov 2000 06:14:05 -0800
Received: from u-71.karlsruhe.ipdial.viaginterkom.de ([62.180.19.71]:2312 "EHLO
        u-71.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S553826AbQKRONn>; Sat, 18 Nov 2000 06:13:43 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870463AbQKRON3>;
        Sat, 18 Nov 2000 15:13:29 +0100
Date:   Sat, 18 Nov 2000 15:13:28 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: sysmips syscall
Message-ID: <20001118151328.B17046@bacchus.dhis.org>
References: <20001118115909.D8672@bacchus.dhis.org> <23098.974555179@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <23098.974555179@ocs3.ocs-net>; from kaos@melbourne.sgi.com on Sun, Nov 19, 2000 at 12:46:19AM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Nov 19, 2000 at 12:46:19AM +1100, Keith Owens wrote:

> On Sat, 18 Nov 2000 11:59:09 +0100, 
> Ralf Baechle <ralf@oss.sgi.com> wrote:
> >You can base a spinlock implementation on the fact that the register k0
> >will be left at a value != zero after any exception, also including context
> >switches.
> >
> >Problem: this solution breaks silently on multiproessor systems.
> 
> Use Dekker's algorithm between systems.  It requires cache coherent
> memory but does not need any inter cpu locking mechanisms.
> 
> http://www.cs.wvu.edu/~jdm/classes/cs356/notes/mutex/Dekker.html
> describes the algorithm for the two cpu case.  It assumes no preemption
> on each cpu so it has to be modified to handle interrupts.  Add a local
> lock so you are the only code on this processor trying to use Dekker
> between processors.

We're talking about a algorithem to implement atomic operations only in
userspace.  There is Dekker and few improved variants of it.  They all
got in common that they're performing badly for an increasing number of
threads even for the no-contention case.  And non-constant memory
requirements which would require further changes to glibc.  So I consider
this whole family of algorithems to be a entirely theoretical construct.
Which is why we're thinking about those crude hacks.

  Ralf
