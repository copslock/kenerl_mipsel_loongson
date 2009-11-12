Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 22:16:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54568 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493307AbZKLVQs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Nov 2009 22:16:48 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nACLGhLh027976;
	Thu, 12 Nov 2009 22:16:44 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nACLGbSH027974;
	Thu, 12 Nov 2009 22:16:37 +0100
Date:	Thu, 12 Nov 2009 22:16:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v7 04/17] tracing: add static function tracer support
	for MIPS
Message-ID: <20091112211637.GA27465@linux-mips.org>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com> <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com> <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com> <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com> <4AF8B31C.5030802@caviumnetworks.com> <1257814817.2822.3.camel@falcon.domain.org> <4AF99848.9090000@caviumnetworks.com> <1257907351.2922.37.camel@falcon.domain.org> <20091111031325.GA20716@linux-mips.org> <alpine.LFD.2.00.0911111327450.10184@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911111327450.10184@eddie.linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 11, 2009 at 01:30:40PM +0000, Maciej W. Rozycki wrote:

> 
> On Wed, 11 Nov 2009, Ralf Baechle wrote:
> 
> > 64-bit with -mlong-call:
> > 
> > 	lui	$25, %highest(foo)
> > 	lui	$2, %hi(foo)
> > 	daddiu	$25, %higher(foo)
> > 	daddiu	$2, %lo(foo)
> > 	dsll	$25, 32
> > 	daddu	$25, $2
> > 	jalr	$25
> 
>  Don't we use -msym32 these days for this very reason?

We do - where we can.  Not all systems can use -msym32.

  Ralf
