Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2003 23:45:51 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:10998 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225250AbTF0Wpt>;
	Fri, 27 Jun 2003 23:45:49 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h5RMjl721405;
	Fri, 27 Jun 2003 15:45:47 -0700
Date: Fri, 27 Jun 2003 15:45:47 -0700
From: Jun Sun <jsun@mvista.com>
To: Patrick Hilt <patrick.hilt@pioneer-pdt.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: KGDB problem
Message-ID: <20030627154547.T31851@mvista.com>
References: <200306271411.18555.philt@pioneer-pdt.com> <20030627141945.S31851@mvista.com> <200306271518.32093.philt@pioneer-pdt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200306271518.32093.philt@pioneer-pdt.com>; from patrick.hilt@pioneer-pdt.com on Fri, Jun 27, 2003 at 03:18:32PM -0400
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Jun 27, 2003 at 03:18:32PM -0400, Patrick Hilt wrote:
> Hi Jun!
> Thank you very much for your reply! I very much appreciate it! I think I am 
> getting a little confused now... I read your "Linux MIPS porting howto" (very 
> informative, thanks a lot :-) and consulted some other documents about this 
> and there it says to have a kernel command line such as "... gdb gdbttys=1 
> gdbbaud=115200". Now, should I just try to add "kgdb=ttys1" to that or 
> replace the previous command with it. Sorry if I am asking a stupid question 
> but this process is not very well documented... somehow...
>

The exact command can only be found in the kernel tree for that board.
Since we don't have the source code for your board, you have
to figure it out yourself.

For example, the way to figure what command Malta wants for kgdb
is to look at arch/mips/mips-boards/malta/malta_setup.c.

Jun
