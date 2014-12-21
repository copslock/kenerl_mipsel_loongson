Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2014 21:54:16 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:43328 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009368AbaLUUyOe5kT2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2014 21:54:14 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 0EE8919BD0A;
        Sun, 21 Dec 2014 22:54:14 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 88WCimSQ3+xr; Sun, 21 Dec 2014 22:54:07 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 66BA45BC006;
        Sun, 21 Dec 2014 22:54:07 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/5] MIPS/crypto: MD5 for OCTEON
Date:   Sun, 21 Dec 2014 22:53:57 +0200
Message-Id: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44879
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

This adds accelerated MD5 cryptoapi module for OCTEON.

Tested with 3.19-rc1 on EdgeRouter Lite (OCTEON+) and EdgeRouter Pro
(OCTEON2) by running selftest, tcrypt and also by sending TCP MD5SIG
traffic between OCTEON <-> X86 box.

Below figures show the improvement on ER Lite compared to md5-generic
(calculated from output of tcrypt mode=402).

test  0 (   16 byte blocks,   16 bytes per update,   1 updates): 1.20x faster
test  1 (   64 byte blocks,   16 bytes per update,   4 updates): 1.17x faster
test  2 (   64 byte blocks,   64 bytes per update,   1 updates): 1.30x faster
test  3 (  256 byte blocks,   16 bytes per update,  16 updates): 1.14x faster
test  4 (  256 byte blocks,   64 bytes per update,   4 updates): 1.29x faster
test  5 (  256 byte blocks,  256 bytes per update,   1 updates): 1.84x faster
test  6 ( 1024 byte blocks,   16 bytes per update,  64 updates): 1.13x faster
test  7 ( 1024 byte blocks,  256 bytes per update,   4 updates): 2.01x faster
test  8 ( 1024 byte blocks, 1024 bytes per update,   1 updates): 2.49x faster
test  9 ( 2048 byte blocks,   16 bytes per update, 128 updates): 1.13x faster
test 10 ( 2048 byte blocks,  256 bytes per update,   8 updates): 2.05x faster
test 11 ( 2048 byte blocks, 1024 bytes per update,   2 updates): 2.57x faster
test 12 ( 2048 byte blocks, 2048 bytes per update,   1 updates): 2.71x faster
test 13 ( 4096 byte blocks,   16 bytes per update, 256 updates): 1.15x faster
test 14 ( 4096 byte blocks,  256 bytes per update,  16 updates): 2.08x faster
test 15 ( 4096 byte blocks, 1024 bytes per update,   4 updates): 2.63x faster
test 16 ( 4096 byte blocks, 4096 bytes per update,   1 updates): 2.83x faster
test 17 ( 8192 byte blocks,   16 bytes per update, 512 updates): 1.13x faster
test 18 ( 8192 byte blocks,  256 bytes per update,  32 updates): 2.09x faster
test 19 ( 8192 byte blocks, 1024 bytes per update,   8 updates): 2.66x faster
test 20 ( 8192 byte blocks, 4096 bytes per update,   2 updates): 2.87x faster
test 21 ( 8192 byte blocks, 8192 bytes per update,   1 updates): 2.87x faster

A.

Aaro Koskinen (5):
  MIPS: OCTEON: add crypto helper functions
  MIPS: OCTEON: crypto: add instruction definitions for MD5
  MIPS: OCTEON: reintroduce crypto features check
  MIPS: OCTEON: crypto: add MD5 module
  crypto: enable OCTEON MD5 module selection

 arch/mips/cavium-octeon/Makefile                 |   1 +
 arch/mips/cavium-octeon/crypto/Makefile          |   7 +
 arch/mips/cavium-octeon/crypto/octeon-crypto.c   |  66 +++++++
 arch/mips/cavium-octeon/crypto/octeon-crypto.h   |  75 ++++++++
 arch/mips/cavium-octeon/crypto/octeon-md5.c      | 216 +++++++++++++++++++++++
 arch/mips/cavium-octeon/executive/octeon-model.c |   6 +
 arch/mips/include/asm/octeon/octeon-feature.h    |  17 +-
 arch/mips/include/asm/octeon/octeon.h            |   5 -
 crypto/Kconfig                                   |   9 +
 9 files changed, 395 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/crypto/Makefile
 create mode 100644 arch/mips/cavium-octeon/crypto/octeon-crypto.c
 create mode 100644 arch/mips/cavium-octeon/crypto/octeon-crypto.h
 create mode 100644 arch/mips/cavium-octeon/crypto/octeon-md5.c

-- 
2.2.0
