Received:  by oss.sgi.com id <S42248AbQGDWxq>;
	Tue, 4 Jul 2000 15:53:46 -0700
Received: from u-179.karlsruhe.ipdial.viaginterkom.de ([62.180.18.179]:45575
        "EHLO u-179.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42246AbQGDWxd>; Tue, 4 Jul 2000 15:53:33 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1403794AbQGDWxZ>;
        Wed, 5 Jul 2000 00:53:25 +0200
Date:   Wed, 5 Jul 2000 00:53:25 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Andreas Jaeger <aj@suse.de>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: FPU Control Word: Initial Value looks wrong
Message-ID: <20000705005325.A5913@bacchus.dhis.org>
References: <u8sntrm88t.fsf@gromit.rhein-neckar.de> <20000704003232.A2112@bacchus.dhis.org> <u8g0pqjfaf.fsf@gromit.rhein-neckar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <u8g0pqjfaf.fsf@gromit.rhein-neckar.de>; from aj@suse.de on Tue, Jul 04, 2000 at 01:39:04PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jul 04, 2000 at 01:39:04PM +0200, Andreas Jaeger wrote:

> Ralf> I tried your program on a Indy running 2.4.0-test2 + glibc 2.2 and it was
> Ralf> printing ``0 0''.
> 
> Did you try it with a shared program?

Yes.

> Static programs always initialize the FPU.  Could you run the program on
> other machines also?

Will do.

> Ralf> Could you check the source of your kernel for the value it's writing to
> Ralf> fcr31?  That's the constant FPU_DEFAULT defined in arch/mips/kernel/
> Ralf> r4k_switch.S.  Some quite old kernel were using a different value but I
> Ralf> was actually assuming those versions have already died out.
> 
> The kernels I used have 0 as FPU_DEFAULT - but nevertheless the
> returned value is wrong.  When is FPU_DEFAULT written to the FPU?

We do lazy fp context switching.  So the kernel initializes the FPU for a
process at the moment when it attempts to use it for the first time.  It
does so by enabling the FPU in the status register, clearing all flags in
$fcr31 and setting all fp registers to a SNAN.

  Ralf
