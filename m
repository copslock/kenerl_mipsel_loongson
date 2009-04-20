Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 14:10:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:5867 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20032717AbZDTNKh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2009 14:10:37 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3KDAQMX012697;
	Mon, 20 Apr 2009 15:10:27 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3KDAM1V012696;
	Mon, 20 Apr 2009 15:10:22 +0200
Date:	Mon, 20 Apr 2009 15:10:22 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Zhang Le <r0bertz@gentoo.org>, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, yanh@lemote.com,
	linux-mips@linux-mips.org, linux-rt-users@vger.kernel.org
Subject: Re: "RT_PREEMPT for loongson" is updated to patch-2.6.29.1-rt8
Message-ID: <20090420131022.GA10183@linux-mips.org>
References: <1240193547.25532.52.camel@falcon> <20090420050419.GA22520@adriano.hkcable.com.hk> <1240211926.8884.27.camel@falcon> <20090420080155.GA11621@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090420080155.GA11621@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 20, 2009 at 10:01:55AM +0200, Ralf Baechle wrote:

> > I have divided ftrace to several commits in the above git tree, hope you
> > can check it, thx :-) 
> > 
> > in addition to the static/dynamic/graph function tracer & system call
> > tracer implementation, a mips specific ring_buffer_time_stamp
> > (kernel/trace/ring_buffer.c) is also implemented to get 1us precision
> > time, this is very important to make ftrace available in mips,
> > otherwise, we can only get 1ms precision time for the original
> > ring_buffer_time_stamp is based on sched_clock(jiffies based). 
> > 
> > perhaps we can implement a more precise sched_clock directly, just as
> > x86 does(native_sched_clock, tsc based), but in mips, there is only a
> > 32bit timer count which will quickly overflow, so it will need an extra
> > overflow protection, which may influence the other parts of the kernel.
> 
> My git clone is still running to I'm commenting only on the patches you
> posted earlier.  #ifdef-MIPS'ing things into the generic kernel code
> definately won't be an acceptable way to get µs resolution.

In changeset e67f78d663a84ef93aa12c3c8c1adf3033c4f9a1 you introduce
<asm/rwsem.h> but because RWSEM_GENERIC_SPINLOCK is always set that file
won't ever be included.

  Ralf
