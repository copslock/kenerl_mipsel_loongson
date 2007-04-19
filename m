Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2007 01:34:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:12699 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021964AbXDSAem (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Apr 2007 01:34:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3J0YP0J001329;
	Thu, 19 Apr 2007 01:34:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3J0YAPU001328;
	Thu, 19 Apr 2007 01:34:10 +0100
Date:	Thu, 19 Apr 2007 01:34:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Uhler, Mike" <uhler@mips.com>
Cc:	Fuxin Zhang <fxzhang@ict.ac.cn>, tiansm@lemote.com,
	linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 3/16] Kconfig update for lemote fulong mini-PC
Message-ID: <20070419003410.GB30699@linux-mips.org>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <20070418120620.GE3938@linux-mips.org> <46261DE2.5040908@ict.ac.cn> <692AB3595F5D76428B34B9BEFE20BC1FC1D723@Exchange.mips.com> <20070418163806.GA27199@linux-mips.org> <692AB3595F5D76428B34B9BEFE20BC1FC1D733@Exchange.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692AB3595F5D76428B34B9BEFE20BC1FC1D733@Exchange.mips.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 18, 2007 at 03:27:16PM -0700, Uhler, Mike wrote:

> Note that both of these apply to pre-MIPS64 processors.  In a MIPS64
> implementation, The Status.PX bit should be used to enable 64-bit
> operations without enabling 64-bit addressing.  The Status.XX bit is
> gone and can't be set.  The addressing boundary condition that Bill
> mentioned is explicitly address in the Architecture for Programmer's
> manual, Volume III, section 4.10 as a requirement for hardware in
> exactly this case.
> 
> I realize that Loongson is a MIPS III processor where Bill's suggestion
> may apply, but it's not a general problem moving forward to MIPS64.

Linux limits the address space to 0x7fff8000 for 32-bit processes.  For
sake of simplicity and symmetry we do this on both 32-bit and 64-bit
kernels, on all processors.  A 64-bit kernel always runs userspace
processes with UX=1.  Since a 32-bit process cannot create mappings
above the low 2GB there isn't an actual need to use PX.

(I think there is a small bug in this scheme though, a process that is
accessing a 64-bit userspace address that isn't a 32-bit address should
be sent a SIGBUS but will actually receive a SIGSEGV.  But that's a
subtility and also requires extrapolating from an API documents that only
covers a strict 32-bit universe.)

  Ralf
