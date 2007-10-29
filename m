Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 18:37:07 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53484 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573974AbXJ2ShF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 18:37:05 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TIav37014522;
	Mon, 29 Oct 2007 18:36:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TIaqvc014520;
	Mon, 29 Oct 2007 18:36:52 GMT
Date:	Mon, 29 Oct 2007 18:36:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] c-r3k: Implement flush_cache_range()
Message-ID: <20071029183652.GF3953@linux-mips.org>
References: <Pine.LNX.4.64N.0710171144410.28993@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710171144410.28993@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 17, 2007 at 11:51:39AM +0100, Maciej W. Rozycki wrote:

>  Contrary to the belief of some, the R3000 and related processors did have 
> caches, both a data and an instruction cache.  Here is an implementation 
> of r3k_flush_cache_page(), which is the processor-specific back-end for 
> flush_cache_range(), done according to the spec in 
> Documentation/cachetlb.txt.
> 
>  While at it, remove an unused local function: get_phys_page(), do some 
> trivial formatting fixes and modernise debugging facilities.

Applied.

  Ralf
