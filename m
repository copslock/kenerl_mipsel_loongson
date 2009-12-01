Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 16:58:14 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38032 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492779AbZLAP6K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 16:58:10 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB1FwOIj005920;
        Tue, 1 Dec 2009 15:58:25 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB1FwMW2005919;
        Tue, 1 Dec 2009 15:58:22 GMT
Date:   Tue, 1 Dec 2009 15:58:21 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: Re: [PATCH 1/2] Loongson: disable PAGE_SIZE_4KB
Message-ID: <20091201155821.GB23697@linux-mips.org>
References: <1259650525-31884-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259650525-31884-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 02:55:25PM +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> Date:   Tue,  1 Dec 2009 14:55:25 +0800
> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org, zhangfx@lemote.com,
> 	Wu Zhangjin <wuzhangjin@gmail.com>
> Subject: [PATCH 1/2] Loongson: disable PAGE_SIZE_4KB
> 
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Currently, with PAGE_SIZE_4KB, the kernel for loongson will hang on:
> 
> Kernel panic - not syncing: Attempted to kill init!
> 
> The possible reason is the cache aliases problem:
> 
> Loongson 2F has 64kb, 4 way L1 Cache, the way size is 16kb, which is
> bigger then 4kb. so, If using 4kb page size, there is cache aliases
> problem(Documentation/cachetlb.txt), to avoid such problem, we may need
> extra cache flushing. but with 16kb page size, there is no cache aliases
> problem and no corresponding operations needed to cope with that
> problem, so, it's better to disable 4kb page size directly before the
> above problem is solved.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Applied - though I'm not so sure if I can get this one to Linus as
close to a release as we are now.

Thanks!

  Ralf
