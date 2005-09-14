Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 16:22:01 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:13716 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8225305AbVINPVp>;
	Wed, 14 Sep 2005 16:21:45 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id 95A73F007A; Wed, 14 Sep 2005 17:21:44 +0200 (CEST)
Date:	Wed, 14 Sep 2005 17:21:44 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Git
Message-ID: <20050914152144.GJ23161@lug-owl.de>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20050913124544.GC3224@linux-mips.org> <20050913133126.GO23161@lug-owl.de> <20050913152038.GE3224@linux-mips.org> <20050914095858.GD23161@lug-owl.de> <20050914123750.GL3224@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4B4+7MsODflw+h2f"
Content-Disposition: inline
In-Reply-To: <20050914123750.GL3224@linux-mips.org>
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
X-archive-position: 8948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--4B4+7MsODflw+h2f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-09-14 13:37:50 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Sep 14, 2005 at 11:58:58AM +0200, Jan-Benedict Glaw wrote:
> > monotone
> > 	Is quite nice'n'easy to use for CVS users, you'll have quite a
> > 	fast start. The network sync protocol can be a bit lengthy at
> > 	a time, but it works. It's acceptable in speed, but not
> > 	exactly "fast". Written in C, code can easily be read and
> > 	hacked.
>=20
> Git has taken some ideas from Monotone.

Though monotone uses a (berkeley?) DB to store all objects...

> > arch
> > 	Arch can do almost everything; it's network sync protocol is
> > 	quite fast (can use several transports and will make use of
> > 	caches). However, it's not exactly easy to use because of it's
> > 	thousands of commands and it's project name conventions are,
> > 	um, ugly. It has very good merging capabilities, but it's
> > 	heavy use of local caches forces you to have loads of free HDD
> > 	space.
>=20
> Git is a huge diskspace consumer also unless repositories are converted.
> For example, the Linux kernel repository from CVS did inflate itself to
> over 4GB and over 340,000 files.  After packing I got that down to like
> 170MB.  Not bad compared to the some 770MB of RCS files it's using
> currently and < 11s checkout from git can't be wrong either ;-)

Well, Arch *may* cache any tree version you check out. So take a
source tree and check-out some 15 tree versions, you may end up with a
really *hugh* cache. You're free to delete it, though...

> > To get fixes/port updates/subsystem updates upstream to Linus, GIT is
> > the way[tm] to go, so we'd try to get familiar with it.
>=20
> The other accepted currency of the trade are still simple patches, see
> http://www.linux-mips.org/wiki/The_perfect_patch.

ACK. But unless you've got the perfect Patch Queue Manager that'll
re-diff and re-send your patches automatically to Linus, you keep on
doing some manual work or at least starting your scripts ever and ever
again :)

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

--4B4+7MsODflw+h2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFDKEAIHb1edYOZ4bsRAn1UAJ4hrFzvlb5zNDVpYHOb37RkYR1I+gCY/rwG
jHly3e0FX0dUEOKa057PjQ==
=eKma
-----END PGP SIGNATURE-----

--4B4+7MsODflw+h2f--
