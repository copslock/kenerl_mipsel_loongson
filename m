Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2004 12:36:26 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:61712
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225241AbUEPLgZ>; Sun, 16 May 2004 12:36:25 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id D421438212C; Sun, 16 May 2004 12:36:22 +0100 (BST)
Date: Sun, 16 May 2004 12:36:22 +0100
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040516113622.GA14049@getyour.pawsoff.org>
References: <20040513183059.GA25743@getyour.pawsoff.org> <40A478B0.3070005@bitbox.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <40A478B0.3070005@bitbox.co.uk>
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2004 at 08:43:44AM +0100, Peter Horton wrote:

> Have you tried any other hardware in the slot, PCI network card perhaps ?
>=20
> P.

yeah. adding cards like a tulip network card, linksys wmp11 wireless card. =
even a=20
wintv pci (analogue) card all work ;

0000:00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 211=
42/43=20
(rev 41)
        Subsystem: Kingston Technologies: Unknown device 0001
        Flags: bus master, medium devsel, latency 64, IRQ 23
        I/O ports at 1080 [size=3D288M]
        Memory at 120c0400 (32-bit, non-prefetchable) [size=3D1K]
        Expansion ROM at 00040000 [disabled]

cat /proc/interrupts
           CPU0
  2:          0          XT-PIC  cascade
 14:      27636          XT-PIC  ide0
 18:     435142            MIPS  timer
 19:        696            MIPS  eth0
 20:          7            MIPS  eth2
 21:        302            MIPS  serial
 22:          0            MIPS  cascade
 23:     100002            MIPS  eth1


it just seems to be the DVB card that the pci code doesnt like, for some re=
ason ..

all ideas warmly received ;)

Kieran.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAp1I2OWPbH1PXZ18RAk8PAJ0UExFzPf6YSRYvktmYwgsGyzEHcACdHAZ8
U4BKT14OoxQeoKyOz0kgIpc=
=g40R
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
