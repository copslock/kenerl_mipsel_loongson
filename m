Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2012 06:41:50 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:16731 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903258Ab2BJFll (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Feb 2012 06:41:41 +0100
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q1A5fTiF031052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 10 Feb 2012 00:41:29 -0500
Received: from cr0.redhat.com (vpn-244-44.nrt.redhat.com [10.64.244.44])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q1A5eVkW021917;
        Fri, 10 Feb 2012 00:41:22 -0500
From:   Cong Wang <amwang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cong Wang <amwang@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Kosina <jkosina@suse.cz>,
        Kevin Cernekee <cernekee@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-mips@linux-mips.org
Subject: [PATCH 04/60] mips: remove the second argument of k[un]map_atomic()
Date:   Fri, 10 Feb 2012 13:39:25 +0800
Message-Id: <1328852421-19678-5-git-send-email-amwang@redhat.com>
In-Reply-To: <1328852421-19678-1-git-send-email-amwang@redhat.com>
References: <1328852421-19678-1-git-send-email-amwang@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
X-archive-position: 32413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amwang@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Cong Wang <amwang@redhat.com>
---
 arch/mips/mm/c-r4k.c |    4 ++--
 arch/mips/mm/init.c  |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 4f9eb0b..c97087d 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -498,7 +498,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 		if (map_coherent)
 			vaddr = kmap_coherent(page, addr);
 		else
-			vaddr = kmap_atomic(page, KM_USER0);
+			vaddr = kmap_atomic(page);
 		addr = (unsigned long)vaddr;
 	}
 
@@ -521,7 +521,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 		if (map_coherent)
 			kunmap_coherent();
 		else
-			kunmap_atomic(vaddr, KM_USER0);
+			kunmap_atomic(vaddr);
 	}
 }
 
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 3b3ffd4..1a85ba9 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -207,21 +207,21 @@ void copy_user_highpage(struct page *to, struct page *from,
 {
 	void *vfrom, *vto;
 
-	vto = kmap_atomic(to, KM_USER1);
+	vto = kmap_atomic(to);
 	if (cpu_has_dc_aliases &&
 	    page_mapped(from) && !Page_dcache_dirty(from)) {
 		vfrom = kmap_coherent(from, vaddr);
 		copy_page(vto, vfrom);
 		kunmap_coherent();
 	} else {
-		vfrom = kmap_atomic(from, KM_USER0);
+		vfrom = kmap_atomic(from);
 		copy_page(vto, vfrom);
-		kunmap_atomic(vfrom, KM_USER0);
+		kunmap_atomic(vfrom);
 	}
 	if ((!cpu_has_ic_fills_f_dc) ||
 	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
 		flush_data_cache_page((unsigned long)vto);
-	kunmap_atomic(vto, KM_USER1);
+	kunmap_atomic(vto);
 	/* Make sure this page is cleared on other CPU's too before using it */
 	smp_wmb();
 }
-- 
1.7.7.6
