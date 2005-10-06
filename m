Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 22:13:43 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:29444
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S3465664AbVJFVN0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 22:13:26 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 6 Oct 2005 14:13:24 -0700
Message-ID: <43459374.5080802@avtrex.com>
Date:	Thu, 06 Oct 2005 14:13:24 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	"Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips@linux-mips.org
Subject: Re: Bug in the syscall tracing code
References: <43455D2D.1010901@niisi.msk.ru> <20051006205308.GB31717@hattusa.textio>
In-Reply-To: <20051006205308.GB31717@hattusa.textio>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2005 21:13:24.0497 (UTC) FILETIME=[C99A0810:01C5CABA]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Gleb O. Raiko wrote:
> 
>>Hello,
>>
>>The story continues. The last fix of the syscall tracing code was wrong, 
>>unfortunately. (The bug was a user could invoke any function in the 
>>kernel. The fix was not to use t2 as pointer to a syscall, s0 was chosen 
>>for it.) The problem we discovered is a few syscalls do SAVE_STATIC 
>>(those declared as save_static_function), so s0 (which holds pointer to 
>>the syscall at the time the syscall is invoked) is saved on the stack 
>>overwriting a value saved from the process being traced. No wonder, s0 
>>that restored on syscall exit differs from s0 saved on syscall enter.
>>
>>See, arch/mips/kernel/scall32-o32.S, syscall_trace_entry, for example. 
>>The rest of ABIs are the same.
>>
>>There are several ways to fix this:
>>
>>1. Make syscall handling code to be close to other arches. I mean, check 
>>for the trace flag first, then parse arguments and invoke a syscall.
>>
>>2. Remove save_static_functions and do SAVE_STATIC early for several 
>>syscalls (yes, one big switch or its asm equivalent).
>>
>>3. Store t2 in pt_regs (it means we have to expand this structure).
>>
>>4. I know there should be yet another way.
> 
> 
> - Use the k1 slot instead of s0 to save the function pointer.
> 
That is the conclusion I came to in:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=4207C3E0.7070405%40avtrex.com

IIRC, k0 is already used for something.

David daney.
