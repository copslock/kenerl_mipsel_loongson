Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2003 17:36:21 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:48617
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225437AbTI2Qfm>; Mon, 29 Sep 2003 17:35:42 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 653902BC42; Mon, 29 Sep 2003 18:35:28 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 30330-06;
 Mon, 29 Sep 2003 18:34:57 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 884FC2BC39; Mon, 29 Sep 2003 18:34:57 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id AEBFA40CC; Mon, 29 Sep 2003 18:35:28 +0200 (CEST)
Date: Mon, 29 Sep 2003 18:35:28 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Cc: ralf@gnu.org
Subject: [patch] kmap_types.h for mips64
Message-ID: <20030929163528.GB6983@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org, ralf@gnu.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Virus-Scanned: by amavisd-new-20021227-p2 (Debian)
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--gMR3gsNFwZpnI/Ts
Content-Type: multipart/mixed; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
linux_2_4's mips64 doesn't have kmap_types.h which is needed for the
crypto code.

--- /dev/null	2003-08-29 16:55:43.000000000 +0200
+++ include/asm-mips64/kmap_types.h	2003-09-29 17:44:16.000000000 +0200
@@ -0,0 +1,16 @@
+#ifndef _ASM_KMAP_TYPES_H
+#define _ASM_KMAP_TYPES_H
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_SKB_SUNRPC_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_BH_IRQ,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,
+	KM_TYPE_NR
+};
+
+#endif

Please apply,
 -- Guido

--xB0nW4MQa6jZONgY
Content-Type: text/x-chdr; charset=us-ascii
Content-Disposition: attachment; filename="kmap_types-mips64.h"

--- /dev/null	2003-08-29 16:55:43.000000000 +0200
+++ include/asm-mips64/kmap_types.h	2003-09-29 17:44:16.000000000 +0200
@@ -0,0 +1,16 @@
+#ifndef _ASM_KMAP_TYPES_H
+#define _ASM_KMAP_TYPES_H
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_SKB_SUNRPC_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_BH_IRQ,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,
+	KM_TYPE_NR
+};
+
+#endif

--xB0nW4MQa6jZONgY--

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eF9Qn88szT8+ZCYRAts+AJwNj5VE01yeOeWDF/NUVSHPzjAC6wCfXPKr
PwOS9kRXrmx9rYa3m+WOBDQ=
=B7Zs
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
