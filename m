Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 17:58:06 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:9626 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21494362AbYJNQ6D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 17:58:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9EGvvvN011445;
	Tue, 14 Oct 2008 17:57:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9EGvv0a011444;
	Tue, 14 Oct 2008 17:57:57 +0100
Date:	Tue, 14 Oct 2008 17:57:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	a.zummo@towertech.it
Subject: Re: [PATCH v4] M48T35: new RTC driver
Message-ID: <20081014165756.GD11407@linux-mips.org>
References: <20081014151732.DBFA3C3AEA@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081014151732.DBFA3C3AEA@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 14, 2008 at 05:17:32PM +0200, Thomas Bogendoerfer wrote:

> This driver replaces the broken ip27-rtc driver in drivers/char and
> gives back RTC support for SGI IP27 machines.
> 
> Acked-by: Alessandro Zummo <alessandro.zummo@towertech.it>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> 
> Please apply for 2.6.28

Thanks, applied.

  Ralf
