Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Oct 2004 20:13:43 +0000 (GMT)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:44769 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8225207AbUJaUNh>;
	Sun, 31 Oct 2004 20:13:37 +0000
Received: by lug-owl.de (Postfix, from userid 1001)
	id D30454ABE2; Sun, 31 Oct 2004 21:13:35 +0100 (CET)
Date: Sun, 31 Oct 2004 21:13:35 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dennis Grevenstein <dennis@pcde.inka.de>
Cc: linux-mips@linux-mips.org
Subject: Re: unable to handle kernel paging request
Message-ID: <20041031201335.GH2094@lug-owl.de>
Mail-Followup-To: Dennis Grevenstein <dennis@pcde.inka.de>,
	linux-mips@linux-mips.org
References: <20041031184233.GA11120@aton.pcde.inka.de> <Pine.GSO.4.10.10410311947570.9753-100000@helios.et.put.poznan.pl> <20041031191631.GB11681@aton.pcde.inka.de> <20041031192653.GG2094@lug-owl.de> <20041031195550.GA12397@aton.pcde.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline
In-Reply-To: <20041031195550.GA12397@aton.pcde.inka.de>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-31 20:55:50 +0100, Dennis Grevenstein <dennis@pcde.inka.de>
wrote in message <20041031195550.GA12397@aton.pcde.inka.de>:
> On Sun, Oct 31, 2004 at 08:26:53PM +0100, Jan-Benedict Glaw wrote:
> > From my fading MIPS knowledge, ip22zilog_interrupt called
> > ip22zilog_receive_chars and the later one crashed. Now, use objdump and
> > create a disassembly dump of the object file that contains the IP22
> > Zilog stuff. There, find the part that's 0x20 bytes away from the start
> > of ip22zilog_receive_chars. Now you know the cause of this oops.
>=20
> That's what I found:


> 8810da14:       8c82001c        lw      v0,28(a0)
> 8810da18:       00809021        move    s2,a0
> 8810da1c:       8c510000        lw      s1,0(v0)

It's accessing (most probably) a structure's first field, where the
structure is supplied by pointer in v0.

> 8810da20:       00a09821        move    s3,a1  =20
> 8810da24:       8e220118        lw      v0,280(s1)=20

So now, find out what v0 belongs to. Maybe compiling the kernel with
debug infos (-g) and using objdump -S (for intermixing sources) will
help you.

Most probably, something wasn't correctly registered, so the pointer to
a struct is just a NULL pointer.

> and:
>=20
> 8810e224:       0e04367f        jal     8810d9fc <ip22zilog_receive_chars>
> 8810e228:       02803021        move    a2,s4
> 8810e22c:       0a04386e        j       8810e1b8 <ip22zilog_interrupt+0xd=
8>
> 8810e230:       32020001        andi    v0,s0,0x1  =20
> 8810e234:       0e0437bc        jal     8810def0 <ip22zilog_transmit_char=
s>

So this all fits properly :-)

> > From
> > here, try to figure out the reason for it...
> =20
> Well, I'm sure "MIPS assembly for Dummies" must be available
> somewhere. While I keep looking please help me ;-)

"objdump -S" for starters, but it seems quite straight forward. Maybe
paste the code of ip22zilog_receive_chars, I don't  have that at hands
right now...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBhUdvHb1edYOZ4bsRAnVMAJ9QlxgtosnKRW7Qos2EOSm9SX0PAQCfVVRM
Cvz5a5N/Nn2FuXO4Zb8t3Rg=
=sX1C
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--
