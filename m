Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7FBSuRw032170
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 15 Aug 2002 04:28:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7FBSujP032169
	for linux-mips-outgoing; Thu, 15 Aug 2002 04:28:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7FBSlRw032159
	for <linux-mips@oss.sgi.com>; Thu, 15 Aug 2002 04:28:48 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id E526D13587; Thu, 15 Aug 2002 13:31:21 +0200 (CEST)
Date: Thu, 15 Aug 2002 13:31:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: R4600SC Indy
Message-ID: <20020815113121.GV19435@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020806111959.C15670@marmot.cita.utoronto.ca> <20020815020642.A23230@marmot.cita.utoronto.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80wSvbVxSilpZkXN"
Content-Disposition: inline
In-Reply-To: <20020815020642.A23230@marmot.cita.utoronto.ca>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--80wSvbVxSilpZkXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-08-15 02:06:42 -0400, Robin Humble <rjh@cita.utoronto.ca>
wrote in message <20020815020642.A23230@marmot.cita.utoronto.ca>:
> On Tue, Aug 06, 2002 at 11:19:59AM -0400, Robin Humble wrote:
> >I have an R4600SC Indy and an R5000 Indy and the R4600SC hasn't worked
> >with a kernel since around 2.4.17 13feb2002.=20
>=20
> To be precise, the changes that were checked in on 6-mar-2002 broke
> R4600SC support. These changes were to arch/mips/mm/c-r4k.c (and its mips=
64
> counterpart). The patch below (to 13-aug-02 linux_2_4 CVS) is simply a
> reversal of the changes made on 6-mar-02 and makes my R4600SC Indy work
> just fine.

They broke R4600 Version 1.7 to be exactly, as this CPU has got some
bugs in it's cache flush commands. The result is: you need to disable
interrupts to get the desired result, but that's some kind of PITA
performance-wise, so the workaround for R4k6 V1.7 was dropped later on.

I've got a somewhat better patch introducing all needed routines for the
buggy R4k6 V1.7 and setting them up (more or less correctly).

However, it seems that I did bug somewhere. My patch seems to not be as
stable as expected. I tried to post it at the weekend, but it didn't
show up (size?). I'll try it again these days, though.

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--80wSvbVxSilpZkXN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9W5EJHb1edYOZ4bsRAjW2AJ9hRHkMaoAOX9w6Tk2lVU3SXzXP3gCeKg84
+LYkIkf6aW2sYWa/Vg4dXsk=
=zRuK
-----END PGP SIGNATURE-----

--80wSvbVxSilpZkXN--
