Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 21:02:13 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:58276 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007130AbbEYTCMeVsWl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 21:02:12 +0200
Received: from dab-rcn1-h-82-6.dab.02.net ([82.132.246.147] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1Ywxdb-00007I-96; Mon, 25 May 2015 20:02:13 +0100
Received: from ben by deadeye with local (Exim 4.85)
        (envelope-from <ben@decadent.org.uk>)
        id 1Ywxd8-0001Qd-VC; Mon, 25 May 2015 20:01:42 +0100
Message-ID: <1432580495.12412.126.camel@decadent.org.uk>
Subject: [PATCH] MIPS: Octeon: Select USB_OHCI_BIG_ENDIAN_MMIO
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>
Date:   Mon, 25 May 2015 20:01:35 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-dnvzXWEMkQnGjZ4WkIRV"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 82.132.246.147
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47657
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


--=-dnvzXWEMkQnGjZ4WkIRV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The Octeon OHCI is now supported by the ohci-platform driver, and
USB_OCTEON_OHCI is marked as deprecated.  However, it is currently
still necessary to enable it in order to select
USB_OHCI_BIG_ENDIAN_MMIO.  Make CPU_CAVIUM_OCTEON select that as well,
so that USB_OCTEON_OHCI is really obsolete.

Fixes: 2193dda5eec6 ("USB: host: Remove ehci-octeon and ohci-octeon drivers=
")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
This is untested, aside from comparing the resulting config files.

Ben.

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f501665..d5c81b4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1569,6 +1569,7 @@ config CPU_CAVIUM_OCTEON
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select USB_OHCI_BIG_ENDIAN_MMIO
 	select MIPS_L1_CACHE_SHIFT_7
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing

--=20
Ben Hutchings
Design a system any fool can use, and only a fool will want to use it.

--=-dnvzXWEMkQnGjZ4WkIRV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVWNxlue/yOyVhhEJAQpo5w//RUvBPxpioUrUVnd6G7oHVUrS570k2zEt
ZQB+SsG0pv6xOx+jEvClECRiShExZ+YH2Id1/Y78UuMCWZ6M9JeNsK34FZPevbRO
hH/l02soJazNMEUjlCTD7PeObfiadWM9z5BIQwI9MQYGlHN4Rn2ZZ+WAMjFs1Ds6
0i9l4RxZZhSPcs8YjaW2hx/GCIGWrW742ghIE0aAQAYjCIRezHnCa7vAJAYi49hu
DVmL7tQryefpYJ3f5cIjuLaZNcCPMXSR/mRwu502dovQZz4rywobFDT3tY4QgTiM
3NLZ8yMgTuhel4ms2SPcAmK2+vauu6aLWIR4PABepkMfz3psSu7w3q7Ql1+GpZQc
Gy2wD04nXTZIAhTDuKdd4aP7o40LWrFnrGIp9B80a2OPXOpZUP6uW9z1sFBiHErc
1QAXP6Y7NFLsfW5lRyYo/Donr4KL83+p7nuThwSk7Iv77RH0xFMk2v2q7gEeKRDQ
IoQsUIK9/MkSkghueD9RV8e2wE9JWXn/TL3vFB7W2neFJzQoSuHA0/ihTYg2a96M
/6aoL08olEqmJg7NsXWD/N3qh8pr+4GsiScbFX48hcVMHRbgpuyGXbZ17QKa64L8
Bo6ZA5RQ5JYgEaKRQ0zFGSj1CreIsS/LTBnsAHABJY1oF7JzUl4GpfcrpHANEctn
rJ7pGYun0qQ=
=xMun
-----END PGP SIGNATURE-----

--=-dnvzXWEMkQnGjZ4WkIRV--
