Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Oct 2004 19:26:59 +0000 (GMT)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:3297 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8225200AbUJaT0y>;
	Sun, 31 Oct 2004 19:26:54 +0000
Received: by lug-owl.de (Postfix, from userid 1001)
	id D57F34AB6C; Sun, 31 Oct 2004 20:26:53 +0100 (CET)
Date: Sun, 31 Oct 2004 20:26:53 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dennis Grevenstein <dennis@pcde.inka.de>
Cc: linux-mips@linux-mips.org
Subject: Re: unable to handle kernel paging request
Message-ID: <20041031192653.GG2094@lug-owl.de>
Mail-Followup-To: Dennis Grevenstein <dennis@pcde.inka.de>,
	linux-mips@linux-mips.org
References: <20041031184233.GA11120@aton.pcde.inka.de> <Pine.GSO.4.10.10410311947570.9753-100000@helios.et.put.poznan.pl> <20041031191631.GB11681@aton.pcde.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline
In-Reply-To: <20041031191631.GB11681@aton.pcde.inka.de>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-31 20:16:31 +0100, Dennis Grevenstein <dennis@pcde.inka.de>
wrote in message <20041031191631.GB11681@aton.pcde.inka.de>:
> On Sun, Oct 31, 2004 at 07:48:15PM +0100, Stanislaw Skowronek wrote:
> > > <1>CPU 0 Unable to handle kernel paging request at\
> > >  virtual address 00000000, epc =3D=3D 8810da1c, ra =3D=3D 8810e22c
> >=20
> > Look into your System.map and tell us what is there.
> =20
> At 8810da1c or 8810e22c? Nothing directly.
> Closest thing is this:

System.map is a list of function start addresses. Typically, functions
don't crash at their very first instructions, this is why you don't see
"exact" matches.

> 8810d9b0 t ip22zilog_maybe_update_regs
> 8810d9fc t ip22zilog_receive_chars
This is epc (+0x20).

> 8810dd18 t ip22zilog_status_handle
> 8810def0 t ip22zilog_transmit_chars
> 8810e0e0 t ip22zilog_interrupt
=2E..and this is ra.

> 8810e26c t ip22zilog_tx_empty

>From my fading MIPS knowledge, ip22zilog_interrupt called
ip22zilog_receive_chars and the later one crashed. Now, use objdump and
create a disassembly dump of the object file that contains the IP22
Zilog stuff. There, find the part that's 0x20 bytes away from the start
of ip22zilog_receive_chars. Now you know the cause of this oops. From
here, try to figure out the reason for it...

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

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBhTx9Hb1edYOZ4bsRAkYSAJwLbPffuXF7PBQ1QBrB5HL7nEhWQACeOkyK
kaZT7PBUY/flH9uuSsF8ZSs=
=/RBU
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--
