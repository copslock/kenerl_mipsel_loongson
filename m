Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 16:08:12 +0100 (CET)
Received: from www.tglx.de ([62.245.132.106]:51757 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493394AbZKPPIE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Nov 2009 16:08:04 +0100
Received: from localhost (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id nAGF7e8b011796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Nov 2009 16:07:40 +0100
Date:	Mon, 16 Nov 2009 16:07:40 +0100 (CET)
From:	Thomas Gleixner <tglx@linutronix.de>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
cc:	rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Michal Simek <monstr@monstr.eu>,
	"Maciej W . Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com
Subject: Re: [PATCH v8 01/16] tracing: convert trace_clock_local() as weak
 function
In-Reply-To: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
Message-ID: <alpine.LFD.2.00.0911161559280.24119@localhost.localdomain>
References: <cover.1258177321.git.wuzhangjin@gmail.com> <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.1 at www.tglx.de
X-Virus-Status:	Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Sat, 14 Nov 2009, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> trace_clock_local() is based on the arch-specific sched_clock(), in X86,
> it is tsc(64bit) based, which can give very high precision(about 1ns
> with 1GHz). but in MIPS, the sched_clock() is jiffies based, which can
> give only 10ms precison with 1000 HZ. which is not enough for tracing,
> especially for Real Time system.
> 
> so, we need to implement a MIPS specific sched_clock() to get higher
> precision. There is a tsc like clock counter register in MIPS, whose
> frequency is half of the processor, so, if the cpu frequency is 800MHz,
> the time precision reaches 2.5ns, which is very good for tracing, even
> for Real Time system.
> 
> but 'Cause it is only 32bit long, which will rollover quickly, so, such
> a sched_clock() will bring with extra load, which is not good for the
> whole system. so, we only need to implement a arch-specific
> trace_clock_local() for tracing. as a preparation, we convert it as a
> weak function.

Hmm, I'm not convinced that this is really a huge overhead. 

First of all the rollover happens once every 10 seconds on a 800MHz
machine. 

Secondly we have a lockless implementation of extending 32bit counters
to 63 bit which is used at least by ARM to provide a high resolution
sched_clock implementation. See include/linux/cnt32_63.h and the users
in arch/

But that's a problem which can be discussed seperately and does not
affect the rest of the tracing infrastructure. I really would
recommend that you implement a sched_clock for the r4k machines based
on cnt32_63 and measure the overhead. Having a fine granular
sched_clock in general is probably not a bad thing.

Thanks,

	tglx
