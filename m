Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 21:28:16 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:58345 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007130AbbEYT2OmQieQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 21:28:14 +0200
Received: from dab-ntm1-h-25-4.dab.02.net ([82.132.229.168] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1Ywy2k-0001LT-3q; Mon, 25 May 2015 20:28:16 +0100
Received: from ben by deadeye with local (Exim 4.85)
        (envelope-from <ben@decadent.org.uk>)
        id 1Ywy29-0001eU-Sj; Mon, 25 May 2015 20:27:33 +0100
Message-ID: <1432582049.12412.134.camel@decadent.org.uk>
Subject: [PATCH v2] MIPS: Octeon: Set OHCI and EHCI MMIO byte order to match
 CPU
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Paul Martin <paul.martin@codethink.co.uk>
Date:   Mon, 25 May 2015 20:27:29 +0100
In-Reply-To: <1432580495.12412.126.camel@decadent.org.uk>
References: <1432580495.12412.126.camel@decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-BOqKBh7ObvItzJitGivm"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 82.132.229.168
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47658
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


--=-BOqKBh7ObvItzJitGivm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The Octeon OHCI is now supported by the ohci-platform driver, and
USB_OCTEON_OHCI is marked as deprecated.  However, it is currently
still necessary to enable it in order to select
USB_OHCI_BIG_ENDIAN_MMIO.  Make CPU_CAVIUM_OCTEON select that as well,
so that USB_OCTEON_OHCI is really obsolete.

The old ohci-octeon and ehci-octeon drivers also only enabled big-endian
MMIO in case the CPU was big-endian.  Make the selections of
USB_EHCI_BIG_ENDIAN_MMIO and USB_OHCI_BIG_ENDIAN_MMIO conditional, to
match this.

Fixes: 2193dda5eec6 ("USB: host: Remove ehci-octeon and ohci-octeon drivers=
")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
v2: Make selections conditional

This is also untested; I'm just comparing the old and new code.

Ben.

 arch/mips/Kconfig        | 4 ++--
 drivers/usb/host/Kconfig | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d5c81b4..4b43459 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1568,7 +1568,8 @@ config CPU_CAVIUM_OCTEON
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
-	select USB_EHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select MIPS_L1_CACHE_SHIFT_7
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -295,7 +295,7 @@ config USB_OCTEON_EHCI
 	bool "Octeon on-chip EHCI support (DEPRECATED)"
 	depends on CAVIUM_OCTEON_SOC
 	default n
-	select USB_EHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USB_EHCI_HCD_PLATFORM
 	help
 	  This option is deprecated now and the driver was removed, use
@@ -568,7 +568,7 @@ config USB_OCTEON_OHCI
 	bool "Octeon on-chip OHCI support (DEPRECATED)"
 	depends on CAVIUM_OCTEON_SOC
 	default USB_OCTEON_EHCI
-	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USB_OHCI_LITTLE_ENDIAN
 	select USB_OHCI_HCD_PLATFORM
 	help

--=20
Ben Hutchings
Design a system any fool can use, and only a fool will want to use it.


--=-BOqKBh7ObvItzJitGivm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVWN3pee/yOyVhhEJAQoM9xAAubQYHgj0qqLW/QZblk66+ZJDohnGWhyh
KTY3jQlwmIoBf2tLa2wZFSrg9Qgza9AG10wssu6MuTO1ot8NW/wn+Ob8RvPpUy0V
ZQAKz7MwEhl3IXhQKGQymyBt5+9hBLh179qFcF0tjnjR4LuD7kWeNliKYcnbL4KI
Tz+Yv5PzQLHaJYK7c2Tzbh8Up3muXDyGuW6hxJMkt9W0ccGhS3TEajte0yehW5C6
zbknqEyB9yzFFeStygu+aneJ8hP6ud9SDQLqnsmzo1mu75t4ig0oloTrad6RlYYM
stbJuNiu2Gisb80AUbhUFMlnGZA+aYtbDJlPoOEw0auf/eXYw2kTyF18s9L9iHyE
ATT9K//Rfst1itP6LFx9o27OZMvpzYABWLUbp6hCoQiGtp9FpiZTHbZxcEds2bi+
9Ra1uj3BUKf/yFrUaDRbyVRDR8Asr6GHgqOM/Noo6bqgU84xjNa7+Y5t9bbRdH/C
HSaCajXNOr/fBPvwl2uw6pZXjXEAJ7Vk34OobM/5SGQF/fEb7QsTeM6Yu9fw9Vog
ubfl+3tlqMleoaXmVoC3UMZu+xcs1thoFuoPKYyvCk12T0F+z0Wahy0ggakw1rcm
hbQeL7o7yaEoBbrO+Py+YY+My9KSEvtT0MSQ97EWYmzjc4Cdy/ceV0L91qKjvywt
XVX4FGq3Xgg=
=ggQR
-----END PGP SIGNATURE-----

--=-BOqKBh7ObvItzJitGivm--
