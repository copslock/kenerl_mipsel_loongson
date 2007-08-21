Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2007 02:57:29 +0100 (BST)
Received: from mail.ok-labs.com ([221.199.209.5]:11495 "EHLO mail.ok-labs.com")
	by ftp.linux-mips.org with ESMTP id S20022017AbXHUB5V (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2007 02:57:21 +0100
Received: from [10.21.11.188]
	by mail.ok-labs.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <carl@ok-labs.com>)
	id 1INIwQ-0000ch-FN; Tue, 21 Aug 2007 11:53:58 +1000
Message-ID: <46CA45AD.8080203@ok-labs.com>
Date:	Tue, 21 Aug 2007 11:53:49 +1000
From:	Carl van Schaik <carl@ok-labs.com>
Organization: Open Kernel Labs Inc.
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: TLS register for NPTL
References: <46C93BB5.9050809@ok-labs.com> <20070820080627.GF4479@networkno.de> <20070820145449.GA11766@linux-mips.org>
In-Reply-To: <20070820145449.GA11766@linux-mips.org>
X-Enigmail-Version: 0.95.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 10.21.11.188
X-SA-Exim-Mail-From: carl@ok-labs.com
X-SA-Exim-Scanned: No (on mail.ok-labs.com); SAEximRunCond expanded to false
Return-Path: <carl@ok-labs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carl@ok-labs.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Aug 20, 2007 at 09:06:27AM +0100, Thiemo Seufer wrote:
>
>   
>>> It seems the rdhwr emulation is used/proposed for accessing the thread
>>> word in NPTL.
>>> I've been reading some of the posts from 2005 about this choice of this
>>> and what I have missed is anyone talking about using the "k0" register
>>> for TLS. It seems logical that the kernel could always restore k0 on
>>> returning to user-land and having k1 only for the last part of returning
>>> to user is sufficient. Any reason why this was not looked at?
>>>       
>> The TLB handlers need k0/k1 as well and have no good place to save/restore
>> a register.
>>     
>
> It can be done but would require several extra instructions in the most
> performance sensitive parts of the OS.
>
> Aside, latest MIPS processors support a hardware implementation of rdhwr $29,
> so there is no more emulation overhead for this instruction at full binary
> compatibility.
>   
Ok, I agree that this is probably the best way to go. In the L4
microkernel we have for a long time used k0 (sony did this as well?),
but that was before any rdhwr existed, hence my questions. It should be
easy to change L4 to use rdhwr, or both for an intermediate period of
time which allows us to virtualize Linux mips applications with NPTL.

thanks,
Carl
