Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jan 2003 09:47:01 +0000 (GMT)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:13581 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225216AbTAPJrB>; Thu, 16 Jan 2003 09:47:01 +0000
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 764214A8D5; Thu, 16 Jan 2003 10:47:00 +0100 (CET)
Date: Thu, 16 Jan 2003 10:47:00 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: MOPD problems
Message-ID: <20030116094700.GK27441@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <1042674081.2735.102.camel@Opus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kJMkLA1uPhjFFA+D"
Content-Disposition: inline
In-Reply-To: <1042674081.2735.102.camel@Opus>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--kJMkLA1uPhjFFA+D
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-01-15 18:41:16 -0500, Justin Pauley <jpauley@xwizards.com>
wrote in message <1042674081.2735.102.camel@Opus>:
> I downloaded the mopd server and installed a bunch of the patches until
> mopd compiled. I downloaded the mopimage and put it in my /tftpboot/mop
> with the correct name. However, after running mop with "mopd -d eth0"
> and then running "boot 3/mop" on my decstation nothing happens. However,
> I have noticed that when I run a packet dumping software (etherreal) and
> then I try it I get this on my mopd:
>=20
> MOP DL 8:0:2b:2e:77:40   > ab:0:0:1:0:0      len   11 code 08 RPR
> MOP DL 0:d0:9:f8:fc:a5   > 8:0:2b:2e:77:40   len    1 code 03 ASV
> MOP DL 8:0:2b:2e:77:40   > 0:d0:9:f8:fc:a5   len   11 code 08 RPR
> MOP DL 0:d0:9:f8:fc:a5   > 8:0:2b:2e:77:40   len 1058 code 02 MLD
>=20
> This in my syslog:
> Jan 15 18:30:47 opus mopd[18215]: 8:0:2b:2e:77:40 (1) Do you have
> 08002b2e7740? (Yes)
> Jan 15 18:30:47 opus mopd[18215]: 8:0:2b:2e:77:40 Send me 08002b2e7740
>=20
> but then my Decstation produces something similar to the following:
>=20
> >> boot 3/mop
>=20
> ???
> ? PC: 0x.....
> ? CR: 0x....
> ? SR: 0x....
> ? VA: 0x0
> ? ER: 180....
> ? MER: 0x162....
>=20
> and then returns back to the console ">>".
> (note that the ... were added by me to replace a long line of
> numbers/letters)

It doesn't really tell me much, but please try the ELF linux kernel
image instead of the MOP image once.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--kJMkLA1uPhjFFA+D
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Jn+UHb1edYOZ4bsRAk1uAJ0UukOmCylrsGe6blP//eovA+sLtQCdH03V
TqN43aX/LuSjL3SuuhNzCg8=
=lTX4
-----END PGP SIGNATURE-----

--kJMkLA1uPhjFFA+D--
