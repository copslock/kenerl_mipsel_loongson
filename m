Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 18:02:44 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:51355 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493094Ab0ACRCh convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2010 18:02:37 +0100
Received: by pzk35 with SMTP id 35so2467078pzk.22
        for <multiple recipients>; Sun, 03 Jan 2010 09:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7g9idHECJs7p5wdWlxhy6TGC8FiWIB+d+Lg9yGbSW2E=;
        b=lc7oLOOjms3QZigndwJG1vr54vIpnxUCthJojjBfs+tAfDJ3J2awCedzz4j4oXd38E
         N/EI6trvbmKi2yZqTxb1LMLiFpuIEKED86ejpIo+OPu+fD2qMAIrMOcnWGMcAzZGk6dM
         CjxyCEME/XDlMZnmE/Xj5OXL/l4q+T1PsC7Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FGbIcsm5SNJg7QCD5uMt9mI22gWxdrgvX1jH34RlT54AQwEDEMl6dEegA9QMq4sVB1
         mnY4ZQEoPPen1p3eqian+YcozkFSrvHGZ1jhDV9E2PA0FZ/LmLhSyAC1WgyvqzvSfvys
         hqSg557dlMDXiUAbfzNbAXoCEmTQzafbDinFs=
MIME-Version: 1.0
Received: by 10.142.75.10 with SMTP id x10mr14815981wfa.288.1262537724086; 
        Sun, 03 Jan 2010 08:55:24 -0800 (PST)
In-Reply-To: <20100103164414.GB21156@n2100.arm.linux.org.uk>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> 
        <20100103160313.GA21156@n2100.arm.linux.org.uk> <daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com> 
        <20100103164414.GB21156@n2100.arm.linux.org.uk>
From:   Hui Zhu <teawater@gmail.com>
Date:   Mon, 4 Jan 2010 00:55:04 +0800
Message-ID: <daef60381001030855o3a39c3fdr879e2634fb85c491@mail.gmail.com>
Subject: Re: [PATCH] stack2core: show stack message and convert it to core 
        file when kernel die
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     saeed bishara <saeed.bishara@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
        Chris Dearman <chris@mips.com>,
        Paul Gortmaker <Paul.Gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Brian Gerst <brgerst@gmail.com>, Tejun Heo <tj@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Coly Li <coly.li@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: teawater@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1947

I didn't give the user raw oopses.
I give him core file. When the kernel die, do we can get a core file now?


(gdb) bt
#0  0xc0008470 in kernel_init (unused=<value optimized out>)
  at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/init/main.c:916
#1  0xc0042660 in sys_waitid (which=<value optimized out>, upid=<value
optimized out>, infop=0x0, options=0, ru=0x14)
  at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/kernel/exit.c:1798
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

It show which line make kernel die.

Hui




On Mon, Jan 4, 2010 at 00:44, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 04, 2010 at 12:30:20AM +0800, Hui Zhu wrote:
>> This S2C: message just for program s2c.
>> s2c can convert it to a core file.  Then gdb can do a clear analyse
>> with this file.
>> Then you can get more message than current we can get.
>
> I understand that.  What I'm saying is that all the additional noise
> you're causing the kernel to create is just a pure duplication of
> what we already dump.
>
> Oops dumps are already noisy enough - especially if they cause a panic
> at the end (where you end up with two backtraces.)  We do not need even
> more noise caused by needless duplication.
>
> You can get everything you need already from the kernel.  On ARM, we
> already dump out all the registers and the _full_ stack.  There is no
> need for you to implement your own register dumping code and full stack
> dump on top of that again.
>
> So, I'm not going to accept your patch for the ARM kernel.  Please use
> what's already provided - it's more than adequate.  By doing so, you
> don't penalise those of us who want to read the raw oopses.
>
> Talking about noisy oopses, I'm getting one with 2.6.33-rc2 on 'poweroff'
> shutdown.  No idea what it is because most of it's scrolled off the top of
> the screen and I can't scroll back.  Not bothered about it at the moment.
> What it does illustrate though is why making things too noisy when problems
> occur makes it _more_ difficult to find out what went wrong.
>
