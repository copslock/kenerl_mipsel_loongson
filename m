Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 16:50:14 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59847 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133555AbWFSPuE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jun 2006 16:50:04 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5JFo2we014004;
	Mon, 19 Jun 2006 16:50:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5JFo140013977;
	Mon, 19 Jun 2006 16:50:01 +0100
Date:	Mon, 19 Jun 2006 16:50:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Merge window ...
Message-ID: <20060619155001.GA12123@linux-mips.org>
References: <20060619103653.GA4257@linux-mips.org> <20060620000346.2b704b9b.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620000346.2b704b9b.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 20, 2006 at 12:03:46AM +0900, Yoichi Yuasa wrote:

> 
> 4G Systems MTX-1
> AMD Alchemy Bosporus
> AMD Alchemy Mirage
> Jazz family
> Toshiba TBTX49[23]7
> 
> These boards are candidate for removal.
> If there are none objection, we can add to feature-removal-schedule.txt.

A little too much.  Malta for example works and I'm running top of tree.
Jazz is happy, SNI was doing ok and received a major upgrade just on
the weekend  and the Broadcom stuff - aside of slight bitrot is crucially
important for many projects as the provider of horsepower for native
builds.

My candidates for nuking are marked with a big red box in the wiki in
the hope somebody will fix the code:

  http://www.linux-mips.org/wiki/Category:Deprecated

Many eval boards tend to have a short livespan unlike vintage workstation
and server hardware, so I tend to be trigger happier for eval board
type of stuff.

  Ralf
