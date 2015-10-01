Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Oct 2015 02:52:37 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47893 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009320AbbJAAwfsintg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Oct 2015 02:52:35 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.247] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZhS6s-0000t6-EK; Thu, 01 Oct 2015 01:52:34 +0100
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZhS6n-0003BT-Ak; Thu, 01 Oct 2015 01:52:29 +0100
Message-ID: <1443660744.2730.19.camel@decadent.org.uk>
Subject: [PATCH RESEND] MIPS: BPF: Disable JIT on R3000 (MIPS-I)
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Date:   Thu, 01 Oct 2015 01:52:24 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-q85VFV3otLtbf1KW0LHx"
X-Mailer: Evolution 3.16.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.247
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49408
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


--=-q85VFV3otLtbf1KW0LHx
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
Knowledge is power.  France is bacon.

--=-q85VFV3otLtbf1KW0LHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVgyDyOe/yOyVhhEJAQrO2g//e9XaSoiwmSQIv0GTnsID/X1Pkabj+POA
Q1EGHRdR0b8fj9WjTSbuwMnieNJ8KgaKDl/NMrxzMsL68s2f6vzUUb31HwJfAmk5
ZkfrmXR1qNA2Xpfx/CZL8prLf2mZIzhRuArei/p6SQrRoErDKtf1HdEbURlZQI9l
TLpUtYmX+Omb1hJRw7wpIox3RmJm6wKOKV3jW12OyOeBOawsLHhgz0xaoYyQS4mN
dtKdGzLcozDbCtfsQ7mphPIfI1nJV5MS9vQc3XaRueNaVrvGsgeRcA3ebZy26zoF
ydT16lKnt/tEPoxkd1Crd4IsreyqUwQca3HT25KZPZJ+QPCIk4n83qcrZmDFQk08
j/fEFD1dNk1g8ALBxzS6wDT3gdxXWMlbPA1xZmmUhxd9oTJ5E48sMnVmMdrCd4rQ
TxiFrji8YYbGsBB4S1XuMmCwPoy5fenzgce5RrizLL8JlET321GGYosOHswsA1gx
VM/KmfYUXhxmardb/hUETGwAmfCOENj6O1cOHPYellX70t72kpF02cdy1ICXPr1R
6Joz1tAvlP345aXSGC+Qv/xXxR2M1kamAPg6fYllxOHU0eXqY6V2tXlvLx48crvZ
gFvEgyxebXz5ZXJ+2KonNoUZm7FzEjOAnztDS0eHed6ht89tSxrAISP7PlEsS0ER
NBnuOK6Ni/Y=
=rPpP
-----END PGP SIGNATURE-----

--=-q85VFV3otLtbf1KW0LHx--
