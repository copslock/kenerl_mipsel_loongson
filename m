Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 20:27:09 +0200 (CEST)
Received: from GS256.SP.CS.CMU.EDU ([128.2.199.27]:61899 "HELO
	gs256.sp.cs.cmu.edu") by linux-mips.org with SMTP
	id <S1122987AbSIQS1J>; Tue, 17 Sep 2002 20:27:09 +0200
Subject: Re: Delayed jumps and branches
From: justinca@cs.cmu.edu
To: Gareth <g.c.bransby-99@student.lboro.ac.uk>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20020917161959.33787757.g.c.bransby-99@student.lboro.ac.uk>
References: <20020917161959.33787757.g.c.bransby-99@student.lboro.ac.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Q+nb2dc7wgIh4ey09bkw"
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 14:26:18 -0400
Message-Id: <1032287178.27966.133.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Source-Info: Sender is really justinca+@gs256.sp.cs.cmu.edu
Return-Path: <justinca@cs.cmu.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinca@cs.cmu.edu
Precedence: bulk
X-list: linux-mips


--=-Q+nb2dc7wgIh4ey09bkw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-09-17 at 11:19, Gareth wrote:
> Hi,
>     jal <my_function>
>     li  $s2, 3
>     li  $v0, 2
>=20
> If the jump is not taken, it requires 3 cycles to execute these 3 instruc=
tions.
> If the jump is taken, it requires 3 cycles to execute the first instructi=
on of
> my_function, and li $s2, 3 is executed.
>=20
> Is my reasoning correct?
>=20

Aside from the corrections Thiemo sent, you should probably also
disabuse yourself of the notion that one instruction =3D=3D one cycle.=20

For most processors, there's no simple answer to the question "how many
cycles will this code segment take to run".   Even in the embedded
world, most newer processors are superscalar.  In addition, if you want
to be precise, you have to take into account cache behaviour, branch
prediction, issue restrictions, etc.

-Justin


--=-Q+nb2dc7wgIh4ey09bkw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9h3PK47Lg4cGgb74RAvt0AKCxxyeynMj9TK6FL6gzGQS2L3ZwcACcCHIy
AZBYb7ePF4BizakKKHCp0jg=
=mAoT
-----END PGP SIGNATURE-----

--=-Q+nb2dc7wgIh4ey09bkw--
