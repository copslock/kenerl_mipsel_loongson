Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2009 22:36:29 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:44054 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365751AbZCDWgZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Mar 2009 22:36:25 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49af02100000>; Wed, 04 Mar 2009 17:34:56 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Mar 2009 14:34:17 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Mar 2009 14:34:16 -0800
Message-ID: <49AF01E8.80705@caviumnetworks.com>
Date:	Wed, 04 Mar 2009 14:34:16 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Brian Foster <brian.foster@innova-card.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <200903040919.29294.brian.foster@innova-card.com> <20090304154418.GA13464@linux-mips.org> <FF038EB85946AA46B18DFEE6E6F8A289BE0B68@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A289BE0B68@xmb-rtp-218.amer.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2009 22:34:16.0907 (UTC) FILETIME=[5A27C9B0:01C99D19]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David VomLehn (dvomlehn) wrote:
>> -----Original Message-----
>> From: linux-mips-bounce@linux-mips.org 
>> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Baechle
>> Sent: Wednesday, March 04, 2009 7:44 AM
>> To: Brian Foster
>> Cc: David Daney; Maciej W. Rozycki; 
>> linux-mips@linux-mips.org; libc-ports@sourceware.org; Maciej 
>> W. Rozycki
>> Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
>>
>> On Wed, Mar 04, 2009 at 09:19:28AM +0100, Brian Foster wrote:
>>
>>> On Tuesday 03 March 2009 17:56:25 David Daney wrote:
>>>> [ ... ]
>>>> When (and if) we move the sigreturn trampoline to a vdso 
>> we should be
>>>> able to maintain the ABI.
>>>  it's more a matter of "when" rather than "if".
>>>  there is still an intention here to use XI (we
>>>  have SmartMIPS), which requires not using the
>>>  signal (or FP) trampoline on the stack.
>>>
>>>  moving the signal trampoline to a vdso (which
>>>  is(? was?) called, maybe misleadingly, 'vsyscall',
>>>  on other architectures) is the obvious solution to
>>>  that part of the puzzle.  and yes, it is possible
>>>  to maintain the ABI; the signal trampoline is still
>>>  also put on the stack, and modulo XI, would work if
>>>  used - the trampoline-on-stack is simply not used
>>>  if there is a vdso with the signal trampoline.
>> We generally want to get rid of stack trampolines.  
>> Trampolines require
>> cacheflushing which especially on SMP systems can be a rather 
>> expensive
>> operation.
> 
> If I understand this correctly, using a vdso would allow a stack without
> execute permission on those processors that differentiate between read
> and execute permission. This defeats attaches that use buffer overrun to
> write code to be executed onto the stack, a nice thing for more secure
> systems.
> 

With one caveat, software other than the Linux kernel depends on an 
executable stack (GCC's nested functions for example).  All users of the 
executable stack would have to modified before you could universally 
make the switch.

That said, we do have RI/XI working well in our kernel (for non-stack 
memory), so it is something we are interested in pursuing.

David Daney
