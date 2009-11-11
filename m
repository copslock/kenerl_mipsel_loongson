Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 14:15:05 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47661 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492533AbZKKNPC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 14:15:02 +0100
Date:	Wed, 11 Nov 2009 13:15:02 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, zhangfx@lemote.com, zhouqg@gmail.com,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v7 04/17] tracing: add static function tracer support
 for MIPS
In-Reply-To: <1257907351.2922.37.camel@falcon.domain.org>
Message-ID: <alpine.LFD.2.00.0911111309170.10184@eddie.linux-mips.org>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>  <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>  <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com> 
 <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com>  <4AF8B31C.5030802@caviumnetworks.com>  <1257814817.2822.3.camel@falcon.domain.org>  <4AF99848.9090000@caviumnetworks.com> <1257907351.2922.37.camel@falcon.domain.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 11 Nov 2009, Wu Zhangjin wrote:

> > -mlong-calls really degrades performance.  I have seen things like 6% 
> > drop in network packet forwarding rates with -mlong-calls.
> > 
> 
> so much drop? seems only two instructions added for it: lui, addi. from
> this view point, I think the -fno-omit-frame-pointer(add, sd, move...)
> will also bring with much drop.

 No, register jumps cannot be predicted -- this is where the performance 
goes on any serious processor -- the two extra instructions are nothing 
compared to that.  OTOH frame pointer calculations are pure arithmetic, so 
you only lose time incurred by the instructions themselves.

  Maciej
