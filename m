Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2003 22:19:50 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:20729 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225250AbTF0VTs>;
	Fri, 27 Jun 2003 22:19:48 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h5RLJjD20993;
	Fri, 27 Jun 2003 14:19:45 -0700
Date: Fri, 27 Jun 2003 14:19:45 -0700
From: Jun Sun <jsun@mvista.com>
To: Patrick Hilt <patrick.hilt@pioneer-pdt.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: KGDB problem
Message-ID: <20030627141945.S31851@mvista.com>
References: <200306271411.18555.philt@pioneer-pdt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200306271411.18555.philt@pioneer-pdt.com>; from patrick.hilt@pioneer-pdt.com on Fri, Jun 27, 2003 at 02:11:18PM -0400
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Jun 27, 2003 at 02:11:18PM -0400, Patrick Hilt wrote:
> Hello!
> I just recently started working on Broadcom MIPS32 architecture (7115 chipset 
> based STB, Broadcom modified 2.4.18 kernel) and have been trying to get kgdb 
> setup to do some kernel source level debugging... with little success I might 
> add ;-|. I compiled remote debug support in to the kernel, added kernel 
> command line parameters and tried a dozen different configurations... but 
> never got a "Wait for gdb client connection..." message at boot time.  The box 
> happily continues to boot on. On the other hand, there seems to be support 
> for debugging in the kernel source since there is a .../dbg_io.c 
> implementation.
>

Kgdb support is board dependent.  Some boards, such as Malta, decide to
skip kgdb _even when_ you configure it.  To activate kgdb, you need to
pass command line args, such as "kgdb=ttyS1", to kernel.  What a smart idea. :)

Check the source for your board.

What I like to see is kgdb should be activated when it is configured.
However, "nokgdb" argument can be passed to kernel to skip it even when
kgdb is configured.

Jun
