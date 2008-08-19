Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 10:47:27 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:34974
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28574549AbYHSJrU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 10:47:20 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7J9lBwU028632;
	Tue, 19 Aug 2008 10:47:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7J9l6eY028630;
	Tue, 19 Aug 2008 10:47:06 +0100
Date:	Tue, 19 Aug 2008 10:47:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use compat_sys_ptrace
Message-ID: <20080819094706.GB27342@linux-mips.org>
References: <20080817144926.0425BC3F17@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080817144926.0425BC3F17@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 17, 2008 at 04:49:25PM +0200, Thomas Bogendoerfer wrote:

> This replaces mips's sys_ptrace32 with a compat_arch_ptrace and
> enables the new generic definition of compat_sys_ptrace instead.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks, queued for 2.6.28.

  Ralf
