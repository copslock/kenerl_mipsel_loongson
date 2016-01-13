Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2016 23:52:34 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:49945 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010858AbcAMWwcg6v1j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jan 2016 23:52:32 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0LodXq-1ZhOdE1S94-00gZnP; Wed, 13 Jan
 2016 23:51:46 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, Michael Buesch <m@bues.ch>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ssb: host_soc depends on sprom
Date:   Wed, 13 Jan 2016 23:51:43 +0100
Message-ID: <8128014.DbbgBtKY3z@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:qf3MfOAjxyTMT+zbPmgOFoj6CnQXJVnKFJj8MM2r7T0XFz5sSkl
 Hbs8mgoDbEjNAh36lhSc/YRJmMhN4X1xMUpfQvo0VHEa9ztYw2oqCRpdDVqFo4qAO+3drQI
 ZfYeeCcID/RpeEs1NHcG1thWy9kcRKpDrnG3Mnxu7f+yRwcGAAFEhmNXH1ubp94qdiAfJ/K
 xBHi5BvzVjyAdc9CE2ziA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:99gYFoNzJ9k=:WoH8pasRVrCiCgxcGd9crr
 njCHP9wAEgXpZkLt3yLnDnzby9Lm0afd01hX2+F4gfAzq1H7zbTpUpGtOtfv99u0xjdQn1Ld7
 tjlh2ZHZ7EnaOmuoE6xGMOYBjcquglG2SvEbJSRYzhL9BPZubSf5FuXfrfj8hgcMlOTxcm2yy
 1JU4oxbAesn0cKe+P5yQFbl9FmKgLOpgmF1Dnfn2n+jFH/EMwoDagcqpJsnwRU1mK55YJFVGX
 SJPh9qXe1T+WSNdoWT6zh/NlqHysgor6ClfMpaMI8ctzZqYKciMjo7oOMzvYevzrXAxFqoYN5
 lQ5xckCbWXOM/DVi2fc82kK/Lit0/dY3mq7Sgm32P7Ug3e5nJ0bzqQJqG5kjeJvobL+EynxbX
 8xkO9mpND846GEt1pIGmDtoNC/xiCTcbZY2k4yvAtjleBYMUPIGttwRZOzvyBsNX6o81ADKgD
 mgqd4QFAbrL0yQBQcCXmo+fH6tJmIsbeBEKD4OO+BqmIM+b8oHjh/WSlh0uYbbQt9ON1TMSRE
 nFOASpIItrhwlRIfHOlk5U7LwN26YWaE9CSMPdEzB2vs5pWmjyNqlTYCcJ3zN2vWgvvN9Xd3R
 2PBHVSdhcDcn+yFvTIgOMl7TwaXcBEf7JaCV0xYbAQ46TLoD1xbsFiL8EvtMN8/G5s8U8NHom
 xFAV6kO+DFWE5g+O/Yl67Mx7Qcax8VjIJevccimXmn+RtYWvFI0Xt6QxMR4ozYDEz4TDfhs70
 /skRbFTA9Ol0LCtw
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

Drivers that use the SSB sprom functionality typically 'select SSB_SPROM'
from Kconfig, but CONFIG_SSB_HOST_SOC misses this, which results in
a build failure unless at least one of the other drivers that selects
it is enabled:

drivers/built-in.o: In function `ssb_host_soc_get_invariants':
(.text+0x459494): undefined reference to `ssb_fill_sprom_with_fallback'

This adds the same select statement that is used elsewhere.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 541c9a84cd85 ("ssb: pick SoC invariants code from MIPS BCM47xx arch")
---
I'm not sure who the right person is to pick up the fix. The patch that
introduced the problem was merged by Kalle through the iwlwifi tree.

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index 0c675861623f..d8e4219c2324 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -83,6 +83,7 @@ config SSB_SDIOHOST
 config SSB_HOST_SOC
 	bool "Support for SSB bus on SoC"
 	depends on SSB && BCM47XX_NVRAM
+	select SSB_SPROM
 	help
 	  Host interface for a SSB directly mapped into memory. This is
 	  for some Broadcom SoCs from the BCM47xx and BCM53xx lines.
