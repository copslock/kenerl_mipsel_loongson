Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0B0nFm03081
	for linux-mips-outgoing; Thu, 10 Jan 2002 16:49:15 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0B0n9g03046
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 16:49:09 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4E7AE842; Fri, 11 Jan 2002 00:48:56 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 4474E3F3F; Fri, 11 Jan 2002 00:49:03 +0100 (CET)
Date: Fri, 11 Jan 2002 00:49:03 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: LTP tests / Crash :)
Message-ID: <20020110234903.GA10021@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i am just trying to run the LTP (Linux Test Project -> ltp.sf.net)=20
on a 2.4.16 SGI/Indy and it seems to crash reproducable :)

<<<test_start>>>
tag=3Dgetpeername01 stime=3D1010706641
cmdline=3D"getpeername01"
contacts=3D""
analysis=3Dexit
initiation_status=3D"ok"
<<<test_output>>>

On 2 different machines - Running both 2.4.16 Debian/Sid and
Debian/Woody - I will try to gather the oops - But it seems we should
take the LTP for regular regression tests :)

Crashes are:

Kernel unaligned instruction access in unaligned.c:do_ade, line 397

and

Unhandled kernel unaligned access in unaligned.c:emulate_load_store_isns, l=
ine 342

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8PihvUaz2rXW+gJcRAtn5AJ9l7VzQ9wi3rHXgbRLnp6TGxkkW3gCeIgTF
Cqf0yQfwWbm4CWjWo1TKpJs=
=wSCI
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
