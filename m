Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5UDGjnC020662
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 30 Jun 2002 06:16:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5UDGjR1020661
	for linux-mips-outgoing; Sun, 30 Jun 2002 06:16:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5UDGanC020650
	for <linux-mips@oss.sgi.com>; Sun, 30 Jun 2002 06:16:37 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id E8FD212FD2; Sun, 30 Jun 2002 15:20:20 +0200 (CEST)
Date: Sun, 30 Jun 2002 15:20:20 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: [RFC][PATCH]
Message-ID: <20020630132020.GF17216@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020629184128.GX17216@lug-owl.de> <20020630144238.A342@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iBipwI8N6cjWJAiJ"
Content-Disposition: inline
In-Reply-To: <20020630144238.A342@dea.linux-mips.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--iBipwI8N6cjWJAiJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-06-30 14:42:38 +0200, Ralf Baechle <ralf@oss.sgi.com>
wrote in message <20020630144238.A342@dea.linux-mips.net>:
> On Sat, Jun 29, 2002 at 08:41:29PM +0200, Jan-Benedict Glaw wrote:
> > Please give me a comment on this patch. I'm currently tryin' to make the
> > HAL2 driver work (yes, I've got my Indy out of the edge again and I'm
> > going to use it as my desktop machine).
> >=20
> > It fixes a compilation problem on dmabuf.c. There, DMA_AUTOINIT isn't
> > defined. As ./include/asm-mips/dma.h looks like the asm-i386 file in
> > general, I've copied the #define from the i386 port (and reformated the
> > passus...).
> >=20
> > If you think it'o okay, please apply it (and drop me a note:-p)
>=20
> Sort of the right thing - why the heck does the Indy sound code have to
> rely on code for the that antique PC DMA controller ...

Well, OSS has some 'soundbase.o', in which dmabuf.o is linked into.
Possibly which code path is not used at all on Indy, but the #define has
to be there... So there's no real answer, but running 2.4.16 (from
Debian installer) and 'insmod -f'ing the just compiled 2.4.19-rc1 hal2.o
into that kernel ends up in useable sound. So this is some working way
of doing sound.

Btw., I think I'll have a deeper look at hal2.o - the smallest load lets
sound proceed in snail mode:-(

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--iBipwI8N6cjWJAiJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9HwWTHb1edYOZ4bsRAqmQAJ4qKOgpNCXnNg3oIaGWD+BEpb5r6QCeL+55
9k7uls+//1dLH1K8iMjw1dE=
=SJ/l
-----END PGP SIGNATURE-----

--iBipwI8N6cjWJAiJ--
