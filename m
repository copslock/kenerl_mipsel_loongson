Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 23:24:11 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:41988 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20021616AbZDWWYD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Apr 2009 23:24:03 +0100
Received: from [10.9.200.131] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Thu, 23 Apr 2009 15:23:46 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.1.358.0; Thu, 23 Apr 2009 15:23:45 -0700
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 85A4874D05 for
 <linux-mips@linux-mips.org>; Thu, 23 Apr 2009 15:23:45 -0700 (PDT)
Subject: HIGHMEM fix for r24k
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Organization: Broadcom
Date:	Thu, 23 Apr 2009 18:23:44 -0400
Message-ID: <1240525424.15448.33.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8)
X-WSS-ID: 65EE35F838S1956460-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips

For all you guys working on HIGMEM.

I found a bug that was keeping HIGHMEM from working on mips 24k
processors starting at 2.6.26.  


2008-04-28 Chris Dearman [MIPS] Allow setting of the cache attribute at
run ...

This commit introduces the variable _page_cachable_default, which
defaults to zero.

arch/mips/mm/cache.c:
	unsigned long _page_cachable_default;

The variable is used to create the prototype PTE for __kmap_atomic in
arch/mips/mm/init.c:kmap_init.

The variable is initialized in arch/mips/mm/c-r4k.c:coherency_setup.

Unfortunately, the variable is used before it is initialized properly.
As a result, all kmap_atomic PTE have the cache coherency algorithm mode set to 0.  
Mode 0 is "cacheable, nocoherent, write-through, no write allocate".
This is not valid on my r24k and my not be on any r24k.

The result is that writes to kmap_atomic pages get corrupted.  This was confirmed
using a jtag probe, examining uncached memory, the D cache itself, and cached memory.

I've changed the variable declaration to be:
  unsigned long _page_cachable_default = _CACHE_CACHABLE_NONCOHERENT;

My highmem kernel now works.  This is w/o discontiguous or sparsemem set.
I do have two discontiguous banks of memory.

I'm not sure of the best fix.  Simple reordering of the the init code to
set the variable  before it gets used breaks other initialization.


My kernel tree is a big mess right now and I'm back at 2.6.26 where the bug was introduce.
As soon as I have 2.6.28 or 29 working, I'll post any more changes.

Jon Fraser
Broadcom
