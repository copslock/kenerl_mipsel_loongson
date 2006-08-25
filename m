Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2006 01:11:01 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:417 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20038528AbWHYALA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2006 01:11:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7P0BIsK001295;
	Fri, 25 Aug 2006 01:11:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7P0BDHb001294;
	Fri, 25 Aug 2006 01:11:13 +0100
Date:	Fri, 25 Aug 2006 01:11:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 9/12] removed unused resources for Cobalt
Message-ID: <20060825001113.GA32490@linux-mips.org>
References: <20060822225755.55a055c0.yoichi_yuasa@tripeaks.co.jp> <20060824193121.GA23792@colonel-panic.org> <20060825081107.45e9996e.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825081107.45e9996e.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 25, 2006 at 08:11:07AM +0900, Yoichi Yuasa wrote:

> > Is this correct ? These resources maybe unused, but the registers are
> > there, and should be listed as unavailable.
> 
> How about the change of them to "reserved"?

Afaik the SuperIO chip used in the Cobalt implements those registers but
due to missing external circuitry touching some of these registers is
dangerous.  Afaic that is the case for the PS/2 keyboard/mouse controller
ports.  So those should be marked as reserved.  The remaining registers
are implemented just not terribly useful, so I think what he have is
probably right as it is.

  Ralf
