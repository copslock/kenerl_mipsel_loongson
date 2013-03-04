Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Mar 2013 05:17:35 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:58526 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820301Ab3CDERbEUu7Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Mar 2013 05:17:31 +0100
Received: from [2001:470:1f08:1539:a11:96ff:fec6:70c4] (helo=deadeye.wl.decadent.org.uk)
        by shadbolt.decadent.org.uk with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.72)
        (envelope-from <ben@decadent.org.uk>)
        id 1UCMq8-0008Uo-Ml; Mon, 04 Mar 2013 04:17:28 +0000
Received: from ben by deadeye.wl.decadent.org.uk with local (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1UCMq6-0001Ah-Iv; Mon, 04 Mar 2013 04:17:26 +0000
Message-ID: <1362370641.3768.291.camel@deadeye.wl.decadent.org.uk>
Subject: MIPS: Add dependencies for HAVE_ARCH_TRANSPARENT_HUGEPAGE
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Date:   Mon, 04 Mar 2013 04:17:21 +0000
In-Reply-To: <1362257499.3768.141.camel@deadeye.wl.decadent.org.uk>
References: <1362257499.3768.141.camel@deadeye.wl.decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-pkLsUp5uyLa/Ger4Wu2y"
X-Mailer: Evolution 3.4.4-2 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:470:1f08:1539:a11:96ff:fec6:70c4
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-archive-position: 35840
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-pkLsUp5uyLa/Ger4Wu2y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The MIPS implementation of transparent huge-pages (THP) is 64-bit only,
and of course also requires that the CPU supports huge-pages.

Currently it's entirely possible to enable THP in other configurations,
which then fail to build due to pfn_pmd() not being defined.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: David Daney <david.daney@cavium.com>
---
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -19,7 +19,7 @@ config MIPS
 	select HAVE_KRETPROBES
 	select HAVE_DEBUG_KMEMLEAK
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
-	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
 	select RTC_LIB if !MACH_LOONGSON
 	select GENERIC_ATOMIC64 if !64BIT
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE


--=-pkLsUp5uyLa/Ger4Wu2y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUTQgUee/yOyVhhEJAQp3jw//fnKx7rIN2oRr7XtzxTqKGNdJO/FsIpic
T/m4CZEeHL3LZCfc/nQvYu3u08kXYHhYUmsKi7xjFyMMLlp5ps4dObSMJWJ6+BUr
7kYXIO3pGL6N7qGkohapxMwD0NSe1nV16NakK3SOGBivggAJTcOe/HZXXSXE1e3m
bLxoCv1YYuvh+T8s6J38m7Fo6HtF7ujDn+A03wxKyCCJ5DeZ4lm0/RnXJWpiE9Ij
WbKWUjco3wKKIYuPflBXf1HXP/Ql5u5vHJx5KCFDbEyO0cV+/GUftfbNz0WUH2ao
Of4S7FEFQXT+1YsSlK4V08KuBhF1p9/aku5EbCSghpsE8otopEk0AJQGBTz/Hc8z
9/fuocet2X8tV3yo0lnoxNUwmLsYPC2SYfCzGpRXvwuy5skELfQZj7W0N+P1DM+n
cHK+iurF9e+U4bGR2IVSBstfzhzG/Yh3A0oMdef73RLXNAk38d9fItZM6HHVAJOE
/7h+UmV1aizkDjGhGRKTtTNpplgHE+tKcRDkng7L6WkryeIE4GHrIcfo14LHcekR
ajohaS5Cgz5sQYXy2Cige9tXon7UoNSxAMoR4hBn2XnnnwPsRlYut1tQCvwlZuy4
e3uGrwQEohLxnps0daMwU1IzJSmtM9itcApH9SKtHfy79UWuXWbuigA4mxFmXEQB
AIe8G9CXNpM=
=MmR4
-----END PGP SIGNATURE-----

--=-pkLsUp5uyLa/Ger4Wu2y--
