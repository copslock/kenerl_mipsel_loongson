Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 08:10:27 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:56926 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492175AbZLCHKX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 08:10:23 +0100
Received: from [89.193.139.6] (helo=[10.36.82.250])
        by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
        id 1NG5pP-0003Ly-Nk; Thu, 03 Dec 2009 07:10:18 +0000
Date:   Thu, 3 Dec 2009 07:10:00 +0000 (GMT)
From:   David Woodhouse <dwmw2@infradead.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org,
        Thomas Koeller <thomas.koeller@baslerweb.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] eXcite: Remove platform support and drivers.
In-Reply-To: <20091202153534.GA10692@linux-mips.org>
Message-ID: <alpine.LFD.2.00.0912030709230.10116@macbook.infradead.org>
References: <20091202153016.GA9892@linux-mips.org> <20091202153534.GA10692@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+27164d45208a24c6f88d+2293+infradead.org+dwmw2@casper.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwmw2@infradead.org
Precedence: bulk
X-list: linux-mips

On Wed, 2 Dec 2009, Ralf Baechle wrote:

> The platform has never been fully merged.  Remove it including MTD and
> watchdog drivers.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
> I'd like acks from the watchdog and MTD maintainers please.

Acked-by: David Woodhouse <David.Woodhouse@intel.com>

-- 
dwmw2
