Received:  by oss.sgi.com id <S42232AbQFYWAb>;
	Sun, 25 Jun 2000 15:00:31 -0700
Received: from u-217.frankfurt3.ipdial.viaginterkom.de ([62.180.18.217]:25348
        "EHLO u-217.frankfurt3.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42183AbQFYV77>; Sun, 25 Jun 2000 14:59:59 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1403784AbQFYV7R>;
        Sun, 25 Jun 2000 23:59:17 +0200
Date:   Sun, 25 Jun 2000 23:59:17 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Andreas Jaeger <aj@suse.de>
Cc:     Mike Klar <mfklar@ponymail.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: errno assignment in _syscall macros and glibc
Message-ID: <20000625235917.C3802@bacchus.dhis.org>
References: <NDBBIDGAOKMNJNDAHDDMCEODCKAA.mfklar@ponymail.com> <u8d7l6p0vq.fsf@gromit.rhein-neckar.de> <20000625204334.E1572@bacchus.dhis.org> <u8zoo9mw2d.fsf@gromit.rhein-neckar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <u8zoo9mw2d.fsf@gromit.rhein-neckar.de>; from aj@suse.de on Sun, Jun 25, 2000 at 08:53:30PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jun 25, 2000 at 08:53:30PM +0200, Andreas Jaeger wrote:

> I'm considering to commit the appended patch.  I've compiled glibc
> with it and didn't notice any problems.  If nobody objects, I'll apply
> it tomorrow.
> 
> Ralf, are there any other places that needs to be changed?

libc/sysdeps/unix/sysv/linux/sys/syscall.h should be patched the same way.

I remember that I once saw a program the __NR_ syscall numbers imported
via unistd.h.  Fixing won't be a big deal.

> What do you think of adding 
> #ifdef KERNEL
> around _syscallX in <asm/unistd.h> ?

__KERNEL__ that is ...

Slightly radical but I like it.  It'll break some programs which are using
the _syscallX() macros to get syscalls which libc doesn't yet have wrappers
for just to get away without fixing / upgrading libc.  Those people still
can use syscall(3) in such a case.

  Ralf
