Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB3Ec8P20881
	for linux-mips-outgoing; Mon, 3 Dec 2001 06:38:08 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB3Ec2o20877
	for <linux-mips@oss.sgi.com>; Mon, 3 Dec 2001 06:38:03 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5E48E882; Mon,  3 Dec 2001 14:37:54 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C17C944E6; Mon,  3 Dec 2001 14:37:34 +0100 (CET)
Date: Mon, 3 Dec 2001 14:37:34 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Ian Chilton <ian@ichilton.co.uk>
Cc: linux-mips@oss.sgi.com
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation 5000/150)
Message-ID: <20011203143734.A5965@paradigm.rfc822.org>
References: <20011203000338.A30090@paradigm.rfc822.org> <20011203000036.A10356@buzz.ichilton.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20011203000036.A10356@buzz.ichilton.local>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2001 at 12:00:36AM +0000, Ian Chilton wrote:
> Hello,
>=20
> > the current cvs (as of a couple hours ago) works without additional
> > patches on my Decstation 5000/150 like a charm:
>=20
> It also worked for me earlier on an Indy R4600 - 1st kernel I have had
> properly boot since 2.4-test9 IIRC.

It basically comes up for me but is endlessly slow because i am getting
a mad interrupt - Putting an printk("I%d", irq) into do_IRQ shows=20
IRQ 8 going mad ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8C4AdUaz2rXW+gJcRAgjGAJ9igf+jO/47RLAiikURAcRNagWkoQCffqB1
LFFqaK4DNPdj5dzhNNoqwxE=
=xgYV
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
