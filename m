Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 16:58:49 +0100 (BST)
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:24015 "EHLO
	mail8.fw-sd.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133392AbWDEP6e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Apr 2006 16:58:34 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id k35G9blu002304;
	Wed, 5 Apr 2006 16:09:38 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k35G9bSM004591;
	Wed, 5 Apr 2006 16:09:37 GMT
Message-ID: <4433EBC1.5060609@am.sony.com>
Date:	Wed, 05 Apr 2006 09:09:37 -0700
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/4] fix tx4938 undefined reference
References: <4433122A.1090104@am.sony.com> <4433CA7E.1010504@ru.mvista.com>
In-Reply-To: <4433CA7E.1010504@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
>     I'm sorry, where do you see this option? It belongs to cross-arch KGDB 
> which AFAIK is not in the Linus' kernel yet. So, NAK.

Yes, sorry about that.  I'll send it off to the kgdb ML.

-Geoff

>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> 
>> 
>> Index: linux-2.6.16.1/arch/mips/tx4938/common/Makefile
>> ===================================================================
>> --- linux-2.6.16.1.orig/arch/mips/tx4938/common/Makefile	2006-01-02 19:21:10.000000000 -0800
>> +++ linux-2.6.16.1/arch/mips/tx4938/common/Makefile	2006-03-07 11:05:05.000000000 -0800
>> @@ -7,5 +7,5 @@
>>  #
>>  
>>  obj-y	+= prom.o setup.o irq.o irq_handler.o rtc_rx5c348.o
>> -obj-$(CONFIG_KGDB) += dbgio.o
>> +obj-$(CONFIG_KGDB_8250) += dbgio.o
> 
> WBR, Sergei
> 
