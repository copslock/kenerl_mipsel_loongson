Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2015 21:08:17 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:33433 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008366AbbCHUH6r9wtM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Mar 2015 21:07:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 54F3521B74A;
        Sun,  8 Mar 2015 22:07:58 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id by-TuZP-h2kg; Sun,  8 Mar 2015 22:07:53 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 561EB5BC012;
        Sun,  8 Mar 2015 22:07:53 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/7] crypto: OCTEON MD5 bugfix + SHA modules
Date:   Sun,  8 Mar 2015 22:07:40 +0200
Message-Id: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46270
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

Hi,

The first patch is a bug fix for OCTEON MD5 aimed for 4.0-rc cycle.

The remaining patches add SHA1/SHA256/SHA512 modules. I have tested
these on the following OCTEON boards and CPUs with 4.0-rc2:

	D-Link DSR-1000N:	CN5010p1.1-500-SCP
	EdgeRouter Lite:	CN5020p1.1-500-SCP
	EdgeRouter Pro:		CN6120p1.1-1000-NSP

All selftests are passing. With tcrypt, I get the following numbers
on speed compared to the generic modules:

	SHA1:

test  0 (   16 byte blocks,   16 bytes per update,   1 updates): 1.25x faster
test  1 (   64 byte blocks,   16 bytes per update,   4 updates): 1.20x faster
test  2 (   64 byte blocks,   64 bytes per update,   1 updates): 1.47x faster
test  3 (  256 byte blocks,   16 bytes per update,  16 updates): 1.15x faster
test  4 (  256 byte blocks,   64 bytes per update,   4 updates): 1.56x faster
test  5 (  256 byte blocks,  256 bytes per update,   1 updates): 2.27x faster
test  6 ( 1024 byte blocks,   16 bytes per update,  64 updates): 1.13x faster
test  7 ( 1024 byte blocks,  256 bytes per update,   4 updates): 2.74x faster
test  8 ( 1024 byte blocks, 1024 bytes per update,   1 updates): 3.60x faster
test  9 ( 2048 byte blocks,   16 bytes per update, 128 updates): 1.13x faster
test 10 ( 2048 byte blocks,  256 bytes per update,   8 updates): 2.87x faster
test 11 ( 2048 byte blocks, 1024 bytes per update,   2 updates): 3.90x faster
test 12 ( 2048 byte blocks, 2048 bytes per update,   1 updates): 4.18x faster
test 13 ( 4096 byte blocks,   16 bytes per update, 256 updates): 1.13x faster
test 14 ( 4096 byte blocks,  256 bytes per update,  16 updates): 2.95x faster
test 15 ( 4096 byte blocks, 1024 bytes per update,   4 updates): 4.09x faster
test 16 ( 4096 byte blocks, 4096 bytes per update,   1 updates): 4.57x faster
test 17 ( 8192 byte blocks,   16 bytes per update, 512 updates): 1.13x faster
test 18 ( 8192 byte blocks,  256 bytes per update,  32 updates): 2.99x faster
test 19 ( 8192 byte blocks, 1024 bytes per update,   8 updates): 4.20x faster
test 20 ( 8192 byte blocks, 4096 bytes per update,   2 updates): 4.72x faster
test 21 ( 8192 byte blocks, 8192 bytes per update,   1 updates): 4.73x faster

	SHA256:

test  0 (   16 byte blocks,   16 bytes per update,   1 updates): 2.72x faster
test  1 (   64 byte blocks,   16 bytes per update,   4 updates): 2.45x faster
test  2 (   64 byte blocks,   64 bytes per update,   1 updates): 3.65x faster
test  3 (  256 byte blocks,   16 bytes per update,  16 updates): 2.18x faster
test  4 (  256 byte blocks,   64 bytes per update,   4 updates): 3.74x faster
test  5 (  256 byte blocks,  256 bytes per update,   1 updates): 5.72x faster
test  6 ( 1024 byte blocks,   16 bytes per update,  64 updates): 2.08x faster
test  7 ( 1024 byte blocks,  256 bytes per update,   4 updates): 6.54x faster
test  8 ( 1024 byte blocks, 1024 bytes per update,   1 updates): 8.19x faster
test  9 ( 2048 byte blocks,   16 bytes per update, 128 updates): 2.06x faster
test 10 ( 2048 byte blocks,  256 bytes per update,   8 updates): 6.77x faster
test 11 ( 2048 byte blocks, 1024 bytes per update,   2 updates): 8.56x faster
test 12 ( 2048 byte blocks, 2048 bytes per update,   1 updates): 9.01x faster
test 13 ( 4096 byte blocks,   16 bytes per update, 256 updates): 2.05x faster
test 14 ( 4096 byte blocks,  256 bytes per update,  16 updates): 6.89x faster
test 15 ( 4096 byte blocks, 1024 bytes per update,   4 updates): 8.82x faster
test 16 ( 4096 byte blocks, 4096 bytes per update,   1 updates): 9.50x faster
test 17 ( 8192 byte blocks,   16 bytes per update, 512 updates): 2.04x faster
test 18 ( 8192 byte blocks,  256 bytes per update,  32 updates): 6.96x faster
test 19 ( 8192 byte blocks, 1024 bytes per update,   8 updates): 8.95x faster
test 20 ( 8192 byte blocks, 4096 bytes per update,   2 updates): 9.66x faster
test 21 ( 8192 byte blocks, 8192 bytes per update,   1 updates): 9.67x faster

	SHA512:

test  0 (   16 byte blocks,   16 bytes per update,   1 updates): 3.19x faster
test  1 (   64 byte blocks,   16 bytes per update,   4 updates): 2.18x faster
test  2 (   64 byte blocks,   64 bytes per update,   1 updates): 3.19x faster
test  3 (  256 byte blocks,   16 bytes per update,  16 updates): 2.12x faster
test  4 (  256 byte blocks,   64 bytes per update,   4 updates): 3.54x faster
test  5 (  256 byte blocks,  256 bytes per update,   1 updates): 5.16x faster
test  6 ( 1024 byte blocks,   16 bytes per update,  64 updates): 1.92x faster
test  7 ( 1024 byte blocks,  256 bytes per update,   4 updates): 5.80x faster
test  8 ( 1024 byte blocks, 1024 bytes per update,   1 updates): 8.07x faster
test  9 ( 2048 byte blocks,   16 bytes per update, 128 updates): 1.88x faster
test 10 ( 2048 byte blocks,  256 bytes per update,   8 updates): 6.00x faster
test 11 ( 2048 byte blocks, 1024 bytes per update,   2 updates): 8.64x faster
test 12 ( 2048 byte blocks, 2048 bytes per update,   1 updates): 9.40x faster
test 13 ( 4096 byte blocks,   16 bytes per update, 256 updates): 1.86x faster
test 14 ( 4096 byte blocks,  256 bytes per update,  16 updates): 6.12x faster
test 15 ( 4096 byte blocks, 1024 bytes per update,   4 updates): 9.03x faster
test 16 ( 4096 byte blocks, 4096 bytes per update,   1 updates): 10.31x faster
test 17 ( 8192 byte blocks,   16 bytes per update, 512 updates): 1.85x faster
test 18 ( 8192 byte blocks,  256 bytes per update,  32 updates): 6.18x faster
test 19 ( 8192 byte blocks, 1024 bytes per update,   8 updates): 9.26x faster
test 20 ( 8192 byte blocks, 4096 bytes per update,   2 updates): 10.64x faster
test 21 ( 8192 byte blocks, 8192 bytes per update,   1 updates): 10.65x faster

A.

Aaro Koskinen (7):
  crypto: octeon - don't disable bottom half in octeon-md5
  crypto: octeon - always disable preemption when using crypto engine
  crypto: octeon - add instruction definitions for SHA1/256/512
  crypto: octeon - add SHA1 module
  crypto: octeon - add SHA256 module
  crypto: octeon - add SHA512 module
  crypto: octeon - enable OCTEON SHA1/256/512 module selection

 arch/mips/cavium-octeon/crypto/Makefile        |   5 +-
 arch/mips/cavium-octeon/crypto/octeon-crypto.c |   4 +-
 arch/mips/cavium-octeon/crypto/octeon-crypto.h |  83 +++++++-
 arch/mips/cavium-octeon/crypto/octeon-md5.c    |   8 -
 arch/mips/cavium-octeon/crypto/octeon-sha1.c   | 241 +++++++++++++++++++++
 arch/mips/cavium-octeon/crypto/octeon-sha256.c | 280 +++++++++++++++++++++++++
 arch/mips/cavium-octeon/crypto/octeon-sha512.c | 277 ++++++++++++++++++++++++
 crypto/Kconfig                                 |  27 +++
 8 files changed, 911 insertions(+), 14 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/crypto/octeon-sha1.c
 create mode 100644 arch/mips/cavium-octeon/crypto/octeon-sha256.c
 create mode 100644 arch/mips/cavium-octeon/crypto/octeon-sha512.c

-- 
2.2.0
