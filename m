Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 20:11:03 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1603 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827499Ab3FNSLCjkXRN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 20:11:02 +0200
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 14 Jun 2013 11:01:40 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Fri, 14 Jun 2013 11:10:43 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Fri, 14 Jun 2013 11:10:43 -0700
Received: from LTMHT-KDASU (dhcp-mhtb-7-118.and.broadcom.com
 [10.28.7.118]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 63C8BF2D74; Fri, 14 Jun 2013 11:10:28 -0700 (PDT)
Received: from kdasu-ltmht-linux.and.broadcom.com by LTMHT-KDASU (PGP
 Universal service); Fri, 14 Jun 2013 14:10:44 -0500
X-PGP-Universal: processed; by LTMHT-KDASU on Fri, 14 Jun 2013 14:10:44
 -0500
From:   "Kamal Dasu" <kdasu.kdev@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Kamal Dasu" <kdasu.kdev@gmail.com>
Subject: [PATCH] MIPS: Fix get_user_page_fast() for mips with cache
 alias
Date:   Fri, 14 Jun 2013 14:10:03 -0400
Message-ID: <1371233403-30153-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.8.2.3
MIME-Version: 1.0
X-WSS-ID: 7DA5850E2L833386520-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <kdasu.kdev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kdasu.kdev@gmail.com
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

get_user_pages_fast() is missing cache flushes for MIPS platforms
with cache alias. Filesystem failures observed with DirectIO
operations due to missing flush_anon_page() that use page coloring
logic to work with cache aliases. This fix falls through to take
slow_irqon path that calls get_user_pages() that has required
logic for platforms where cpu_has_dc_aliases is true.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 arch/mips/mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
index d4ea5c9..346fb7e 100644
--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -273,7 +273,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 
 	end = start + len;
-	if (end < start)
+	if (end < start || cpu_has_dc_aliases)
 		goto slow_irqon;
 
 	/* XXX: batch / limit 'nr' */
-- 
1.8.2.3
