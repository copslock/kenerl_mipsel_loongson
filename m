Received:  by oss.sgi.com id <S42218AbQFYVW7>;
	Sun, 25 Jun 2000 14:22:59 -0700
Received: from u-217.frankfurt3.ipdial.viaginterkom.de ([62.180.18.217]:22532
        "EHLO u-217.frankfurt3.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42183AbQFYVWT>; Sun, 25 Jun 2000 14:22:19 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1403784AbQFYVVj>;
        Sun, 25 Jun 2000 23:21:39 +0200
Date:   Sun, 25 Jun 2000 23:21:39 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:     Andreas Jaeger <aj@suse.de>, Mike Klar <mfklar@ponymail.com>,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: errno assignment in _syscall macros and glibc
Message-ID: <20000625232138.A3802@bacchus.dhis.org>
References: <20000625204334.E1572@bacchus.dhis.org> <E136I3I-0002yR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E136I3I-0002yR-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jun 25, 2000 at 08:26:42PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jun 25, 2000 at 08:26:42PM +0100, Alan Cox wrote:

> > Andreas - I think the syscall interface should finally officially be
> > declared a private interface between libc and the kernel, that is nobody
> > except these two should use it.  Many of the other attempts to use it
> > have been quite problematic - portabilitywise and worse.
> 
> Don't make it too private. glibc is still worryingly large for some embedded
> applications. Between a libc and the kernel yes, between glibc and the kernel
> no.

Sure; these days glibc is more or less synonym with libc and I was using
it in that sense.

What small, portable libcs do we have available anyway?  Some mipers will
want one.

  Ralf
