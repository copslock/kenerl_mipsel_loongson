Received:  by oss.sgi.com id <S42229AbQFYVtl>;
	Sun, 25 Jun 2000 14:49:41 -0700
Received: from u-217.frankfurt3.ipdial.viaginterkom.de ([62.180.18.217]:24068
        "EHLO u-217.frankfurt3.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42183AbQFYVtT>; Sun, 25 Jun 2000 14:49:19 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1403784AbQFYVsd>;
        Sun, 25 Jun 2000 23:48:33 +0200
Date:   Sun, 25 Jun 2000 23:48:33 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:     Andreas Jaeger <aj@suse.de>, Mike Klar <mfklar@ponymail.com>,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: errno assignment in _syscall macros and glibc
Message-ID: <20000625234833.B3802@bacchus.dhis.org>
References: <20000625232138.A3802@bacchus.dhis.org> <E136JuZ-0003C0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E136JuZ-0003C0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jun 25, 2000 at 10:25:48PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jun 25, 2000 at 10:25:48PM +0100, Alan Cox wrote:

> > Sure; these days glibc is more or less synonym with libc and I was using
> > it in that sense.
> > 
> > What small, portable libcs do we have available anyway?  Some mipers will
> > want one.
> 
> I've been playing with the Linux8086 libc which is tiny but not portable when
> Prumpf pointed out that Cygnus newlib is designed for precisely this job. Its
> about 250K MIPS32 (my PDA has mips32/mips64 but not mips16 - duh!!)

Oh promised lands of small happy libcs :-)

Back to the original problem - the i386 <asm/unistd.h> __syscall_return
macro which is used by the _syscallX macros set the errno variable - even
inside the kernel.  In the age of SMP this looks broken - at least nothing
seems to rely on it.  So how about removing the whole errno thing from
there?

  Ralf
