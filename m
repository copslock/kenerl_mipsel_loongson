Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 May 2004 02:10:37 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:49148 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225740AbUEHBKd>;
	Sat, 8 May 2004 02:10:33 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i481AWx6021181;
	Fri, 7 May 2004 18:10:32 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i481AVSU021179;
	Fri, 7 May 2004 18:10:31 -0700
Date: Fri, 7 May 2004 18:10:31 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: semaphore woes in 2.6, 32bit
Message-ID: <20040507181031.F9702@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I got a bunch of segfaults which are due to HAS_LLSCD cpu operating
on a semaphore which is aligned along 4-byte boundary instead of the
desired 8-byte boundary.

I traced down one such place at serial/serial_core.c:

int uart_register_driver(struct uart_driver *drv)
{
        struct tty_driver *normal = NULL;
        int i, retval;

        BUG_ON(drv->state);

        /*
         * Maybe we should be using a slab cache for this, especially if
         * we have a large number of ports to handle.
         */
        drv->state = kmalloc(sizeof(struct uart_state) * drv->nr, GFP_KERNEL);
...

where drv->state contains a semaphore variable, but apparently kmalloc() only
give 4-byte boundary alignment.

There are many other faults, which I did not bother to trace down.
Simply removing CPU_HAS_LLSCD makes the problem go away, which probably indicates
they are all of the same nature.

I wonder why this problem only shows up now while it did not show up
earlier when we introduced the new up().  Perhaps kmalloc() always
returns 8-byte aligned blocks?

I can't think of an immediate and good fix.  Hopefully someone else smarter
than me can find a solution before I come back to it on Monday.  :)

Jun
