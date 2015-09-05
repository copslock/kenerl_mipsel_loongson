Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Sep 2015 21:29:50 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39438 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007600AbbIET3tL4V4C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Sep 2015 21:29:49 +0200
Received: from dab-yat1-h-48-9.dab.02.net ([82.132.215.124] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZYJ9o-0006Nh-8d
        for linux-mips@linux-mips.org; Sat, 05 Sep 2015 20:29:48 +0100
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZYJ9b-0004Mp-Gl
        for linux-mips@linux-mips.org; Sat, 05 Sep 2015 20:29:35 +0100
Message-ID: <1441481368.15927.0.camel@decadent.org.uk>
Subject: [PATCH] MIPS: BPF: Disable JIT on R3000 (MIPS-I)
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-mips@linux-mips.org
Date:   Sat, 05 Sep 2015 20:29:28 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-a2Mb50HiA7RBkyHSuVQZ"
X-Mailer: Evolution 3.16.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 82.132.215.124
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


--=-a2Mb50HiA7RBkyHSuVQZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The JIT does not include the load delay slots required by MIPS-I
processors.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 199a835..7ff9cba 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -12,7 +12,7 @@ config MIPS
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_BPF_JIT if !CPU_MICROMIPS
+	select HAVE_BPF_JIT if !CPU_MICROMIPS && !CPU_R3000
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select HAVE_FUNCTION_TRACER
 	select HAVE_DYNAMIC_FTRACE
--=20
Ben Hutchings
friends: People who know you well, but like you anyway.


--=-a2Mb50HiA7RBkyHSuVQZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVetCmOe/yOyVhhEJAQpXNhAAi4GWCPzgagNUQPiit/cVDo+kQ3mvQIA9
VbXmoqVvt1Z4+WMxyPUz2UXcX1m3mlCu7afZjaHgu6gpYLxl4F9r7OR6I4DEQHXD
UqZvNLLIuTbW5En8wuYkyOmKVSNWBR+i4m2Pp3UCwSVRMaaIOSFVC9rGQQHJm8M2
F2IHyXEY2V80mhk8d0tvH+yQoJfHeF3jf4Jj4nX1ee3zPJt3ZSbe+3utekGF4RR0
YDO58xsxIIzJYP7iNG8HOywOSDbideSv0gV7dSGDJ71yhcy0iJ3o4ozspy80EGyL
f8ChokLGWT5q6b8Z1GMOTUh6OTEuI/Nrs7uynvW42a8hdrvwJ0/QtWHy8cqeEPms
KisCNC+jLd1cPT726C+VQeolRv/1O4S2IbYQjKSKNdyZXvlzoBhHpW1/9iQ4WgSZ
ILzH/x06Q2BM+yINvMGXebiVfgELsaEFxxZ9kCPQnOnzLAeB2N2jyBYLEBba3JD/
m1e1o/DEns1cAOxxfhOqUQmkM0GeyQ0/shnq0YN8cb++Tyo0n6veUO2I0SUCH60v
p9QKVIgHLTGy3vVKVcimJ2E0U/1ROU/mkjVBZD7BEK7F7GPILvVW4HRb9NGh01zy
TrfeIEGmDg/vr9dsZIrRpsenuZLPR/IWo4NfVr1dowhCyrO3cqR/9T38/thrp+Bp
stmvvTNobd4=
=BOnp
-----END PGP SIGNATURE-----

--=-a2Mb50HiA7RBkyHSuVQZ--
