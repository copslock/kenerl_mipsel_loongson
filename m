Received:  by oss.sgi.com id <S305156AbQENWPK>;
	Sun, 14 May 2000 22:15:10 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:28529 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQENWOs>;
	Sun, 14 May 2000 22:14:48 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA19525; Sun, 14 May 2000 15:09:58 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA40330
	for linux-list;
	Sun, 14 May 2000 15:05:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA04679
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 14 May 2000 15:04:59 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: from belgarath.esg-guetersloh.mediapoint.de (belgarath.esg-guetersloh.mediapoint.de [193.189.251.50]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07015
	for <linux@cthulhu.engr.sgi.com>; Sun, 14 May 2000 15:04:57 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: by belgarath.esg-guetersloh.mediapoint.de (Postfix, from userid 1000)
	id EAA2E51314; Mon, 15 May 2000 00:04:54 +0200 (CEST)
Date:   Mon, 15 May 2000 00:04:54 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: Indy Documentation
Message-ID: <20000515000454.A6575@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux@cthulhu.engr.sgi.com
References: <Pine.LNX.4.21.0005130609590.1061-100000@calypso.engr.sgi.com> <20000513183248.C1279@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
X-Mailer: Mutt 1.0i
In-Reply-To: <20000513183248.C1279@paradigm.rfc822.org>; from flo@rfc822.org on Sat, May 13, 2000 at 06:32:48PM +0200
X-Operating-System: Linux belgarath.esg-guetersloh.mediapoint.de 2.0.35 
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, May 13, 2000 at 06:32:48PM +0200, Florian Lohoff wrote:
> On Sat, May 13, 2000 at 06:21:56AM -0700, Ulf Carlsson wrote:
> > Subject: Indy Documentation
>=20
> Someday somebody might be interested in doing more work
> for the Indigo and then there is no documentation avail.

Doing "more" work for Indigo? Well, what work has actually be done up to
now to support linux on this (okay, quite old...) box?

- The R3k is supported by gcc (I think R3000 support is mainly used for
  the DECStations?)
- Glibc2.2 will be available in near future and hopefully fully
  functional;)

But:

- No kernel support so far (okay, one try to make it run, but this=20
  resulted in an exception right after tftp'ing the kernel image to
  the machine)

Personally I'd like to do work on an Indigo as I got one, but it seems
to only be a no-documentation-available problem. (I remember I got some
email address of a woman working at SGI I should have contacted a week
or two ago...).

I'd love to sign a 1US$/year contract with SGI as Flo suggested, but
this doesn't ease (nor solve) the problem. Even if I would get some
sources from eg Irix5.2 (to figure out the bootstrap process) I wouldn't
be allowed to use it in GPL'ed work because of parts being licensed
from other companies;(

However, there were some documents found. Save them. Save them at a
very save place as they might disappear which is somewhat "normal"
for documentation;) Maybe there will (at some certain time) be someone
at SGI who has got enough spare time to evaluate docs and sources.
Maybe licensed parts can be removed without removing all necessary
infos to build a kernel for Indigos. This would be equal to what
IBM does to their JFS (with one difference: Indigos are equal to=20
a mid-class 486, JFS is even today a first-class fs). This unfortunately
requires menwork and so it is costly;( I also think that is isn't
really cheap to port XFS, as well. But porting XFS is a step forward,=20
making Indigos is kind of nostalgic...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
	...und aus aktuellem Anla=DF:	ILOVEYOU, Linux!

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEAREBAAYFAjkfIwYACgkQHb1edYOZ4bsV9wCfZnwzgJpLJXG8Jqo6cXoGMJ67
MIMAni44IACMhujFEAsIrxuGRb1h/ZGg
=PO4J
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
