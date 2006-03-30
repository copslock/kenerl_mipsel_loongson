Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2006 19:46:51 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:53206 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133445AbWC3Sqc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2006 19:46:32 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FP2KO-0001KL-TW; Thu, 30 Mar 2006 13:57:05 -0500
Date:	Thu, 30 Mar 2006 13:57:04 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Nigel Stephens <nigel@mips.com>
Cc:	colin <colin@realtek.com.tw>, linux-mips@linux-mips.org
Subject: Re: Using hardware watchpoint for applications debugging
Message-ID: <20060330185704.GA5063@nevyn.them.org>
References: <024c01c65337$63931c90$106215ac@realtek.com.tw> <442A94D0.1020106@mips.com> <002d01c6539f$d040a200$106215ac@realtek.com.tw> <442BB7B2.1010204@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442BB7B2.1010204@mips.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
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

If you want GDB to use them, you almost certainly want them to be
per-process.  You can context switch them lazily, though.  We've solved
this problem before plenty of times...

-- 
Daniel Jacobowitz
CodeSourcery
