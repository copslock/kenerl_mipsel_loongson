Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2005 20:18:18 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:43277 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225362AbVIOTSD>; Thu, 15 Sep 2005 20:18:03 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8FJHvU2017701;
	Thu, 15 Sep 2005 20:17:57 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8FJHm83017700;
	Thu, 15 Sep 2005 20:17:48 +0100
Date:	Thu, 15 Sep 2005 20:17:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Don Hiatt <Don_Hiatt@pmc-sierra.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Trival shell script crashes under 2.4.25
Message-ID: <20050915191747.GT3224@linux-mips.org>
References: <5C1FD43E5F1B824E83985A74F396286E5E9475@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C1FD43E5F1B824E83985A74F396286E5E9475@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 14, 2005 at 04:00:40PM -0700, Don Hiatt wrote:

>   Sorry if this is the wrong list to post to; if it is, could you
> please suggest an alternative? :)

How about linux-mips ;-)

>   Below you will find a very simple shell script that crashes under
> 2.4.25 running on a RM9000 (PMC rm7935) with busybox 1.0. This script
> just demonstrates the actual problem but I do not believe it is 
> isolated to busybox. In fact I wrote a simple program that just does
> this:
> 	* for(;;)
> 		* fork()
> 			* mmap file "foo"
> 			* compare "foo" to an array image
> 		* waitpid()

linux-mips.org has no RM9000 support in it's 2.4 code.  That leaves
it up to guessing what could be happening in your codebase.

> and it will run for a while and then SEGFAULT at various times. According
> to GDB the stack is corrupted and looking at the PC it does seem bogus
> (0x2acf2e50). 

That would be a typical address for a shared library.

>   The program crashes after a random amount of time but generally no more
> that a minute or so. I can speed up the process if I ping-flood the target.
> 
>   Now what is really wierd is that if I run the program under gdbserver
> it doesn't crash (or at least has not in the last 1/2 hour). Does gdbserver
> change the execution context differently that gdb??

Strange indeed.  Both shouldn't affect the state of a running program
as long as it isn't being stopped.

  Ralf
