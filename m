Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 22:04:34 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:53185 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8226101AbVF3VEN>;
	Thu, 30 Jun 2005 22:04:13 +0100
Received: from drow by nevyn.them.org with local (Exim 4.51)
	id 1Do6CU-0006KK-9l; Thu, 30 Jun 2005 17:03:58 -0400
Date:	Thu, 30 Jun 2005 17:03:58 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Bryan Althouse <bryan.althouse@3phoenix.com>,
	'Linux/MIPS Development' <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
Message-ID: <20050630210357.GA23456@nevyn.them.org>
References: <20050630173409Z8226102-3678+735@linux-mips.org> <20050630202111.GC3245@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630202111.GC3245@linux-mips.org>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 30, 2005 at 09:21:11PM +0100, Ralf Baechle wrote:
> On Thu, Jun 30, 2005 at 01:33:39PM -0400, Bryan Althouse wrote:
> 
> > The executable will seg fault.  If I remove the -lpthread, it is fine.
> > Also, if I change the 64 to 32, it is fine.
> 
> I fear you may be hitting these problems simple because you're the first
> through the mine field of 64-bit pthreads ;-)  So far most people are
> simple running 32-bit software on their 64-bit kernels.  No reason to
> panic though, most of the bits are in place, it's just the one or other
> insect hiding in the code.

Bryan seems to be using the original Red Hat gnupro 64-bit toolchain. 
I don't know how well that works nowadays; but current CVS versions do
work, or did when I last tested (a month or two ago).

-- 
Daniel Jacobowitz
CodeSourcery, LLC
