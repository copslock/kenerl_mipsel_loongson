Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2014 16:47:40 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:55659 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816503AbaCVPrh4mAY8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 22 Mar 2014 16:47:37 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s2MFlLZK025965;
        Sat, 22 Mar 2014 08:47:21 -0700
Date:   Sat, 22 Mar 2014 08:47:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: export icache_flush_range
Message-ID: <20140322154720.GA23863@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.71 on 10.2.0.1
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

The lkdtm module performs tests against executable memory ranges, so
it needs to flush the icache for proper behaviors. Other architectures
already export this, so do the same for MIPS.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is currently untested! I'm building a MIPS cross-compiler now...
If someone can validate this fixes the build when lkdtm is a module,
that would be appreciated. :)
---
 arch/mips/mm/cache.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index fde7e56d13fe..b3f1df13d9f6 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -38,6 +38,7 @@ void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
 void (*__invalidate_kernel_vmap_range)(unsigned long vaddr, int size);
 
 EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
+EXPORT_SYMBOL_GPL(flush_icache_range);
 
 /* MIPS specific cache operations */
 void (*flush_cache_sigtramp)(unsigned long addr);
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
