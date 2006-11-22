Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2006 22:17:19 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:17356 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039344AbWKVWRR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Nov 2006 22:17:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAMMHCe5009458;
	Wed, 22 Nov 2006 22:17:14 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAMMHCJQ009457;
	Wed, 22 Nov 2006 22:17:12 GMT
Date:	Wed, 22 Nov 2006 22:17:12 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ashlesha Shintre <ashlesha@kenati.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: request_module: runaway loop modprobe net-pf-1
Message-ID: <20061122221712.GB8819@linux-mips.org>
References: <1164224559.6511.4.camel@sandbar.kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164224559.6511.4.camel@sandbar.kenati.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 22, 2006 at 11:42:39AM -0800, Ashlesha Shintre wrote:

> During boot up on the Encore M3 board (AU1500 MIPS) of the 2.6.14.6
> kernel, the process stops after the NFS filesystem has been mounted,
> memory freed  and spits out the following message:
> 
> 
> > request_module: runaway loop modprobe net-pf-1

The kernel tried to open UNIX domain socket but because support is not
compiled it will load the module instead.  Now, glibc-based programs
happen to try to connect to nscd via a UNIX domain socket on startup
and the whole show starts all over.  After a few iterations the kernel
gets tired of the whole game and prints this friendly message.

> What does the net-pf-1 mean?

net-pf-1 is PF_UNIX, see the definitions in include/linux/socket.h.  So
you should set CONFIG_UNIX to y.  Building it as a module won't work
as you just found :).

  Ralf
