Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 19:39:33 +0000 (GMT)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:56443
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8224935AbVBGTjQ>;
	Mon, 7 Feb 2005 19:39:16 +0000
Received: from [192.168.0.35] ([192.168.0.35] unverified) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 7 Feb 2005 11:39:14 -0800
Message-ID: <4207C3E0.7070405@avtrex.com>
Date:	Mon, 07 Feb 2005 11:39:12 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
CC:	andreev <andreev@niisi.msk.ru>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: Strace doesn't work on linux-2.4.28 and later
References: <41FF876B.3070407@niisi.msk.ru> <4207C142.6070804@avtrex.com>
In-Reply-To: <4207C142.6070804@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2005 19:39:14.0679 (UTC) FILETIME=[B47E7870:01C50D4C]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> andreev wrote:
> 
>> Hi, list.
>>
>> We are using the latest kernel from mips-linux CVS and there is a 
>> problem with ptrace.
>>
>> When syscall with 5 or more arguments are traced, the fifth argument 
>> of the syscall is overwritten
>> by tracing code. This error causes problems with strace. For example, 
>> you can't trace dynamically linked
>> applications, because ld.so calls mmap which has 6 arguments.
>>
> 
> This patch broke it:
> 
> http://www.linux-mips.org/archives/linux-cvs/2004-11/msg00116.html
> 
> RCS file: /home/cvs/linux/arch/mips/kernel/Attic/scall_o32.S,v
> retrieving revision 1.18.2.13
> retrieving revision 1.18.2.14
> diff -u -p -r1.18.2.13 -r1.18.2.14
> --- linux/arch/mips/kernel/Attic/scall_o32.S    2004/04/26 15:06:02    
> 1.18.2.13
> +++ linux/arch/mips/kernel/Attic/scall_o32.S    2004/11/25 09:43:59    
> 1.18.2.14
> @@ -121,9 +121,9 @@ reschedule:
> 
>  trace_a_syscall:
>      SAVE_STATIC
> -    sw    t2, PT_R1(sp)
> +    sw    t2, PT_SCRATCH0(sp)
>      jal    syscall_trace
> -    lw    t2, PT_R1(sp)
> +    lw    t2, PT_SCRATCH0(sp)
> 
>      lw    a0, PT_R4(sp)        # Restore argument registers
>      lw    a1, PT_R5(sp)
> 
> PT_SCRATCH0(sp) = 16(sp) which is where arg5 is stored.  This overwrites 
> it.
> 
> In arch/mips/tools/offset.c we have:
> 
>     offset("#define PT_SCRATCH0 ", struct pt_regs, pad0[4]);
>     offset("#define PT_SCRATCH1 ", struct pt_regs, pad0[5]);
> 
> I am thinking of testing a patch where I change them to:
> 
>     offset("#define PT_SCRATCH0 ", struct pt_regs, pad0[0]);
>     offset("#define PT_SCRATCH1 ", struct pt_regs, pad0[1]);
> 
> Any needed argument registers are already saved in and restored from the 
> regs array so overwriting the stack area reserved for them should be OK.
> 
I now think that is bogus reasoning as the first four slots can be 
clobbered by the compiler.

It seems that t2 must be saved somewhere in the regs list.  I am not 
sure what the problem with PT_R1(sp) was, but it seems like a good 
candidate.  Perhaps PT_R26 or PT_R27 (k0, k1) would be a better place to 
store t2 as I don't think k0 or k1 are ever stored.

David Daney.
