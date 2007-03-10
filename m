Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2007 12:37:00 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:59369 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021824AbXCJMg7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Mar 2007 12:36:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2ACZ32N000552;
	Sat, 10 Mar 2007 12:35:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2ACZ1So000527;
	Sat, 10 Mar 2007 12:35:01 GMT
Date:	Sat, 10 Mar 2007 12:35:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] do_fpe() cleanup
Message-ID: <20070310123501.GA516@linux-mips.org>
References: <20070310.010745.07456268.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070310.010745.07456268.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 10, 2007 at 01:07:45AM +0900, Atsushi Nemoto wrote:

> If we had already lost FPU before disabling preempt, we do not have to
> own it at all.  And we do not prevent preemption when managing saved
> FCR31 if we did not have FPU ownership.

Applied,

  Ralf
