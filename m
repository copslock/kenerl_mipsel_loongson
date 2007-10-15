Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 16:58:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52611 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20036886AbXJOP6u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 16:58:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9FFwmmw017938;
	Mon, 15 Oct 2007 16:58:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9FFwlsc017937;
	Mon, 15 Oct 2007 16:58:47 +0100
Date:	Mon, 15 Oct 2007 16:58:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org,
	qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] QEMU/MIPS & dyntick kernel
Message-ID: <20071015155847.GA17912@linux-mips.org>
References: <20071002200644.GA19140@hall.aurel32.net> <20071015150514.GV3379@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071015150514.GV3379@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 15, 2007 at 04:05:14PM +0100, Thiemo Seufer wrote:

> I found Qemu/MIPS locks up in the emulated kernel's calibrate_delay
> function. Switching the kernel option off works around the problem.

I still haven't patched up the issue which was causing the problem for
Aurel.  Is the slow execution of the emulator also the cause of what
you're seeing?

   Ralf
