Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61FALnC007700
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 08:10:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61FALP3007699
	for linux-mips-outgoing; Mon, 1 Jul 2002 08:10:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61FAAnC007684
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 08:10:11 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 439DE133AA; Mon,  1 Jul 2002 17:13:59 +0200 (CEST)
Date: Mon, 1 Jul 2002 17:13:59 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1
Message-ID: <20020701151359.GR17216@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020701094359.GP17216@lug-owl.de> <Pine.GSO.3.96.1020701161009.7601E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Og4V1LL7XI16KR+9"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020701161009.7601E-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Og4V1LL7XI16KR+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-07-01 16:28:13 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
wrote in message <Pine.GSO.3.96.1020701161009.7601E-100000@delta.ds2.pg.gda=
.pl>:
> On Mon, 1 Jul 2002, Jan-Benedict Glaw wrote:
>=20
> > Okay, stupid idea. All these flush functions seem to be never called in
> > parallel or recursive, so if might be possible to have a global flags
> > variable and instead of always calling __save..() and __restore..(),
> > we bulid a pair of inline functions doing this. This wouldn't give
> > any penalty for !CONFIG_CPU_R4X00 and doesn't obscure the code so much
> > as all those #ifdef and #endif's would do... I'll test my suggestion
> > as fast as I reach my Indy again (is powered down at home...).
>=20
>  Feel free to use the change privately.  Otherwise please code a real fix,
> i.e. a set of buggy-R4600-specific functions, as CONFIG_CPU_R4X00 means
> other processors as well, e.g. R4000 or R4400 which are fine here.=20
>=20
>  Actually blocking interrupts for over 0.01s as it used to be done is

Ah. That would explain the huge time drifts when the box is under
load...

> unacceptable, even for buggy R4600 processors.  A fix should use a more
> fine-grained interrupt masking.=20

I'm just compiling with my proposed "fix". However, is it really a good
idea to duplicate so much code? Taking my 2nd idea (having inline
functions for saveing/restoring flags which are complete no-ops if
!CONFIG_CPU_R4X00), would it be much overhead for 4400 and 4000 to check
if we need to shuffle around flags and cut off interrupts?

I'm not really familiar w/ cache and interrupt handling/masking, and I
don't (yet) exactly know how to check for the buggy old R4600, but I
think I'll have to become an expert around that:-O

Any hints for online resources? I've had a look at idt.com (found it in
=2E/asm-mips/war.h), but I cannot find the resources there:-(

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--Og4V1LL7XI16KR+9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9IHG2Hb1edYOZ4bsRAhLRAJ9hcQ++TJ7XjmjsVDv5FGeXsbRfegCgkWaO
NFb9LBirwGu+mQjNMFV0b70=
=RhOT
-----END PGP SIGNATURE-----

--Og4V1LL7XI16KR+9--
