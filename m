Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 23:48:41 +0100 (CET)
Received: from hera.kernel.org ([140.211.167.34]:54733 "EHLO hera.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493057Ab0ACWsg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2010 23:48:36 +0100
Received: from htj.dyndns.org (localhost [127.0.0.1])
        by hera.kernel.org (8.14.3/8.14.3) with ESMTP id o03Mlqui006642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Sun, 3 Jan 2010 22:47:54 GMT
Received: from [10.7.8.135] (a135.air [10.7.8.135])
        by htj.dyndns.org (Postfix) with ESMTPSA id 64B5A10810A2F;
        Mon,  4 Jan 2010 07:53:13 +0900 (KST)
Message-ID: <4B411F14.1040302@kernel.org>
Date:   Mon, 04 Jan 2010 07:49:56 +0900
From:   Tejun Heo <tj@kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
MIME-Version: 1.0
To:     Hui Zhu <teawater@gmail.com>
CC:     Russell King <linux@arm.linux.org.uk>,
        saeed bishara <saeed.bishara@gmail.com>,
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
        Brian Gerst <brgerst@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Coly Li <coly.li@suse.de>
Subject: Re: [PATCH] stack2core: show stack message and convert it to core
 file   when kernel die
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
In-Reply-To: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
X-Enigmail-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 25492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2034

On 01/04/2010 12:05 AM, Hui Zhu wrote:
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
> 
> The stack2core function, can let kernel show stack message when kernel
> die.  This stack message can be convert to core file by program s2c
> (tools/s2c).  Then gdb can show the message in this core file.

FWIW, I love it.  I used to have to match the assembly to the source
code manually to find out which register and stack space meant what.
This will be very helpful in decoding oops message, but I think that
it would be far more useful if it uses the existing oops messages
instead of adding extra messages.  The new messages don't add any new
information and the oops message is already quite long and scrolls off
the screen on certain configurations.  Adding new configuration option
and making oops message longer will make acquiring the information
quite more difficult.

If implementing parsing of oops message in C is too awkward
(unsurprising at all), maybe implementing a converter in perl or
python is the easiest way so that it takes the oops message and puts
out well formatted input for the s2c program?

thanks.

-- 
tejun
