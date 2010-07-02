Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jul 2010 03:44:20 +0200 (CEST)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:52643 "EHLO
        rtp-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492124Ab0GBBoQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Jul 2010 03:44:16 +0200
Authentication-Results: rtp-iport-1.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAD/hLEytJV2Y/2dsb2JhbACfcXGkAJowhSUEg3GGXg
X-IronPort-AV: E=Sophos;i="4.53,524,1272844800"; 
   d="scan'208";a="127808520"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rtp-iport-1.cisco.com with ESMTP; 02 Jul 2010 01:44:08 +0000
Received: from xbh-rcd-202.cisco.com (xbh-rcd-202.cisco.com [72.163.62.201])
        by rcdn-core-1.cisco.com (8.14.3/8.14.3) with ESMTP id o621i892001454;
        Fri, 2 Jul 2010 01:44:08 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-202.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 1 Jul 2010 20:44:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Apply kmap_high_get with MIPS
Date:   Thu, 1 Jul 2010 20:44:07 -0500
Message-ID: <7A9214B0DEB2074FBCA688B30B04400D0116BADD@XMB-RCD-208.cisco.com>
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400D0116BA36@XMB-RCD-208.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Apply kmap_high_get with MIPS
Thread-Index: Acr9ycy17NGkqChPReO+gQqYaLC/oAbmU6KwAAi/quA=
From:   "Dezhong Diao (dediao)" <dediao@cisco.com>
To:     "Kevin Cernekee" <cernekee@gmail.com>
Cc:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 02 Jul 2010 01:44:08.0510 (UTC) FILETIME=[100375E0:01CB1988]
Return-Path: <dediao@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dediao@cisco.com
Precedence: bulk
X-list: linux-mips

In terms of my previous email, the changes are intended to be made in
"__dma_sync_contiguous" so that "addr == 0" case can be satisfied. 


+static inline void __dma_sync_contiguous(struct page *page,
+	unsigned long offset, size_t size, enum dma_data_direction
direction) 
+{
+	unsigned long addr;
+
+	if (!PageHighMem(page)) {
+		addr = (unsigned long)page_address(page) + offset;
+		__dma_sync_virtual(addr, size, direction);
+	} else {
+		addr = (unsigned long)kmap_high_get(page);
+		if (addr) {
+			addr += offset;
+			__dma_sync_virtual(addr, size, direction);
+			kunmap_high(page);
+		} else {
+			addr = (unsigned long)kmap_atomic(page,
KM_MIPS_SYNC_PAGE);
+			flush_data_cache_page(addr + offset);
+			kunmap_atomic((void *)addr, KM_MIPS_SYNC_PAGE);
+           }           
+	} 
+}
+


Dezhong

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Dezhong Diao
(dediao)
Sent: Thursday, July 01, 2010 2:57 PM
To: Kevin Cernekee
Cc: linux-mips@linux-mips.org
Subject: RE: [PATCH] Apply kmap_high_get with MIPS

The issue (addr == 0) you mentioned had been discussed before
(http://www.linux-mips.org/archives/linux-mips/2008-03/msg00011.html).
For some reasons, the solution couldn't be accepted.

Since then, we haven't touched that function until the changes of
"kmap_high_get" were involved. The changes we made in
"__flush_dcache_page" (below) should fix the problem which has been
resolved in ARM.



Dezhong


void __flush_dcache_page(struct page *page) {
  struct address_space *mapping = page_mapping(page);
  void *addr;

  /* If there is a temporary kernel mapping, i.e. if kmap_atomic was
   * used to map a page, we only need to flush the page. We can skip
   * the other work here because it won't be used in any other way. */
  if (PageHighMem(page)) {
    addr = kmap_atomic_to_vaddr(page);
    if (addr != NULL) {
      flush_data_cache_page((unsigned long) addr);
      return;
    }
  }

  /* If page_mapping returned a non-NULL value, then the page is not
   * in the swap cache and it isn't anonymously mapped. If it's not
   * already mapped into user space, we can just set the dirty bit to
   * get the cache flushed later, if needed */
  if (mapping && !mapping_mapped(mapping)) {
    SetPageDcacheDirty(page);
    return;
  }

  /*
   * We could delay the flush for the !page_mapping case too.  But that
   * case is for exec env/arg pages and those are %99 certainly going to
   * get faulted into the tlb (and thus flushed) anyways.
   */	
  if (!PageHighMem(page)) {
    addr = page_address(page);
    flush_data_cache_page((unsigned long) addr);
  } else {
    if (!cpu_has_dc_aliases) {
      addr = kmap_high_get(page);
      if (addr) {
        /* The page has been kmapped */
        flush_data_cache_page((unsigned long) addr);
        kunmap_high(page);
      } else {
        /* Alright, we need a temporary kernel mapping. Since we are on
         * a processor that has hardware to eliminate data cache
         * aliases, we don't have to get an address whose virtual index
         * into the cache that matches the index originally used to map
         * the page. This makes the task doable. */
        addr = kmap_atomic(page, KM_MIPS_SYNC_PAGE);
        flush_data_cache_page((unsigned long) addr);
        kunmap_atomic(addr, KM_MIPS_SYNC_PAGE);
      }
    } else {
      /* Sorry, we may have data cache aliases, which means that we
       * have to be able to get a virtual address whose virtual index
       * into cache matches the index used to map this page. This is
       * hard and so, just like the hard problems in my Physics
       * classes, is left as an exercise for the reader. */
      panic("Unable to flush page 0x%p on processor with data cache "
            "aliases\n", page);
    }
  }
}
