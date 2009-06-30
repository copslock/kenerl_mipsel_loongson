Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jun 2009 16:51:10 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44093 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493041AbZF3OvC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Jun 2009 16:51:02 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5UEjgmx019179;
	Tue, 30 Jun 2009 15:45:42 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5UEjeX0019177;
	Tue, 30 Jun 2009 15:45:40 +0100
Date:	Tue, 30 Jun 2009 15:45:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [BUG] MIPS: Hibernation in the latest linux-mips:master branch
	not work
Message-ID: <20090630144540.GA18212@linux-mips.org>
References: <1246372868.19049.17.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246372868.19049.17.camel@falcon>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 30, 2009 at 10:41:08PM +0800, Wu Zhangjin wrote:

> I just updated my git repository to the master branch of the latest
> linux-mips git repository, and tested the STD/Hibernation support on
> fuloong2e and yeeloong2f, it failed:
> 
> when using the no_console_suspend kernel command line to debug, it
> stopped on:
> 
> PM: Shringking memory... done (1000 pages freed)
> PM: Freed 160000 kbytes in 1.68 seconds (95.23 MB/s)
> PM: Creating hibernation image:
> PM: Need to copy 5053 pages
> PM: Hibernation image created (4195 pages copied)
> 
> and then, the number indicator light of keyboard works well, but can not
> type anything. 
> 
> anybody have tested it on another platform? does it work?

At the time of the merge I tested it on Malta and found it to be working.

  Ralf
