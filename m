Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4CDZmwJ008429
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 12 May 2002 06:35:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4CDZm5x008428
	for linux-mips-outgoing; Sun, 12 May 2002 06:35:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4CDZgwJ008425
	for <linux-mips@oss.sgi.com>; Sun, 12 May 2002 06:35:42 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8A30F857; Sun, 12 May 2002 15:37:25 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 841B93711E; Sun, 12 May 2002 15:36:56 +0200 (CEST)
Date: Sun, 12 May 2002 15:36:56 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Krishna Kondaka <krishna@Sanera.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: Is this a /proc or kernel bug? (more info...)
Message-ID: <20020512133656.GB1091@paradigm.rfc822.org>
References: <200205090328.g493SWH02942@icarus.sanera.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <200205090328.g493SWH02942@icarus.sanera.net>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2002 at 08:28:32PM -0700, Krishna Kondaka wrote:
> The above function works fine as long as the SIZE is lessthan 4K. If SIZE=
 is
> greater than 4K then some times I see the following kernel panic when
> I try to do "cat /proc/<myfilename>"
>=20
> Unhandled kernel unaligned access in unaligned.c:emulate_load_store_insn,=
 line=20
> 373:
> $0 : 00000000 10009f00 8f20802c 48494a4b
> $4 : 8f320988 00000001 00000000 00000116

IIRC i386 has the same problem with reading more then a single page from=20
/proc.

Retrieving more information should probably be a device driver with
a char or block interface.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE83m/4Uaz2rXW+gJcRAg1mAJ4phppOf7xRHdsfFJlWoPgduE0KKACfYywX
pbJ3Dp4qfg/Nu6RwkGgN2BA=
=0ZLb
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
