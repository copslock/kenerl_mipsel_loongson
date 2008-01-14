Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 00:10:21 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:60127 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20035125AbYANAKT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 00:10:19 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0E0AEji022497;
	Mon, 14 Jan 2008 00:10:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0E0AEtG022496;
	Mon, 14 Jan 2008 00:10:14 GMT
Date:	Mon, 14 Jan 2008 00:10:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28 fixes
Message-ID: <20080114001014.GC20115@linux-mips.org>
References: <20080112230051.AE10EC2F34@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080112230051.AE10EC2F34@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 13, 2008 at 12:00:51AM +0100, Thomas Bogendoerfer wrote:

> - ISA DMA is broken on IP28
> - bus error handler improved to not issue bus errors for
>   speculative accesses to CPU and GIO addresses. We now
>   treat CSTAT_ADDR and GSTAT_TIME errors as non fatal, when
>   they are issues via MC error interrupt. For real (non
>   speculative) bus errors a DBE will be issued, which is
>   lethal as before. Handling the issue this way gets rid
>   of decoding instructions
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Folded into the "[MIPS] IP28 support" patch for 2.6.28.

Thanks,

  Ralf
