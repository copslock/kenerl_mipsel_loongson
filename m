Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2002 05:28:41 +0200 (CEST)
Received: from h24-83-208-253.sbm.shawcable.net ([24.83.208.253]:31632 "EHLO
	straylight.cyberhqz.com") by linux-mips.org with ESMTP
	id <S1122960AbSIKD2l>; Wed, 11 Sep 2002 05:28:41 +0200
Received: from cyberhq.internal.cyberhqz.com (cyberhq.internal.cyberhqz.com [192.168.0.2])
	by straylight.cyberhqz.com (Postfix) with ESMTP
	id BCBAA5400B; Tue, 10 Sep 2002 20:28:33 -0700 (PDT)
Received: by cyberhq.internal.cyberhqz.com (Postfix, from userid 1000)
	id 326C41B96A9; Tue, 10 Sep 2002 20:28:32 -0700 (PDT)
Date: Tue, 10 Sep 2002 20:28:32 -0700
From: Ryan Murray <rmurray@debian.org>
To: linux-mips@linux-mips.org
Cc: libc-alpha@sources.redhat.com
Subject: [patch] userspace mcontext_t doesn't match what kernel returns
Message-ID: <20020911032832.GA1500@cyberhqz.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <rmurray@cyberhqz.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmurray@debian.org
Precedence: bulk
X-list: linux-mips


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The definition of mcontext_t in sysdeps/unix/sysv/linux/mips/sys/ucontext.h
does not match what the kernel copies to userspace (struct sigcontext).
alpha, ia64, and hppa have fixed this by typedefing one to the other in
sys/ucontext.h  The following patch accomplishes the same thing for mips.

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--- sysdeps/unix/sysv/linux/mips/sys/ucontext.h	2002-09-10 20:16:52.0000000=
00 -0700
+++ sysdeps/unix/sysv/linux/mips/sys/ucontext.h	2002-09-10 20:17:24.0000000=
00 -0700
@@ -61,11 +61,7 @@
=20
=20
 /* Context to describe whole processor state.  */
-typedef struct
-  {
-    gregset_t gregs;
-    fpregset_t fpregs;
-  } mcontext_t;
+typedef struct sigcontext mcontext_t;
=20
 /* Userlevel context.  */
 typedef struct ucontext

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9frhfN2Dbz/1mRasRAlH7AKDGz4kHoyBsQOyOSdXeuUFhcbBEaQCeI5yX
LLrN33jUyyS4Yny5Pl/kwWE=
=mPJS
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
