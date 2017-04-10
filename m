Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 18:49:09 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993938AbdDJQprQHPFJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 18:45:47 +0200
Received: from localhost (084035110146.static.ipv4.infopact.nl [84.35.110.146])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17C91B90;
        Mon, 10 Apr 2017 16:45:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@caviumnetworks.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 053/152] MIPS: c-r4k: Fix Loongson-3s vcache/scache waysize calculation
Date:   Mon, 10 Apr 2017 18:41:45 +0200
Message-Id: <20170410164202.813467311@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170410164159.934755016@linuxfoundation.org>
References: <20170410164159.934755016@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 0be032c190abcdcfa948082b6a1e0d461184ba4d upstream.

If scache.waysize is 0, r4k___flush_cache_all() will do nothing and
then cause bugs. BTW, though vcache.waysize isn't being used by now,
we also fix its calculation.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J . Hill <Steven.Hill@caviumnetworks.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15756/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/c-r4k.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1558,6 +1558,7 @@ static void probe_vcache(void)
 	vcache_size = c->vcache.sets * c->vcache.ways * c->vcache.linesz;
 
 	c->vcache.waybit = 0;
+	c->vcache.waysize = vcache_size / c->vcache.ways;
 
 	pr_info("Unified victim cache %ldkB %s, linesize %d bytes.\n",
 		vcache_size >> 10, way_string[c->vcache.ways], c->vcache.linesz);
@@ -1660,6 +1661,7 @@ static void __init loongson3_sc_init(voi
 	/* Loongson-3 has 4 cores, 1MB scache for each. scaches are shared */
 	scache_size *= 4;
 	c->scache.waybit = 0;
+	c->scache.waysize = scache_size / c->scache.ways;
 	pr_info("Unified secondary cache %ldkB %s, linesize %d bytes.\n",
 	       scache_size >> 10, way_string[c->scache.ways], c->scache.linesz);
 	if (scache_size)
