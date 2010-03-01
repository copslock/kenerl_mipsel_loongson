Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2010 03:34:19 +0100 (CET)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51052
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492306Ab0CACeB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Mar 2010 03:34:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id 1329F24C097;
        Sun, 28 Feb 2010 18:34:18 -0800 (PST)
Date:   Sun, 28 Feb 2010 18:34:17 -0800 (PST)
Message-Id: <20100228.183417.52179576.davem@davemloft.net>
To:     sebastian@breakpoint.cc
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 3/3] ide: move dcache flushing to generic ide code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1267371341-16684-4-git-send-email-sebastian@breakpoint.cc>
References: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
        <1267371341-16684-4-git-send-email-sebastian@breakpoint.cc>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Date: Sun, 28 Feb 2010 16:35:41 +0100

> the pio callbacks are called with different kind of buffers. It could be
> a straight kernel addr, kernel stack or a kmaped highmem page.
> Some of this break the virt_to_page() assumptions.
> This patch moves the dcache flush from architecture code into generic
> ide code. ide_pio_bytes() is the only place where user pages might be
> written as far as I can see.
> The dcache flush is avoided in two cases:
> - data which is written to the device (i.e. they are comming from the
>   userland)

This needs a flush on sparc, otherwise an alias now exists in the
kernel side copy of the buffer.  The D-cache flush is intentionally
unconditional for PIO mode.  I definitely don't want to take the same
risks you guys seem to be willing to take for this optimization which
is of questionable value.

I also, intrinsically, really don't like these changes.

For one thing, you're optimizing PIO mode.

Secondly, IDE is in deep maintainence mode, if you want to optimize
cache flushing do it in the ATA layer.

Thanks.
