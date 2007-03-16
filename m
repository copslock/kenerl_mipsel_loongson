Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 23:26:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:47007 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022621AbXCPX0n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 23:26:43 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2GNOhC7026932;
	Fri, 16 Mar 2007 23:24:43 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2GNOgMf026931;
	Fri, 16 Mar 2007 23:24:42 GMT
Date:	Fri, 16 Mar 2007 23:24:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	akpm@linux-foundation.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/12] mips: PMC MSP71xx core platform
Message-ID: <20070316232442.GB17478@linux-mips.org>
References: <200703162132.l2GLWuAv032733@pasqua.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200703162132.l2GLWuAv032733@pasqua.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 16, 2007 at 03:32:56PM -0600, Marc St-Jean wrote:

> [PATCH 1/12] mips: PMC MSP71xx core platform
> 
> Patch to add core platform support for the PMC-Sierra
> MSP71xx devices.

When I first reviewed this patch I requested removal of prom_printf and
all stuff like prom_getchar, prom_putchar that was associated with it
because I was about to remove prom_printf.  Well, prom_printf is gone
now which means this patch will no longer work ...

  Ralf
