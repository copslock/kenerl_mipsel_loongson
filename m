Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2005 19:35:00 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:40727 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225744AbVIFSef>; Tue, 6 Sep 2005 19:34:35 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j86IfNUi001612;
	Tue, 6 Sep 2005 18:41:24 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j86IfLll001611;
	Tue, 6 Sep 2005 19:41:21 +0100
Date:	Tue, 6 Sep 2005 19:41:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: unkillable process due to setup_frame() failure
Message-ID: <20050906184118.GC3102@linux-mips.org>
References: <20050907.014234.108739386.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907.014234.108739386.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 07, 2005 at 01:42:34AM +0900, Atsushi Nemoto wrote:

> 1.  The "break" instruction raises a exception.
> 2.  The exception handler queues SIGTRAP(5).
> 3.  dequeue_signal() dequeue a signal with LOWEST number (i.e. SIGTRAP).
> 4.  setup_frame() fails due to bad stack pointer and queues SIGSEGV(11).
> 5.  returns to user process (pc unchanged).
> 6.  goto 1. (forever)
> 
> So, the process can not be kill by SIGKILL.  In 2.6.12, 'sigkill
> priority fix' was applied to __dequeue_signal(), but it does not help
> while the SIGTRAP is queued to tsk->pending but SIGKILL (by kill
> command) is queued to tsk->signal->shared_pending.

The behaviour of not advancing the EPC beyond the faulting instruction is
part of the problem - but I believe that was the usual behaviour for
MIPS UNIXoid operating systems.

  Ralf
