Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2008 14:39:49 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:49556
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20022434AbYGaNjm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2008 14:39:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6VDdc82012237;
	Thu, 31 Jul 2008 14:39:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6VDdb6t012236;
	Thu, 31 Jul 2008 14:39:37 +0100
Date:	Thu, 31 Jul 2008 14:39:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] TXx9: Fix mips_hpt_frequency initialization
Message-ID: <20080731133937.GB10405@linux-mips.org>
References: <20080731.222953.128619433.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080731.222953.128619433.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 31, 2008 at 10:29:53PM +0900, Atsushi Nemoto wrote:

> The mips_hpt_frequency initialization code was lost in commit
> 94a4c32939dede9328c6e4face335eb8441fc18d ("TXx9: Add 64-bit support").
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, applied.

  Ralf
