Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 20:11:19 +0100 (BST)
Received: from mail.timesys.com ([65.117.135.102]:55964 "EHLO
	exchange.timesys.com") by ftp.linux-mips.org with ESMTP
	id S8133558AbVJFTLE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 20:11:04 +0100
Received: from [127.0.0.1] ([192.168.2.230]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 6 Oct 2005 15:08:27 -0400
Message-ID: <43457563.60505@timesys.com>
Date:	Thu, 06 Oct 2005 15:05:07 -0400
From:	john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Greg Weeks <greg.weeks@timesys.com>, linux-mips@linux-mips.org,
	john cooper <john.cooper@timesys.com>
Subject: Re: PREEMPT
References: <43456EA9.8020209@timesys.com> <20051006184656.GA12173@linux-mips.org> <43457266.3090208@timesys.com> <20051006185504.GD15275@linux-mips.org>
In-Reply-To: <20051006185504.GD15275@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2005 19:08:28.0890 (UTC) FILETIME=[55DF2BA0:01C5CAA9]
Return-Path: <john.cooper@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john.cooper@timesys.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Oct 06, 2005 at 02:52:22PM -0400, Greg Weeks wrote:
> 
> 
>>I'd remembered some problems ages ago, but had thought they'd been 
>>fixed. John was just picking my brain about it so I thought I'd ask to 
>>be sure.
> 
> 
> The problems I recall were all related to being preempted just while
> fiddling with the hardware FPU - can't happen on the fpu-less 4Kc.
> Another issue fixesd recently even though more cosmetic were a bunch
> of global variables.

The code base I'm dealing with is a 2.6.13 derivative
with PREEMPT_RT support.  Looks like the problem was
due to PREEMPT_RT confusing fpu_emulator_cop1Handler()
resulting in a SIGBUS nailing the associated task.

I have it sort of working for soft FPU but expect it
requires some attention to safely access a HW FPU where
emulation assistance is needed.

-john

-- 
john.cooper@timesys.com
