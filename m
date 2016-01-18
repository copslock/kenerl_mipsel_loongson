Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 17:53:52 +0100 (CET)
Received: from bues.ch ([80.190.117.144]:56476 "EHLO bues.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010552AbcARQxsbWDpT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jan 2016 17:53:48 +0100
Received: by bues.ch with esmtpsa (Exim 4.80)
        (envelope-from <m@bues.ch>)
        id 1aLD3i-0007Qo-NK; Mon, 18 Jan 2016 17:53:38 +0100
Date:   Mon, 18 Jan 2016 17:53:03 +0100
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips\@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Subject: ssb: Set linux-wireless as MAINTAINERS list
Message-ID: <20160118175303.19164539@wiggum>
In-Reply-To: <87y4bn5m4q.fsf@kamboji.qca.qualcomm.com>
References: <8128014.DbbgBtKY3z@wuerfel>
 <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
 <4037550.DMaVTE01Aq@wuerfel>
 <87bn8l7miw.fsf@kamboji.qca.qualcomm.com>
 <CACna6ryvDFHqwJ3ExURcyFT2ZaT9fS9v36wCnJfze5BLnE88og@mail.gmail.com>
 <87y4bn5m4q.fsf@kamboji.qca.qualcomm.com>
X-Mailer: Claws Mail 3.13.1 (GTK+ 2.24.29; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/W9FSX.bWK4dE3/AP7ZDba/G"; protocol="application/pgp-signature"
Return-Path: <m@bues.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m@bues.ch
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

--Sig_/W9FSX.bWK4dE3/AP7ZDba/G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

ssb patches go through the linux-wireless tree.
Set the list to linux-wireless, so linux-wireless patchwork can catch the p=
atches.

Signed-off-by: Michael Buesch <m@bues.ch>

---

Index: linux/MAINTAINERS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/MAINTAINERS
+++ linux/MAINTAINERS
@@ -10036,7 +10036,7 @@ F:	drivers/net/ethernet/natsemi/sonic.*
=20
 SONICS SILICON BACKPLANE DRIVER (SSB)
 M:	Michael Buesch <m@bues.ch>
-L:	netdev@vger.kernel.org
+L:	linux-wireless@vger.kernel.org
 S:	Maintained
 F:	drivers/ssb/
 F:	include/linux/ssb/


--=20
Michael

--Sig_/W9FSX.bWK4dE3/AP7ZDba/G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnRhvAAoJEPUyvh2QjYsOPYMP+wVU8Zgs2cPYZAxBjr/7/ZKX
7/S5jsyNck3aQRMfwW9l2od0ZC1zwkSCRZLNzwtbWlXTdsc5ti/5xY8b1BG8AMai
jvuwrpQFJTP3pDBfITcfHy1TOCRAp9WlZYftbz5AsnweHe3c9pGZVSEi5kdRXQrt
5UlcViNaQ2Xj6mcbvSHGL78lvspgUGikjztlKq2FDfeYn++iyr71x9cSBfbNkB3v
ZKa3bFPAaNR2/0gY9xVKE6pcHBroGUB6RxuLoXXp2rCX6XpTtI6hq0ITFUcyEwuQ
MQqFqh67iB3prN6hRHX+dJl2VsuruyAZpgPCOVDysF0xThHdEZFDTlAgPmpdnju9
wRb6hKiQkjvjzYAHAxo6YepAOIXHEhaPqnPs8u2hxVCZk8mM4dOMGp5ZNdsmQi8q
F/Dd9MbYYDpgy/1y65dCPTz0KRq0UzzUdu85MSOk/SQ3ZxA5vlYs8t8IKeIM7x+A
9QDwtlcNjnqzJ8qgd/rweC/Pty8m3Tg6wzIXYeDs8lty7VygC2MZ5cggCUHMdap1
urBEE09Vz9aK8/q+SvMGis//flrjcodlhrmQPZkJ5x5I+pACf0n/t5JMrRWkw49n
EF1djRh9+YHd0KdsuYU336RgW00GV2FWUepPGeKVuQH9Z+cGKriakXeTDkpsnm+w
Nf2mv0KxPsLC53wdZlyN
=OMM2
-----END PGP SIGNATURE-----

--Sig_/W9FSX.bWK4dE3/AP7ZDba/G--
