Received:  by oss.sgi.com id <S42214AbQFYSot>;
	Sun, 25 Jun 2000 11:44:49 -0700
Received: from u-202.karlsruhe.ipdial.viaginterkom.de ([62.180.10.202]:17156
        "EHLO u-202.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42183AbQFYSo1>; Sun, 25 Jun 2000 11:44:27 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1403784AbQFYSne>;
        Sun, 25 Jun 2000 20:43:34 +0200
Date:   Sun, 25 Jun 2000 20:43:34 +0200
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     Andreas Jaeger <aj@suse.de>
Cc:     Mike Klar <mfklar@ponymail.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: errno assignment in _syscall macros and glibc
Message-ID: <20000625204334.E1572@bacchus.dhis.org>
References: <NDBBIDGAOKMNJNDAHDDMCEODCKAA.mfklar@ponymail.com> <u8d7l6p0vq.fsf@gromit.rhein-neckar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <u8d7l6p0vq.fsf@gromit.rhein-neckar.de>; from aj@suse.de on Sun, Jun 25, 2000 at 11:26:33AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jun 25, 2000 at 11:26:33AM +0200, Andreas Jaeger wrote:

> The question remains what we should do with glibc 2.2.  Currently
> <sys/syscalls.h> includes <asm/unistd.h> and this makes _syscall0 and
> friends available to userspace. 
> 
> I couldn't find any reference to <sys/syscalls.h> in the ABI and
> consider dropping the include of <asm/unistd.h> since it's not needed
> at all.
> 
> Any objections or better suggestions?

I will take his report as a real bug but for another reason.  The kernel
has a global variable errno which at least on i386 get the returned
error value.  Fixing this one will magically fix userland.

Still everybody should be aware that using your own syscall wrappers
can be _very_ dangerous.  I saw an attempt to use pread / pwrite which
was ok on Intel but might have corrupted data on MIPS due to different
calling conventions.  You have been warned.

Andreas - I think the syscall interface should finally officially be
declared a private interface between libc and the kernel, that is nobody
except these two should use it.  Many of the other attempts to use it
have been quite problematic - portabilitywise and worse.

  Ralf
