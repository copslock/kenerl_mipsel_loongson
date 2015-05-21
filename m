Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 08:00:29 +0200 (CEST)
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:40147 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010740AbbEUGA1N6kLC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2015 08:00:27 +0200
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-01v.sys.comcast.net with comcast
        id WW0N1q0012TL4Rh01W0Njj; Thu, 21 May 2015 06:00:22 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-17v.sys.comcast.net with comcast
        id WW0L1q00J42s2jH01W0Mwr; Thu, 21 May 2015 06:00:22 +0000
Message-ID: <555D7469.7090806@gentoo.org>
Date:   Thu, 21 May 2015 02:00:09 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP, Almost there?
References: <55597B21.4010704@gentoo.org> <5559D483.905@gentoo.org> <555C1A53.9010803@gentoo.org>
In-Reply-To: <555C1A53.9010803@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432188022;
        bh=7LN4Axh1zAnXiXpVdPUVB145f3fFU5mQVjR0iHZ2TxU=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=kQy20OfIMmrfBExAgF2RPzBE/SIeo/uQMt7uWLDQX5dFxL3I2hJWqF6Ncxu7BtpJ9
         omnAzE6OZc/lADurQZFON95Fm9Y42c5ig5g3XZyQPpRlV2rOT3xZfI0eKPLZ6E9385
         sInlNHjQxNYkPAdN1PPmfNJnWnZrzUg5PNGVzBcL5k4x4psipOp7a1OUc9aXf/67wT
         GWFm0KXRrJN+xAKOFmAQ7+6nna0sfOSwxVLXrsLUT95/xaLCRR0aT7mrTiZ5Tkeacd
         NoLCMqhrEZHnIaU2TP4t6IccEk4zSXSwrFqLTCJaDfImo1xr75tqPhS5CIb+KMmK1l
         B4r63J7isozGw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 05/20/2015 01:23, Joshua Kinard wrote:
> <stuff no one reads>

Found my "scheduling while atomic" bug.  Who knew that 'get_cpu_var' attempted
to disable preemption and thus, incremented preempt_count?  That got caught by
__schedule_bug and thus, sleeping while atomic.  Since I based some of the SMP
updates off of arch/mips/kernel/smp-bmips.c, I failed to notice originally,
that code used '__get_cpu_var', which is a different function (and doesn't try
to disable preemption).  I looked at the latest smp-bmips.c code, and that is
now using __this_cpu_ptr(), which solved the sleeping problem.

Still getting instruction bus errors, though.  But this time, one of the IBEs
happened in kernel context and I got an Oops for once:

[     0.148514] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
[     0.198242] Switched to clocksource HEART
[     1.137056] Warning: unable to open an initial console.
[     1.156456] Freeing unused kernel memory: 4544K (a800000020190000 -
a800000020600000)
[     1.169048] Instruction bus error, epc == 00000000004289ac, ra ==
000000000047d054
[     1.183979] Instruction bus error, epc == 00000000004289ac, ra ==
000000000047d054
[     1.195707] Instruction bus error, epc == 000000000040448c, ra ==
0000000000404440
[     1.206829] Instruction bus error, epc == a8000000200ff12c, ra ==
a800000020104fec
[     1.209208] Oops[#1]:
[     1.209907] CPU: 1 PID: 42 Comm: init Not tainted
4.1.0-rc3-mipsgit-20150517 #100
[     1.212251] task: a80000009f372800 ti: a80000009f3bc000 task.ti:
a80000009f3bc000
[     1.214585] $ 0   : 0000000000000000 0000000000948ba9 000000009f35f000
a80000009f35f000
[     1.217115] $ 4   : a80000009f35f000 0000000000948ba0 0000000000000009
a80000009f35f000
[     1.219642] $ 8   : 0000000000000000 0000000000000000 0000000000000000
0000000000000fa4
[     1.222168] $12   : 0000000000000000 ffffffff84080018 0000000000000001
a80000009f3a8000
[     1.224694] $16   : a8000000232d3cc8 0000000000000009 0000000000000000
a800000020650000
[     1.227221] $20   : a80000009f3bfe00 a80000009f3bfdb0 0000000000000009
0000000000000009
[     1.229748] $24   : 0000000000000009 000000000047338c

[     1.232273] $28   : a80000009f3bc000 a80000009f3bfce0 0000000000948ba0
a800000020104fec
[     1.234802] Hi    : 00000000001dda1d
[     1.235897] Lo    : 000000000009f35f
[     1.237010] epc   : a8000000200ff12c __copy_user_common+0xa4/0x358
[     1.238933]     Not tainted
[     1.239801] ra    : a800000020104fec copy_page_from_iter+0x338/0x3f8
[     1.241777] Status: b004fce3 KX SX UX KERNEL EXL IE
[     1.243346] Cause : 00000018
[     1.244222] PrId  : 00000f24 (R14000)
[     1.245353] Process init (pid: 42, threadinfo=a80000009f3bc000,
task=a80000009f372800, tls=00000000005287dc
[     1.248431] Stack : 3200000000000000 000000000047338c a80000009f357a80
a80000009f357a80
o  0000000000000000 a80000009f357a80 0000000000000000 a80000009f3bfdb0
o  a80000009f357e80 0000000000000000 a80000002013e500 a800000020190000
o  a80000009f357c80 a8000000200c38ec a80000002013e528 a8000000232d3cc8
o  a80000009f357e80 a80000009f3bfe70 a80000009f3bfe70 0000000000948ba0
o  0000000000000009 0000000000000063 0000000000000030 0000000000000020
o  0000000000000000 a8000000200bbb14 00000001b004fce1 0000000000000000
o  0000000000000000 0000000000000000 0000000000000000 0000000000000000
o  0000000000948ba0 0000000000000009 a80000009f3bfe40 a80000009f357e80
o  ...
[     1.268825] Call Trace:
[     1.269571] [<a8000000200ff12c>] __copy_user_common+0xa4/0x358
[     1.271403] [<a800000020104fec>] copy_page_from_iter+0x338/0x3f8
[     1.273295] [<a8000000200c38ec>] pipe_write+0x27c/0x45c
[     1.274939] [<a8000000200bbb14>] __vfs_write+0xc8/0xfc
[     1.276539] [<a8000000200bbc78>] vfs_write+0xc8/0x11c
[     1.278112] [<a8000000200bbde0>] SyS_write+0x5c/0xb8
[     1.279670] [<a8000000200185d8>] handle_sys+0x138/0x15c
[     1.281294]
[     1.281726]
Code: cc810100  14d8ffea  00000000 <10c00070> 2cc80020  1500000e 30d80007
dca80000  dca90008
[     1.285075] ---[ end trace f34b7ca5fa10bf37 ]---
[     1.286573] Fatal exception: panic in 5 seconds
<snip>


Following the code path, __copy_user_common has this assembly:

    a8000000200ff120:   cc810100    pref   0x1,256(a0)
    a8000000200ff124:   14d8ffea    bne    a2,t8,a8000000200ff0d0
<__copy_user_common+0x48>
    a8000000200ff128:   00000000    nop
--> a8000000200ff12c:   10c00070    beqz   a2,a8000000200ff2f0
<__copy_user_common+0x268>
    a8000000200ff130:   2cc80020    sltiu  a4,a2,32
    a8000000200ff134:   1500000e    bnez   a4,a8000000200ff170
<__copy_user_common+0xe8>
    a8000000200ff138:   30d80007    andi   t8,a2,0x7
    a8000000200ff13c:   dca80000    ld     a4,0(a1)
    a8000000200ff140:   dca90008    ld     a5,8(a1)


Which is defined in arch/mips/lib/memcpy.S:

        PREFD(  1, 8*32(dst) )
        bne     len, rem, 1b
         nop

        /*
         * len == rem == the number of bytes left to copy < 8*NBYTES
         */
.Lcleanup_both_aligned\@:
-->     beqz    len, .Ldone\@
         sltu   t0, len, 4*NBYTES
        bnez    t0, .Lless_than_4units\@
         and    rem, len, (NBYTES-1)    # rem = len % NBYTES
        /*
         * len >= 4*NBYTES
         */
        LOAD( t0, UNIT(0)(src), .Ll_exc\@)
        LOAD( t1, UNIT(1)(src), .Ll_exc_copy\@)


Where I am lost is, though, why would I get an IBE on a 'beqz' instruction?
It's a valid instruction from MIPS-I ('beqz' is just 'beq' w/ $0 as rt).  the
R10K Manual states this:

"""
A Bus Error exception occurs when a processor block read, upgrade, or
double/single/partial-word read request receives an external ERR completion
response, or a processor double/single/partial-word read request receives an
external ACK completion response where the associated external
double/single/partial-word data response contains an uncorrectable error. This
exception is not maskable.
"""

My guess is there's still something not kosher with icache flushing somewhere.
 I can reboot this kernel multiple times and not always get the same IBE.  Most
happen in user context, which are impossible to trace.

Anyone got ideas?  Is there some way to dump the contents of the icache and/or
dcache for debugging?

--J
