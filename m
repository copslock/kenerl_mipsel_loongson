Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2JCAF927109
	for linux-mips-outgoing; Tue, 19 Mar 2002 04:10:15 -0800
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2JCA7927106
	for <linux-mips@oss.sgi.com>; Tue, 19 Mar 2002 04:10:08 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2415B849; Tue, 19 Mar 2002 13:11:34 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5A72D37047; Tue, 19 Mar 2002 13:11:14 +0100 (CET)
Date: Tue, 19 Mar 2002 13:11:14 +0100
From: Florian Lohoff <flo@rfc822.org>
To: David Christensen <dpchrist@holgerdanske.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: hello
Message-ID: <20020319121114.GB18733@paradigm.rfc822.org>
References: <00f601c1ced8$63586600$0b01a8c0@w2k30g>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <00f601c1ced8$63586600$0b01a8c0@w2k30g>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2002 at 03:55:00PM -0800, David Christensen wrote:
> linux-mips@oss.sgi.com:
>=20
> Hello!  I have the opportunity to work on MIPS Linux using a MIPS Atlas
> (4Kc) board.
>=20
> 1.  Is there a reason why SourceForge isn't being used for the MIPS
>     Linux project?

The Linux-mips project is much older than sourceforge and looking at the
history of hyped venture capital companys does not really give a good
feeling about using sourceforge. Personally spoken i dont like
sourceforge - For most cases its just too bloated and working for ISPs
its not a problem to get some public accesible ftp/web/cvs space.

> 4.  Is MIPS Linux self-hosted?

Definitly

> 5.  Can you do native development on MIPS Linux?

Yep - The Debian autobuilder run native on little and big endian.

> 6.  Does MIPS Linux support sound (oss or alsa) on any platform?  Does
>     it support sound on MIPS Atlas?

Some rumors about Indy/Indigo2 HAL support have been heard.

The problem with some sourceforge trees and thesplit up information is=20
that like you already experienced is a real problem for Linux-mips
as there is no "source of the only wisdom". I dont like that
tree-forking etc. Either build your stuff clean - ready for inclusion -=20
or just drop the tree under the table as a big bad ugly hack.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8lyriUaz2rXW+gJcRAk6JAJ9VOE/CYT4FKczzBjhH6JYLH8wqkQCg3u2G
swXJvWI65kvpzL949cYdShw=
=L10y
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
