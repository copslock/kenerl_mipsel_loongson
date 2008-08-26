Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 13:33:16 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:42649
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20037675AbYHZMdN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 13:33:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7QCXB45001573;
	Tue, 26 Aug 2008 13:33:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7QCXAhX001571;
	Tue, 26 Aug 2008 13:33:10 +0100
Date:	Tue, 26 Aug 2008 13:33:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix WARNING: at kernel/smp.c:290
Message-ID: <20080826123310.GA1276@linux-mips.org>
References: <20080804185357.E0CD4C315B@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080804185357.E0CD4C315B@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 04, 2008 at 08:53:57PM +0200, Thomas Bogendoerfer wrote:

> Subject: [PATCH] Fix WARNING: at kernel/smp.c:290 
> 
> trap_init issues flush_icache_range(), which uses ipi functions to
> get icache flushing done on all cpus. But this is done before interrupts
> are enabled and caused WARN_ON messages. This changeset introduces
> a new local_flush_icache_range() and uses it before interrupts (and
> additional CPUs) are enabled to avoid this problem.

Thanks, applied.

  Ralf
