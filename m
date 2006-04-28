Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 19:27:26 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:59856 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133421AbWD1S1R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Apr 2006 19:27:17 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FZXdS-0007MR-09; Fri, 28 Apr 2006 20:24:10 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FZXgR-0005C9-Hh; Fri, 28 Apr 2006 20:27:15 +0200
Date:	Fri, 28 Apr 2006 20:27:15 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Freddy Spierenburg <freddy@dusktilldawn.nl>
Cc:	linux-mips@linux-mips.org
Message-ID: <20060428182715.GE12157@enneenne.com>
References: <20060427154948.GI32278@enneenne.com> <20060428111933.GY11097@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline
In-Reply-To: <20060428111933.GY11097@dusktilldawn.nl>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: trouble on serial console for au1100
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2006 at 01:19:33PM +0200, Freddy Spierenburg wrote:
>=20
> Can it be that you face the same problem I was facing not so long
> ago? After I applied the patch in the email I attach to this one
> all my serial troubles on the au1100 disappeared.
>=20
> At the moment I'm running kernel 2.6.16 and am using a serial
> console and several other serial applications without any
> problem.

Yes, this patch fix the problem but it does it only on branch
=ABlinux-2.6.16-stable=BB, =ABmaster=BB branch is still buggy!

The problem on master branch is that the console is not initializated
at boot and also the =AB8250_early.c=BB must be modified in order to
support au1x00 serial register... I did it (the patch is at
http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-8250_early.c)
but after that I found more problems if VT support is enabled, and
even if I disable it the last error was:

   Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)            =
       =20
   Memory: 61080k/65536k available (2168k kernel code, 4400k reserved, 387k=
 data, 124k init, 0k highmem)                                              =
            =20
   kmem_cache_create: Early error in slab size-32                          =
       =20
   Break instruction in kernel code[#1]:                                   =
       =20
   Cpu 0                                                                   =
       =20
   $ 0   : 00000000 1000fc00 00000032 80356228                             =
       =20
   $ 4   : 80356228 80350000 80356240 00000000                             =
       =20
   ...
   epc   : 8017837c kmem_cache_create+0x74/0x600     Not tainted           =
       =20
   ra    : 8017837c kmem_cache_create+0x74/0x600                           =
       =20
   Status: 1000fc03    KERNEL EXL IE                                       =
       =20
   Cause : 00800024                                                        =
       =20
   PrId  : 02030204                                                        =
       =20
   Modules linked in:                                                      =
       =20
   Process swapper (pid: 0, threadinfo=3D80352000, task=3D80354000)        =
           =20
   Stack : 81062ca0 80321e44 8032bf60 00042000 0000044c 00003165 0000007c 0=
0000183        =20
           0021e21c 803b0000 00040000 8035849c 80358490 8035855c 8039bdb0 8=
0360000
   ...
   Call Trace:                                                             =
        =20
   [<803915fc>] kmem_cache_init+0x194/0x51c                                =
       =20
   [<80387078>] mem_init+0x1f4/0x218                                       =
       =20
   [<8038703c>] mem_init+0x1b8/0x218                                       =
       =20
   [<803807dc>] start_kernel+0x1d4/0x3b4                                   =
       =20
   [<80380134>] unknown_bootoption+0x0/0x304                               =
                          =20
   Code: 24a51e44  0c04a8e0  02e03021 <0200000d> 3c058036  0c0c6ebe  24a485=
50  3c03803b  8c70a35c
   Kernel panic - not syncing: Aiee, killing interrupt handler!            =
       =20

so, I'll continue my work on =ABlinux-2.6.16-stable=BB branch. :)

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEUl6DQaTCYNJaVjMRAhT2AJ9kKvq686CZdk4XKJA5Opq75MzG3wCcD0yc
WFhIL6OJOYmnkR91qnyqSvA=
=RVLz
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
