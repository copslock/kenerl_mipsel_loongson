Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 13:43:19 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:15117 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8224861AbTFQMnR>; Tue, 17 Jun 2003 13:43:17 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id C32F94AA20; Tue, 17 Jun 2003 14:43:15 +0200 (CEST)
Date: Tue, 17 Jun 2003 14:43:15 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
Message-ID: <20030617124314.GF6353@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20030617125216.E27590@ftp.linux-mips.org> <Pine.GSO.3.96.1030617141524.22214C-100000@delta.ds2.pg.gda.pl> <20030617131859.A32079@ftp.linux-mips.org> <20030617123212.GE6353@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Content-Disposition: inline
In-Reply-To: <20030617123212.GE6353@lug-owl.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-06-17 14:32:13 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de>
wrote in message <20030617123212.GE6353@lug-owl.de>:
> On Tue, 2003-06-17 13:18:59 +0100, Ladislav Michl <ladis@linux-mips.org>
> wrote in message <20030617131859.A32079@ftp.linux-mips.org>:
> > On Tue, Jun 17, 2003 at 02:16:12PM +0200, Maciej W. Rozycki wrote:
> > > On Tue, 17 Jun 2003, Ladislav Michl wrote:
> > > > >  Well, I would see early_printk() as advantageous if it was also =
capable
> > > > > to leave messages in the kernel ring buffer for dmesg or klogd to=
 fetch.=20
> >=20
> > I think we can leave it enabled by default, since it doesn't hurt too m=
uch.
> > Kernel cmdline argument could control usage of early console.
>=20
> If we constantly add (new) kernel arguments, we may at some time face
> the problem that the calling PROM/firmware/whatever cannot handle a
> command line which is *that* long. IIRC DECstations have a quite limited
> prompt length. This hurts for "3/tftp():vmecoff root=3D/dev/ram
> nfsroot=3D/nfsroot/decxxxx ip=3Dbootp console=3DttyS2 console=3Dtty0
> early_printk=3Darc"
>=20
> I'm just thinking about numerizing all __setup() calls so that you maybe
> can use something C99 style like: .15=3D/dev/ttyS0 (where .15 is the
> fiveteenth variable which is "console".

Hmmm. That's almose trivial:) ./kernel/params.c:parse_one() needs to be
tweaked a bit. The rest is a small script to tell us what's between
__start___param and __stop___param.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7wziHb1edYOZ4bsRAkeFAJsE+H4zSpEBo4cOUfLPJwmgUdaGUACfb5bO
pT1hGhiQPjUGrFY8wNpCy28=
=NFw2
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
