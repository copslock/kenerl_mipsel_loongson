Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g47AinwJ015024
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 03:44:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g47AimZa015023
	for linux-mips-outgoing; Tue, 7 May 2002 03:44:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g47AigwJ015019
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 03:44:43 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6A51D8A1; Tue,  7 May 2002 12:46:03 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id BDB823711E; Tue,  7 May 2002 12:45:38 +0200 (CEST)
Date: Tue, 7 May 2002 12:45:38 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linux-mips@oss.sgi.com, ralf@gnu.org
Subject: Re: howto pass ramdisk loaddress to kernel
Message-ID: <20020507104538.GB795@paradigm.rfc822.org>
References: <20020507123249.A9827@gandalf.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <20020507123249.A9827@gandalf.physik.uni-konstanz.de>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2002 at 12:32:49PM +0200, Guido Guenther wrote:
> My question is now: how do i properly pass the initrd's memory address
> to the kernel? Choices are:
> 1) on the commandline: rd_start=3D0x...
> 2) a bootparameter block like on i386 or sparc in head.S
> 3) rely on the kernel to identify if a radisk has
>   been loaded by a magic number
>=20
> I'd prefer (1) but it seems none of the other arches does this. Is there
> a reason for that? If not could we just introduce a new kernel
> commandline parameter rd_start which has a memory address as a
> parameter. Ralf, would you let this into the kernel?

I would do 1+3 - Give the address on the command line and let the ramdisk
have a magic + length in the first 2 __u32.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE817BSUaz2rXW+gJcRAmCeAKCIIsxjjGn/9EI7VvPv+tmKGnvfUQCgrUXy
IAUCLJ+9Xf6UMd05umVk9eQ=
=kPC1
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
