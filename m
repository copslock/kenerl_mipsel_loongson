Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2008 13:16:34 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:50915 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S536794AbYDHLQ2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2008 13:16:28 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m38BEV5n005731
	for <linux-mips@linux-mips.org>; Tue, 8 Apr 2008 04:14:32 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m38B5mEE000459;
	Tue, 8 Apr 2008 12:05:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m38B5lMG000458;
	Tue, 8 Apr 2008 12:05:47 +0100
Date:	Tue, 8 Apr 2008 12:05:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org, i2c@lm-sensors.org
Subject: Re: [PATCH] Alchemy: SMBus resource fix
Message-ID: <20080408110547.GA424@linux-mips.org>
References: <200804052216.21699.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200804052216.21699.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 05, 2008 at 10:16:21PM +0400, Sergei Shtylyov wrote:

> The Alchemy platform code registers the SMBus device using the virtual address
> of its registers instead of the physical one -- fix this, taking into account
> that actually the whole megabyte is decoded by any of the programmable serial
> controllers (one of which is SMBus), and that all the Alchemy peripherals are
> directly mappable into KSEG1 kernel space and therefore ioremap() call would
> just boil down to CKSEG1ADDR() invocation.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

Looks ok, so I'll send it to Linus.

  Ralf
