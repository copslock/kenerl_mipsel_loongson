Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2006 22:44:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34245 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039656AbWJHVom (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Oct 2006 22:44:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k98LimlP010070;
	Sun, 8 Oct 2006 22:44:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k98Lii7Y010059;
	Sun, 8 Oct 2006 22:44:44 +0100
Date:	Sun, 8 Oct 2006 22:44:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <KevinK@mips.com>
Cc:	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ret_from_irq adjustment
Message-ID: <20061008214443.GA6254@linux-mips.org>
References: <20061009.012423.59032950.anemo@mba.ocn.ne.jp> <006501c6eb07$4fbf66c0$8003a8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006501c6eb07$4fbf66c0$8003a8c0@Ulysses>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 08, 2006 at 08:26:44PM +0200, Kevin D. Kissell wrote:

> While setting up ra "by hand" and transferring control via the jr
> is a reasonable optimization, you're otherwise breaking things for SMTC.
> While the comments are misleading (they accurately described an earlier
> version of the code), the function being called here is ipi_decode(), which
>  needs a pt_regs * in the first argument (hence the copy of the sp), and 
> the pointer to the IPI message descriptor in the second.
> 
> Do you have access to a 34K to test changes to SMTC?  I'd have
> expected this one to have been pretty quickly fatal.

The shakeup of the code by the recent series of pt_regs related cleanups
is pretty massive.  As of last night I only had uniprocessor support
working again.  VSMP and SMTC were broken; actual multi-core CPU not
tested yet.

  Ralf
