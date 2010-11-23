Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 18:12:36 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:60306 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492090Ab0KWRM3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 18:12:29 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1PKwPs-0000w0-00; Tue, 23 Nov 2010 18:12:28 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 19F021D4A1; Tue, 23 Nov 2010 18:11:07 +0100 (CET)
Date:   Tue, 23 Nov 2010 18:11:07 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix build failure for IP22
Message-ID: <20101123171107.GA13648@alpha.franken.de>
References: <1290511948-10347-1-git-send-email-dmitri.vorobiev@movial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1290511948-10347-1-git-send-email-dmitri.vorobiev@movial.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Nov 23, 2010 at 01:32:28PM +0200, Dmitri Vorobiev wrote:
> Commit 48e1fd5a81416a037f5a48120bf281102f2584e2 changed the name
> of the MIPS-specific dma_cache_sync() routine by prefixing it with
> `mips_', and removed the export for its symbol. Two drivers, which

Glancing at the mentioned patch IMHO it's better to use dma_sync_for_cpu/device
This way we could kill mips_dma_cache_sync() completely.

Thomas

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
