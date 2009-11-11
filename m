Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 04:14:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53695 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1491825AbZKKDO0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Nov 2009 04:14:26 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAB3DhIx024500;
	Wed, 11 Nov 2009 04:13:45 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAB3DPdg024488;
	Wed, 11 Nov 2009 04:13:25 +0100
Date:	Wed, 11 Nov 2009 04:13:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, zhangfx@lemote.com, zhouqg@gmail.com,
	rostedt@goodmis.org, Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v7 04/17] tracing: add static function tracer support
	for MIPS
Message-ID: <20091111031325.GA20716@linux-mips.org>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com> <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com> <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com> <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com> <4AF8B31C.5030802@caviumnetworks.com> <1257814817.2822.3.camel@falcon.domain.org> <4AF99848.9090000@caviumnetworks.com> <1257907351.2922.37.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257907351.2922.37.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 11, 2009 at 10:42:31AM +0800, Wu Zhangjin wrote:

> > -mlong-calls really degrades performance.  I have seen things like 6% 
> > drop in network packet forwarding rates with -mlong-calls.
> > 
> 
> so much drop? seems only two instructions added for it: lui, addi. from
> this view point, I think the -fno-omit-frame-pointer(add, sd, move...)
> will also bring with much drop.

The calling sequence is quite badly bloated.  Example:

Normal 32/64-bit subroutine call:

	jal	symbol

32-bit with -mlong-call:

	lui	$25, %hi(foo)
	addiu	$25, %lo(foo)
	jalr	$25

64-bit with -mlong-call:

	lui	$25, %highest(foo)
	lui	$2, %hi(foo)
	daddiu	$25, %higher(foo)
	daddiu	$2, %lo(foo)
	dsll	$25, 32
	daddu	$25, $2
	jalr	$25

So not considering the possible cost of the delay slot that's 1 vs. 3 vs. 7
instructions.  Last I checked ages ago gcc didn't apropriately consider this
cost when generating -mlong-calls code and Linux these days also is
optimized under the assumption that subroutine calls are cheap.

It's time that we get a -G optimization that works for the kernel; it would
allow to cut down the -mlong-calls calling sequence to just:

	lw/ld	$25, offset($gp)
	jalr	$25

> It's time to remove them? -mlong-calls, -fno-omit-frame-pointer.
> 
> > It would be better to fix all the tools so that they could handle both 
> > -mlong-calls and -mno-long-calls code.
> > 
> 
> It's totally possible, will try to make it work later. I just wanted the
> stuff simple, but if it really brings us with much drop, it's time to
> fix it.

  Ralf
