Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2010 19:37:07 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:37112 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491101Ab0IIRhE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Sep 2010 19:37:04 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1Otl3X-000126-00; Thu, 09 Sep 2010 19:37:03 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 17ADB2397F0; Thu,  9 Sep 2010 19:34:27 +0200 (CEST)
Date:   Thu, 9 Sep 2010 19:34:27 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: DMA: Add plat_extra_sync_for_cpu()
Message-ID: <20100909173426.GA14371@alpha.franken.de>
References: <064bb0722da5d8c271c2bd9fe0a521cc@localhost> <99a0868bdbcfa8785a92b4af4f6d9b99@localhost> <4C8914E8.5030002@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C8914E8.5030002@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 27740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7443

On Thu, Sep 09, 2010 at 10:10:00AM -0700, David Daney wrote:
> On 09/08/2010 04:02 PM, Kevin Cernekee wrote:
>> On noncoherent processors with a readahead cache, an extra platform-
>> specific invalidation is required during the dma_sync_*_for_cpu()
>> operations to keep drivers from seeing stale prefetched data.
>
> But as far as I can see, none of your plat_extra_sync_for_cpu() do anything.
>
> Perhaps adding this hook should be deferred until there is actually a user.

looks like this is doing what the non_coherent_r10000 case does. So IMHO
either which make non_coheren check more generic or could use the new
plat_sync thingie for IP28 and other non coherent r10k boxes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
