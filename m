Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2014 23:12:04 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49979 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6870567AbaAHWMAm9Gh3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jan 2014 23:12:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 5148256FA3E;
        Thu,  9 Jan 2014 00:11:58 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id OHKEte-80OV8; Thu,  9 Jan 2014 00:11:54 +0200 (EET)
Received: from blackmetal.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 2A52D5BC014;
        Thu,  9 Jan 2014 00:11:54 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/2] Linux 3.13: Fix MIPS/loongson2 regression
Date:   Thu,  9 Jan 2014 00:11:17 +0200
Message-Id: <1389219079-6133-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.5.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38908
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

Hello,

During the 3.13 merge window, MIPS/loongson2 support got badly broken:
none of the boards are booting at all. The following patches fixes it.
Since the MIPS maintainer has been away during the whole -rc cycle,
I'm sending these patches directly to you.

MIPS patchwork links to the patches:
	http://patchwork.linux-mips.org/patch/6176/
	http://patchwork.linux-mips.org/patch/6175/

Please consider including these fixes to 3.13 release, thanks.

A.

Aaro Koskinen (1):
  MIPS: fix blast_icache32 on loongson2

Huacai Chen (1):
  MIPS: Fix case mismatch in local_r4k_flush_icache_range()

 arch/mips/include/asm/cacheops.h |  2 +-
 arch/mips/include/asm/r4kcache.h | 51 ++++++++++++++++++++--------------------
 arch/mips/mm/c-r4k.c             | 11 +++++++--
 3 files changed, 36 insertions(+), 28 deletions(-)

-- 
1.8.5.2
