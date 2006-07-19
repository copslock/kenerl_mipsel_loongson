Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2006 10:16:08 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:41885 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133416AbWGSJQA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Jul 2006 10:16:00 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1G37BC-0004cF-8E; Wed, 19 Jul 2006 10:13:14 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1G389w-0000Ip-1X; Wed, 19 Jul 2006 11:16:00 +0200
Date:	Wed, 19 Jul 2006 11:16:00 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Message-ID: <20060719091559.GD25330@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] no console disabling during suspend stage
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--OaZoDhBhXzo6bW1J
Content-Type: multipart/mixed; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

here a little patch to avoid disabling console during suspend stage
while we are debugging kernel.

Ciao,

Rodolfo

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-no-console-disabling-on-kernel-debugging
Content-Transfer-Encoding: quoted-printable

--- kernel/power/main.c	2006-07-19 10:54:11.000000000 +0200
+++ kernel/power/main.c.new	2006-07-18 19:38:41.000000000 +0200
@@ -86,7 +86,9 @@
 			goto Thaw;
 	}
=20
+#ifndef CONFIG_DEBUG_KERNEL
 	suspend_console();
+#endif
 	if ((error =3D device_suspend(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to suspend\n");
 		goto Finish;

--uXxzq0nDebZQVNAZ--

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEvfhPQaTCYNJaVjMRArQ/AJ9kH8tD9+4Ns9dePH7itlofL9XqvACgk+ur
ne26TtLGRWhHpAkSQBOmV64=
=Wnji
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
