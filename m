Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4BIp9wJ027249
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 11 May 2002 11:51:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4BIp9P4027248
	for linux-mips-outgoing; Sat, 11 May 2002 11:51:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4BIp2wJ027245
	for <linux-mips@oss.sgi.com>; Sat, 11 May 2002 11:51:03 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id BF60E857; Sat, 11 May 2002 20:52:41 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 2184E3711E; Sat, 11 May 2002 20:38:08 +0200 (CEST)
Date: Sat, 11 May 2002 20:38:08 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: howto pass ramdisk loaddress to kernel
Message-ID: <20020511183808.GA7240@paradigm.rfc822.org>
References: <20020507123249.A9827@gandalf.physik.uni-konstanz.de> <20020507104538.GB795@paradigm.rfc822.org> <20020510203737.A5410@gandalf.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20020510203737.A5410@gandalf.physik.uni-konstanz.de>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2002 at 08:37:37PM +0200, Guido Guenther wrote:
> > I would do 1+3 - Give the address on the command line and let the ramdi=
sk
> > have a magic + length in the first 2 __u32.
> I implemented (1) only since the kernel checks for a proper fs/gzip
> magic anyway. I added this to the kernels at:

Ok ...

>  http://honk.physik.uni-konstanz.de/linux-mips/kernels/
> Patch is at:
>  http://honk.physik.uni-konstanz.de/linux-mips/kernel-patches/ramdisk-cmd=
line-2002-05-09.diff

I looked at the patch and it seems it does support all sub-archs - Is that
correct ?

BTW: When we boot with tip we might also compress the kernel as gzip.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE83WUPUaz2rXW+gJcRArAsAKCk5Kx40HzI3MA5S6nzrP36AUcW6wCffTY+
HBVCqaJi5RnkmpWkzkxHqbE=
=TRin
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
