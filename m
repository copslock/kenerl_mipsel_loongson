Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 16:02:09 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:49566 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493394AbZKPPCC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 16:02:02 +0100
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta01.mail.rr.com with ESMTP
          id <20091116150154011.VNOJ4007@hrndva-omta01.mail.rr.com>;
          Mon, 16 Nov 2009 15:01:54 +0000
Subject: Re: [PATCH v8 01/16] tracing: convert trace_clock_local() as weak
 function
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>,
	"Maciej W . Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com
In-Reply-To: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
References: <cover.1258177321.git.wuzhangjin@gmail.com>
	 <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Mon, 16 Nov 2009 10:01:52 -0500
Message-Id: <1258383712.22249.452.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Sat, 2009-11-14 at 14:33 +0800, Wu Zhangjin wrote:
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
> 
> The MIPS specific trace_clock_local() is coming in the next two patches.
> 
> Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
