Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 01:48:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:30341 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022934AbXCSBsF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 01:48:05 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2J1k7r4005714;
	Mon, 19 Mar 2007 01:46:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2J1k53g005713;
	Mon, 19 Mar 2007 01:46:05 GMT
Date:	Mon, 19 Mar 2007 01:46:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Cleanup for plat_irq_dispatch functions
Message-ID: <20070319014604.GA5658@linux-mips.org>
References: <20070319001337.GB7744@networkno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070319001337.GB7744@networkno.de>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 19, 2007 at 12:13:37AM +0000, Thiemo Seufer wrote:

> the appended patch
>  - adds missing ST0_IM masks, which caused the logging of valid
>    interrupts as spurious
>  - stops pnx8550 to log every interrupt as spurious
>  - adds cause register masks for ip22/ip32, which caused handling
>    of masked interrupts
>  - removes some superfluous parentheses in the SNI interrupt code

Thanks for sorting this out.

Now, I think spurious_interrupt should be deleted, it delivers not too
much useful data and even the reasoning for adding it back in the dark
ages was fairly weak ...

  Ralf
