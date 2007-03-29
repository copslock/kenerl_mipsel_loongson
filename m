Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2007 22:11:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59266 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021344AbXC2VLA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Mar 2007 22:11:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2TLAqAX022881;
	Thu, 29 Mar 2007 22:10:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2TLAolL022880;
	Thu, 29 Mar 2007 22:10:50 +0100
Date:	Thu, 29 Mar 2007 22:10:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Gary Smith <gary.smith@3phoenix.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 'mem= ' Kernel Boot Parameter on BCM1250/1480 Platform
Message-ID: <20070329211050.GA22703@linux-mips.org>
References: <001301c77234$04d014c0$8eacaac0@3PiGAS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001301c77234$04d014c0$8eacaac0@3PiGAS>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 29, 2007 at 02:56:49PM -0400, Gary Smith wrote:

> I'd like to ask a question about use of the 'mem=' kernel parameter.  When
> booting without this parameter, the kernel automatically detects the amount
> of memory as 989020 kB.  If a kernel parameter is added to specify
> 'mem=989020k' a TLB Miss error is encountered.  Do you all have guidance
> about how the memory parameter can be specified without causing the error?
> Since the mem= parameter was set to an identical value as the memory
> reported by meminfo in the /proc filesystem, use of this kernel parameter
> should be OK.  This behavior has been observed on both the BCM1250/1480
> platforms when running Debian linux.  The 2.6.17-2 kernel is used with the
> system.

mem=989020k tells the kernel there is 989020k of memory starting at
address 0.  On these SOCs there first 512MB of memory are at physical
address 0, the next 256MB at address 0x80000000, the next 256MB at
0xc0000000 and the rest of memory goes starting at 0x100000000.  So to
override the automatically detected memory map if you had 1GB you'd
need something like: mem=512M@0 mem=256M@0x80000000 mem=256M=0xc0000000.

  Ralf
