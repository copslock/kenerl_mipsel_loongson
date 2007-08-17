Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2007 16:54:07 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56465 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021785AbXHQPyF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Aug 2007 16:54:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7HFs4YL006860;
	Fri, 17 Aug 2007 16:54:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7HFs4sn006859;
	Fri, 17 Aug 2007 16:54:04 +0100
Date:	Fri, 17 Aug 2007 16:54:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	POORNIMA R <rpoornar@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS]mcheck error
Message-ID: <20070817155403.GA4853@linux-mips.org>
References: <BAY141-F39F0F707148D2899FEF184C2DF0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY141-F39F0F707148D2899FEF184C2DF0@phx.gbl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 16, 2007 at 01:34:13PM +0000, POORNIMA R wrote:

> I am working on MIPS architecture and my kernel version
> is linux-2.6.10  and  I am a newbie to MIPS architecture.
> If I try inserting  any module (.ko), I get meck exception
> due to multiple matching entries in TLB

Linux 2.6.10 is now well over 2 1/2 years old so forgive if my memory
on bugs that can cause machine checks is fading a little.  You should
upgrade.  REALLY.

> 1. What is the reason for multiple enteries in TLB
> due to module insertion?

A machine check exception will be generated if during a TLB lookup (for
example during instruction fetch or loading/storing the data for a load
rsp. store instruction) multiple entries match.

> 2. Should the TLB operations be performed with interrupts disabled?

Yes; the kernel does so.

  Ralf

PS: Ditch that 2.6.10 antique!  It belongs into a vitrine in the
MIPSonian Institude, not a life a computer system :-)

PPS: Have you considered upgrading your kernel?
