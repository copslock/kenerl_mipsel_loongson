Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 21:59:18 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:40458
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225800AbUERU7R>; Tue, 18 May 2004 21:59:17 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id 57B6038212C; Tue, 18 May 2004 21:59:14 +0100 (BST)
Date: Tue, 18 May 2004 21:59:14 +0100
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040518205914.GA29574@getyour.pawsoff.org>
References: <20040513183059.GA25743@getyour.pawsoff.org> <20040518073439.GA6818@skeleton-jack>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20040518073439.GA6818@skeleton-jack>
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2004 at 08:34:39AM +0100, Peter Horton wrote:

>=20
> Not quite so esoteric :-)
>=20
> Try changing COBALT_QUBE_SLOT_IRQ from 23 to 9 in
> include/asm/cobalt/cobalt.h.
>=20

alas, no joy.

<snip-snip>

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with=20
idebus=3Dxx
VP_IDE: IDE controller at PCI slot 0000:00:09.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci0000:00:09.1
    ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:pio, hdd:pio
spurious 8259A interrupt: IRQ9.

cheers,
Kieran.

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqnkiOWPbH1PXZ18RAoOiAKCKMQaoYtsw65TbrOWg5x4j6c0+rgCfW0SQ
828gi0rXy2rXtnz1QLQMqg4=
=m4za
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
