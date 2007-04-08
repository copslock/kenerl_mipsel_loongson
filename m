Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2007 00:11:39 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:15832 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022769AbXDHXLi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Apr 2007 00:11:38 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l38NBVnY031795;
	Mon, 9 Apr 2007 01:11:31 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l38NBUjW031794;
	Mon, 9 Apr 2007 01:11:30 +0200
Date:	Mon, 9 Apr 2007 01:11:30 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	h h <harsh512@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Describing Physical RAM Map to Linux
Message-ID: <20070408231130.GA31563@linux-mips.org>
References: <640437.41507.qm@web53812.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640437.41507.qm@web53812.mail.re2.yahoo.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 07, 2007 at 02:59:15PM -0700, h h wrote:

> I have a very basic question -- When describing physical memory to the kernel in 
> prom_init(), should we describe the physical memory region where kernel is loaded or leave it out?  We are using add_memory_region() call to describe physical memory to the kernel.  If we do describe the memory region where kernel is loaded, how will kernel know not to use these pages for User processes?

The kernel does this automatically.

> We are using 2.6.16 on Cavium/Octeon based platform. 

Which atm are only supported by Cavium's proprietary version of Linux ...

  Ralf
