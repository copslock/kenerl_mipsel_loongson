Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2004 14:30:45 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:60333 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8224924AbUGNNak>; Wed, 14 Jul 2004 14:30:40 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id ABD524B7BD; Wed, 14 Jul 2004 15:30:39 +0200 (CEST)
Date: Wed, 14 Jul 2004 15:30:39 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Help with MOP network boot install on DECstation 5000/240
Message-ID: <20040714133039.GS2019@lug-owl.de>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org> <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de> <000e01c4696f$f65cf4f0$0a9913ac@swift> <Pine.LNX.4.55.0407141058480.4513@jurand.ds.pg.gda.pl> <20040714124435.GR2019@lug-owl.de> <Pine.LNX.4.55.0407141446440.27072@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LmUdgXdNLPkN/XLh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0407141446440.27072@jurand.ds.pg.gda.pl>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--LmUdgXdNLPkN/XLh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-07-14 14:51:35 +0200, Maciej W. Rozycki <macro@linux-mips.org>
wrote in message <Pine.LNX.4.55.0407141446440.27072@jurand.ds.pg.gda.pl>:
> On Wed, 14 Jul 2004, Jan-Benedict Glaw wrote:
> > While we are at it. I'll have to re-verify that, but my mopd is loosing
> > file descriptors if you ^A-F your box during a load.
>=20
>  Hmm, while I get what you mean, what is "^A-F" specifically?

Sending a break from minicom :)   That is, I just ask the MOP client to
stop loading.

>  Anyway, this may be true -- probably the server is still waiting for
> following requests to come.  A timeout might be a good thing to add. =20
> Unfortunately I don't have time to work on mopd ATM.  It would be good to
> do a serious rewrite and I plan to do that in the future.  No established=
=20
> plan, though.

Eventually I'll re-get all the sources and compile again. Adding a
timeout shouldn't be all that hard. It should be a matter of extending
the "connection" table by "last packet's recv/send time" and check this
table entry upon each new request.

>  Another problem which is already known is mopd dying when one of
> interfaces it's listening on goes down.

Haven't seen that, but my interfaces tend to not go down (at least not
until the whole machine goes down...).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--LmUdgXdNLPkN/XLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9TV/Hb1edYOZ4bsRAimRAKCBLdIZkrAEWyzx3vEWQ8GEJm9DTgCfa+pp
TuGWCrJFrg4Z6LBJgeqVyRI=
=P4E0
-----END PGP SIGNATURE-----

--LmUdgXdNLPkN/XLh--
