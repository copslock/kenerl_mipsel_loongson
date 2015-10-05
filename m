Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 01:57:09 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43971 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008072AbbJEX5IRGh9V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Oct 2015 01:57:08 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.247] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZjFcw-00080y-83; Tue, 06 Oct 2015 00:57:06 +0100
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZjFcr-0000zL-4c; Tue, 06 Oct 2015 00:57:01 +0100
Message-ID: <1444089416.2956.2.camel@decadent.org.uk>
Subject: [PATCH] MIPS: io: Define ioremap_uc
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Date:   Tue, 06 Oct 2015 00:56:56 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ThEYXMY18K1S3Z/7Gvn8"
X-Mailer: Evolution 3.16.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.247
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49443
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


--=-ThEYXMY18K1S3Z/7Gvn8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

All architectures must now define ioremap_uc(), but MIPS currently
only has ioremap_nocache().

Fixes: 4c73e8926623 ("arch/*/io.h: Add ioremap_uc() to all architectures")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
---
 arch/mips/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 9e777cd..d10fd80 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -256,6 +256,7 @@ static inline void __iomem * __ioremap_mode(phys_addr_t=
 offset, unsigned long si
  */
 #define ioremap_nocache(offset, size)					\
 	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
+#define ioremap_uc ioremap_nocache
=20
 /*
  * ioremap_cachable -	map bus memory into CPU space
--=20
Ben Hutchings
All the simple programs have been written, and all the good names taken.
--=-ThEYXMY18K1S3Z/7Gvn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVhMOSOe/yOyVhhEJAQpxSRAAwxAsLP+1rP/dlAfxbaTUdpdUmfvSawaO
67nLr9ZX/qEkGKM9X04rqtKt9lld4Xr82JK78cQmA4s5iJS/AeHayBgtMxh/yEQ1
pZWmAO75hcHZCDLXJQ893i2PxSTSdrjx3NBxri4QTrUoTX9aklqM5cyoHrHln8vN
Bq3zReKiRK+xC8HnWp75F4ifF8zBm16ouwyDIoFUrFkeoqfIhc4TFSRI/QXWX1VZ
PymN/vURtAYmwaWpM0SbDOh7UeDlXDl6nLVEghnVYEm2KHIv+E3LPl4xgnZZFZsb
OGb4mn8k1+rF4euCwTPz7nirlJXxMNzwbh6JVlJz4fxjpz9hDrjJMEBjyiy55N7Q
3yVM4HHC8Mi+foTXNZgcz14pSipNkF/CsKfYVu/sIC77oRaiNPVnj42H7u8wuKEE
950g5qsrBI8Kw+hfvrwu5bNGoAT2qNwvo8Zq54ngvt5twH27EivwjEtJG7XkNN6a
kzpoZEpStIygK9CX11/HJmjDF6vJ30lM1X2Qr6ePU+lWDvBPtX79OITP6sRsNtzB
ReTD5a8vAZD18MK2orMiY1gmjI9C/aMnTaW00C3LgJeyFLd/t8D2ytDmfC78E9DX
KfE3ez0j5Nf0XbdSGma01wNDeujx2J7llIJkZM2+aGdLZm5zPpxZAIYBkgXrsCmE
2/LPe20UCMA=
=csyk
-----END PGP SIGNATURE-----

--=-ThEYXMY18K1S3Z/7Gvn8--
