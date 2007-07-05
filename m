Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2007 14:41:21 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36812 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023017AbXGENlT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jul 2007 14:41:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l65DfH7G016096;
	Thu, 5 Jul 2007 14:41:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l65DfH4S016095;
	Thu, 5 Jul 2007 14:41:17 +0100
Date:	Thu, 5 Jul 2007 14:41:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: diffs between lmo and mainline
Message-ID: <20070705134117.GA15896@linux-mips.org>
References: <20070705.223050.65192436.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070705.223050.65192436.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 05, 2007 at 10:30:50PM +0900, Atsushi Nemoto wrote:

> There are some commits in lmo which are not mainlined yet.
> IMO the commit 4ecfa04... is the most critical one.
> 
> 
> commit 87268cc40b143bdbe35d2e8f22e1ae6c359fe368
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Mon Jan 15 14:17:19 2007 +0000
> 
>     [MIPS] Malta: Fix SMTC crash on bootup with idebus= boot argument
>     
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

This one isn't quite kosher so won't make it to kernel.org as is anyway.
Some of the other patches are in all reality unmergable because we're
so late in the release cycle or are cosmetic things.  I keep sending the
important bits to Linus but chances are that there will be a few things
that stay unmerged for 2.6.22.

  Ralf
