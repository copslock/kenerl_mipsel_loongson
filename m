Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 14:54:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:48420 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20027512AbZEANyr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 May 2009 14:54:47 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n41Dsiw4021881;
	Fri, 1 May 2009 15:54:44 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n41Dsh3m021878;
	Fri, 1 May 2009 15:54:43 +0200
Date:	Fri, 1 May 2009 15:54:43 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	luk@debian.org, linux-mips@linux-mips.org
Subject: Re: kernel for a Broadcom Swarm board
Message-ID: <20090501135443.GB15672@linux-mips.org>
References: <49FA27FA.3070408@debian.org> <20090501075730.GC16244@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090501075730.GC16244@hall.aurel32.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 01, 2009 at 09:57:30AM +0200, Aurelien Jarno wrote:

> > > | [    0.000000] PID hash table entries: 1024 (order: 10, 8192 bytes)
> > >
> > > And then it hangs...
> >
> > The zeros look like there are no timing interrupts happening. It's a  
> > pity we don't have hardware to test which kernel version introduced the  
> > bug (for instance with git-bisect and reboots).
> >
> 
> I think the zeros are normal here, on other machines, the values
> actually start to change just after this line.

They are completly normal and I'd be happy if people disable
CONFIG_PRINTK_TIME for readability when posting kernel messages.

  Ralf
