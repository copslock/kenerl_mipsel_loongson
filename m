Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jan 2003 09:46:15 +0000 (GMT)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:13069 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225216AbTAPJqO>; Thu, 16 Jan 2003 09:46:14 +0000
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 42BAD4A8D5; Thu, 16 Jan 2003 10:46:12 +0100 (CET)
Date: Thu, 16 Jan 2003 10:46:12 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: MOPD problems
Message-ID: <20030116094612.GJ27441@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <1042674081.2735.102.camel@Opus> <Pine.LNX.4.44.0301160103580.10229-100000@skynet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="03sphU6jKm9HdgU1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301160103580.10229-100000@skynet>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--03sphU6jKm9HdgU1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-01-16 01:04:58 +0000, Dave Airlie <airlied@csn.ul.ie>
wrote in message <Pine.LNX.4.44.0301160103580.10229-100000@skynet>:
>=20
> sometimes a long time agao.. you needed to manually add the ethernet
> address of the decstation to the arp table on the host machine..
>=20
> arp -s <decstation_hostname> <ethernet_address>

MOP isn't an IP based protocol so it doesn't care about IP addresses. I
think you want to solve some problem while TFTP'ing something:-)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--03sphU6jKm9HdgU1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Jn9jHb1edYOZ4bsRAqpvAJ40vNRwzZYla/WobPBhmRNChVCIwACgiFJM
zxt6huAPZc6VsRqq/hmp2xs=
=TWdM
-----END PGP SIGNATURE-----

--03sphU6jKm9HdgU1--
