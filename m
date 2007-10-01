Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 11:44:06 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:31714 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022183AbXJAKoE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 11:44:04 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l914Miss022359
	for <linux-mips@linux-mips.org>; Mon, 1 Oct 2007 05:22:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l914Mh1b022358;
	Mon, 1 Oct 2007 05:22:43 +0100
Date:	Mon, 1 Oct 2007 05:22:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mark Zhan <rongkai.zhan@windriver.com>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com, a.zummo@towertech.it
Subject: Re: [PATCH 4/4] MIPS: Remove the legacy RTC codes of MIPS sibyte
	boards
Message-ID: <20071001042243.GA22342@linux-mips.org>
References: <46FF7283.7050702@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46FF7283.7050702@windriver.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Sep 30, 2007 at 05:55:15PM +0800, Mark Zhan wrote:

> This patch removes the legacy RTC codes of MIPS sibyte boards,
> which are replaced by new RTC class drivers. And a board init
> routine is added to register sibyte platform devices.
> 
> Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
> ---
>  arch/mips/sibyte/swarm/Makefile        |    2
>  arch/mips/sibyte/swarm/rtc_m41t81.c    |  232 
>  ---------------------------------
>  arch/mips/sibyte/swarm/rtc_xicor1241.c |  209 -----------------------------
>  arch/mips/sibyte/swarm/setup.c         |   56 +++++--
>  4 files changed, 37 insertions(+), 462 deletions(-)

Patch looks okay but does not apply to the top of the -queue tree due
to the dyntick patches which basically turn every piece of time code
on MIPS upside down.  Can you respin this patch against the -queue tree?

Thanks,

  Ralf
