Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 00:23:40 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:12997 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133817AbWD0XXb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Apr 2006 00:23:31 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FZFmc-0002gc-Rg
	for linux-mips@linux-mips.org; Fri, 28 Apr 2006 01:20:27 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FZFqC-00083x-0v
	for linux-mips@linux-mips.org; Fri, 28 Apr 2006 01:24:08 +0200
Date:	Fri, 28 Apr 2006 01:24:08 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060427232407.GB9883@enneenne.com>
References: <20060427154948.GI32278@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20060427154948.GI32278@enneenne.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: trouble on serial console for au1100
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2006 at 05:49:48PM +0200, Rodolfo Giometti wrote:
>=20
> I noticed that the serial lines management code is changed from
> linux-2.6.12 and I'd like to know if someone is running the serial
> console on ttyS0 on au1100...

Modifying the printk() code and sending the output directly to the
serial line (without using the driver since u-boot already init the
serial port for me) I get:

   <4>Synthesized TLB store handler fastpath (34 instructions).            =
       =20
   <4>Synthesized TLB modify handler fastpath (33 instructions).           =
       =20
   <4>PID hash table entries: 512 (order: 9, 2048 bytes)                   =
       =20
   <4>calculating r4koff... 00060ae0(396000)                               =
       =20
   <4>CPU frequency 396.00 MHz                                             =
       =20
   <4>Break instruction in kernel code[#1]:                                =
       =20
   <4>Cpu 0                                                                =
       =20
   <4>$ 0   : 00000000 1000fc00 0fffff00 00010000                          =
       =20
   <4>$ 4   : 803bfd30 00000000 8036dbe0 803bfd70                          =
       =20
   <4>$ 8   : 8036dbe0 00000000 00000000 1000fc01                          =
       =20
   <4>$12   : 803c0000 fffffffe ffffffff 0000000a                          =
       =20
   <4>$16   : 803b1b78 803b1b80 83fc4000 83fb12e0                          =
       =20
   <4>$20   : a3eb4462 00000000 83fc4000 00000000                          =
       =20
   <4>$24   : 00000000 80363e1b                                            =
       =20
   <4>$28   : 80362000 80363f30 83fc4000 803a9a88                          =
       =20
   <4>Hi    : 00000000                                                     =
       =20
   <4>Lo    : 00030570                                                     =
       =20
   <4>epc   : 80129a0c acquire_console_sem+0xd4/0xf0     Not tainted       =
       =20
   <4>ra    : 803a9a88 con_init+0x24/0x2a0                                 =
       =20
   <4>Status: 1000fc03    KERNEL EXL IE                                    =
       =20
   <4>Cause : 00800024                                                     =
       =20
   <4>PrId  : 02030204                                                     =
       =20
   <4>Modules linked in:                                                   =
       =20
   <4>Process swapper (pid: 0, threadinfo=3D80362000, task=3D80364000)     =
           =20
   <4>Stack : 83fc4000 803a42d4 00000000 00000800 803a9a88 179a7b00 83fc400=
0 83fb12e0
   <4>        a3eb4462 00000000 83fc4000 00000000 803b1b78 803b1b80 83fc400=
0 83fb12e0
   <4>        a3eb4462 00000000 803a8f58 803b0000 83fc4000 0000018c 0000000=
0 431bde83
   <4>        83fb4000 803b0000 8039479c 8039475c 80338f5c 803b4004 8036624=
4 00000000
   <4>        80394134 00000000 803b4e2c 00000000 83fb4000 83fb4000 83fb1aa=
c 00000000
   <4>
   <4>Call Trace:                                                          =
       =20
   <4> [<803a42d4>] __alloc_bootmem_nopanic+0x68/0xb0                      =
       =20
   <4> [<803a9a88>] con_init+0x24/0x2a0                                    =
       =20
   <4> [<803a8f58>] console_init+0x48/0x68                                 =
       =20
   <4> [<8039479c>] start_kernel+0x194/0x3b4                               =
       =20
   <4> [<8039475c>] start_kernel+0x154/0x3b4                               =
       =20
   <4> [<80394134>] unknown_bootoption+0x0/0x304                           =
       =20
   <4>                                                                     =
       =20
   <4>                                                                     =
       =20
   <4>Code: 00000040  0804a664  00000000 <0200000d> 0804a657  3c03803b  0c0=
ca698  00000000  0804a667
   <0>Kernel panic - not syncing: Aiee, killing interrupt handler!         =
       =20

So the problem seems to be the "acquire_console_sem()" into
"con_init()" function (file =ABdrivers/char/vt.c=BB).

Suggestions? How is possible that the serial console code is buggy?
=3D:-o

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEUVKXQaTCYNJaVjMRAnKoAJ4zcnQ3EJ/UsrHT4e+r0D5CKlB82gCgoSgs
BcEO1iAFUZohL4qwPvzzsl8=
=Ilt8
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
