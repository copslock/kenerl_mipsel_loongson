Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 17:31:02 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:57217 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493092Ab0ACQas convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2010 17:30:48 +0100
Received: by pwj1 with SMTP id 1so9091051pwj.24
        for <multiple recipients>; Sun, 03 Jan 2010 08:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nsZJH84oAr7EAExqqhiYT2Ui74x3lrLBqTDtBOwhTg4=;
        b=LDVOcH9EOFI+W5pqMzyVCaXTTchYFnJL0a3KLdw0f0lhkyrbdt6JgSL9z1+VC4gjuF
         LGNorcEGtkRzJbv7wjnByhQwSpV4Jl/Hx7HGGXjji1cgaiGKFJ8dHReQO9Z8QkCTmQu5
         /m9ldzySN/bnv4tdG/ufZTlTU3XoPESspjRIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fRoWasEwl+1+vy0LFGbRyCKX4QTmOW2eThbK1eJJOMmd/Oo/ho2djNoK6z0nTCIzJA
         +nPgiBeFOBkTPHVS9eykFjw2L+CeaLyVaaxYg5prRw7B912UZq2w3wOwIHfXlOTaVWNE
         5D6ooDb5+jn7C2vVf7SofVXSqWRW96hAD4ZHM=
MIME-Version: 1.0
Received: by 10.142.60.3 with SMTP id i3mr14692521wfa.147.1262536240101; Sun, 
        03 Jan 2010 08:30:40 -0800 (PST)
In-Reply-To: <20100103160313.GA21156@n2100.arm.linux.org.uk>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> 
        <20100103160313.GA21156@n2100.arm.linux.org.uk>
From:   Hui Zhu <teawater@gmail.com>
Date:   Mon, 4 Jan 2010 00:30:20 +0800
Message-ID: <daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com>
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
X-archive-position: 25476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: teawater@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1931

Thanks Russell,

This S2C: message just for program s2c.
s2c can convert it to a core file.  Then gdb can do a clear analyse
with this file.
Then you can get more message than current we can get.

For example:
(gdb) bt
#0  0xc0008470 in kernel_init (unused=<value optimized out>)
   at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/init/main.c:916
#1  0xc0042660 in sys_waitid (which=<value optimized out>, upid=<value
optimized out>, infop=0x0, options=0, ru=0x14)
   at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/kernel/exit.c:1798
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

a more clear backtrace.

(gdb) frame 1
#1  0xc0042660 in sys_waitid (which=<value optimized out>, upid=<value
optimized out>, infop=0x0, options=0, ru=0x14)
   at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/kernel/exit.c:1798
1798                    pid = find_get_pid(upid);
(gdb) p pid
$1 = (struct pid *) 0x0

A value of a val in stack in the frame.


I think it will more helpful for user to deal with the kernel die.

Best regards,
Hui

On Mon, Jan 4, 2010 at 00:03, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jan 03, 2010 at 11:05:05PM +0800, Hui Zhu wrote:
>> Hello,
>>
>> For, when the kernel die, the user will get some message like:
>> PC is at kernel_init+0xd4/0x104
>> LR is at _atomic_dec_and_lock+0x48/0x6c
>> pc : [<c0008470>]    lr : [<c01911f8>]    psr: 60000013
>> sp : c7823fd8  ip : c7823f48  fp : c7823ff4
>> Stack: (0xc7823fd8 to 0xc7824000)
>> 3fc0:                                                       00000000 00000001
>> Backtrace:
>> [<c000839c>] (kernel_init+0x0/0x104) from [<c0042660>] (do_exit+0x0/0x880)
>> This backtrace have some wrong message sometime and cannot get any
>> val. Of course, kdump can get more message.  But it need do some a lot
>> of other config.
>
> If you have frame pointers enabled, the backtrace is _never_ wrong.
> It only goes wrong if you disable frame pointers, at which point the
> unwind tables have to be used.
>
>> When kernel die, show some message:
>> S2C:elf_class=1
>> S2C:elf_data=1
>> S2C:elf_arch=40
>> S2C:elf_osabi=0
>> S2C:r0=0x00000000;
>> S2C:r1=0xc7822000;
>> S2C:r2=0xc7823f48;
>> S2C:r3=0x00000003;
>> S2C:r4=0x00000000;
>> S2C:r5=0x00000000;
>> S2C:r6=0x00000000;
>> S2C:r7=0x00000000;
>> S2C:r8=0x00000000;
>> S2C:r9=0x00000000;
>> S2C:r10=0x00000000;
>> S2C:fp=0xc7823ff4;
>> S2C:ip=0xc7823f48;
>> S2C:sp=0xc7823fd8;
>> S2C:lr=0xc01911f8;
>> S2C:pc=0xc0008470;
>> S2C:cpsr=0x60000013;
>> S2C:ORIG_r0=0xffffffff;
>>
>> S2C:stack=0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
>> S2C:stack=0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> S2C:stack=0x00, 0x00, 0x00, 0x00, 0xf8, 0x3f, 0x82, 0xc7,
>> S2C:stack=0x60, 0x26, 0x04, 0xc0, 0xa8, 0x83, 0x00, 0xc0,
>> S2C:stack=0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>
> Please don't invent yet another way of dumping stuff out of the kernel.
> What we already have is sufficient for your needs - there's no reason
> what so ever to change it to achieve your goals.  We already dump the
> registers and the stack, which seems to be all that you require.
>
