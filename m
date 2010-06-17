Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 23:25:48 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3743 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491190Ab0FQVZo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 23:25:44 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c1a92eb0000>; Thu, 17 Jun 2010 14:26:03 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Jun 2010 14:25:40 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Jun 2010 14:25:40 -0700
Message-ID: <4C1A92D4.504@caviumnetworks.com>
Date:   Thu, 17 Jun 2010 14:25:40 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Jan Rovins <janr@adax.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Help with decoding a NMI Watchdog interrupt on an Octeon
References: <4C1A8D86.60005@adax.com>
In-Reply-To: <4C1A8D86.60005@adax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2010 21:25:40.0853 (UTC) FILETIME=[A2F24A50:01CB0E63]
X-archive-position: 27164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12394

On 06/17/2010 02:03 PM, Jan Rovins wrote:
> Hi, I need some tips on how to go about deciphering the following NMI dump.
>
> This is from a 2.6.21.7 kernel that came with the Cavium Networks 1.8.1
> toolchain.
> Is there any way to get some kind of back trace from this, or just find
> out which function it was in?
>
> I have been playing around with objdump -x vmlinux but I cant zero in on
> anything this way.
>
> Thanks in advance,
>
> Jan
> *** NMI Watchdog interrupt on Core 0x6 ***
> $0 0x0000000000000000 at 0x000000001010cce0
> v0 0x000000000000003d v1 0x000000000000024a
> a0 0xffffffff807d7b70 a1 0x0000000000000000
> a2 0x000000000000024a a3 0x0000000000000000
> a4 0xffffffff807d7b60 a5 0x0000000000000080
> a6 0x0000000000000001 a7 0xa800000411c62578
> t0 0x0000000000000001 t1 0xa80000048ef3e880
> t2 0xffffffff82d40000 t3 0xa80000041f48c000
> s0 0xc0000000000d9640 s1 0xc000000000088028
> s2 0x0000000000000000 s3 0x0000000000000180
> s4 0x0000000000000000 s5 0x0000000000000000
> s6 0xb7a89c196f513832 s7 0x0000000000000000
> t8 0xffffffff807d0000 t9 0xffffffff807d0000
> k0 0x0000000000000000 k1 0x00000000104dbcbf
> gp 0xa80000041f48c000 sp 0xa80000041f48fcf0
> s8 0x0000000000000000 ra 0xc0000000023c5004
> epc 0xffffffff802b10b8

You may want to verify that epc value is being loaded from C0_ErrorEPC 
rather than C0_EPC.  SDK-1.8.1 gets this wrong.

Look in watchgog.c:octeon_watchdog_nmi_stage3.

Once you have it printing the ErrorEPC value, the trace actually tells 
you what was happening when the NMI fired.

objdump -d vmlinux will give you a disassembly of the kernel, and away 
you go.

David Daney

> status 0x000000001058cce4 cause 0x0000000040008c08
> sum0 0x0000002100000000 en0 0x0000009300008000
> Code around epc
> 0xffffffff802b10a8 000000002406ffff
> 0xffffffff802b10ac 0000000064a5ffff
> 0xffffffff802b10b0 0000000010a60005
> 0xffffffff802b10b4 0000000000000000
> 0xffffffff802b10b8 0000000080620000
> 0xffffffff802b10bc 000000001440fffb
> 0xffffffff802b10c0 0000000064630001
> 0xffffffff802b10c4 000000006463ffff
> 0xffffffff802b10c8 0000000003e00008
>
>
>
