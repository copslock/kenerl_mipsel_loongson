Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 18:52:36 +0100 (BST)
Received: from lug-owl.de ([195.71.106.12]:54684 "EHLO lug-owl.de")
	by ftp.linux-mips.org with ESMTP id S8133881AbWHCRw1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Aug 2006 18:52:27 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id ACD8FF0291; Thu,  3 Aug 2006 19:52:26 +0200 (CEST)
Date:	Thu, 3 Aug 2006 19:52:26 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Subject: Re: Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
Message-ID: <20060803175226.GA20586@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <S8133924AbWHCQmm/20060803164242Z+747@ftp.linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <S8133924AbWHCQmm/20060803164242Z+747@ftp.linux-mips.org>
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
X-archive-position: 12177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-08-03 17:42:34 +0100, linux-mips@linux-mips.org <linux-mips@li=
nux-mips.org> wrote:
> diff --git a/.gitignore b/.gitignore
> index 5535e8b..d272b10 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -30,12 +30,15 @@ include/config
>  include/linux/autoconf.h
>  include/linux/compile.h
>  include/linux/version.h
> +<<<<<<< HEAD/.gitignore
>  include/asm-*/asm-offsets.h
> +=3D=3D=3D=3D=3D=3D=3D
> +include/linux/utsrelease.h
> +>>>>>>> 3f2792ffbd88dc1cd41d226674cc428914981e98/.gitignore

[...]

I think you may want to fix this :)

MfG, JBG

--=20
       Jan-Benedict Glaw       jbglaw@lug-owl.de                +49-172-760=
8481
Signature of:           "really soon now":       an unspecified period of t=
ime, likly to
the second  :                                    be greater than any reason=
able definition
                                                 of "soon".

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE0jfaHb1edYOZ4bsRArRaAJ9Jj0orQug4akRyzHmVbQ09WZ/g2ACcD1j/
p5Dd8db1p+QldrwSz1VC/II=
=g6UH
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
