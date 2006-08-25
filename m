Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2006 16:03:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26345 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20038874AbWHYPDs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2006 16:03:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7PF4BGs010003;
	Fri, 25 Aug 2006 16:04:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7PF4A5I010002;
	Fri, 25 Aug 2006 16:04:10 +0100
Date:	Fri, 25 Aug 2006 16:04:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Watkins <treestem@gmail.com>
Cc:	linux-mips@linux-mips.org, Jonathan Day <imipak@yahoo.com>
Subject: Re: [PATCH 2] 64K page size
Message-ID: <20060825150410.GA6789@linux-mips.org>
References: <44EF0C61.7090008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EF0C61.7090008@gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 25, 2006 at 10:42:41AM -0400, Peter Watkins wrote:

> Question: Is there an SMP malta board?

A CoreFPGA 2 or 3 card with a 34K bitfile is as close as you can get.
The 34K would run either run a VSMP kernel which is a hyperthreading-like
dual-processor kernel or an SMTC kernel which is uses the 34K's fancier
multithreading features to implement upto 5 processors.

Of course the CoreFPGA cards being an FPGA CPU card allows you to roll
your own stuff ;-)

  Ralf
