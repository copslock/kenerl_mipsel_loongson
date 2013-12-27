Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Dec 2013 19:48:22 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:40364 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823125Ab3L0SsSrMt1s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Dec 2013 19:48:18 +0100
Received: from localhost (cpe-74-71-55-169.nyc.res.rr.com [74.71.55.169])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8D80658FFCB;
        Fri, 27 Dec 2013 10:48:15 -0800 (PST)
Date:   Fri, 27 Dec 2013 13:48:14 -0500 (EST)
Message-Id: <20131227.134814.345379118522548543.davem@davemloft.net>
To:     willy@linux.intel.com
Cc:     linux-mm@kvack.org, sparclinux@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20131227180018.GC4945@linux.intel.com>
References: <20131227180018.GC4945@linux.intel.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.1 (shards.monkeyblade.net [0.0.0.0]); Fri, 27 Dec 2013 10:48:16 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Matthew Wilcox <willy@linux.intel.com>
Date: Fri, 27 Dec 2013 13:00:18 -0500

> It seems to me that while (for example) on SPARC, it's not possible to
> create a non-coherent mapping with mmap(), after we've done an mmap,
> we can then use remap_file_pages() to create a mapping that no longer
> aliases in the D-cache.
> 
> I have only compile-tested this patch.  I don't have any SPARC hardware,
> and my PA-RISC hardware hasn't been turned on in six years ... I noticed
> this while wandering around looking at some other stuff.

I suppose this is needed, but only in the case where the mapping is
shared and writable, right?  I don't see you testing those conditions,
but with them I'd be OK with this change.
