Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2005 22:30:40 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:15006 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133359AbVIVVaW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2005 22:30:22 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1EIYe4-0004BP-Hc; Thu, 22 Sep 2005 17:30:20 -0400
Date:	Thu, 22 Sep 2005 17:30:20 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS64 NPTL Status
Message-ID: <20050922213020.GA15905@nevyn.them.org>
References: <43323D35.9030905@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43323D35.9030905@jg555.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 21, 2005 at 10:12:21PM -0700, Jim Gifford wrote:
> Looking through the latest glibc snapshot they have removed linuxthreads 
> and moved it to ports. I know Daniel has been working on getting NPTL to 
> work on MIPS32, which it does. Thank you Daniel. I know from emails I 
> read around linux-mips.org he was going to work on MIPS64 NPTL, just 
> curious to the status.
> 
> For the record the current glibc snapshot will not build at all under 
> MIPS64. Here is the error message I have received, still working on 
> getting it to build properly

Hi Jim,

I've got complete patches to do this.  I thought I'd already submitted
them, but I found out yesterday morning that I hadn't... simply an
accident.  I've posted my complete set of glibc patches here:

http://return.false.org/~drow/mips/glibc-2005-09-22-HEAD-MIPS64-NPTL.tar.gz

As of this morning, they work for me, using GCC HEAD and binutils HEAD.
Rather more work is required for GDB (see my earlier post today and the
last patch in the above tarball).

There are some test failures.  IIRC, at least one of them is a GCC
unwinder bug that I haven't dug out the fix for yet from my archives.
I'm going to try to get all of this merged soon.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
