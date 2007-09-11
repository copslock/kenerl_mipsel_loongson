Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 14:31:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45762 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022329AbXIKNby (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Sep 2007 14:31:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8BDVrJR000598;
	Tue, 11 Sep 2007 14:31:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8BDVr4B000597;
	Tue, 11 Sep 2007 14:31:53 +0100
From:	ralf@linux-mips.org
Date:	Tue, 11 Sep 2007 14:31:53 +0100
To:	Vlad Lungu <vlad@comsys.ro>
Cc:	qemu-devel@nongnu.org, linux-mips@linux-mips.org
Subject: Re: Qemu and Linux 2.4
Message-ID: <20070911133153.GA32031@linux-mips.org>
References: <46E68AA3.2010907@comsys.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46E68AA3.2010907@comsys.ro>
F-rom:	Ralf Baechle <ralf@linux-mips.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 11, 2007 at 03:31:31PM +0300, Vlad Lungu wrote:

> I know some of you will laugh, but:
> 
> - QEMU malta emulation is not really complete, to put it mildly
> - the QEMU target is available only for Linux 2.6
> - despite popular opinion, 2.4 ain't dead yet, at least in the embedded 
> market

It very much is for new product development.  It's a long time that I've
seen any 2.4-based development being started for new MIPS platforms.  I
basically get zero feedback for 2.4.

The last patch submitted for 2.4 was on 2006-06-15 by Chris Dearman btw.
Everything else since was just backported fixes from newer kernels and I've
given up on that give the overwhelming feedback I keep receiving for 2.4.

> I have a port of the QEMU target for Linux 2.4.34.4 (latest 2.4 kernel 
> on linux-mips.org), with NE2000 card working (in both BE and LE modes).
> Still rough at the edges, but it works on stock qemu-0.9.0 with -M mips.

Actually 2.4.35.2 / 2.4.36-pre1 are the latest.

> If anyone is interested, I can send the patch by e-mail. I have no idea 
> if I can post attachments to the list(s), that's why it's not attached.

I do take Linux 2.4 patches provided they don't destabilize the 2.4 branch.
The few remaining user expect stability, not a Penguin action movie ;-)
But aside of that, same submission guidelines as for 2.6.

Cheers,

  Ralf
