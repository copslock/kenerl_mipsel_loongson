Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6G0slRw016570
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 17:54:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6G0sl5q016569
	for linux-mips-outgoing; Mon, 15 Jul 2002 17:54:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from myware.mynet (cpe-24-221-190-179.ca.sprintbbd.net [24.221.190.179])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6G0scRw016560
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 17:54:40 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by myware.mynet (8.12.3/8.12.3) with ESMTP id g6G0xOLV005747;
	Mon, 15 Jul 2002 17:59:25 -0700
Subject: Re: PATCH: Always use ll/sc for mips
From: Ulrich Drepper <drepper@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
In-Reply-To: <20020702114045.A16197@lucon.org>
References: <20020702114045.A16197@lucon.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-pu3iGaXCetuK+RR7Gii9"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-2) 
Date: 15 Jul 2002 17:59:24 -0700
Message-Id: <1026781165.3673.11.camel@myware.mynet>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-pu3iGaXCetuK+RR7Gii9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-07-02 at 11:40, H. J. Lu wrote:
> The ll/sc emulation is implemented in 2.4.0 and above. This patch makes
> glibc always use ll/sc.

Since I haven't seen any objections I've checked this patch in.

--=20
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

--=-pu3iGaXCetuK+RR7Gii9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9M2/s2ijCOnn/RHQRAmmEAJ9gOVWz631kACuhoQOZwzFjYdEIbwCeJmSb
7Nu/3IYQiH6P6vaRNBK+uIw=
=6hDg
-----END PGP SIGNATURE-----

--=-pu3iGaXCetuK+RR7Gii9--
