Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2003 14:10:37 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:1244 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225507AbTJUNKf>; Tue, 21 Oct 2003 14:10:35 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 5CB494B419; Tue, 21 Oct 2003 15:10:33 +0200 (CEST)
Date: Tue, 21 Oct 2003 15:10:33 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: LK201 keyboard
Message-ID: <20031021131033.GM20846@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwG3HqqAyJLiyW5N"
Content-Disposition: inline
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--ZwG3HqqAyJLiyW5N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm currently reworking the LK201 keyboard driver to attach it to the
new Input API, as well as letting it use the serio interface (-> this
way, you're not bound to dz.c/zs.c).

I've got a little problem with it, though. I've got docs (for the VAX)
which describe the LK201 in detail. First of all, the "Set LEDs On"
command is wrong there (advertised as 0x12, but 0x13 actually works;
this is what the current driver uses, too). That may be a typo, though..

However, the "Set Mode" command (to set the repeat mode for a block of
keys) doesn't work for me on a lk201. Using a lk401 instead, these
commands work. Every time I send a set-mode command, I get a Input Error
(from the keyboard) sent back...

I'd like to ask you DECstation users to verify that the set-mode command
actually works for you on a lk201... Or do you all use the newer lk401?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--ZwG3HqqAyJLiyW5N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lTBJHb1edYOZ4bsRAo5lAJ9AJVI9HIbU1SQbHuVtZI0OwrjQqgCghXiV
E1TLby0GwfLSgBWAdftcfKU=
=ArsP
-----END PGP SIGNATURE-----

--ZwG3HqqAyJLiyW5N--
