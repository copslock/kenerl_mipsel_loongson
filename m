Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 21:28:41 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:58353 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007134AbbEYT2jZayi- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 21:28:39 +0200
Received: from dab-ntm1-h-25-4.dab.02.net ([82.132.229.168] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1Ywy3E-0001Lb-Fp; Mon, 25 May 2015 20:28:41 +0100
Received: from ben by deadeye with local (Exim 4.85)
        (envelope-from <ben@decadent.org.uk>)
        id 1Ywy2k-0001ev-HE; Mon, 25 May 2015 20:28:10 +0100
Message-ID: <1432582079.12412.135.camel@decadent.org.uk>
Subject: [PATCH v2] MIPS: Octeon: Set OHCI and EHCI MMIO byte order to match
 CPU
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Paul Martin <paul.martin@codethink.co.uk>
Date:   Mon, 25 May 2015 20:27:59 +0100
In-Reply-To: <1432580495.12412.126.camel@decadent.org.uk>
References: <1432580495.12412.126.camel@decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-r+tARUa2xs820qXt7wN9"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 82.132.229.168
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47659
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


--=-r+tARUa2xs820qXt7wN9
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


--=-r+tARUa2xs820qXt7wN9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVWN3yue/yOyVhhEJAQrOgQ/+KDwbb9kQVsKDZSLnib2mLthsTUbdSzRN
1+/TDVj7Fqua3BMPKkiLYuuHxypHjgBkfhX6uoUNFdzeGv985AXpfOBIxZ5Cywum
8wRpJAKNLyWKO1CKDId23m4xGv1BRx7pY2JYCjc6Qkfk6M3x4L5cy/JTjBAC7kF/
X51/R53z1ITPTTogNpFcXc0A/SdE3q4OCgmPCe7sHkOu1AJGINsgcuY3XMbu3JSU
Rk0Fq+YgpKyHw0mK+0NtZKLCmoWDzZKjU6fbUlecRdZgZVtUyV0LYnrAhjvw45+G
PfRKFDTWjXFBBhlrhC++Yr7HTFiy5PwJPW10yweqqPqnd7HKRzhLFR+6v7RAeWNl
XooZ6bJBMWbKjW6tidIDWOV5bgKqJpn5chS5FXEyGAhEivHhAnH9oRPk/PQOdAFg
TPK9HsSZLqUlnK/VJ7uaTR0brxgXVPhrgDJFOs79iWURFYH/RNdEWRg+jy945c8h
bNLGtJYCuXZurrc7YrbGCFavSRYg36N27Vf4UTUepyDQVK4cHSNqh6rixzL+/f8J
SJM55CN4q59KXZaEZXaefv4pd2LVxoZjhRls41XueiZHSSuCsyuR75J8R/DfMjnz
iM3L6RTK4bpeFivXWlfWY52ZUK6v2oh3Qdke5isFLw6TBYxkAUDiD2eBZa6Ts8Fa
nJbO0Bcsg2U=
=Zpi7
-----END PGP SIGNATURE-----

--=-r+tARUa2xs820qXt7wN9--
