Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 11:23:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52558 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492190AbZJPJXD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Oct 2009 11:23:03 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9G9OLLR004090;
	Fri, 16 Oct 2009 11:24:21 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9G9OJpM004088;
	Fri, 16 Oct 2009 11:24:19 +0200
Date:	Fri, 16 Oct 2009 11:24:18 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Minchan Kim <minchan.kim@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Chungki woo <chungki.woo@gmail.com>
Subject: Re: BUG? linux-mips flush_dcache_page
Message-ID: <20091016092418.GA3686@linux-mips.org>
References: <20091016141719.de606482.minchan.kim@barrios-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091016141719.de606482.minchan.kim@barrios-desktop>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 02:17:19PM +0900, Minchan Kim wrote:

> Many code of kernel fs usually allocate high page and flush.
> But flush_dcache_page of mips checks PageHighMem to avoid flush
> so that data consistency is broken, I think. 

What processor and cache configuration?

> I found it's by you and Atsushi-san on 585fa724. 
> Why do we need the check?
> Could you elaborte please? 

The if statement exists because __flush_dcache_page would crash if a page
is not mapped.  This of course isn't correct but that wasn't a problem
since highmem still is only supported on machines that don't have aliases.

  Ralf
