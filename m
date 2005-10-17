Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2005 17:07:43 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:64524 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133583AbVJQQHR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Oct 2005 17:07:17 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9HG79UJ017173;
	Mon, 17 Oct 2005 17:07:09 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9HG79su017172;
	Mon, 17 Oct 2005 17:07:09 +0100
Date:	Mon, 17 Oct 2005 17:07:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: How to improve performance of 2.6 kernel
Message-ID: <20051017160708.GA8613@linux-mips.org>
References: <f69849430510170429t2735ed0fo3caa862c1dfea83a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69849430510170429t2735ed0fo3caa862c1dfea83a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 17, 2005 at 04:29:44AM -0700, kernel coder wrote:

> I have just ported linux kernel 2.6.10 for MIPS4Kc-core board.Before
> porting 2.6 kernel ,2.4.20 was running on this board. When I took
> benchmarks for both the kernels for comparison, I found out that
> linux-2.4.20 was giving much better results than linux-2.6.10. The
> specs for the board are as follows:
> 
> --------------------------------------------------------------
> 133MHz MIPS4kc

How many TLB entries does your 4Kc have?  2.6 is hitting the TLB harder
and system that have small TLBs tend to suffer from that at the bottom
line even though all the other benefits of 2.6.

It would be interesting to see lmbench numbers for the system configurations
you've tested.  Lmbench is a well defined workload that's proven useful
in isolating such issues.

Thanks,

  Ralf
