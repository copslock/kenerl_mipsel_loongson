Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jun 2009 14:41:30 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56828 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492012AbZFLMlX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Jun 2009 14:41:23 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5CCXirt030579;
	Fri, 12 Jun 2009 13:33:44 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5CCXfi5030565;
	Fri, 12 Jun 2009 13:33:41 +0100
Date:	Fri, 12 Jun 2009 13:33:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexey Zaytsev <zaytsev@altell.ru>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make it compile.
Message-ID: <20090612123341.GA21878@linux-mips.org>
References: <20090610140002.17913.33485.stgit@bzz.altell.local> <4A2FBFE5.2090205@ru.mvista.com> <4A30EE9B.30206@altell.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A30EE9B.30206@altell.ru>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 11, 2009 at 03:46:35PM +0400, Alexey Zaytsev wrote:

>>> diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
>>> index f69c6b5..222bed0 100644
>>> --- a/arch/mips/lib/delay.c
>>> +++ b/arch/mips/lib/delay.c
>>> @@ -51,6 +51,6 @@ void __ndelay(unsigned long ns)
>>>  {
>>>      unsigned int lpj = current_cpu_data.udelay_val;
>>>  -    __delay((us * 0x00000005 * HZ * lpj) >> 32);
>>> +    __delay((ns * 0x00000005 * HZ * lpj) >> 32);
>>
>>    This (and more) is already fixed by the patch posted by Atsushi  
>> Nemoto.
> Thanks for noticing. I should really start reading the ml before
> sending any more patches. ;)
>
>
> -- 
> This message has been scanned for viruses and
> dangerous content by MailScanner, and is
> believed to be clean.

Obviously it doesn't scan for old patches ;-)

(and why would we believe such a statement sent over an insecure medium
anyway)

There is one open nit in the udelay rewrite which I'm about to fix now.

Cheers,

  Ralf
