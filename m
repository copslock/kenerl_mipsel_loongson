Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g02LfL725502
	for linux-mips-outgoing; Wed, 2 Jan 2002 13:41:21 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g02LfFg25499
	for <linux-mips@oss.sgi.com>; Wed, 2 Jan 2002 13:41:15 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7EDBA85D; Wed,  2 Jan 2002 21:41:01 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id CDFD648B5; Wed,  2 Jan 2002 21:41:10 +0100 (CET)
Date: Wed, 2 Jan 2002 21:41:10 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Siders, Keith" <keith_siders@toshibatv.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: general linux question
Message-ID: <20020102204110.GA5075@paradigm.rfc822.org>
References: <7DF7BFDC95ECD411B4010090278A44CA1B74D9@ATVX>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA1B74D9@ATVX>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2002 at 11:36:27AM -0600, Siders, Keith wrote:
> This isn't mips-specific, so maybe belongs on another list, but I figured
> someone here could probably answer just as quickly. I need to track versi=
ons
> of all files in the system (embedded, flash-based, no disk media), but
> cannot find a structure member where a version number can be stored in a
> file header. Most linux command line apps generally have a -version comma=
nd
> line option, but is not viable for our application. Have I missed somethi=
ng?
> Is there a standard Linux method/practice for version number tracking and
> retrieval that is separate from CVS and the -version command switch, or d=
o I
> have to use something proprietary? Or should I just try to use the file
> creation timestamp?

Usually this is the reason for a distribution which stores some kind
of metadata in some flavour of package database:

(flo@paradigm)~# dpkg -l gcc binutils
Desired=3DUnknown/Install/Remove/Purge/Hold
| Status=3DNot/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=3D(none)/Hold/Reinst-required/X=3Dboth-problems (Status,Err: upperc=
ase=3Dbad)
||/ Name           Version        Description
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ii  gcc            2.95.4-9       The GNU C compiler.
ii  binutils       2.11.92.0.12.3 The GNU assembler, linker and binary util=
iti


Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8M3BmUaz2rXW+gJcRAg7bAKCUytylU681DBPo5jAG8zUb5WavTwCdGa06
Vv+9oAAbL20Gu20Q82TqmcQ=
=YmhJ
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
