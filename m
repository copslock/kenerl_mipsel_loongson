Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2014 21:55:25 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:41031 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009472AbaLUUyQilv0p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2014 21:54:16 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 718D25A6DDE;
        Sun, 21 Dec 2014 22:54:07 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id oHAEdT66TDHs; Sun, 21 Dec 2014 22:54:00 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 0D50B5BC00D;
        Sun, 21 Dec 2014 22:54:08 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 5/5] crypto: enable OCTEON MD5 module selection
Date:   Sun, 21 Dec 2014 22:54:02 +0200
Message-Id: <1419195242-546-6-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
References: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Enable user to select OCTEON MD5 module.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 crypto/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 87bbc9c..1618468 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -427,6 +427,15 @@ config CRYPTO_MD5
 	help
 	  MD5 message digest algorithm (RFC1321).
 
+config CRYPTO_MD5_OCTEON
+	tristate "MD5 digest algorithm (OCTEON)"
+	depends on CPU_CAVIUM_OCTEON
+	select CRYPTO_MD5
+	select CRYPTO_HASH
+	help
+	  MD5 message digest algorithm (RFC1321) implemented
+	  using OCTEON crypto instructions, when available.
+
 config CRYPTO_MD5_SPARC64
 	tristate "MD5 digest algorithm (SPARC64)"
 	depends on SPARC64
-- 
2.2.0
