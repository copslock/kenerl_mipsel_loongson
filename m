Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 10:36:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:23970 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133408AbWEBJga (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 10:36:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k429aNgt004399;
	Tue, 2 May 2006 10:36:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k429aLwq004398;
	Tue, 2 May 2006 10:36:21 +0100
Date:	Tue, 2 May 2006 10:36:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	moreau francis <francis_moreau2000@yahoo.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: Re : module allocation
Message-ID: <20060502093621.GA4301@linux-mips.org>
References: <20060428200307.GA17705@linux-mips.org> <20060502071949.44638.qmail@web25811.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502071949.44638.qmail@web25811.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 02, 2006 at 07:19:49AM +0000, moreau francis wrote:

> > There is another reason against putting modules into mapped space and
> > that's the need for -mlong-calls which generates larger, less efficient
> > code.
> 
> BTW, I don't see why -mlong-calls wouldn't be needed for GFP module
> allocation. Can you explain ?

It assumes a low-memory system where the entire RAM resides within the
range of a J/JAL instructions.

  Ralf
