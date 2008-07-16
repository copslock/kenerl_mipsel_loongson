Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 09:46:06 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:62645
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28580470AbYGPIqE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 09:46:04 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6G8k3Zp023169;
	Wed, 16 Jul 2008 09:46:03 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6G8k3l3023168;
	Wed, 16 Jul 2008 09:46:03 +0100
Date:	Wed, 16 Jul 2008 09:46:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] [MIPS] add missing prototypes to asm/page.h
Message-ID: <20080716084603.GC22957@linux-mips.org>
References: <1216141052-28005-1-git-send-email-dmitri.vorobiev@movial.fi> <1216141052-28005-4-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1216141052-28005-4-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 15, 2008 at 07:57:32PM +0300, Dmitri Vorobiev wrote:

> This patch fixes the following sparse warnings:
> 
> >>>>>>>>>>>>>>>>>>
> arch/mips/mm/page.c:284:16: warning: symbol
> 'build_clear_page' was not declared. Should it be static?
> 
> arch/mips/mm/page.c:426:16: warning: symbol 'build_copy_page'
> was not declared. Should it be static?
> >>>>>>>>>>>>>>>>>>
> 
> The fix is to add appropriate prototypes to the header
> include/asm-mips/page.h.

Same comment as for 2/3 applies.  Patch applied.  Thanks,

  Ralf
