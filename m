Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 17:02:13 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:55984 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023072AbXJ1RCL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Oct 2007 17:02:11 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9T0PLVc019081;
	Mon, 29 Oct 2007 00:25:21 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9T0PHCP019080;
	Mon, 29 Oct 2007 00:25:17 GMT
Date:	Mon, 29 Oct 2007 00:25:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] Fix/Rewrite of the mipsnet driver
Message-ID: <20071029002517.GB16913@linux-mips.org>
References: <20071028043846.GM29176@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071028043846.GM29176@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 28, 2007 at 04:38:46AM +0000, Thiemo Seufer wrote:

> Hello All,
> 
> currently the mipsnet driver fails after transmitting a number of
> packages because SKBs are allocated but never freed. I fixed that
> and coudn't refrain from removing the most egregious warts.
> 
> - mipsnet.h folded into mipsnet.c, as it doesn't provide any
>   useful external interface.
> - Free SKB after transmission.
> - Call free_irq in mipsnet_close, to balance the request_irq in
>   mipsnet_open.
> - Removed duplicate read of rxDataCount.
> - Some identifiers are now less verbose.
> - Removed dead and/or unnecessarily complex code.
> - Code formatting fixes.
> 
> Tested on Qemu's mipssim emulation, with this patch it can boot a
> Debian NFSroot.

The patch does no longer apply to a recent tree, can you respin it?

  Ralf
