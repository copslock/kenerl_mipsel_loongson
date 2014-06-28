Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 22:34:34 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:38857 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817913AbaF1Uec25sST (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 22:34:32 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 977315A7097;
        Sat, 28 Jun 2014 23:34:26 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id klOohrcizO5b; Sat, 28 Jun 2014 23:34:20 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 0FC905BC005;
        Sat, 28 Jun 2014 23:34:25 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/3] MIPS: OCTEON: Minimal support for D-Link DSR-1000N
Date:   Sat, 28 Jun 2014 23:34:07 +0300
Message-Id: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40906
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

The following patches add minimal support for D-Link DSR-1000N router.
USB and ethernet ports should now work with these patches.
(I guess WLAN (PCI/ath9k) should work too; I was able to scan networks,
but for some reason it did not connect to my AP.)

Aaro Koskinen (3):
  MIPS: OCTEON: cvmx-bootinfo: add D-Link DSR-1000N
  MIPS: OCTEON: add USB clock type for D-Link DSR-1000N
  MIPS: OCTEON: add interface & port definitions for D-Link DSR-1000N

 .../cavium-octeon/executive/cvmx-helper-board.c    | 22 ++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       |  2 ++
 2 files changed, 24 insertions(+)

-- 
2.0.0
