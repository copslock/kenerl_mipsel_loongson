Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 19:09:35 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:61313 "EHLO
	gundam.enneenne.com") by linux-mips.org with ESMTP
	id <S8226651AbVGLSJM>; Tue, 12 Jul 2005 19:09:12 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DsPCv-0005cl-00
	for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 20:10:13 +0200
Date:	Tue, 12 Jul 2005 20:10:13 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: Re: power management status for au1100
Message-ID: <20050712181013.GC9234@gundam.enneenne.com>
References: <20050712142202.GB9234@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <20050712142202.GB9234@gundam.enneenne.com>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Looking at linux-2.6.10 I notice that the function
startup_match20_interrupt() has been mofified as follow:

    #ifdef CONFIG_PM
   -void startup_match20_interrupt(void)
   +void startup_match20_interrupt(void (*handler)(int, void *, struct
   pt_regs *))
    {
   +       static struct irqaction action;
   +       /* This is a big problem.... since we didn't use request_irq
   +          when kernel/irq.c calls probe_irq_xxx this interrupt will
   +          be probed for usage. This will end up disabling the device :(
   +
   +       Give it a bogus "action" pointer -- this will keep it from
   +          getting auto-probed!
   +
   +       By setting the status to match that of request_irq() we
   +       can avoid it.  --cgray
   +       */
   +       action.dev_id =3D handler;
   +       action.flags =3D 0;
   +       action.mask =3D 0;
   +       action.name =3D "Au1xxx TOY";
   +       action.handler =3D handler;
   +       action.next =3D NULL;
   +
   +       irq_desc[AU1000_TOY_MATCH2_INT].action =3D &action;
   +       irq_desc[AU1000_TOY_MATCH2_INT].status
   +                &=3D ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING |
   IRQ_INPROGRESS);
   +
           local_enable_irq(AU1000_TOY_MATCH2_INT);
    }
    #endif

and the irq dispatcher has been modified as follow:

           irq =3D au_ffs(intc0_req1) - 1;
           intc0_req1 &=3D ~(1<<irq);
   -#ifdef CONFIG_PM
   -       if (irq =3D=3D AU1000_TOY_MATCH2_INT) {
   -               mask_and_ack_rise_edge_irq(irq);
   -               counter0_irq(irq, NULL, regs);
   -               local_enable_irq(irq);
   -       }
   -       else
   -#endif
   -       {
   -               do_IRQ(irq, regs);
   -       }
   +       do_IRQ(irq, regs);
    }
     =20
Well, running old code on my au1100 I have no problem but using new one I
got:

   Linux version 2.6.12 (giometti@vvonth) (gcc version 3.4.3) #29 Tue Jul 1=
2 19:41:24 CEST 2005
   CPU revision is: 02030204
   AMD Alchemy WWPC Board
   (PRId 02030204) @ 396MHZ
   BCLK switching enabled!
   Determined physical RAM map:
    memory: 04000000 @ 00000000 (usable)
   Built 1 zonelists
   Kernel command line: console=3DttyS0,115200 root=3D/dev/nfs rw nfsroot=
=3D192.168.32.254:/home/develop/embedded/mipsel/distro/_geek ip=3D192.168.3=
2.23:192.168.32.254::255.255.255.0:wwpc:eth0:off
   Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 by=
tes.
   Primary data cache 16kB, 4-way, linesize 32 bytes.
   Synthesized TLB refill handler (20 instructions).
   Synthesized TLB load handler fastpath (32 instructions).
   Synthesized TLB store handler fastpath (32 instructions).
   Synthesized TLB modify handler fastpath (31 instructions).
   PID hash table entries: 512 (order: 9, 8192 bytes)
   calculating r4koff... 00060ae0(396000)
   CPU frequency 396.00 MHz
   Console: colour dummy device 80x25
   Break instruction in kernel code in arch/mips/kernel/traps.c::do_bp, lin=
e 629[#1]:
   Cpu 0
   $ 0   : 00000000 10007c00 00000000 000f41fa
   $ 4   : 80462000 000f41fa 00000000 00000000
   $ 8   : 26aa8a40 000f41fa 80462000 00000000
   $12   : 0000006e fffffffa ffffffff 0000000a
   $16   : 00000af8 804d0000 80461ef0 804d0000
   $20   : 80461e18 80462000 00000002 00000000
   $24   : 00000001 80461dea                 =20
   $28   : 80460000 80461e08 83fc92b8 8010277c
   Hi    : 000f41fa
   Lo    : 26aa8a40
   epc   : 80148b28 run_posix_cpu_timers+0x804/0x86c     Not tainted
   ra    : 8010277c counter0_irq+0x98/0x168
   Status: 10007c03    KERNEL EXL IE=20
   Cause : 00808024
   PrId  : 02030204
   Modules linked in:
   Process swapper (pid: 0, threadinfo=3D80460000, task=3D80462000)
   Stack : 000003f4 000003f4 38313932 804c8934 80461e18 80461e18 00000000 0=
0000000
           80462000 00000000 00000af8 804d0000 80461ef0 804d0000 00000b1b 0=
0000011
           00000002 00000000 83fc92b8 8010277c 804de270 00000013 804de270 8=
0461ec8
           804cf9d4 00000000 00000000 00000001 80461ef0 80150964 804e0000 8=
0435d90
           00000002 10007c00 804a4220 00000011 804cf9d4 804e0000 80461ef0 8=
3f43c00
           ...
   Call Trace:
    [<8010277c>] counter0_irq+0x98/0x168
    [<80150964>] handle_IRQ_event+0x7c/0x134
    [<80150b24>] __do_IRQ+0x108/0x194
    [<804be264>] uart_set_options+0xe0/0x178
    [<8010600c>] do_IRQ+0x1c/0x34
    [<80101390>] au1000_IRQ+0x150/0x1a0
    [<801292d8>] __call_console_drivers+0x80/0xac
    [<80416fc4>] _etext+0x0/0x8f03c
    [<804a6700>] start_kernel+0x11c/0x254
    [<804a6710>] start_kernel+0x12c/0x254
    [<804a6134>] unknown_bootoption+0x0/0x310


   Code: aea30140  08052103  aea4013c <0200000d> 080520de  8ea4013c  240400=
1e  24050001  0c04e2c9=20
   Kernel panic - not syncing: Aiee, killing interrupt handler!

I suppose the problem is when function startup_match20_interrupt()
tries to install the irq handler for the counter0.

Why did you modify such function?

Where could be the problem in the new code?

Should we come back to the old code? ;-p

Thanks,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC1AeFQaTCYNJaVjMRAsLlAJ48XrghsRDlwUJaPEt/ogPlWf2YxwCg0okm
XZKTUCFS+CD/9gzycFFnE5c=
=jyfE
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
