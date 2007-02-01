Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 17:02:35 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:5014 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20038939AbXBARC3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 17:02:29 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 6B4E12985D0;
	Thu,  1 Feb 2007 12:01:51 -0500 (EST)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu,  1 Feb 2007 12:01:51 -0500 (EST)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 1 Feb 2007 09:01:50 -0800
Message-ID: <45C21CFE.9060804@avtrex.com>
Date:	Thu, 01 Feb 2007 09:01:50 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Question about signal syscalls !
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>	 <20070201135734.GB12728@linux-mips.org> <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
In-Reply-To: <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2007 17:01:50.0664 (UTC) FILETIME=[AA7F2480:01C74622]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Hi Ralf,
> 
> On 2/1/07, Ralf Baechle <ralf@linux-mips.org> wrote:
>> The values of those registers need to be preserved so they can later be
>> copied into the signal frame.
>>
> 
> Let's take for example sys_sigreturn(). In my understanding this
> syscall is used automatically when the signal handler returns. At this
> time, I don't see the point to save the static registers since they
> have been already saved by setup_sigcontext().
> 
> Actually I don't see why they need to be saved/restored at all...
> 
> Let's say that process P1 sends a signal X to process P2 which has a
> handler defined for signal X and assume that the static registers are
> not saved at all.
> 
> Signal X is received by P2. The signal handler is now executed in user
> mode. At this point what are the values of the static registers ? I
> would say they have the same values (let's call this state S) when P2
> got interrupted. Once the signal handler returns into the kernel mode
> by executing 'syscall __NR_sigreturn' instructions, static registers
> still have state S and this state is normally preserved during
> sys_sigreturn syscall execution. So when resuming the normal execution
> of P2, the static registers have the correct values.
> 
> What am I missing ?

I don't think *any* registers *need* to be saved on sys_sigreturn(). 
The values in sigcontext on the user stack associated with the system 
call are all used instead of the actual register values.

David Daney
