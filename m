Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2007 20:53:58 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:49416 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021292AbXC2Tx5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Mar 2007 20:53:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id CA6C3E1CC6;
	Thu, 29 Mar 2007 21:53:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CMbRCljjLZ1S; Thu, 29 Mar 2007 21:53:08 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 663EFE1CBF;
	Thu, 29 Mar 2007 21:53:08 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l2TJrMJg018141;
	Thu, 29 Mar 2007 21:53:22 +0200
Date:	Thu, 29 Mar 2007 20:53:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Gary Smith <gary.smith@3phoenix.com>
cc:	linux-mips@linux-mips.org
Subject: Re: 'mem= ' Kernel Boot Parameter on BCM1250/1480 Platform
In-Reply-To: <001301c77234$04d014c0$8eacaac0@3PiGAS>
Message-ID: <Pine.LNX.4.64N.0703292043490.20097@blysk.ds.pg.gda.pl>
References: <001301c77234$04d014c0$8eacaac0@3PiGAS>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.1/2961/Thu Mar 29 16:06:01 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 29 Mar 2007, Gary Smith wrote:

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

 Make sure the overridden ranges as reported in the "User-defined physical 
RAM map" dump do not claim any reserved areas reported in the "Determined 
physical RAM map" dump at the beginning of the bootstrap.

  Maciej
