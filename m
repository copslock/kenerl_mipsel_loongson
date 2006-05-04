Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 07:57:33 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:47553 "HELO tool.snarl.nl")
	by ftp.linux-mips.org with SMTP id S8133487AbWEDG5F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 May 2006 07:57:05 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 7C3F15E59A;
	Thu,  4 May 2006 08:56:58 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 32305-04; Thu, 4 May 2006 08:56:58 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id F27FB5DF61; Thu,  4 May 2006 08:56:57 +0200 (CEST)
Date:	Thu, 4 May 2006 08:56:57 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	safiudeen Ts <safiudeen@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux-2.6.16 on DB1100
Message-ID: <20060504065657.GI11097@dusktilldawn.nl>
References: <BAY18-F22BF9163A6C30B8B903B8EADB40@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wFsmFZmaatp/x6ak"
Content-Disposition: inline
In-Reply-To: <BAY18-F22BF9163A6C30B8B903B8EADB40@phx.gbl>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--wFsmFZmaatp/x6ak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Safiudeen,

On Thu, May 04, 2006 at 06:31:08AM +0000, safiudeen Ts wrote:
> About to load tftp://192.168.0.3//tftpboot/vmlinux.srec
> Press Ctrl-C to break
> .........................................................................=
=2E.....
> .........................................................................=
=2E........
> .........................................................................=
=2E......
>=20
> Start =3D 0x8034f000, range =3D ( 0x80100000,0x8036e084 )
There is some vital information missing from your email. Can you
also send the yamon command's you use to start the system. Like for
instance the output below is far more complete than yours. I have put some
extra comment in between '->' and '<-' to give you an idea what is happenin=
g.

-> Here yamon starts and shows some general information <-

		YAMON ROM Monitor, Revision 02.27GDB1100.
		Copyright (c) 1999-2004 MIPS Technologies, Inc. - All Rights Reserved.

		For a list of available commands, type 'help'.

		Switch S1.1 selects endian.

		Compilation time =3D            Jan  1 2000  00:00:35
		MAC address =3D                 00.00.00.00.00.00
		Processor Company ID =3D        0x03
		Processor ID/revision =3D       0x02 / 0x04
		Endianness =3D                  Little
		CPU =3D                         396 MHz
		Flash memory size =3D           64 MByte
		SDRAM size =3D                  192 MByte
		First free SDRAM address =3D    0x800a66ec

-> Here you can see me loading the kernel image by means of tftp from my tf=
tp-server. <-

		YAMON> load tftp://192.168.10.136/vmlinux-2.6.16-20060418.000.srec
		About to load tftp://192.168.10.136/vmlinux-2.6.16-20060418.000.srec
		Press Ctrl-C to break
		........................................
		........................................
		........................................
		........................................
		........................................
		........................................
		........................................
		........................................
		........................................
		........................................
		........................................
		..................
		Start =3D 0x80473000, range =3D (0x80100000,0x80498085), format =3D SREC

-> Here you can see me starting the kernel image, which uses a
   root filesystem from my nfs-server <-

		YAMON> go . ip=3D192.168.10.236 nfsroot=3D192.168.10.136:\
		? /opt/cellar0/AMD.Alchemy/test.20060202/root/ rw

-> Here you can see my kernel starting <-

		Linux version 2.6.16 (frsp@id6236) (gcc version 3.4.6 20060122 (prereleas=
e) (Debian 3.4.5-2)) #20 PREEMPT Tue Apr 18 10:59:57 CEST 2006
		CPU revision is: 02030204
		AMD Alchemy Au1100/Db1100 Board
		(PRId 02030204) @ 396MHZ
		BCLK switching enabled!
		Determined physical RAM map:
		 memory: 0c000000 @ 00000000 (usable)
		Built 1 zonelists
		Kernel command line: ip=3D192.168.10.236 nfsroot=3D192.168.10.136:/opt/ce=
llar0/AMD.Alchemy/test.20060202/root/ rw console=3DttyS0,115200

-> I have cut out the rest for brevity <-

So there can be two things:

	a) You forgot to start the loaded kernel. (this I can't tell
	from your output, so please make it more verbose)

	b) Can it be that you have disabled CONFIG_PRINTK in the kernel
	configuration???

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--wFsmFZmaatp/x6ak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEWaW5bxf9XXlB0eERArDpAJ9sUya6dZUmZWH5abHD5/cBjfyWpACfXxdV
luil/nEZFXO02WICmYTe9qs=
=8o2h
-----END PGP SIGNATURE-----

--wFsmFZmaatp/x6ak--
