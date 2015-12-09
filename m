Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 16:03:12 +0100 (CET)
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:51617 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007243AbbLIPDKCAda5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 16:03:10 +0100
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 884071C1C38
        for <linux-mips@linux-mips.org>; Wed,  9 Dec 2015 15:03:04 +0000 (GMT)
Received: (qmail 21247 invoked from network); 9 Dec 2015 15:03:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.246.231])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 9 Dec 2015 15:03:04 -0000
Date:   Wed, 9 Dec 2015 15:03:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2] MIPS: fix DMA contiguous allocation
Message-ID: <20151209150302.GB15910@techsingularity.net>
References: <1449672845-2196-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1449672845-2196-1-git-send-email-qais.yousef@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mgorman@techsingularity.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mgorman@techsingularity.net
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

On Wed, Dec 09, 2015 at 02:54:05PM +0000, Qais Yousef wrote:
> Recent changes to how GFP_ATOMIC is defined seems to have broken the condition
> to use mips_alloc_from_contiguous() in mips_dma_alloc_coherent().
> 
> I couldn't bottom out the exact change but I think it's this one
> 
> d0164adc89f6 (mm, page_alloc: distinguish between being unable to sleep,
> unwilling to sleep and avoiding waking kswapd)
> 
> From what I see GFP_ATOMIC has multiple bits set and the check for !(gfp
> & GFP_ATOMIC) isn't enough.
> 
> The reason behind this condition is to check whether we can potentially do
> a sleeping memory allocation. Use gfpflags_allow_blocking() instead which
> should be more robust.
> 
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
