Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2006 22:57:08 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:34460 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20027711AbWINV5G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 Sep 2006 22:57:06 +0100
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id C30EBE404D;
	Thu, 14 Sep 2006 15:17:40 -0700 (PDT)
Subject: Re: early_initcall
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060907033050.GA17965@linux-mips.org>
References: <66910A579C9312469A7DF9ADB54A8B7D366028@exchange.ZeugmaSystems.local>
	 <1157566247.6485.12.camel@sandbar.kenati.com>
	 <20060907033050.GA17965@linux-mips.org>
Content-Type: text/plain
Date:	Thu, 14 Sep 2006 15:05:05 -0700
Message-Id: <1158271505.7660.9.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Thank you for your email Ralf.  

The kernel now crashes inconsistently.  Firstly when I load the image in
YAMON and issue the go . command, it does not always give a machine
exception.  It seems to be stuck in the  do_fast_cp0_gettimeoffset
function, as the log buffer only contains this line recursively printed
from the printk statement inserted in the function as below: 

static unsigned long cached_quotient=0;
printk("INSIDE DO FAST CP0 GETTIMEOFFSET\n");
tmp = jiffies;


When I step through the dissassembly code, do_fast_cp0_gettimeoffset
function gets executed smoothly and the kernel crashed in the ways
listed below:

1) After the 3rd iteration of the  for (;;) loop in the
parse_cmdline_early file, a machine exception was generated.

-- If I step through the code in the for loop, all the 3 printk
statments that I have put get executed sequentially.  However if I only
introduce one break point at the first printk statement and run through
the loop, none of the statements are executed although control still
comes back to the break point! Also, none of the if conditions in the
for loop are ever satisfied.

2) In the same for loop -- between the 4th and 15th iteration the
breakpoint at  "c = *(from++);" is skipped and again the contents of the
logbuf are bizzarely overwritten by the one printk("INSIDE DO FAST CP0
GETTIMEOFFSET\n"); statement! -- This happened 3 times.

Any pointers?

Thank you,
Ashlesha.
  





On Thu, 2006-09-07 at 05:30 +0200, Ralf Baechle wrote: 
> On Wed, Sep 06, 2006 at 11:10:47AM -0700, Ashlesha Shintre wrote:
> 
> > I googled early_initcall and found a patch which basically adds this
> > line to the /include/init.h file:
> > 
> > #define early_initcall(fn)             __define_initcall(".early1",fn)
> 
> There is more infrastructure needed to get this to work.  And in fact why
> are you trying to get it to work at all - a direct call from setup_arch
> to your early init function is trivial to do.
> 
> > I built a kernel image with this new line included and now if I try
> > executing it, the bootloader YAMON gives an exception error before it
> > can even begin!  Here is the dump:
> 
> Such a dump could be from YAMON or in the very early phase of the kernel
> initialization.

> > A machine check means that an exception is generated due to duplicate
> > TLB entries.  I dont understand why the kernel crashes so early.
> 
> There are also other implementation specified reasons that may result
> in a machine check exception as well.
> 
> > Also, what does the ".early1" mean? Is that a definition of a different
> > segment in the init.h file?
> 
> Section not segment.  It's just a section name.
> 
> > I checked output of the "readelf -a vmlinux" and found that the address
> > for the early_initcall comes up about 5 times.  I m not sure what each
> > of the fields mean, so I have attached the above part of the readelf in
> > a file called readelf.
> 
> And if you had not quoted 50 lines of the previous message in this thread
> but those lines from the readelf output we might actually tell you.
> 
>   Ralf
