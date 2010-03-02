Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Mar 2010 22:14:21 +0100 (CET)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:37840 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492382Ab0CBVOS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Mar 2010 22:14:18 +0100
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
        (easymta 1.00 BETA 1)
        id 1NmZPz-0001IG-2B; Tue, 02 Mar 2010 22:14:15 +0100
Date:   Tue, 2 Mar 2010 22:14:15 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     David Miller <davem@davemloft.net>
Cc:     sebastian@breakpoint.cc, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 3/3] ide: move dcache flushing to generic ide code
Message-ID: <20100302211414.GA4065@Chamillionaire.breakpoint.cc>
References: <1267371341-16684-4-git-send-email-sebastian@breakpoint.cc>
 <20100228.183417.52179576.davem@davemloft.net>
 <20100301195858.GA27906@Chamillionaire.breakpoint.cc>
 <20100301.163959.177031088.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20100301.163959.177031088.davem@davemloft.net>
X-Key-Id: FE3F4706
X-Key-Fingerprint: FFDA BBBB 3563 1B27 75C9  925B 98D5 5C1C FE3F 4706
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sebastian@breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

* David Miller | 2010-03-01 16:39:59 [-0800]:

>All buffers passed to the architecture IDE ops should be PAGE_OFFSET
>relative kernel virtual addresses for which __pa() works.
>
>Are kmap()'d things ending up here?
Ah, bounce buffers are used. So no, there no highmem which get kmap()ed.

Sebastian
