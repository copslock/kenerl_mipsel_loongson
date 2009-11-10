Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 18:49:39 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19904 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492864AbZKJRtd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Nov 2009 18:49:33 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4af9a7a60002>; Tue, 10 Nov 2009 09:49:26 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Nov 2009 09:48:47 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Nov 2009 09:48:47 -0800
Message-ID: <4AF9A77E.6020908@caviumnetworks.com>
Date:	Tue, 10 Nov 2009 09:48:46 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Wu Zhangjin <wuzhangjin@gmail.com>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v7 03/17] tracing: add MIPS specific trace_clock_local()
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com> <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com> <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
In-Reply-To: <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2009 17:48:47.0544 (UTC) FILETIME=[0DF1AB80:01CA622E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
[...]
> + * trace_clock_local(): the simplest and least coherent tracing clock.
> + *
> + * Useful for tracing that does not cross to other CPUs nor
> + * does it go through idle events.
> + */
> +u64 trace_clock_local(void)
> +{
> +	unsigned long flags;
> +	u64 clock;
> +
> +	raw_local_irq_save(flags);
> +
> +	clock = mips_timecounter_read();
> +
> +	raw_local_irq_restore(flags);
> +
> +	return clock;
> +}

Why disable interrupts?

Also you call the new function mips_timecounter_read().  Since 
sched_clock() is a weak function, you can override the definition with a 
more accurate version when possible.  Then you could just directly call 
it here, instead of adding the new mips_timecounter_read() that the 
'[PATCH v7 02/17] tracing: add mips_timecounter_read() for MIPS' adds.

David Daney
