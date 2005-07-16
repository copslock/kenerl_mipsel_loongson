Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2005 16:18:50 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:60078 "EHLO
	zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8226777AbVGPPS2>; Sat, 16 Jul 2005 16:18:28 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DtoSE-00067i-00; Sat, 16 Jul 2005 17:19:50 +0200
Date:	Sat, 16 Jul 2005 17:19:50 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Dan Malek <dan@embeddededge.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: power management status for au1100
Message-ID: <20050716151950.GF26127@enneenne.com>
References: <20050712142202.GB9234@gundam.enneenne.com> <20050712181013.GC9234@gundam.enneenne.com> <a2882b70a3d6c0f32728086e0c63764c@embeddededge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Content-Disposition: inline
In-Reply-To: <a2882b70a3d6c0f32728086e0c63764c@embeddededge.com>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Looking function mips_timer_interrupt() (which is the normal timer
interrupt when PM is not enabled) I noticed that it has called from
file =ABarch/mips/au1000/common/int-handler.S=BB as follow:

	...
        .text
        .set    macro
        .set    noat
        .align  5

NESTED(au1000_IRQ, PT_SIZE, sp)
        SAVE_ALL
        CLI                             # Important: mark KERNEL mode !

        mfc0    t0,CP0_CAUSE            # get pending interrupts
        mfc0    t1,CP0_STATUS           # get enabled interrupts
        and     t0,t1                   # isolate allowed ones

        andi    t0,0xff00               # isolate pending bits
        beqz    t0, 3f                  # spurious interrupt

        andi    a0, t0, CAUSEF_IP7
        beq     a0, zero, 1f
        move    a0, sp
        jal     mips_timer_interrupt
        j       ret_from_irq
	...

Looking at =ABCLI=BB implementation into =ABinclude/asm/stackframe.h=BB:

   /*
    * Move to kernel mode and disable interrupts.
    * Set cp0 enable bit as sign that we're running on the kernel stack
    */
		   .macro  CLI
		   mfc0    t0, CP0_STATUS
		   li      t1, ST0_CU0 | 0x1f
		   or      t0, t1
		   xori    t0, 0x1f
		   mtc0    t0, CP0_STATUS
		   irq_disable_hazard
		   .endm

I see that the CLI macro ensures that mips_timer_interrupt() will be
executed into =ABkernel mode=BB.

What do you think about that? Can it cause the error =ABBreak
instruction in kernel code in arch/mips/kernel/traps.c::do_bp, line
629[#1]:=BB?

If so, can someone help me in fixing such bug? I'm not a MIPS assembly
master! ;-p

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC2SWWQaTCYNJaVjMRAg/LAJ4ybFGl3NYmbruQhihgQNDw6v+yyACfcw9G
Fnw2qiWTNcnuhHeIqWr1zQY=
=RmQV
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--
