Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2006 13:58:16 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:63181 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133371AbWBGN6G (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Feb 2006 13:58:06 +0000
Received: (qmail 30854 invoked from network); 7 Feb 2006 14:03:36 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 7 Feb 2006 14:03:36 -0000
Message-ID: <43E8A97F.3090208@ru.mvista.com>
Date:	Tue, 07 Feb 2006 17:06:55 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	David Sanchez <david.sanchez@lexbox.fr>
CC:	linux-mips@linux-mips.org, Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: Au1xx0: really set KSEG0 to uncached on reboot
References: <17AB476A04B7C842887E0EB1F268111E02746A@xpserver.intra.lexbox.org>
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E02746A@xpserver.intra.lexbox.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Sanchez wrote:
> Yes, I mean "freezes" :) 

> I have the BCSR fix applied.

> And the message "** Resetting Integrated Peripherals" comes from the arch/mips/au1000/common/reset.c file (I'm using the kernel 2.6.10).

    You're right, I'm wrong. :-)
    I'm using the same kernel for development (at least the same version of it 
:-), and it reboots OK.

> Maybe I forget to apply other patches...

    Can't say what other patches may concern this issue off the top of my head...

-----Message d'origine-----
> De : Sergei Shtylylov [mailto:sshtylyov@ru.mvista.com] 
> Envoyé : lundi 6 février 2006 18:46
> À : linux-mips@linux-mips.org
> Cc : Jordan Crouse; David Sanchez; Sergei Shtylylov
> Objet : Re: Au1xx0: really set KSEG0 to uncached on reboot
> 
> Hello.
> 
> Jordan Crouse wrote:
> 
>>On 06/02/06 09:10 +0100, David Sanchez wrote:
>>
>>
>>>Hi,
>>>
>>>This is exactly what I did...
>>>But I notice that sometimes it works and sometimes the kernel frees when 
> 
> 
>     You mean "freezes" probably? :-)
> 
> 
>>>"** Resetting Integrated Peripherals"
> 
> 
>     This is not kernel's msg, but YAMON's one...
> 
> 
>>We'll need to nail this down before we go any further.  Can we get a trace
>>of what happens when it crashes?
> 
> 
>     David, do you have BCSR fix from:
> 
> http://www.linux-mips.org/archives/linux-mips/2005-10/msg00236.html
> 
> applied (the recent kernel has it but which one are you using?)?
> DBAu1550 reset may not work as expeceted otherwise indeed...
> 
> 
>>Jordan

WBR, Sergei
