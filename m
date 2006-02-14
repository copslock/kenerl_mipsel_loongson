Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 10:28:37 +0000 (GMT)
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:10904 "EHLO
	fgwmail5.fujitsu.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133421AbWBNK22 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 10:28:28 +0000
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
        by fgwmail5.fujitsu.co.jp (Fujitsu Gateway)
        with ESMTP id k1EAYfwM030035; Tue, 14 Feb 2006 19:34:41 +0900
        (envelope-from kamezawa.hiroyu@jp.fujitsu.com)
Received: from s5.gw.fujitsu.co.jp by m2.gw.fujitsu.co.jp (8.12.10/Fujitsu Domain Master)
	id k1EAYdY7027268; Tue, 14 Feb 2006 19:34:40 +0900
	(envelope-from kamezawa.hiroyu@jp.fujitsu.com)
Received: from s5.gw.fujitsu.co.jp (s5 [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id CCD1D1B8057;
	Tue, 14 Feb 2006 19:34:39 +0900 (JST)
Received: from fjm503.ms.jp.fujitsu.com (fjm503.ms.jp.fujitsu.com [10.56.99.77])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 186131B805C;
	Tue, 14 Feb 2006 19:34:39 +0900 (JST)
Received: from [127.0.0.1] (fjmscan501.ms.jp.fujitsu.com [10.56.99.141])by fjm503.ms.jp.fujitsu.com with ESMTP id k1EAYYg7006708;
	Tue, 14 Feb 2006 19:34:36 +0900
Message-ID: <43F1B29B.3030909@jp.fujitsu.com>
Date:	Tue, 14 Feb 2006 19:36:11 +0900
From:	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Subject: [PATCH] unify pfn_to_page take3 [12/23] mips pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamezawa.hiroyu@jp.fujitsu.com
Precedence: bulk
X-list: linux-mips

MIPS can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-mips/mmzone.h
===================================================================
--- testtree.orig/include/asm-mips/mmzone.h
+++ testtree/include/asm-mips/mmzone.h
@@ -22,20 +22,6 @@
  		       NODE_DATA(__n)->node_spanned_pages) : 0);\
  })

-#define pfn_to_page(pfn)					\
-({								\
- 	unsigned long __pfn = (pfn);				\
-	pg_data_t *__pg = NODE_DATA(pfn_to_nid(__pfn));		\
-	__pg->node_mem_map + (__pfn - __pg->node_start_pfn);	\
-})
-
-#define page_to_pfn(p)						\
-({								\
-	struct page *__p = (p);					\
-	struct zone *__z = page_zone(__p);			\
-	((__p - __z->zone_mem_map) + __z->zone_start_pfn);	\
-})
-
  /* XXX: FIXME -- wli */
  #define kern_addr_valid(addr)	(0)

Index: testtree/include/asm-mips/page.h
===================================================================
--- testtree.orig/include/asm-mips/page.h
+++ testtree/include/asm-mips/page.h
@@ -17,6 +17,7 @@

  #endif

+
  /*
   * PAGE_SHIFT determines the page size
   */
@@ -140,8 +141,6 @@ typedef struct { unsigned long pgprot; }
  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)

  #ifndef CONFIG_NEED_MULTIPLE_NODES
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif

@@ -160,6 +159,7 @@ typedef struct { unsigned long pgprot; }
  #define WANT_PAGE_VIRTUAL
  #endif

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _ASM_PAGE_H */
