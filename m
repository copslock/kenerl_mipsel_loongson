Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBBAuWV13746
	for linux-mips-outgoing; Tue, 11 Dec 2001 02:56:32 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBBAuOo13743
	for <linux-mips@oss.sgi.com>; Tue, 11 Dec 2001 02:56:24 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 96F5B83F; Tue, 11 Dec 2001 10:56:13 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A4F2748FF; Tue, 11 Dec 2001 10:55:48 +0100 (CET)
Date: Tue, 11 Dec 2001 10:55:48 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Klaus Naumann <spock@mgnet.de>
Cc: Guido Guenther <agx@sigxcpu.org>, Linux/MIPS list <linux-mips@oss.sgi.com>,
   klaus@mgnet.de
Subject: Re: [PATCH] sgiwd93.c fix for multiple disks
Message-ID: <20011211095548.GB399@paradigm.rfc822.org>
References: <20011211095759.A5689@gandalf.physik.uni-konstanz.de> <Pine.LNX.4.21.0112111034340.2714-300000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112111034340.2714-300000@spock.mgnet.de>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2001 at 10:37:11AM +0100, Klaus Naumann wrote:
> Hi all,
>=20
> I've done some bonnie++ tests and everything looks good IMHO.
> See attachments (new_speed is with lolo's patch and old_speed without).
> I vote for commit. Cool work !

It looks like this is statistical distortion as some numbers went up.
It looks at least that there is no real difference ...

> Version  1.02       ------Sequential Output------ --Sequential Input- --R=
andom-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --S=
eeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /s=
ec %CP
> ivy            368M  1415  95  2437   7  1003   4  1208  81  2298   6  90=
.7   2
>                     ------Sequential Create------ --------Random Create--=
------
>                     -Create-- --Read--- -Delete-- -Create-- --Read--- -De=
lete--
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /s=
ec %CP
>                  16   235  99 +++++ +++ 13871  98   242  99 +++++ +++   8=
98  99
> ivy,368M,1415,95,2437,7,1003,4,1208,81,2298,6,90.7,2,16,235,99,+++++,+++,=
13871,98,242,99,+++++,+++,898,99

> Version  1.02       ------Sequential Output------ --Sequential Input- --R=
andom-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --S=
eeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /s=
ec %CP
> ivy            368M  1348  91  2468   7   836   3  1297  87  2178   5  91=
.0   2
>                     ------Sequential Create------ --------Random Create--=
------
>                     -Create-- --Read--- -Delete-- -Create-- --Read--- -De=
lete--
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /s=
ec %CP
>                  16   220  99 +++++ +++ 13440  98   232  99 +++++ +++   7=
80  99
> ivy,368M,1348,91,2468,7,836,3,1297,87,2178,5,91.0,2,16,220,99,+++++,+++,1=
3440,98,232,99,+++++,+++,780,99

I would commit that too with some additional comments that the HPC
is capable of doing scatter-gather but this does not mix with the wd33
framwork which has no support for that.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8FdgkUaz2rXW+gJcRAlWpAKC/kwHl1XGkzBWHzVMhp2cSH2ALGgCfZwRl
J0LG1JCgpbEQmWa+aO2txGo=
=tUtw
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
