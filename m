Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2003 14:23:19 +0100 (BST)
Received: from p508B6977.dip.t-dialin.net ([IPv6:::ffff:80.139.105.119]:32472
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225420AbTJJNXP>; Fri, 10 Oct 2003 14:23:15 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9ADNENK004278;
	Fri, 10 Oct 2003 15:23:14 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9ADNCiJ004277;
	Fri, 10 Oct 2003 15:23:12 +0200
Date: Fri, 10 Oct 2003 15:23:12 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Steve Scott <steve.scott@pioneer-pdt.com>
Cc: linux-mips@linux-mips.org
Subject: Re: bug in kernel_entry?
Message-ID: <20031010132312.GB27103@linux-mips.org>
References: <5334.156.153.254.2.1065650433.squirrel@webmail.rmci.net> <20031009140319.GA17647@linux-mips.org> <021e01c38eb2$4e95f840$2256fea9@janelle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021e01c38eb2$4e95f840$2256fea9@janelle>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 09, 2003 at 03:11:36PM -0700, Steve Scott wrote:

> kernel_entry initializes the kernel stack pointer 'kernelsp'. But then
> immediately after this clears the bss, which has the side effect of setting
> kernelsp to 0. In our system, on initial entry to cpu_idle(), kernelsp is 0.

Funny this wasn't noticed for so long.  Fix is in CVS, thanks for reporting.

  Ralf
