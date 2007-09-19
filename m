Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 17:58:13 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42906 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023823AbXISQ6L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Sep 2007 17:58:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8JGwAoX015378;
	Wed, 19 Sep 2007 17:58:10 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8JGw92Q015377;
	Wed, 19 Sep 2007 17:58:09 +0100
Date:	Wed, 19 Sep 2007 17:58:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
Subject: Re: MIPS atomic memory operations (A.K.A PR 33479).
Message-ID: <20070919165809.GA14767@linux-mips.org>
References: <46F06980.4080500@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46F06980.4080500@avtrex.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 18, 2007 at 05:12:48PM -0700, David Daney wrote:

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
>   "1:\tll" SUFFIX "\t%0,%1\n"			\
>   "\tbne\t%0,%2,2f\n"				\
>   "\t" OP "\t%@,%3\n"				\
>   "\tsc" SUFFIX "\t%@,%1\n"			\
>   "\tbeq\t%@,%.,1b\n"				\

Please make this loop closure branch a branch-likely.  This is necessary
as a errata workaround for some processors.

(I know silicon people hate me for keeping branch likely instruction alive
this way but it's my job to make sure Linux and software are working without
unpleasant surprises.)

>   "\tnop\n"					\
>   "2:%]%>%)"
> 
> 
> 
> I guess my basic question is:  Should MIPS_COMPARE_AND_SWAP have a 
> 'sync' after the 'sc'?  I would have thought that 'sc' made the write 
> visible to all CPUs, but on the SB1 it appears not to be the case.

The MIPS architecture specification specifies no memory model, so for
portable code you need to make a worst case assumption which is weak
ordering.

Only on R4000 and R4400 SC and SCD did imply a SYNC operation.

> If we do need to add another 'sync' should it go in the delay slot of 
> the branch?  I would say yes because we would expect the branch to 
> rarely taken.

Not when using a branch likely.

Btw, I recently wrote an article about memory consistency which is at
http://www.linux-mips.org/wiki/Memory_consistency.  It gives a bit of
an overview of things in general and on MIPS specifically.  I request
people with detailed knowledge of MIPS cores not specifically covered
in that article to contribute.

  Ralf
