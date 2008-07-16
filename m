Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 09:45:25 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:61621
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28580432AbYGPIpX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 09:45:23 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6G8jMP6023163;
	Wed, 16 Jul 2008 09:45:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6G8jMPu023162;
	Wed, 16 Jul 2008 09:45:22 +0100
Date:	Wed, 16 Jul 2008 09:45:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] [MIPS] fix missing prototypes in asm/fpu.h
Message-ID: <20080716084522.GB22957@linux-mips.org>
References: <1216141052-28005-1-git-send-email-dmitri.vorobiev@movial.fi> <1216141052-28005-3-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1216141052-28005-3-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 15, 2008 at 07:57:31PM +0300, Dmitri Vorobiev wrote:

> While building the Malta defconfig, sparse spat the following
> warnings:
> 
> >>>>>>>>>>>>>>>>>>
> arch/mips/math-emu/kernel_linkage.c:31:6: warning: symbol
> 'fpu_emulator_init_fpu' was not declared. Should it be static?
> 
> arch/mips/math-emu/kernel_linkage.c:54:5: warning: symbol
> 'fpu_emulator_save_context' was not declared. Should it be
> static?
> 
> arch/mips/math-emu/kernel_linkage.c:68:5: warning: symbol
> 'fpu_emulator_restore_context' was not declared. Should it be
> static?
> >>>>>>>>>>>>>>>>>>
> 
> This patch fixes these errors by adding the proper prototypes
> to the include/asm-mips/fpu.h header, and actually using this
> header in the sparse-spotted source file.

I'm not terribly fond of exporting these private prototypes by making
their prototypes widely available.  I see it's need to make sparse a more
productive tool, so I applied the patch though.

Thanks,

  Ralf
