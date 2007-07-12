Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 14:34:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:61143 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022454AbXGLNeY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 14:34:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6CDJMCo011910;
	Thu, 12 Jul 2007 14:19:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6CDJLkf011909;
	Thu, 12 Jul 2007 14:19:21 +0100
Date:	Thu, 12 Jul 2007 14:19:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Workaround for a sparse warning in
	include/asm-mips/io.h
Message-ID: <20070712131921.GE11019@linux-mips.org>
References: <20070711.231200.05599385.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0707111516250.26459@blysk.ds.pg.gda.pl> <20070711.235420.18311683.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070711.235420.18311683.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 11, 2007 at 11:54:20PM +0900, Atsushi Nemoto wrote:

> Yes, adding 'L' to KSEG1 is another way to silence the warnings.  But
> I just thought it was a bit intrusive.  And I'm not sure all code are
> OK if KSEG1 is 'signed' ...

The MIPS architecture's idea of the 32 and 64-bit address space is that
32-bit addresses can be sign-extended to 64-bit addresses.  This if of
course conflicting with the general Linux idea that virtual addresses are
represented as an unsigned long.

  Ralf
