Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Mar 2006 08:01:59 +0000 (GMT)
Received: from lug-owl.de ([195.71.106.12]:17352 "EHLO lug-owl.de")
	by ftp.linux-mips.org with ESMTP id S8133469AbWCEIBt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 5 Mar 2006 08:01:49 +0000
Received: by lug-owl.de (Postfix, from userid 1001)
	id 7E082F0040; Sun,  5 Mar 2006 09:09:58 +0100 (CET)
Date:	Sun, 5 Mar 2006 09:09:58 +0100
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: does the linux support rootfs on vfat?
Message-ID: <20060305080958.GX19232@lug-owl.de>
Mail-Followup-To: zhuzhenhua <zzh.hust@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
References: <50c9a2250603042217l475e84pc9ab7ce87c40eb76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o7OlDVNVrpEggBeY"
Content-Disposition: inline
In-Reply-To: <50c9a2250603042217l475e84pc9ab7ce87c40eb76@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--o7OlDVNVrpEggBeY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-03-05 14:17:56 +0800, zhuzhenhua <zzh.hust@gmail.com> wrote:
> if in my product based ide disk, i want to it to support the
> u-disk(with vfat fs), and can i set the root fs as vfat too?
> if use vfat as rootfs, what's disadvantage of the selection?

Well, most notably you won't have device nodes. Maybe a ram-backed
filesystem mounted to /dev/ could solve that, but you'd probably need
an initrd for that to do.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--o7OlDVNVrpEggBeY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFECpzWHb1edYOZ4bsRApTNAJ9nnHoDz7FlJRw/K4FZyI/yGATfsACcCWm4
Ld71XhQiljmHv++Nwzn/MPI=
=YP6z
-----END PGP SIGNATURE-----

--o7OlDVNVrpEggBeY--
