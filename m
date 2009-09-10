Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 18:00:16 +0200 (CEST)
Received: from ru.mvista.com ([213.79.90.228]:1303 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492433AbZIJQAI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Sep 2009 18:00:08 +0200
Received: from [192.168.11.243] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 2896E881D; Thu, 10 Sep 2009 21:00:08 +0500 (SAMST)
Message-ID: <4AA92287.3090608@ru.mvista.com>
Date:	Thu, 10 Sep 2009 20:00:07 +0400
From:	Maxim Uvarov <muvarov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] TLB  handler fix for vmalloc'ed addresses
References: <4AA656D8.9040608@ru.mvista.com> <20090910141518.GA10547@linux-mips.org> <4AA90F3B.6000204@ru.mvista.com> <20090910153744.GA10998@linux-mips.org> <4AA91FB9.205@ru.mvista.com>
In-Reply-To: <4AA91FB9.205@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <muvarov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muvarov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Maxim Uvarov wrote:
>>>>> }
>>>> So your test case allocates vmalloc memory but never touches it.
>>> Yes, it is so. Bug occurs on rmmod this module. (Module does not free 
>>> memory
>>> allocated with vmalloc().
>>
>> Nor does it stop the thread on exit or avoid unloading.  So panicing is
>> expected.
> 
> Ralf, I'm sorry for misunderstanding.  Original kernel does panic in 
> this situation. In my patch it went to panic with


Original kernel does  _NOT_ panic.


> +        else if (pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_k))
> +                goto no_context;
> 
> Actually it was the reason of this patch.
> 
> But looks like we need go immediately to no_context for 64 bit and do 
> not do this checks.
> 
> Maxim.
> 
