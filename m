Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 19:50:18 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:24247 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28581646AbXAPTuQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 19:50:16 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0GJpFwd018916;
	Tue, 16 Jan 2007 19:51:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0GJpE0a018915;
	Tue, 16 Jan 2007 19:51:14 GMT
Date:	Tue, 16 Jan 2007 19:51:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] kconfig: move some entries to appropriate menu
Message-ID: <20070116195114.GA18870@linux-mips.org>
References: <20070116.232911.126576645.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070116.232911.126576645.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 16, 2007 at 11:29:11PM +0900, Atsushi Nemoto wrote:

> Currently KEXEC is in "Machine selection", SECCOMP, PM, APM are in
> "Executable file formats" menu.  Move KEXEC and SECCOMP to "Kernel
> type" and PM, APM to new "Power management options" menu.  Also
> replace "config PM" with kernel/power/Kconfig.

Queued - after fixing up all the whitespace rubbish in the patch.  I
also dropped the power managment bit since it conflicts with another
patchset I have pending.

  Ralf
