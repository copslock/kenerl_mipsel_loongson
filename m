Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 22:09:54 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:43274
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225800AbUERVJx>; Tue, 18 May 2004 22:09:53 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id 9E8E638212C; Tue, 18 May 2004 22:09:52 +0100 (BST)
Date: Tue, 18 May 2004 22:09:52 +0100
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040518210952.GA29618@getyour.pawsoff.org>
References: <20040513183059.GA25743@getyour.pawsoff.org> <20040518073439.GA6818@skeleton-jack> <20040518205914.GA29574@getyour.pawsoff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20040518205914.GA29574@getyour.pawsoff.org>
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2004 at 09:59:14PM +0100, Kieran Fulke wrote:

>=20
> <snip-snip>
>=20
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with=20
> idebus=3Dxx
> VP_IDE: IDE controller at PCI slot 0000:00:09.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci0000:00:09.1
>     ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:pio, hdd:pio
> spurious 8259A interrupt: IRQ9.
>=20

i should also mention that the boot process stops at this point.


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqnugOWPbH1PXZ18RAs0nAJ9QSID6I7pWIW9alG2X+y8BV5ZQoQCeKvVt
y0kM5ubcju1YZBRwRrgMibg=
=mKvX
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
