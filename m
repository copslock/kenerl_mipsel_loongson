Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PArZ905340
	for linux-mips-outgoing; Mon, 25 Feb 2002 02:53:35 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PArS905296
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 02:53:29 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0ADAC836; Mon, 25 Feb 2002 10:53:03 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
	id 78C0D1A3AC; Mon, 25 Feb 2002 10:52:43 +0100 (CET)
Date: Mon, 25 Feb 2002 10:52:43 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: System lockup problem. . .
Message-ID: <20020225095243.GC16992@paradigm.rfc822.org>
References: <000701c1bdae$d226c580$6601a8c0@delllaptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <000701c1bdae$d226c580$6601a8c0@delllaptop>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 24, 2002 at 07:45:06PM -0800, Robert Rusek wrote:
> I am running Kernel 2.4.3 on an SGI Indy (IP22).  I built the RedHat 7.1
> system from the NFS root obtained from ftp.mips.com. Everything seems to
> be working until I added an additional drive.  Now when I do an heavy IO
> operation on the additional drive my system locks up.  It seems like
> there is not enough buffer allocated somewhere. I know that the drive is
> not an issue since when I boot the system up under IRIX 5.3 all works
> well..  Has anyone had a similar problem?  Where should I look?  Is is
> an Kernel issue or a setting in the OS?

Its a know bug in the scsi drivers. Its been fixed since 2.4.16. Its a
problem with scattered DMA etc.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8eglrUaz2rXW+gJcRArx6AJwJTWGMhGl6syiBkWqU72dgqh+5owCgxbz4
0VcaNtaOTp+1d/15yVIqB+g=
=kRw6
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
