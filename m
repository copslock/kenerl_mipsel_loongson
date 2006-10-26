Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2006 13:55:53 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:4258 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038506AbWJZMzw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Oct 2006 13:55:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.7) with ESMTP id k9QCuPQC016175;
	Thu, 26 Oct 2006 13:56:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id k9QCuPMx016174;
	Thu, 26 Oct 2006 13:56:25 +0100
Date:	Thu, 26 Oct 2006 13:56:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	creideiki+linux-mips@ferretporn.se, linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
Message-ID: <20061026125624.GA14122@linux-mips.org>
References: <20061024140614.GB27800@linux-mips.org> <6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se> <20061025.174504.71086461.nemoto@toshiba-tops.co.jp> <20061026.130552.11963152.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026.130552.11963152.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 26, 2006 at 01:05:52PM +0900, Atsushi Nemoto wrote:

> I think I found the problem at last.

I'm afraid there is more than one problem.

On the 34K core each VPE has its own c0_count and c0_compare registers.
However the reset values are undefined.  Which means the time offset
calculated by

    offset = (clocksource_read(clock) - clock->cycle_last) & clock->mask;

may differ wildly between processors resulting in a time jitter of upto
almost 215s between both VPEs.  Unfortunately there is an unavoidable
race condition when attempting to synchronize the two counters.  But
the 34K's nature shrinks the time window to somwhere in the single digit
range of cycles so on a hardcore that would be a handfull of nanoseconds.

Anything that is less than the shortest time for a process to migrate
from one processor (VPE in case of 34K) to another is good enough as it
will guarantee that time cannot jump backward - but the jitter may still
be a a slight problem for the most demanding programs.

Others like RM9000x2 may have similar issues if the counter registers
don't come out of reset synchronized; need to look into that.

  Ralf
