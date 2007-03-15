Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 03:03:51 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:16532 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021804AbXCODDu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Mar 2007 03:03:50 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2F31uTK027172;
	Thu, 15 Mar 2007 03:01:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2F31tir027171;
	Thu, 15 Mar 2007 03:01:55 GMT
Date:	Thu, 15 Mar 2007 03:01:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"A. R." <filesync@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: mmuless support
Message-ID: <20070315030155.GA23616@linux-mips.org>
References: <367600.40867.qm@web32211.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367600.40867.qm@web32211.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 14, 2007 at 05:51:50PM -0700, A. R. wrote:

> >> 4Km is a 4Kc without TLB. I think this is
> supported.
> 
> >Maybe at uclinux.org but certainly not on
> >linux-mips.org.  There have never
> >been many requests for Linux on TLB-less processors
> >and in recent years
> >the interest that low interest seems to have fallen
> >even further.
> 
> 
> List,
> 
> I saw this posting from 2 years ago. Is this still the
> case? I havent been able to find the exact status of
> mmuless mips support in the latest (mips) 2.6 kernel.
> 4Kem (tlb less/fmt) e.g.?

2 years and 4 days since but the posting is still perfectly accurate.

  Ralf

PS:  I'd take patches though ;)
