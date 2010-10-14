Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 02:15:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7919 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491123Ab0JNAPF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Oct 2010 02:15:05 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb64ba80000>; Wed, 13 Oct 2010 17:15:36 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 13 Oct 2010 17:15:15 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 13 Oct 2010 17:15:15 -0700
Message-ID: <4CB64B84.2030402@caviumnetworks.com>
Date:   Wed, 13 Oct 2010 17:15:00 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     "wilbur.chan" <wilbur512@gmail.com>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: va_list implementation on mips64 , with 32bit cross compiled
References: <AANLkTinJXcpd7rVj4QFY0CpskSiZuJB4y10sbG1Td5n9@mail.gmail.com>
In-Reply-To: <AANLkTinJXcpd7rVj4QFY0CpskSiZuJB4y10sbG1Td5n9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2010 00:15:15.0552 (UTC) FILETIME=[E048A600:01CB6B34]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/13/2010 05:06 PM, wilbur.chan wrote:
> I am planning  to use va_list on a single module, however the
> following code did not work properly.
>
> typedef char *	va_list;
> #define _INTSIZEOF(n)	( (sizeof(n) + sizeof(int) - 1)&  ~(sizeof(int) - 1) )
> #define va_start(ap,v)	( ap = (va_list)&v + _INTSIZEOF(v) )
> #define va_arg(ap,t)	( *(t *)((ap += _INTSIZEOF(t)) - _INTSIZEOF(t)) )
> #define va_end(ap)	( ap = (va_list)0 )
>

You cannot arbitrarily define those macros with garbage and expect 
anything to work.

Replace all the above code with #include <stdarg.h>

Then do: man stdarg

That documents how it works.

David Daney


> void test_val_list()
> {
> unsigned long test=0x1234;
> test_printk("test:0x%x OK\n",aaa);
> }
>
> void test_printk(const char *format, ...)
> {
> va_list args;
> va_start(args, format);
> unsigned int v1 = va_arg(args,unsigned long);
> printk("v1 is 0x%x\n",v1);
> unsigned int v2 = va_arg(args,unsigned long);
> printk("v2 is 0x%x\n",v2);
> }
>
>
> The result is :
>
> v1 is 0x00000013
>
> v2 is 0x00000019
>
> Why this happened ? shouldn't v1 be 0x1234 here?
>
> Thank you
>
>
