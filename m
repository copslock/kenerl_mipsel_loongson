Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2004 21:30:13 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:902 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225985AbUFCUaI>; Thu, 3 Jun 2004 21:30:08 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 15F164B7A9; Thu,  3 Jun 2004 22:30:07 +0200 (CEST)
Date: Thu, 3 Jun 2004 22:30:07 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: shared mem problem
Message-ID: <20040603203006.GZ20632@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040603143153.42483.qmail@web60703.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ObBTuCXcSRzA7u8"
Content-Disposition: inline
In-Reply-To: <20040603143153.42483.qmail@web60703.mail.yahoo.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--1ObBTuCXcSRzA7u8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-06-03 15:31:53 +0100, Sujith Nayak <nayak_27@yahoo.com>
wrote in message <20040603143153.42483.qmail@web60703.mail.yahoo.com>:
> Hi,
> I am currently working on a board powered by a MIPS
> processor, using Linux kernel 2.4.2. The problem that

Before doing anything else, you'd consider moving forward to current
2.4.x or even 2.6.x...

> I am facing is, whenever I create a shared memory
> using shmget(), shmat(), etc. APIs, I always see that
> the shared mem is created with 0 bytes. As a result
> any access to it bombs the process.
>=20
> Anyone has any idea, I will be grateful for your
> response. I had a look at the patch-2.4.2-ac23, which
> talks about the some shared mem lock up problem. But I
> cannot apply the patch as it is because my customer
> has pruned the kernel so much that the patch does not
> apply right away.

Then talk your customer (isn't that actually your vendor?) into putting
work into a newer kernel. Maybe you can diff you their changes agains a
2.4.2 from either linux-mips.org or 2.4.2 from Linus and try to
forward-port the changes to current 2.4.x or 2.6.x ...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--1ObBTuCXcSRzA7u8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAv4pOHb1edYOZ4bsRAt6pAJ92cvp2Uekv8WLB/pNwGWXrO+xenwCfc2Ug
Qp1T7DNkT6b8KgZwz3ShOiM=
=+VFP
-----END PGP SIGNATURE-----

--1ObBTuCXcSRzA7u8--
