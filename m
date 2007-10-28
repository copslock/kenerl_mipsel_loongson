Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 20:40:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13501 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023810AbXJ1UkU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Oct 2007 20:40:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9SKeH4S017005;
	Sun, 28 Oct 2007 20:40:17 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9SKeAmn017004;
	Sun, 28 Oct 2007 20:40:10 GMT
Date:	Sun, 28 Oct 2007 20:40:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stephen Hemminger <shemminger@linux-foundation.org>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Fix/Rewrite of the mipsnet driver
Message-ID: <20071028204010.GA16898@linux-mips.org>
References: <20071028043846.GM29176@networkno.de> <20071029002517.GB16913@linux-mips.org> <20071028200308.GB22287@networkno.de> <20071028132204.5ab09c10@freepuppy.rosehill>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071028132204.5ab09c10@freepuppy.rosehill>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 28, 2007 at 01:22:04PM -0700, Stephen Hemminger wrote:

> > -#define MIPSNET_INTCTL_TXDONE     ((uint32_t)(1 <<  0))
> > -#define MIPSNET_INTCTL_RXDONE     ((uint32_t)(1 <<  1))
> > -#define MIPSNET_INTCTL_TESTBIT    ((uint32_t)(1 << 31))
> > -#define MIPSNET_INTCTL_ALLSOURCES	(MIPSNET_INTCTL_TXDONE | \
> > -					 MIPSNET_INTCTL_RXDONE | \
> > -					 MIPSNET_INTCTL_TESTBIT)
> 
> It is standard practice in the kernel to use u32 rather than uint32_t.

uint32_t has widely leaked in and as long as it's not used in headers
exported to userland is perfectly fine.  But if we want to achieve
consistence throughout the kernel it'll take a little witch hunt for
uint32_t and co.

> Also cast of shift is unneeded  (1u << 0) works fine.

Old sins of mipsnet.h which was just copied into mipsnet.c.  Or toothing
pains of a driver on its way to sanity.

  Ralf
