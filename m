Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2003 23:19:29 +0100 (BST)
Received: from [IPv6:::ffff:207.215.131.7] ([IPv6:::ffff:207.215.131.7]:57810
	"EHLO ns.pioneer-pdt.com") by linux-mips.org with ESMTP
	id <S8225250AbTF0WT1>; Fri, 27 Jun 2003 23:19:27 +0100
Received: from philt.mrp.pioneer-pdt.com ([172.30.2.110])
          by ns.pioneer-pdt.com (Post.Office MTA v3.5.3 release 223
          ID# 0-68491U100L2S100V35) with ESMTP id com;
          Fri, 27 Jun 2003 15:21:32 -0700
From: patrick.hilt@pioneer-pdt.com (Patrick Hilt)
Organization: Pioneer
To: Jun Sun <jsun@mvista.com>
Subject: Re: KGDB problem
Date: Fri, 27 Jun 2003 15:18:32 -0400
User-Agent: KMail/1.5
References: <200306271411.18555.philt@pioneer-pdt.com> <20030627141945.S31851@mvista.com>
In-Reply-To: <20030627141945.S31851@mvista.com>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306271518.32093.philt@pioneer-pdt.com>
Return-Path: <patrick.hilt@pioneer-pdt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: patrick.hilt@pioneer-pdt.com
Precedence: bulk
X-list: linux-mips

Hi Jun!
Thank you very much for your reply! I very much appreciate it! I think I am 
getting a little confused now... I read your "Linux MIPS porting howto" (very 
informative, thanks a lot :-) and consulted some other documents about this 
and there it says to have a kernel command line such as "... gdb gdbttys=1 
gdbbaud=115200". Now, should I just try to add "kgdb=ttys1" to that or 
replace the previous command with it. Sorry if I am asking a stupid question 
but this process is not very well documented... somehow...

Again, thanks a lot for your help!!

Patrick


On Friday 27 June 2003 05:19 pm, Jun Sun wrote:
> On Fri, Jun 27, 2003 at 02:11:18PM -0400, Patrick Hilt wrote:
> > Hello!
> > I just recently started working on Broadcom MIPS32 architecture (7115
> > chipset based STB, Broadcom modified 2.4.18 kernel) and have been trying
> > to get kgdb setup to do some kernel source level debugging... with little
> > success I might add ;-|. I compiled remote debug support in to the
> > kernel, added kernel command line parameters and tried a dozen different
> > configurations... but never got a "Wait for gdb client connection..."
> > message at boot time.  The box happily continues to boot on. On the other
> > hand, there seems to be support for debugging in the kernel source since
> > there is a .../dbg_io.c implementation.
>
> Kgdb support is board dependent.  Some boards, such as Malta, decide to
> skip kgdb _even when_ you configure it.  To activate kgdb, you need to
> pass command line args, such as "kgdb=ttyS1", to kernel.  What a smart
> idea. :)
>
> Check the source for your board.
>
> What I like to see is kgdb should be activated when it is configured.
> However, "nokgdb" argument can be passed to kernel to skip it even when
> kgdb is configured.
>
> Jun
