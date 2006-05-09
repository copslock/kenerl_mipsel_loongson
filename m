Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2006 22:00:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:19095 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133879AbWEIUAM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 May 2006 22:00:12 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k49GYCdF010523;
	Tue, 9 May 2006 17:34:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k49GYBKu010522;
	Tue, 9 May 2006 17:34:11 +0100
Date:	Tue, 9 May 2006 17:34:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alex Gonzalez <langabe@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Boot time memory allocation
Message-ID: <20060509163411.GA8528@linux-mips.org>
References: <c58a7a270605090735t8e4f21ax6ca87f97b9143e3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c58a7a270605090735t8e4f21ax6ca87f97b9143e3b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 09, 2006 at 03:35:14PM +0100, Alex Gonzalez wrote:

> I have two independent processors with access to a shared memory
> region, mapped in the 256MB to 512MB region (kseg0).
> 
> One is running a propietary OS, and the second one is running Linux 2.6.12.
> 
> How would I arrange to leave that shared memory region out of the
> scope of Linux's memory management system, but at the same time make
> it possible for a driver to access it?
> 
> I have done similar things before with the help of alloc_bootmem, but
> this time I don't want the kernel to reserve the memory, I want the
> kernel to be completely unaware of it, and I need to specify its start
> and end.

At kernel initialization time just don't tell the kernel about the
existence of your memory region.  For many systems that just means you
shrink the memory region passed to the add_memory_region() call to
something that suits your platform.

  Ralf
