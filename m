Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2007 13:09:20 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:61654 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022395AbXK2NJR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Nov 2007 13:09:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lATD95Ig017076;
	Thu, 29 Nov 2007 13:09:05 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lATD94hL017075;
	Thu, 29 Nov 2007 13:09:04 GMT
Date:	Thu, 29 Nov 2007 13:09:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Thomas Koeller <thomas@koeller.dyndns.org>,
	linux-mips@linux-mips.org
Subject: Re: git problem
Message-ID: <20071129130903.GB14655@linux-mips.org>
References: <200711281950.46472.thomas@koeller.dyndns.org> <474EA356.3070303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474EA356.3070303@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 29, 2007 at 12:32:38PM +0100, Franck Bui-Huu wrote:

> Thomas Koeller wrote:
> > on my machine I have clones of both the linux-mips and
> > Linus' kernel tree. I recently found that git-describe
> > behaves differently in those trees:
>  
> [snip]
> 
> > The commit is of course present in both trees. AFAIK the
> > 'cannot describe' error shows if there are no tags at all,
> > but this is not the case; .git/refs/tags is fully populated.
> 
> Not really, it can happen if the commit you're trying to describe and
> all of its parents are not tagged.
> 
> > Has anybody got a clue as to what may be wrong here?
> 
> Is the commit originally part of Linus' tree and was pulled later by
> Ralf ?
> 
> If so, it probably means that the commits committed by Ralf in his
> tree, which are the tagged ones, have no relationship with the ones
> pulled from Linus.

I intentionally do not carry the tags from Linus tree in the lmo git
tree.  Lots of additional tags with little actual use.  Whoever would
like then can pull from Linus' tree into a lmo clone to get Linus'
tags.

Back to the original topic - git describe fails even with some of the
very old commits of the lmo tree which are known to be tagged so there
is something wrong.

  Ralf
