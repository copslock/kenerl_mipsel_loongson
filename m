Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 17:08:12 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42262 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492693Ab0ACQH6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 17:07:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:In-Reply-To:
        Sender; bh=f8nrrzKorxz2r+0EpnkC6arihC5aecjryFZIJ0m8nto=; b=pHcZJ
        9arLXQ6aN3E+LS/auBWmeBHwSbmteQduTzZO0DnVbP406e4+pIniR0oPERMaVTYi
        kDDU/lh8EbWvHEgMQoFx5PDJ68siX9fiifZgY/HMzZoKqvgOrpg3Cy7r/1m3oQ5h
        9xKDnj9AyCKSy47350lkNhvqTKhauvCWTCodXY=
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1NRSvE-0006vJ-Cu; Sun, 03 Jan 2010 16:03:16 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1NRSvC-0005XC-4t; Sun, 03 Jan 2010 16:03:14 +0000
Date:   Sun, 3 Jan 2010 16:03:13 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Hui Zhu <teawater@gmail.com>
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
Subject: Re: [PATCH] stack2core: show stack message and convert it to core
        file when kernel die
Message-ID: <20100103160313.GA21156@n2100.arm.linux.org.uk>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1924

On Sun, Jan 03, 2010 at 11:05:05PM +0800, Hui Zhu wrote:
> Hello,
> 
> For, when the kernel die, the user will get some message like:
> PC is at kernel_init+0xd4/0x104
> LR is at _atomic_dec_and_lock+0x48/0x6c
> pc : [<c0008470>]    lr : [<c01911f8>]    psr: 60000013
> sp : c7823fd8  ip : c7823f48  fp : c7823ff4
> Stack: (0xc7823fd8 to 0xc7824000)
> 3fc0:                                                       00000000 00000001
> Backtrace:
> [<c000839c>] (kernel_init+0x0/0x104) from [<c0042660>] (do_exit+0x0/0x880)
> This backtrace have some wrong message sometime and cannot get any
> val. Of course, kdump can get more message.  But it need do some a lot
> of other config.

If you have frame pointers enabled, the backtrace is _never_ wrong.
It only goes wrong if you disable frame pointers, at which point the
unwind tables have to be used.

> When kernel die, show some message:
> S2C:elf_class=1
> S2C:elf_data=1
> S2C:elf_arch=40
> S2C:elf_osabi=0
> S2C:r0=0x00000000;
> S2C:r1=0xc7822000;
> S2C:r2=0xc7823f48;
> S2C:r3=0x00000003;
> S2C:r4=0x00000000;
> S2C:r5=0x00000000;
> S2C:r6=0x00000000;
> S2C:r7=0x00000000;
> S2C:r8=0x00000000;
> S2C:r9=0x00000000;
> S2C:r10=0x00000000;
> S2C:fp=0xc7823ff4;
> S2C:ip=0xc7823f48;
> S2C:sp=0xc7823fd8;
> S2C:lr=0xc01911f8;
> S2C:pc=0xc0008470;
> S2C:cpsr=0x60000013;
> S2C:ORIG_r0=0xffffffff;
> 
> S2C:stack=0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
> S2C:stack=0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> S2C:stack=0x00, 0x00, 0x00, 0x00, 0xf8, 0x3f, 0x82, 0xc7,
> S2C:stack=0x60, 0x26, 0x04, 0xc0, 0xa8, 0x83, 0x00, 0xc0,
> S2C:stack=0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,

Please don't invent yet another way of dumping stuff out of the kernel.
What we already have is sufficient for your needs - there's no reason
what so ever to change it to achieve your goals.  We already dump the
registers and the stack, which seems to be all that you require.
