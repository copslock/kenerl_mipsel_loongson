Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2005 20:04:30 +0100 (BST)
Received: from localhost.localdomain ([IPv6:::ffff:127.0.0.1]:28132 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225750AbVGZTEN>; Tue, 26 Jul 2005 20:04:13 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6QJ6ide013267;
	Tue, 26 Jul 2005 15:06:44 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6QJ6hlM013266;
	Tue, 26 Jul 2005 15:06:43 -0400
Date:	Tue, 26 Jul 2005 15:06:43 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: how to access structured registers correctly
Message-ID: <20050726190643.GD7088@linux-mips.org>
References: <20050726182531.6341586f.Hiroshi_DOYU@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726182531.6341586f.Hiroshi_DOYU@montavista.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 26, 2005 at 06:25:31PM +0900, Hiroshi DOYU wrote:
> Date:	Tue, 26 Jul 2005 18:25:31 +0900
> From:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
> To:	linux-mips@linux-mips.org
> Subject: how to access structured registers correctly
> Content-Type: text/plain; charset=US-ASCII
> 
> Hello experts,
> 
> I am wondering how to access registers correctly by usging structured 
> register definitions in TX4938 particularly.
> 
> Some time ago, Linus told "volatile" on a data structure as described 
> below,
> 
> 	http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/1387.html
> 
> 
> In tx4938, every register access is done by using "volatile" like below.

Linus is right, volatile is a dangerous thing.  If you want to write
portable code there's a bunch of things that are not being taken care of
by plain C - even though in my opinion foo->somereg = 42 is more
readable than writel(somereg, 42).  Among the things the pointer to
volatile struct method doesn't catch are endianess conversion that might
be necessary on some systems, write merging, dealing with write buffers
or completly insane methods of attaching the bus such as the infamous
ISA / EISA cage that's attached to the host system through a USB
interface.

Now, how does that affect your TX4928 code?  Probably not terribly much
because you're using a SOC so the configuration of the system is fixed.

  Ralf
