Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2017 07:03:18 +0200 (CEST)
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:52315 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990506AbdC0FDHxqlWI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Mar 2017 07:03:07 +0200
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.53 with ESMTP; 27 Mar 2017 14:02:58 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: minchan@kernel.org
Received: from unknown (HELO LGEAEXHB01P.LGE.NET) (165.244.249.25)
        by 156.147.1.127 with ESMTP; 27 Mar 2017 14:02:58 +0900
X-Original-SENDERIP: 165.244.249.25
X-Original-MAILFROM: minchan@kernel.org
Received: from lgekrmhub01.lge.com (10.185.110.11) by LGEAEXHB01P.LGE.NET
 (165.244.249.21) with Microsoft SMTP Server id 8.3.264.0; Mon, 27 Mar 2017
 14:01:37 +0900
Received: from lgemrelse7q.lge.com ([156.147.1.151])          by
 lgekrmhub01.lge.com (Lotus Domino Release 8.5.3FP6)          with ESMTP id
 2017032714013681-103546 ;          Mon, 27 Mar 2017 14:01:36 +0900 
Received: from unknown (HELO bbox) (10.177.223.161)     by 156.147.1.151 with
 ESMTP; 27 Mar 2017 14:01:35 +0900
X-Original-SENDERIP: 10.177.223.161
X-Original-MAILFROM: minchan@kernel.org
Date:   Mon, 27 Mar 2017 14:01:34 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-alpha@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        <linux-mips@linux-mips.org>, <linuxppc-dev@lists.ozlabs.org>,
        <sparclinux@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH v3 5/7] zram: Convert to using memset_l
Message-ID: <20170327050134.GA19601@bbox>
References: <20170324161318.18718-1-willy@infradead.org>
 <20170324161318.18718-6-willy@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170324161318.18718-6-willy@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-MIMETrack: Itemize by SMTP Server on LGEKRMHUB01/LGE/LG Group(Release 8.5.3FP6|November
 21, 2013) at 2017/03/27 14:01:36,
        Serialize by Router on LGEKRMHUB01/LGE/LG Group(Release 8.5.3FP6|November
 21, 2013) at 2017/03/27 14:01:37,
        Serialize complete at 2017/03/27 14:01:37
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Return-Path: <minchan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minchan@kernel.org
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

On Fri, Mar 24, 2017 at 09:13:16AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> zram was the motivation for creating memset_l().  Minchan Kim sees a 7%
> performance improvement on x86 with 100MB of non-zero deduplicatable
> data:
> 
>         perf stat -r 10 dd if=/dev/zram0 of=/dev/null
> 
> vanilla:        0.232050465 seconds time elapsed ( +-  0.51% )
> memset_l:	0.217219387 seconds time elapsed ( +-  0.07% )
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Tested-by: Minchan Kim <minchan@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks!
