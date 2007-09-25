Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 14:18:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:54488 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023053AbXIYNSo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 14:18:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8PDILbI001888;
	Tue, 25 Sep 2007 14:18:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8PDIH4x001887;
	Tue, 25 Sep 2007 14:18:17 +0100
Date:	Tue, 25 Sep 2007 14:18:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac: Driver model & phylib update
Message-ID: <20070925131817.GA28402@linux-mips.org>
References: <Pine.LNX.4.64N.0709191811040.24627@blysk.ds.pg.gda.pl> <20070921124409.7f3d122b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070921124409.7f3d122b.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 21, 2007 at 12:44:09PM -0700, Andrew Morton wrote:

> >  A driver model and phylib update.
> 
> akpm:/usr/src/25> diffstat patches/git-net.patch | tail -n 1
>  1013 files changed, 187667 insertions(+), 23587 deletions(-)
> 
> Sorry, but raising networking patches against Linus's crufty
> old mainline tree just isn't viable at present.

Out of curiosity:

[ralf@denk linux-queue]$ git diff $(git merge-base master v2.6.23-rc8-mm1)..v2.6.23-rc8-mm1 | wc -cl
1046669 31900996
[ralf@denk linux-queue]$ git diff $(git merge-base master v2.6.23-rc8-mm1)..v2.6.23-rc8-mm1 | diffstat | tail -1
 6049 files changed, 573635 insertions(+), 207630 deletions(-)
[ralf@denk linux-queue]$ 

We're all a little too productive ;-)

  Ralf
