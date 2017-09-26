Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 19:34:15 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:50142 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990644AbdIZReIonpDs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2017 19:34:08 +0200
Received: from localhost (74-93-104-102-Washington.hfc.comcastbusiness.net [74.93.104.102])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 575781340110B;
        Tue, 26 Sep 2017 10:34:01 -0700 (PDT)
Date:   Tue, 26 Sep 2017 10:34:00 -0700 (PDT)
Message-Id: <20170926.103400.1009342814128022820.davem@davemloft.net>
To:     matt.redfearn@imgtec.com
Cc:     netdev@vger.kernel.org, alexandre.torgue@st.com,
        peppe.cavallaro@st.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, paul.burton@imgtec.com,
        james.hogan@imgtec.com
Subject: Re: [PATCH] net: stmmac: Meet alignment requirements for DMA
From:   David Miller <davem@davemloft.net>
In-Reply-To: <587dc9a8-b974-e222-95b4-93c2a8f2aba2@imgtec.com>
References: <1506078833-14002-1-git-send-email-matt.redfearn@imgtec.com>
        <20170922.182639.272534775457081015.davem@davemloft.net>
        <587dc9a8-b974-e222-95b4-93c2a8f2aba2@imgtec.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Sep 2017 10:34:01 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60163
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

From: Matt Redfearn <matt.redfearn@imgtec.com>
Date: Tue, 26 Sep 2017 14:57:39 +0100

> Since the MIPS architecture requires software cache management,
> performing a dma_map_single(TO_DEVICE) will writeback and invalidate
> the cachelines for the required region. To comply with (our
> interpretation of) the DMA API documentation, the MIPS implementation
> expects a cacheline aligned & sized buffer, so that it can writeback a
> set of complete cachelines. Indeed a recent patch
> (https://patchwork.linux-mips.org/patch/14624/) causes the MIPS dma
> mapping code to emit warnings if the buffer it is requested to sync is
> not cachline aligned. This driver, as is, fails this test and causes
> thousands of warnings to be emitted.

For a device write, if the device does what it is told and does not
access bytes outside of the periphery of the DMA mapping, nothing bad
can happen.

When the DMA buffer is mapped, the cpu side cachelines are flushed (even
ones which are partially part of the requsted mapping, this is _fine_).

The device writes into only the bytes it was given access to, which
starts at the DMA address.

The unmap and/or sync operation after the DMA transfer needs to do
nothing on the cpu side since the map operation flushed the cpu side
caches already.

When the cpu reads, it will pull the cacheline from main memory and
see what the device wrote.

It's not like the device can put "garbage" into the bytes earlier in
the cacheline it was given partial access to.

A device read is similar, the cpu cachelines are written out to main
memory at map time and the device sees what it needs to see.

I want to be shown a real example where corruption or bad data can
occur when the DMA API is used correctly.

Other platforms write "complete cachelines" in order to implement
the cpu and/or host controller parts of the DMA API implementation.
I see nothing special about MIPS at all.

If you're given a partial cache line, you align the addresses such
that you flush every cache line contained within the provided address
range.

I really don't see what the problem is and why MIPS needs special
handling.  You will have to give specific examples, step by step,
where things can go wrong before I will be able to consider your
changes.

Thanks.
