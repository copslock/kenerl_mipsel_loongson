Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 23:51:52 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4324 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491777Ab0FQVvs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 23:51:48 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c1a99080000>; Thu, 17 Jun 2010 14:52:08 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Jun 2010 14:51:45 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Jun 2010 14:51:45 -0700
Message-ID: <4C1A98EC.1030708@caviumnetworks.com>
Date:   Thu, 17 Jun 2010 14:51:40 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@paralogos.com>
CC:     Jan Rovins <janr@adax.com>, linux-mips@linux-mips.org
Subject: Re: Help with decoding a NMI Watchdog interrupt on an Octeon
References: <4C1A8D86.60005@adax.com> <4C1A9319.1020202@paralogos.com>
In-Reply-To: <4C1A9319.1020202@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2010 21:51:45.0613 (UTC) FILETIME=[479DB7D0:01CB0E67]
X-archive-position: 27166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12404

On 06/17/2010 02:26 PM, Kevin D. Kissell wrote:
> NMI is just an input pin, so you'd really need to know what it's
> connected to in the system you're working on.

In this case, the NMI is likely being asserted by the watchdog.  So if 
you are stuck in a loop with interrupts disabled, the register dump 
might help you figure out where things are stuck.  But as you say below, 
knowing the value of the ErrorEPC register is critical.

David Daney

> Typically, it's tied to
> some kind of memory bus time-out, but it could be other things.
> Depending on what it's hooked up to, knowing what code was executing
> when it came in may be completely useless. *If* it's hooked up to a bus
> time-out, *and* the instruction that caused the time-out was a load,
> *and* the time-out and NMI occurred *after* the processor got to the
> instruction that consumes the load value (pretty likely if the first two
> conditions are met), *then* looking at disassembled kernel code
> (mips-linux-objdump --disassemble vmlinux) at the ErrorEPC address,
> *not* the address in EPC, which will have latched the address of the
> last recoverable exception (which NMI is not, strictly speaking). That
> instruction should be the consumer of the bad load, so one of its input
> registers should be the target of that load. If it's a two-input
> instruction, e.g. add r1,r2,r3, then it could be either r2 or r3, and
> you have to work your way backwords up the code flow to find out where
> the r2 and r3 values came from, respectively. *Usually* it's possible to
> identify the load, thus the register used as a base address, and see
> that the base address register was trashed, at which point you can start
> forming hypotheses as to how that could have happened.
>
> Of course, in the dump below, we don't see ErrorEPC. I've never been
> able to figure out why so many kernel register dumps skip that register,
> especially for NMI reporting. But unless you're able to reproduce this
> with a kernel that you build yourself, so that you can fix the
> instrumentation, it's going to be tough. So "Plan B" would be to make
> sure that any removable memory DIMMs have been properly seated, and
> double-check that the actual memory capacity corresponds to whatever
> boot parameters are being passed to the kernel. In otherwords, if you
> can't debug the kernel, pray that it's a hardware or operator error. ;o)
>
> Regards,
>
> Kevin K.
>
> Jan Rovins wrote:
>> Hi, I need some tips on how to go about deciphering the following NMI
>> dump.
>>
>> This is from a 2.6.21.7 kernel that came with the Cavium Networks
>> 1.8.1 toolchain.
>> Is there any way to get some kind of back trace from this, or just
>> find out which function it was in?
>>
>> I have been playing around with objdump -x vmlinux but I cant zero in
>> on anything this way.
>>
>> Thanks in advance,
>>
>> Jan
>> *** NMI Watchdog interrupt on Core 0x6 ***
>> $0 0x0000000000000000 at 0x000000001010cce0
>> v0 0x000000000000003d v1 0x000000000000024a
>> a0 0xffffffff807d7b70 a1 0x0000000000000000
>> a2 0x000000000000024a a3 0x0000000000000000
>> a4 0xffffffff807d7b60 a5 0x0000000000000080
>> a6 0x0000000000000001 a7 0xa800000411c62578
>> t0 0x0000000000000001 t1 0xa80000048ef3e880
>> t2 0xffffffff82d40000 t3 0xa80000041f48c000
>> s0 0xc0000000000d9640 s1 0xc000000000088028
>> s2 0x0000000000000000 s3 0x0000000000000180
>> s4 0x0000000000000000 s5 0x0000000000000000
>> s6 0xb7a89c196f513832 s7 0x0000000000000000
>> t8 0xffffffff807d0000 t9 0xffffffff807d0000
>> k0 0x0000000000000000 k1 0x00000000104dbcbf
>> gp 0xa80000041f48c000 sp 0xa80000041f48fcf0
>> s8 0x0000000000000000 ra 0xc0000000023c5004
>> epc 0xffffffff802b10b8
>> status 0x000000001058cce4 cause 0x0000000040008c08
>> sum0 0x0000002100000000 en0 0x0000009300008000
>> Code around epc
>> 0xffffffff802b10a8 000000002406ffff
>> 0xffffffff802b10ac 0000000064a5ffff
>> 0xffffffff802b10b0 0000000010a60005
>> 0xffffffff802b10b4 0000000000000000
>> 0xffffffff802b10b8 0000000080620000
>> 0xffffffff802b10bc 000000001440fffb
>> 0xffffffff802b10c0 0000000064630001
>> 0xffffffff802b10c4 000000006463ffff
>> 0xffffffff802b10c8 0000000003e00008
>>
>>
>
>
>
