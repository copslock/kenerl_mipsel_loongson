Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jun 2003 18:58:47 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:37764
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8224827AbTFAR6p>; Sun, 1 Jun 2003 18:58:45 +0100
Received: (qmail 18627 invoked by uid 502); 1 Jun 2003 17:58:39 -0000
Date: Sun, 1 Jun 2003 10:58:39 -0700
From: ilya@theIlya.com
To: linux-mips@linux-mips.org
Subject: Simple compile fix
Message-ID: <20030601175839.GA3035@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

ip32-berr.c misses #include <linux/sched.h>

Index: arch/mips/sgi-ip32/ip32-berr.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-berr.c,v
retrieving revision 1.4
diff -u -r1.4 ip32-berr.c
--- arch/mips/sgi-ip32/ip32-berr.c      14 Apr 2003 16:33:24 -0000      1.4
+++ arch/mips/sgi-ip32/ip32-berr.c      1 Jun 2003 17:56:58 -0000
@@ -9,6 +9,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/sched.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>
 #include <asm/addrspace.h>


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD4DBQE+2j7O7sVBmHZT8w8RAtg+AKCGh8bxCixWJ3oG5KocSGG+bPbXMQCXc524
R5QgG2wgiNTLzMSLSq9Uxw==
=JTka
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
