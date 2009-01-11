Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2009 17:44:58 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39057 "EHLO mail.linux-mips.net")
	by ftp.linux-mips.org with ESMTP id S21365705AbZAKRoz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2009 17:44:55 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.14.3/8.14.2) with ESMTP id n0BHiprp001754;
	Sun, 11 Jan 2009 17:44:51 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0BHio6U001752;
	Sun, 11 Jan 2009 17:44:50 GMT
Date:	Sun, 11 Jan 2009 17:44:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Phil Sutter <n0-1@freewrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] define io_map_base for rc32434's PCI controller
Message-ID: <20090111174450.GB21239@linux-mips.org>
References: <1226445364-5402-1-git-send-email-n0-1@freewrt.org> <200901111708.59195.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200901111708.59195.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 11, 2009 at 05:08:58PM +0100, Florian Fainelli wrote:

> This patch still applies to current linux-queue/linux.git, can you merge it 
> please ? Thanks a lot.

I sent a pull request for the stuff in the upstream-linus tree earlier
today.  To avoid possible confusion and I'll roll the next tree for him
only after he pulled this one.

  Ralf
