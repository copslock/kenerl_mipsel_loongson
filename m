Received:  by oss.sgi.com id <S42223AbQGCWck>;
	Mon, 3 Jul 2000 15:32:40 -0700
Received: from u-154.karlsruhe.ipdial.viaginterkom.de ([62.180.10.154]:2311
        "EHLO u-154.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42203AbQGCWcg>; Mon, 3 Jul 2000 15:32:36 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1403794AbQGCWcc>;
        Tue, 4 Jul 2000 00:32:32 +0200
Date:   Tue, 4 Jul 2000 00:32:32 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Andreas Jaeger <aj@suse.de>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: FPU Control Word: Initial Value looks wrong
Message-ID: <20000704003232.A2112@bacchus.dhis.org>
References: <u8sntrm88t.fsf@gromit.rhein-neckar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <u8sntrm88t.fsf@gromit.rhein-neckar.de>; from aj@suse.de on Mon, Jul 03, 2000 at 07:30:42PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jul 03, 2000 at 07:30:42PM +0200, Andreas Jaeger wrote:

> Porting glibc to MIPS I noticed that the initial contents of the fpu
> control word doesn't seem to be right (at least on the machines I've
> tried - one with a normal MIPS 2.2.13 and one with 2.2.15 and the
> MIPS/Algorithmics patches (including FPU emulator).

> The appended small test program should return a 0 (that's the desired
> value by glibc for full ISO C99 support) - but it seems to be set to
> 0x600.
> 
> Could the kernel folks fix this, please?  I grepped through the sources
> and didn't find a place where the FPU gets initialised.:-(

Surprise - the kernel initializes this to zero and the libc should do
the same afair.  Did this change?

I tried your program on a Indy running 2.4.0-test2 + glibc 2.2 and it was
printing ``0 0''.

Could you check the source of your kernel for the value it's writing to
fcr31?  That's the constant FPU_DEFAULT defined in arch/mips/kernel/
r4k_switch.S.  Some quite old kernel were using a different value but I
was actually assuming those versions have already died out.

  Ralf
