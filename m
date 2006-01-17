Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 19:35:17 +0000 (GMT)
Received: from lug-owl.de ([195.71.106.12]:39808 "EHLO lug-owl.de")
	by ftp.linux-mips.org with ESMTP id S8133470AbWAQTe5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 19:34:57 +0000
Received: by lug-owl.de (Postfix, from userid 1001)
	id 66DC0F0037; Tue, 17 Jan 2006 20:38:36 +0100 (CET)
Date:	Tue, 17 Jan 2006 20:38:36 +0100
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Subject: Re: undefined reference to `__lshrdi3' error with GCC 4.0
Message-ID: <20060117193836.GJ18336@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20060117134838.GJ27047@deprecation.cyrius.com> <200601171617.16147.p_christ@hol.gr> <20060117190859.GA2061@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline
In-Reply-To: <20060117190859.GA2061@linux-mips.org>
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
X-archive-position: 9949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-01-17 19:08:59 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> There is an awful lot of libgcc bits flying around in the kernel and I gu=
ess
> I'd be flamed for submitting even more ;-)  so I tried to come up with
> something to make most if not all unnecessary.  Still needs a little
> polishing but below for testing and commenting.

People will love you for that. I also already added libgcc
functions:-)

> +#ifdef __BIG_ENDIAN
> +struct DWstruct {
> +	Wtype high, low;
> +};
> +#elif defined(__LITTLE_ENDIAN)
> +struct DWstruct {
> +	Wtype low, high;
> +};
> +#else
> +#error I feel sick.
> +#endif

No, you feel PDP11ish. Though you'd put quotes about the warning
message.

I'm all for adding this!

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

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDzUe8Hb1edYOZ4bsRAm+UAJ91c+hgfTJorKDP0uTiYhnjXyxUDgCggrmv
00Qv7ZDR3/Y22qRU8s6tvkc=
=2TDG
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
