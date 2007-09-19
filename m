Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 09:53:34 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:46475 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021517AbXISIxZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2007 09:53:25 +0100
Received: from lagash (88-106-155-113.dynamic.dsl.as9105.com [88.106.155.113])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 8054AB83BD;
	Wed, 19 Sep 2007 10:45:16 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IXvBL-0006zr-S9; Wed, 19 Sep 2007 09:45:15 +0100
Date:	Wed, 19 Sep 2007 09:45:15 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	David Daney <ddaney@avtrex.com>
Cc:	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
Subject: Re: MIPS atomic memory operations (A.K.A PR 33479).
Message-ID: <20070919084515.GM9972@networkno.de>
References: <46F06980.4080500@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46F06980.4080500@avtrex.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Richard,
>
> There seems to be a small problem with the MIPS atomic memory operations 
> patch I recently committed 
> (http://gcc.gnu.org/ml/gcc-patches/2007-08/msg01290.html), in that on a 
> dual CPU machine it does not quite work.
>
> You can look at http://gcc.gnu.org/bugzilla/show_bug.cgi?id=33479#c3 for 
> more information.
>
> Here is the code in question (from mips.h):
>
> #define MIPS_COMPARE_AND_SWAP(SUFFIX, OP)	\
>   "%(%<%[sync\n"				\

This sync is for SB-1 implied by ll, but other MIPS systems may
need it.

>   "1:\tll" SUFFIX "\t%0,%1\n"			\
>   "\tbne\t%0,%2,2f\n"				\
>   "\t" OP "\t%@,%3\n"				\
>   "\tsc" SUFFIX "\t%@,%1\n"			\
>   "\tbeq\t%@,%.,1b\n"				\
>   "\tnop\n"					\

The SB-1 needs a "sync" here.

>   "2:%]%>%)"
>
>
>
> I guess my basic question is:  Should MIPS_COMPARE_AND_SWAP have a 'sync' 
> after the 'sc'?  I would have thought that 'sc' made the write visible to 
> all CPUs, but on the SB1 it appears not to be the case.
>
> If we do need to add another 'sync' should it go in the delay slot of the 
> branch?  I would say yes because we would expect the branch to rarely 
> taken.

But it would make things a lot worse for the contended case, which is
the interesting one for performance.


Thiemo
