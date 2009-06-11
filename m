Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 17:29:51 +0200 (CEST)
Received: from office.altell.ru ([80.246.246.162]:60576 "EHLO office.altell.ru"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493090AbZFKP3p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Jun 2009 17:29:45 +0200
Received: from [192.168.1.129] (unknown [192.168.1.129])
	by mail.altell.local (Postfix) with ESMTP id AC3B16868C;
	Thu, 11 Jun 2009 15:53:29 +0400 (MSD)
Message-ID: <4A30EE9B.30206@altell.ru>
Date:	Thu, 11 Jun 2009 15:46:35 +0400
From:	Alexey Zaytsev <zaytsev@altell.ru>
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Make it compile.
References: <20090610140002.17913.33485.stgit@bzz.altell.local> <4A2FBFE5.2090205@ru.mvista.com>
In-Reply-To: <4A2FBFE5.2090205@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Altell-MailScanner: Found to be clean
X-Altell-MailScanner-From: zaytsev@altell.ru
Return-Path: <zaytsev@altell.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zaytsev@altell.ru
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.
>
> Alexey Zaytsev wrote:
>
>> Signed-off-by: Alexey Zaytsev <zaytsev@altell.ru>
>
>> diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
>> index f69c6b5..222bed0 100644
>> --- a/arch/mips/lib/delay.c
>> +++ b/arch/mips/lib/delay.c
>> @@ -51,6 +51,6 @@ void __ndelay(unsigned long ns)
>>  {
>>      unsigned int lpj = current_cpu_data.udelay_val;
>>  
>> -    __delay((us * 0x00000005 * HZ * lpj) >> 32);
>> +    __delay((ns * 0x00000005 * HZ * lpj) >> 32);
>
>    This (and more) is already fixed by the patch posted by Atsushi 
> Nemoto.
Thanks for noticing. I should really start reading the ml before
sending any more patches. ;)


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
