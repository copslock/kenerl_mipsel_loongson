Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 20:41:54 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:42726 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20039264AbXBBUls (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 20:41:48 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 5034E298572;
	Fri,  2 Feb 2007 15:41:08 -0500 (EST)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Fri,  2 Feb 2007 15:41:08 -0500 (EST)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Feb 2007 12:41:07 -0800
Message-ID: <45C3A1E3.8010802@avtrex.com>
Date:	Fri, 02 Feb 2007 12:41:07 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Question about signal syscalls !
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>	 <20070201135734.GB12728@linux-mips.org>	 <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>	 <45C21CFE.9060804@avtrex.com>	 <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com>	 <45C3611D.7000702@avtrex.com>	 <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com>	 <45C36D46.5040409@avtrex.com> <cda58cb80702021158n42bdb5fbi6cca4f2c8dff6782@mail.gmail.com>
In-Reply-To: <cda58cb80702021158n42bdb5fbi6cca4f2c8dff6782@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Feb 2007 20:41:07.0505 (UTC) FILETIME=[76FF8210:01C7470A]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> On 2/2/07, David Daney <ddaney@avtrex.com> wrote:
>> Franck Bui-Huu wrote:
>> > David Daney wrote:
>> >> The entire user context (i.e. the value of *all* registers) is 
>> replaced
>> >> with the values stored in the sigcontext structure on the caller's
>> >> stack.  If all registers are being restored from the sigcontext, then
>> >> there is no need to save the current values of the registers, because
>> >> they will never be used.
>> >>
>> >
> 
> Again, why do you think that all values of the registers are saved on
> sys_sigreturn() ?

I don't think that.  I don't think I ever said that.

> 
> 
>> > And now I'm starting to think that we don't need to save static regs in
>> > setup_sigcontext() either...
>> >
>> All registers *must* be saved in the sigcontext.  That is part of the
>> contract the kernel has with user code.
>>
> 
> I'm just talking about _static_ registers which are s0-s7...
> 
>> On return from an asynchronous signal, *all* registers must contain the
>> same values they had before the process was interrupted.
>>
> 
> yes I agree and I've never said the contrary.

I thought you were suggesting not saving s0-s7.  If you don't save them, 
you cannot restore them.  And they have to be restored from the 
sigcontext in the user's address space.   This allows user space signal 
handlers to emulate trapping instructions, and the like.

David Daney
