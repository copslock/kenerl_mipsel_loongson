Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g49Fh3wJ031265
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 9 May 2002 08:43:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g49Fh3Vm031264
	for linux-mips-outgoing; Thu, 9 May 2002 08:43:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g49FguwJ031260
	for <linux-mips@oss.sgi.com>; Thu, 9 May 2002 08:42:57 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 70BE3844; Thu,  9 May 2002 17:44:26 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C22A63711E; Thu,  9 May 2002 17:43:27 +0200 (CEST)
Date: Thu, 9 May 2002 17:43:27 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Robert Rusek <rrusek@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Indy SCSI Errors
Message-ID: <20020509154327.GB6197@paradigm.rfc822.org>
References: <C0F41630CD8B9C4680F2412914C1CF070164BD@WH-EXCHANGE1.AD.WEIDERPUB.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <C0F41630CD8B9C4680F2412914C1CF070164BD@WH-EXCHANGE1.AD.WEIDERPUB.COM>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2002 at 10:23:18AM -0700, Robert Rusek wrote:
> I am currently running kernel 2.4.17 and am getting sparatice errors
> like the following.  I seen that there had been bugs in the scsi driver
> in the earlier kernel versions.  Has anyone encountered this?  Is there
> a newer kernal that maybe addresses this?
>=20
> EXT2-fs error (device sd(8,1)): ext2_check_page: bad entry in directory
> #110030: unaligned
>  directory entry - offset=3D0, inode=3D6226015, rec_len=3D95, name_len=3D=
95
>=20

The SCSI errors we had on the Indy and Indigo2 happened with multiple
disks, disconnects and were pure "read" errors. Filesystem corruption
was quite rare. Mostly we had file data corruption on copy. The bug is
fixed for at least half a year now.

Do you see any other errors than that ? SCSI errors ?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE82pkfUaz2rXW+gJcRAkBeAKDfEfjJEyPkcL00u3pGQmXEg1rObACgsi0V
wdrft6JS5fdm34HTefGHBIE=
=Zkw1
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
