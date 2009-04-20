Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 15:22:29 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.187]:10526 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20032619AbZDTOWW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Apr 2009 15:22:22 +0100
Received: by ti-out-0910.google.com with SMTP id 11so1256064tim.20
        for <multiple recipients>; Mon, 20 Apr 2009 07:22:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=6+8PrpuSrrtrTWAGZiFQl3W5cC0eJpurrITenBSUmqE=;
        b=L/n8C00rTFVWCp2AiVG0gIm65gJjuBj+UTi8tQAWpWKCSf5rsM/9/lkljArq6aI+hc
         ZYM41hf2gr7RHDheDKuOYOV3Q2s7L082sYK4tSNvg2n2LLhbRdFw9/SWgL3B1VYnUI4Z
         nG1T9bzeAqj0wA6b/qsncRjkt1zVGn2Y/r894=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Q2LE6RM7x255sdeUlhV6W9q1n3Ltged8SjukEksW8Iurelc5QwRQEDns09IF7nyIQa
         vujBxVNVGkuRr0icYyjyr1TYsJu5AZ4xnpd8xkA7xDnEgWSyTbUsnSyfKAEKwhb4v3L4
         SzRl/hXo/kL+yl+1gHuTMDvO4f+PXFjNPC3bs=
Received: by 10.110.86.3 with SMTP id j3mr1295291tib.13.1240237338347;
        Mon, 20 Apr 2009 07:22:18 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id d4sm713348tib.15.2009.04.20.07.22.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 07:22:17 -0700 (PDT)
Subject: Re: "RT_PREEMPT for loongson" is updated to patch-2.6.29.1-rt8
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Zhang Le <r0bertz@gentoo.org>, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, yanh@lemote.com,
	linux-mips@linux-mips.org, linux-rt-users@vger.kernel.org
In-Reply-To: <20090420131022.GA10183@linux-mips.org>
References: <1240193547.25532.52.camel@falcon>
	 <20090420050419.GA22520@adriano.hkcable.com.hk>
	 <1240211926.8884.27.camel@falcon> <20090420080155.GA11621@linux-mips.org>
	 <20090420131022.GA10183@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Mon, 20 Apr 2009 22:22:03 +0800
Message-Id: <1240237323.8884.42.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-04-20 at 15:10 +0200, Ralf Baechle wrote:
> On Mon, Apr 20, 2009 at 10:01:55AM +0200, Ralf Baechle wrote:
> 
> > > I have divided ftrace to several commits in the above git tree, hope you
> > > can check it, thx :-) 
> > > 
> > > in addition to the static/dynamic/graph function tracer & system call
> > > tracer implementation, a mips specific ring_buffer_time_stamp
> > > (kernel/trace/ring_buffer.c) is also implemented to get 1us precision
> > > time, this is very important to make ftrace available in mips,
> > > otherwise, we can only get 1ms precision time for the original
> > > ring_buffer_time_stamp is based on sched_clock(jiffies based). 
> > > 
> > > perhaps we can implement a more precise sched_clock directly, just as
> > > x86 does(native_sched_clock, tsc based), but in mips, there is only a
> > > 32bit timer count which will quickly overflow, so it will need an extra
> > > overflow protection, which may influence the other parts of the kernel.
> > 
> > My git clone is still running to I'm commenting only on the patches you
> > posted earlier.  #ifdef-MIPS'ing things into the generic kernel code
> > definately won't be an acceptable way to get µs resolution.
> 

just fix it via moving mips specific ring_buffer_time_stamp to
arch/mips/kernel/ftrace.c via defining the original one as
__attribute__(weak).

in arch/mips/kernel/ftrace.c: 

u64 native_ring_buffer_time_stamp(...) {
...
}
u64 ring_buffer_time_stamp(...)
__attribute__((alias("native_ring_buffer_time_stamp")));

in kernel/trace/ring_buffer.c:

-u64 ring_buffer_time_stamp(struct ring_buffer *buffer, int cpu)
+ u64 __attribute__((weak)) ring_buffer_time_stamp(struct ring_buffer
*buffer, int cpu)

*** not push to the git tree yet.

> In changeset e67f78d663a84ef93aa12c3c8c1adf3033c4f9a1 you introduce
> <asm/rwsem.h> but because RWSEM_GENERIC_SPINLOCK is always set that file
> won't ever be included.
> 

Yes, currently, I'm trying to fix it.

>   Ralf
