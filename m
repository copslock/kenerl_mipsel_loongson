Received:  by oss.sgi.com id <S42428AbQFFMuz>;
	Tue, 6 Jun 2000 05:50:55 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:29026 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42292AbQFFMut>; Tue, 6 Jun 2000 05:50:49 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA06064; Tue, 6 Jun 2000 05:55:42 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id FAA21187; Tue, 6 Jun 2000 05:50:18 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA26020
	for linux-list;
	Tue, 6 Jun 2000 05:36:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA78931
	for <linux@engr.sgi.com>;
	Tue, 6 Jun 2000 05:35:42 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: from belgarath.esg-guetersloh.mediapoint.de (belgarath.esg-guetersloh.mediapoint.de [193.189.251.50]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA01686
	for <linux@engr.sgi.com>; Tue, 6 Jun 2000 05:30:10 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: by belgarath.esg-guetersloh.mediapoint.de (Postfix, from userid 1000)
	id CD56851341; Tue, 06 Jun 2000 14:30:07 +0200 (CEST)
Date:   Tue, 6 Jun 2000 14:30:07 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: Problems booting Indigo...
Message-ID: <20000606143007.G17656@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux@engr.sgi.com
References: <200005310410.VAA00290@hollywood.engr.sgi.com> <Pine.LNX.4.21.0005310417570.274-100000@hork> <20000531122527.A26328@lug-owl.de> <20000605162933.C3774@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
X-Mailer: Mutt 1.0i
In-Reply-To: <20000605162933.C3774@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Jun 05, 2000 at 04:29:33PM +0200
X-Operating-System: Linux belgarath.esg-guetersloh.mediapoint.de 2.0.35 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2000 at 04:29:33PM +0200, Florian Lohoff wrote:
> On Wed, May 31, 2000 at 12:25:27PM +0200, Jan-Benedict Glaw wrote:
> > I hacked the BSD tftpd last night (-> standalone and send from #69) but
> > you're right. It makes no difference at all. This morning, I played with
> > the transceiver again -- 2 switches, 4 possibilities. Tested all, but
> > no success. Some two month ago I booted that Indigo over net (okay, it
> > crashed immediately;) but the only difference is that we used a switched
> > port there... It's brain-dead, but I'll fetch a switch from my old scho=
ol
> > and test it...
>=20
> It cant be the tftp server etc - Use your brain - We have booted
> your machine here - Its an ARP problem i guess.=20

=2E..and on which side? TFTP server hat Indigo's ARP address statically
set - without I can't even see the tftp request...

> And BTW - Use a hub - i had loads of problems booting the
> decstation and the indigo2 via a switch - Hangs in the middle
> were completely normal.

=2EoO( If I only would reach the middle )

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEAREBAAYFAjk87s8ACgkQHb1edYOZ4bu8VgCfQeeYi7OO4Pzb1ZT3tWAKefUy
4KUAn3LnA1W6b7AapRURhzLAd79K1pMQ
=iIHT
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
