Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 22:19:35 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:46346
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225800AbUERVTe>; Tue, 18 May 2004 22:19:34 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id DC84B38212C; Tue, 18 May 2004 22:19:32 +0100 (BST)
Date: Tue, 18 May 2004 22:19:32 +0100
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040518211932.GB29636@getyour.pawsoff.org>
References: <20040513183059.GA25743@getyour.pawsoff.org> <20040518073439.GA6818@skeleton-jack> <20040518205914.GA29574@getyour.pawsoff.org> <20040518211246.GA11722@skeleton-jack> <20040518211810.GA29636@getyour.pawsoff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <20040518211810.GA29636@getyour.pawsoff.org>
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--yudcn1FV7Hsu/q59
Content-Type: multipart/mixed; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2004 at 10:12:46PM +0100, Peter Horton wrote:

>=20
> That's strange, it worked here.
>=20
> Did you a clean build ?
>=20

yeah. cleared out /usr/src and re-emerged mips-sources-2.6.6, then made=20
the change to include/asm/cobalt/cobalt.h you suggested. kernel=20
=2Econfig attached ..

Kieran.





--Sr1nOIr3CvdE5hEN
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Sr1nOIr3CvdE5hEN--

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqn3kOWPbH1PXZ18RAim1AKCMSC7BPX4lQT6GdfYSN8NTzSKA+ACeOwlN
ZpwA8XOjbgUikWBeBP5RWAI=
=OjdU
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
