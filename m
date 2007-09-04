Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 13:44:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:35231 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024744AbXIDMor (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Sep 2007 13:44:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l84CikQu016449;
	Tue, 4 Sep 2007 13:44:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l84Cijm0016448;
	Tue, 4 Sep 2007 13:44:45 +0100
Date:	Tue, 4 Sep 2007 13:44:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	yshi <yang.shi@windriver.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
Message-ID: <20070904124444.GB23736@linux-mips.org>
References: <46DD1CD1.5040306@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46DD1CD1.5040306@windriver.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 04, 2007 at 04:52:33PM +0800, yshi wrote:

> perfmon2 patch changed timer interrupt handler of malta board.
> When kernel handles timer interrupt, interrupt handler will read 30 bit
> of cause register. If this bit is zero, timer interrupt handler will
> exit, won't really handle interrupt. Because Malta 4kec board's core
> revision is CoreFPGA-3, this core's cause register doesn't implement 30
> bit, so kernel always read zero from this bit. This will cause kernel
> hang in calibrate_delay.

You seem to have defined cpu_has_mips_r2 as 1 in your cpu_features_override.h
file.  Classic cut'n'paste error I'd guess :-)

  Ralf
