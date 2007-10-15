Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 17:21:28 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:31905 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20036897AbXJOQVU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 17:21:20 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	by relay01.mx.bawue.net (Postfix) with ESMTP id EF65A48C0D;
	Mon, 15 Oct 2007 18:19:47 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IhSfs-0000Yu-8F; Mon, 15 Oct 2007 17:20:12 +0100
Date:	Mon, 15 Oct 2007 17:20:12 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org,
	qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] QEMU/MIPS & dyntick kernel
Message-ID: <20071015162012.GW3379@networkno.de>
References: <20071002200644.GA19140@hall.aurel32.net> <20071015150514.GV3379@networkno.de> <20071015155847.GA17912@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071015155847.GA17912@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Oct 15, 2007 at 04:05:14PM +0100, Thiemo Seufer wrote:
> 
> > I found Qemu/MIPS locks up in the emulated kernel's calibrate_delay
> > function. Switching the kernel option off works around the problem.
> 
> I still haven't patched up the issue which was causing the problem for
> Aurel.  Is the slow execution of the emulator also the cause of what
> you're seeing?

I haven't analysed it further.


Thiemo
