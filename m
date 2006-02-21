Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 17:59:57 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:3085 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133366AbWBUR7t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 17:59:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1LI6pBW009859;
	Tue, 21 Feb 2006 18:06:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1LI6oCD009858;
	Tue, 21 Feb 2006 18:06:50 GMT
Date:	Tue, 21 Feb 2006 18:06:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] add some __user tags
Message-ID: <20060221180650.GA3815@linux-mips.org>
References: <20060221.013435.104641385.anemo@mba.ocn.ne.jp> <20060220172038.GB18561@linux-mips.org> <20060220174720.GA28701@linux-mips.org> <20060221.160511.118969010.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221.160511.118969010.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 21, 2006 at 04:05:11PM +0900, Atsushi Nemoto wrote:
> Date:	Tue, 21 Feb 2006 16:05:11 +0900 (JST)
> To:	ralf@linux-mips.org
> Cc:	linux-mips@linux-mips.org
> Subject: Re: [PATCH] add some __user tags
> From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Content-Type: Text/Plain; charset=us-ascii
> 
> >>>>> On Mon, 20 Feb 2006 17:47:20 +0000, Ralf Baechle <ralf@linux-mips.org> said:
> ralf> Or rather queued for 2.6.17,
> 
> Please dequeue it and enqueue this revised one.  This does not touch
> sys32_getdents() and sys32_readdir() since I just sent an another
> patch to remove them.

Will do.  I think I'm going to convert the 2.6.17 queue to quilt first,
that's going to make updating, reordering, resolving conflicts, splitting
and merging patches etc. much easier.  So just git as the distribution
medium for the queue-2.6.17 branch.

  Ralf
