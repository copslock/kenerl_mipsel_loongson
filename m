Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 10:31:01 +0100 (CET)
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:34482 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013113AbaKRJbAG4pGY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 10:31:00 +0100
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-06v.sys.comcast.net with comcast
        id GxWo1p00526dK1R01xWo7T; Tue, 18 Nov 2014 09:30:48 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-ch2-01v.sys.comcast.net with comcast
        id GxWn1p0040gJalY01xWn7m; Tue, 18 Nov 2014 09:30:48 +0000
Message-ID: <546B11C0.90805@gentoo.org>
Date:   Tue, 18 Nov 2014 04:30:40 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP Help
References: <5457187D.6030708@gentoo.org> <54607499.2070806@gentoo.org>
In-Reply-To: <54607499.2070806@gentoo.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1416303048;
        bh=+z4dzzvRRHn6DxWZN2nKcW8FYOWcZUOnM6XcOb2LAcE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=suZzpRCpFahIOF17Fvoir+EbxeUadGnQnfkhYDktXIHEC5kOfEtY0ywAjGIsefPYT
         Dcg7Ke3D8n8tRoyFgXc2Z0386kytuIEENpJUwbhuwCxLkp84+zgUPU9Ch76Yz4x5jA
         DHDtCWHfHAhRr8BfDaCk33JcOXqj0SAvax99F4dDEBcVYJEIa2Qj9ijB8dQthzUVoz
         WScK6sV0FUIgHA/WH5X1+uSdY19XGm24QRMxsZBeAqr2b0Rw4wHf2hcTldJsn8jYC6
         f4xA0+J2UCRhz6G8ipFVqWhwPUVp7q8iRuV+niZqHQsyUMM7+BLgi0Owb5/7fQIL+E
         haorCU0urge0Q==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44263
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

On 11/10/2014 03:17, Joshua Kinard wrote:
> On 11/03/2014 00:54, Joshua Kinard wrote:
>>
>> I've recently acquired a dual R14000 CPU for the Octane, so I am trying to get
>> SMP working again, but I can't get things setup properly.  I've attached both
>> ip30-irq.c and ip30-smp.c -- does anyone see any immediate problems (or just
>> where I am doing it wrong)?
>>
>> Most reboot cycles with this code panics because init exited with a code of 0xa
>> or 0xb (which matches w/ SIGSEGV or SIGBUS).  Randomly, I can acquire a dash
>> shell by passing init=/bin/dash.  I can't do much in it, though.  A basic 'ls'
>> either segfaults or triggers a SIGBUS.  If I execute 'ls' enough times, it
>> eventually works.  Can't get much farther beyond that.
> 

What is wrong with these stack addresses?  This is the result of disabling CPU1
in the PROM and booting an SMP kernel.  It's like both the low 32-bits and high
32-bits of the data in the CPU registers are getting merged together somehow
when they're added to the stack.

I can't think of anything in Octane's code doing this.  Has anyone seen
something like this before?  This is likely the cause of the SIGSEGV/SIGBUS
signals I keep getting.

CPU: 0 PID: 54 Comm: grep Not tainted 3.18.0-rc4 #194
task: a800000059b80000 ti: a8000000595c4000 task.ti: a8000000595c4000
$ 0   : 0000000000000000 ffffffff9004fce0 ffffffffffffffff ffffffffffffffff
$ 4   : 0000000077d809a0 0000000000000000 ffffffffffffffff ffffffffffffffff
$ 8   : 0000000000440f14 0000000000439bdc 0000000000000058 0000000000000000
$12   : 0000000000000000 a800000059b88aa0 a8000000200d22d0 001c450400000018
$16   : 0000000077d809a0 0000000077e3f000 0000000000000000 0000000000000000
$20   : 0000000077d803b4 0000000000000001 0000000077d82604 000000007ff808f8
$24   : 0018460400000000 0000000077c7aa90
$28   : 0000000077d88e10 000000007ff807c0 000000007ff807c0 0000000077c68bdc
Hi    : 0000000000061170
Lo    : 00000000000205d0
epc   : 0000000077c7ab00 0x77c7ab00
    Not tainted
ra    : 0000000077c68bdc 0x77c68bdc
Status: 8004fcf3    KX SX UX KERNEL EXL IE
Cause : 00000018
PrId  : 00000f24 (R14000)
Process grep (pid: 54, threadinfo=a8000000595c4000, task=a800000059b80000, tls=0000000077e46490)
Stack : 0000000000000000 77d88e1077d809a0 77d88e1077d809a0 77e3f00077d809a0
        7ff807e877c68bdc 0000000000000000 0000000000000009 77d88e1000000001
        0000000000000000 0000000200000000 7ff808700041e7a4 0000000000000000
        0000003d202fbf00 0043f0d07ff80830 0000003d00000003 00000004004134f4
        77d88e1000000000 0000000300000004 0000000200000000 0043f0d000000001
        0000000200000003 0000000477c34698 0043000000424fd0 000000027ff808f8
        77d88e1077c29488 000000007ff80ae4 0000000200000000 7ff80fc600430000
        00424fd000000002 7ff808b077c34748 000000027ff80fc6 0043000000424fd0
        77d88e107ff808f8 77d8012800403788 0000000077d5638c 0000000077e4028c
        000000007ff808e8 0000000000000000 0043f0d077e101dc 0000000100000000
        ...
Call Trace:
 (Bad stack address)

Code: 30420040  5040000a  82020046  <03c0e821>  8f998750  00002821  8fbf0024  02002021  8fbe0020

--J
