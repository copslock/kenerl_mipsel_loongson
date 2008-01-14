Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 14:16:09 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12462 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030015AbYANOQH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 14:16:07 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0EEEPmp031022;
	Mon, 14 Jan 2008 14:14:50 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0EEEOPF031021;
	Mon, 14 Jan 2008 14:14:24 GMT
Date:	Mon, 14 Jan 2008 14:14:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory for QEMU
Message-ID: <20080114141424.GB22344@linux-mips.org>
References: <20080114.212253.126142719.anemo@mba.ocn.ne.jp> <20080114133701.GA16555@linux-mips.org> <478B6AA3.2070402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478B6AA3.2070402@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 14, 2008 at 04:58:59PM +0300, Dmitri Vorobiev wrote:

> > I was actually planning to remove the Qemu platform for 2.6.25.  The
> > Malta emulation has become so good that there is no more point in having
> > the underfeatured synthetic platform that CONFIG_QEMU is.
> 
> I wholeheartedly agree with that. It is a godsend to me that I can use
> identical configs to build the kernels for QEMU and for a physical Malta.
> Emulation is more convenient to me because QEMU boots and runs faster
> than the board I'm working with. Many thanks for that to QEMU developers.
> 
> Off the topic, how about the plans to remove Atlas support?

Maciej is promising to fix it up since a few years ;-)  Aside of that it's
safe to say the Atlas is dead like a coffin nail.

The main problem with the Atlas is the SAA9730 SOC which is broken in an
infinite number of totally pervert ways, I'm told.  I know of no systems
other than the Atlas using it.

  Ralf
