Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2006 11:59:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7360 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133833AbWFVK7k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Jun 2006 11:59:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5MAxTZj006018;
	Thu, 22 Jun 2006 11:59:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5MAxSRf006017;
	Thu, 22 Jun 2006 11:59:28 +0100
Date:	Thu, 22 Jun 2006 11:59:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	Jean Delvare <khali@linux-fr.org>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: i2c-algo-ite and i2c-ite planned for removal
Message-ID: <20060622105928.GA4032@linux-mips.org>
References: <20060615225723.012c82be.khali@linux-fr.org> <1150406598.1193.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150406598.1193.73.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 16, 2006 at 12:23:17AM +0300, Pete Popov wrote:

> For historical correctness, this driver was once upon a time usable,
> though it was a few years ago. It was written by MV for some ref board
> that had the ITE chip and it did work. That ref board is no longer
> around so it's probably safe to nuke the driver. 

Not quite true; the board support for that board is still around and it's
on my to-be-nuked list for after 2.6.18.

  Ralf
