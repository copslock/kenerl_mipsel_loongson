Received:  by oss.sgi.com id <S553879AbQJ3SoH>;
	Mon, 30 Oct 2000 10:44:07 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:7415 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553877AbQJ3Snj>;
	Mon, 30 Oct 2000 10:43:39 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9UIfs302990;
	Mon, 30 Oct 2000 10:41:54 -0800
Message-ID: <39FDC1B1.A4E33DDE@mvista.com>
Date:   Mon, 30 Oct 2000 10:45:05 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: r4k_dma_cache_inv_pc() does writeback
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


It just occur to me that r4k_dma_cache_inv_pc() actually does a
writeback before it invalidates the cache.  Is there story behind it? 
Or just a plain bug?

If it is a bug, I don't find an easy way to invalidate the whole dcache
other than writing a new function, perhaps in r4kcache.h.

Jun
