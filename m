Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 20:47:30 +0100 (BST)
Received: from H239.C78.B0.tor.eicat.ca ([IPv6:::ffff:72.0.78.239]:55238 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226904AbVGSTrK>; Tue, 19 Jul 2005 20:47:10 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6JJmkNj005817;
	Tue, 19 Jul 2005 15:48:47 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6JJmgt6005810;
	Tue, 19 Jul 2005 15:48:42 -0400
Date:	Tue, 19 Jul 2005 15:48:42 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Markus Dahms <mad@automagically.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: module loading on 64-bit kernel
Message-ID: <20050719194842.GC2771@linux-mips.org>
References: <20050719183546.GA3923@gaspode.automagically.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719183546.GA3923@gaspode.automagically.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 19, 2005 at 08:35:46PM +0200, Markus Dahms wrote:

> do I need other module-init-tools for a 64-bit kernel than I need for
> 32-bit?
> When trying to load a module I get the following output:
> | insmod: error inserting \
> | '/lib/modules/2.6.13-rc3-mad-mips-1-64/kernel/fs/isofs/isofs.ko': -1 \
> | Cannot allocate memory
> 
> in dmesg:
> | allocation failed: out of vmalloc space - use vmalloc=<size> to increase \
> | size.
> 
> It happens with every module. If I'd need other tools these messages are
> confusing. I didn't try "vmalloc=..." as I think module loading wouldn't
> be "disabled" in such a way by default...
> 
> If I need special 64-bit module-init-tools, is there a way to build them
> without a 64-bit glibc as all of my userspace stuff is 32-bit?

You don't need. In fact the nice thing about module-init-tools is that
they're file format agnostic so didn't need any changes for MIPS porting.

  Ralf
