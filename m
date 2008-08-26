Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 13:34:01 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:43673
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20038190AbYHZMd7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 13:33:59 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7QCXvem001579;
	Tue, 26 Aug 2008 13:33:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7QCXuTg001578;
	Tue, 26 Aug 2008 13:33:56 +0100
Date:	Tue, 26 Aug 2008 13:33:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix data bus error recovery
Message-ID: <20080826123356.GB1276@linux-mips.org>
References: <20080804174434.7BD6FC2EAC@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080804174434.7BD6FC2EAC@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 04, 2008 at 07:44:34PM +0200, Thomas Bogendoerfer wrote:

> With -ffunction-section the entries in __dbe_table aren't no longer
> sorted, so the lookup of exception addresses in do_be() failed for
> some addresses. To avoid this we now sort __dbe_table.

Thanks, applied.

  Ralf
