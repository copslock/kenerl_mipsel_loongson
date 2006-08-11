Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 00:17:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2464 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20045180AbWHKXRS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2006 00:17:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7BNHDsl007284;
	Sat, 12 Aug 2006 00:17:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7BNH0Ol007283;
	Sat, 12 Aug 2006 00:17:00 +0100
Date:	Sat, 12 Aug 2006 00:17:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Daniel Mack <daniel@caiaq.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Au1200 OHCI/EHCI fixes
Message-ID: <20060811231700.GD5811@linux-mips.org>
References: <20060810065337.GA8889@roarinelk.homelinux.net> <78B291EC-774F-4FDF-AB9D-133F38A3215E@caiaq.de> <20060810141914.GA9844@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810141914.GA9844@roarinelk.homelinux.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 10, 2006 at 04:19:14PM +0200, Manuel Lauss wrote:

> I searched the mips ML prior to sending.
> Guess I'll have to have a talk about git with
> the firewall guy...

My favorite firewalling product is selling at unbeatably low prices
under the name patch cable ;-)

Short of such a high-performance firewalling enhancment you can also use
the rsync protocol or the http protocol with git.  Both are significantly
less efficient than the native git protocol so should only be used if
plan A that is the git protocol fails.

  Ralf
