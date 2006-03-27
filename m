Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 08:33:45 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:62182 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S8133406AbWC0Hdf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Mar 2006 08:33:35 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id D7B975DF64
	for <linux-mips@linux-mips.org>; Mon, 27 Mar 2006 09:43:52 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 07606-05-2 for <linux-mips@linux-mips.org>;
	Mon, 27 Mar 2006 09:43:52 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 5D1A55DF49; Mon, 27 Mar 2006 09:43:52 +0200 (CEST)
Date:	Mon, 27 Mar 2006 09:43:52 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	linux-mips@linux-mips.org
Subject: [PATCH] small time list process error in prom_getenv()
Message-ID: <20060327074352.GC4781@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jSXJDi5r/aeatSyx"
Content-Disposition: inline
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--jSXJDi5r/aeatSyx
Content-Type: multipart/mixed; boundary="UhXv5VeBZ/Y8lRnC"
Content-Disposition: inline


--UhXv5VeBZ/Y8lRnC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I found a small time bug in prom_getenv() for which I like to
share the fix with y'all.

prom_envp is an array with two elements per environment variable.
So for instance element 0 is memsize and element 1 is 0x08000000
for the environment variable memsize=3D0x08000000.

The code for prom_getenv() only skips one element when it's in
search for the next environment variable. It should of course
step two elements.

I found this error in two files and for both I include a patch to
fix the problem.

Signed-off-by: Freddy Spierenburg <freddy@dusktilldawn.nl>

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--UhXv5VeBZ/Y8lRnC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prom.pnx8550.patch"

diff -Naur linux.orig/arch/mips/philips/pnx8550/common/prom.c linux/arch/mips/philips/pnx8550/common/prom.c
--- linux.orig/arch/mips/philips/pnx8550/common/prom.c	2006-03-22 15:25:58.000000000 +0000
+++ linux/arch/mips/philips/pnx8550/common/prom.c	2006-03-22 15:25:23.000000000 +0000
@@ -70,7 +70,7 @@
 		if(strncmp(envname, env->name, i) == 0) {
 			return(env->name + strlen(envname) + 1);
 		}
-		env++;
+		env+=2;
 	}
 	return(NULL);
 }

--UhXv5VeBZ/Y8lRnC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prom.au1000.patch"

diff -Naur linux.orig/arch/mips/au1000/common/prom.c linux/arch/mips/au1000/common/prom.c
--- linux.orig/arch/mips/au1000/common/prom.c	2006-03-22 15:11:09.000000000 +0000
+++ linux/arch/mips/au1000/common/prom.c	2006-03-22 15:16:22.000000000 +0000
@@ -97,7 +97,7 @@
 		if(strncmp(envname, env->name, i) == 0) {
 			return(env->name + strlen(envname) + 1);
 		}
-		env++;
+		env+=2;
 	}
 	return(NULL);
 }

--UhXv5VeBZ/Y8lRnC--

--jSXJDi5r/aeatSyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEJ5e4bxf9XXlB0eERAvAwAKCHGHnyVjt06DYBtUgVktKgz2EyxQCfa93U
tIHyPJsGzw29mQFf5DTvYh0=
=41sZ
-----END PGP SIGNATURE-----

--jSXJDi5r/aeatSyx--
