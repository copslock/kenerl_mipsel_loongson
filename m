Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4I8J9nC031236
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 18 May 2002 01:19:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4I8J9Nr031235
	for linux-mips-outgoing; Sat, 18 May 2002 01:19:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4I8J2nC031227
	for <linux-mips@oss.sgi.com>; Sat, 18 May 2002 01:19:03 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C717883C; Sat, 18 May 2002 10:19:39 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id DAD9637115; Sat, 18 May 2002 10:18:55 +0200 (CEST)
Date: Sat, 18 May 2002 10:18:55 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Eric LEBOEUF <eric.leboeuf@free.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: Kernel snapshot ?
Message-ID: <20020518081855.GA11227@paradigm.rfc822.org>
References: <3CE5649A.5080206@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <3CE5649A.5080206@free.fr>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2002 at 10:14:18PM +0200, Eric LEBOEUF wrote:
> Hello everybody,
>=20
> I'm trying to get my indy to boot linux, but I've got some problem.
> When I do compile my own kernel, it crash with this message:

I guess you compiled HEAD from the oss.sgi.com cvs ? This is something
in the 2.5 area and not "ready to run(tm)" as at least the scsi driver
is broken and is known to oops on boot.

[ ... oops ... ]

> I did get a 2.4.1 kernel, which works, but do not have good support for=
=20
> scsi disks. How can I do to compile my how kernel ?

You need to get the linux_2_4 branch from the cvs - That one should
work.

Flo
PS: When sending in oopses please make shure you parse them through
    ksymoops with the correct System.map.
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE85g5vUaz2rXW+gJcRAkC8AJ0dlYI+qqyUis2nx2pp2a8mnMRTTQCgzg6k
5v/RZgmT0hJXZJpknfIxiaE=
=ZLS7
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
