Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2005 09:32:03 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:47800 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8225507AbVDAIbs>;
	Fri, 1 Apr 2005 09:31:48 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id 9AF0A1901BB; Fri,  1 Apr 2005 10:31:47 +0200 (CEST)
Date:	Fri, 1 Apr 2005 10:31:47 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Cc:	moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: How to keep uptodate a mips-linux port
Message-ID: <20050401083147.GQ21175@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org,
	moreau francis <francis_moreau2000@yahoo.fr>
References: <20050401075417.14596.qmail@web25106.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zipuvUKAEymKn2g"
Content-Disposition: inline
In-Reply-To: <20050401075417.14596.qmail@web25106.mail.ukl.yahoo.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--6zipuvUKAEymKn2g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 09:54:17 +0200, moreau francis <francis_moreau2000@yahoo=
=2Efr>
wrote in message <20050401075417.14596.qmail@web25106.mail.ukl.yahoo.com>:
> --- Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> > The best approach is to cleanly break out all your
> > changes into
> > semantical patches and submit them to the prople who
> > care about the
> > individual files. The MIPS-specific patches go to
> > this list.
>=20
> I already tried this one, and it doens't seem to be
> the best one: I sent a patch a couple of months ago
> to the list, but I didn't get any answers...so I beg
> for Ralf to look at it on IRC, but he seems to have=20
> not time for it...So now I'm trying to find out a new
> approach....

Don't expect that sending a patch once always leads to it's prompt
acceptance. Pushing a patch *can* involve resending it multiple times,
over a long period of time. However, if a patch is in acceptable state
(that is, a half-way readable coding style, no superfluous debugging
output, ...), Ralf usually takes it quite fast.

> Futhermore, this solution can take several months
> before every patches have been submitted and accepted.
> During this while I'll need to be synchronised with
> CVS tree.

That isn't all that easy, especially with CVS and especially if you want
to keep patches in nicely separated changesets. With CVS, this
unfortunately involves some manual work, or clever scripting. But SCM
systems are a totally different topic. "quilt" may work for you, though.

(And yes, we all search for the solution[tm] to SCM. RFC 1925 comes to
mind, modified to "Easy to use, technically working and politically
correct: Pick any two (you can't have all three)." )

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--6zipuvUKAEymKn2g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCTQbzHb1edYOZ4bsRAoc0AJ95ceZcwpi9b9IWZecz1UeHmob/8QCfVpAx
oc12V7cOTvs/bOBqHX3XD10=
=cM6M
-----END PGP SIGNATURE-----

--6zipuvUKAEymKn2g--
