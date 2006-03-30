Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2006 19:27:12 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:50048 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133445AbWC3S1E (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2006 19:27:04 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2UIbiFY022275;
	Thu, 30 Mar 2006 19:37:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2UIbgaE022274;
	Thu, 30 Mar 2006 19:37:42 +0100
Date:	Thu, 30 Mar 2006 19:37:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nigel Stephens <nigel@mips.com>
Cc:	colin <colin@realtek.com.tw>, linux-mips@linux-mips.org
Subject: Re: Using hardware watchpoint for applications debugging
Message-ID: <20060330183742.GA14515@linux-mips.org>
References: <024c01c65337$63931c90$106215ac@realtek.com.tw> <442A94D0.1020106@mips.com> <002d01c6539f$d040a200$106215ac@realtek.com.tw> <442BB7B2.1010204@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442BB7B2.1010204@mips.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 30, 2006 at 11:49:22AM +0100, Nigel Stephens wrote:

> They're variable, but not very variable: the PID->ASID mapping will only
> change when the ASIDs roll over and the ASID gets reallocated to a
> different process, which will only happen after another 256 processes
> have been created. But in that case your watched process will have to be
> allocated a new ASID before it can run again. So you could, perhaps,
> modify the TLB management code to clear the Watch registers whenever an
> ASID belong to a process with watchpoints is recycled, and then
> reprogram the Watch registers when such a process is allocated a new
> ASID. Alternatively you could maintain pre-process copies of the Watch
> registers, and context switch them along with other per-process register
> state -- though that is adding context switch overhead to processes
> which don't use watchpoints, and might not be popular with the maintainer.

That's not quite true; the kernel also uses the ASID as a way to flush
a context from the TLB very quickly.

  Ralf
