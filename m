Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 12:47:02 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:19461
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225472AbUEQLrB>; Mon, 17 May 2004 12:47:01 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id 8189038212C; Mon, 17 May 2004 12:46:58 +0100 (BST)
Date: Mon, 17 May 2004 12:46:58 +0100
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040517114658.GA20884@getyour.pawsoff.org>
References: <20040513183059.GA25743@getyour.pawsoff.org> <40A478B0.3070005@bitbox.co.uk> <20040516113622.GA14049@getyour.pawsoff.org> <20040516152113.GA9390@convergence.de> <20040516170445.GA4793@linux-mips.org> <40A87A81.5070100@bitbox.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <40A87A81.5070100@bitbox.co.uk>
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 17, 2004 at 09:40:33AM +0100, Peter Horton wrote:

>=20
> I've got no hardware here but the code looks roughly similiar
>=20
> As the Cobalt's use Galileo timer 0 for clock interrupts we could use=20
> Galileo rather than count/compare for the HPT.
>=20
> Precision would be 50MHz rather than 125MHz but that shouldn't be a=20
> problem :-)
>=20

is there any (uncomplicated) way of forcing the machine to assign a=20
different IRQ to its single pci slot?

Kieran.

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqKYyOWPbH1PXZ18RAi24AJ0ff6I1Pwin1ca4o9eIlju/6EgEdgCeLIIg
w53K2bxYmpmZWbuR7DIZAsE=
=GScd
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
