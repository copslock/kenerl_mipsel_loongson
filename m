Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Sep 2014 04:27:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58980 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006940AbaIFC1sHrxkG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Sep 2014 04:27:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A4A21CD78A9D2;
        Sat,  6 Sep 2014 03:27:40 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 6 Sep
 2014 03:27:41 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sat, 6 Sep 2014 03:27:40 +0100
Received: from [127.0.1.1] (192.168.65.146) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 5 Sep
 2014 19:27:38 -0700
Subject: [PATCH] MIPS: Remove a temporary hack for debugging cache flushes in
        SMTC configuration
To:     <linux-mips@linux-mips.org>, <aaro.koskinen@iki.fi>,
        <david.daney@cavium.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <dengcheng.zhu@imgtec.com>, <chenhc@lemote.com>,
        <akpm@linux-foundation.org>
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Fri, 5 Sep 2014 19:27:38 -0700
Message-ID: <20140906022738.6957.53838.stgit@linux-yegoshin>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

This patch removes a temporary hack for debugging SMTC configuration from

	commit 41c594ab65fc89573af296d192aa5235d09717ab
	Author: Ralf Baechle <ralf@linux-mips.org>
	Date:   Wed Apr 5 09:45:45 2006 +0100

which is dropped now. Some performance degradation for multi-VPE systems
is removed.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/include/asm/r4kcache.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 4520adc..b2ae1b1 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -50,7 +50,6 @@ extern void (*r4k_blast_icache)(void);
 /*
  * Optionally force single-threaded execution during I-cache flushes.
  */
-#define PROTECT_CACHE_FLUSHES 1
 
 #ifdef PROTECT_CACHE_FLUSHES
 
