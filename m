Received:  by oss.sgi.com id <S305164AbQD1Vbi>;
	Fri, 28 Apr 2000 14:31:38 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:50720 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQD1VbQ>;
	Fri, 28 Apr 2000 14:31:16 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA13841; Fri, 28 Apr 2000 14:26:29 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA71281
	for linux-list;
	Fri, 28 Apr 2000 14:21:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA52929
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Apr 2000 14:21:05 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: from belgarath.esg-guetersloh.mediapoint.de (belgarath.esg-guetersloh.mediapoint.de [193.189.251.50]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06317
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Apr 2000 14:20:56 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: by belgarath.esg-guetersloh.mediapoint.de (Postfix, from userid 1000)
	id 1B8C8512EA; Fri, 28 Apr 2000 23:21:13 +0200 (CEST)
Date:   Fri, 28 Apr 2000 23:21:12 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: Just a little question ..
Message-ID: <20000428232112.A9839@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux@cthulhu.engr.sgi.com
References: <Pine.LNX.4.10.10004282023290.454-100000@cassiopeia.home> <Pine.LNX.4.05.10004281539310.29506-100000@ns.snowman.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.05.10004281539310.29506-100000@ns.snowman.net>; from nick@ns.snowman.net on Fri, Apr 28, 2000 at 03:40:05PM -0400
X-Operating-System: Linux belgarath.esg-guetersloh.mediapoint.de 2.0.35 
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2000 at 03:40:05PM -0400, nick@ns.snowman.net wrote:
> FDDI sounds right.  What does the physical connector look like?  I think
> FDDI does 4-5 encoding?
> 	Nick

The whole connector is separated into 2 halfes and looks like this:

                    +-----------+
                    |           |
                    |           |_
                    |     O      _|
                    |           |
                    |           |
                    |-----------|
                    |           |
                    |           |_
                    |     O      _|
                    |           |
                    |           |
                    +-----------+

The upper connector's data direction seems to be computer -> glass cable,
the lower one is glass cable -> computer (according to arrows printed on
"Transmitter" (upper one) and "Receiver" (lower one).

On thr right side there are 2 holes (sorry, don't know the english word for
german "Aussparungen";( It's about 25x10mm.

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEAREBAAYFAjkKAMgACgkQHb1edYOZ4bulxwCgjFqOyHo6TtS9qQQq8Efrguyq
VeEAn3MbFzyekUw3+abIlBTjATA92gZ2
=pm/p
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
