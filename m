Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2005 12:40:44 +0000 (GMT)
Received: from pop.gmx.net ([IPv6:::ffff:213.165.64.20]:28311 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225072AbVBQMk3>;
	Thu, 17 Feb 2005 12:40:29 +0000
Received: (qmail invoked by alias); 17 Feb 2005 12:40:23 -0000
Received: from c209082.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.209.82)
  by mail.gmx.net (mp022) with SMTP; 17 Feb 2005 13:40:23 +0100
X-Authenticated: #947741
Message-ID: <4214913A.7000601@gmx.net>
Date:	Thu, 17 Feb 2005 13:42:34 +0100
From:	TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: configuration of yosemite board with titan 1.2
References: <42146C27.8080404@gmx.net> <42148926.8040306@schenk.isar.de>
In-Reply-To: <42148926.8040306@schenk.isar.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Hi,

on the ftp site of PMC I only found kernel 2.4.26 sources supporting
internal UART.
I need kernel 2.6.
Is it planed to integrate internal UART support to linux-mips.org 2.6
sources?

Why PMC-Sierra removed the external UART chip?
So it is not possible to use current yosemite boards with linux-mips.org :-(


Beste regards
TheNop





Rojhalat Ibrahim wrote:

> Hi,
>
> if you want to use the internal UART, you need an adapted
> kernel from PMC. The kernel from linux-mips.org only supports
> the external UART chip. You can download an adapted source
> archive from the PMC-Sierra ftp site.
>
> Rojhalat Ibrahim
>
>
> TheNop wrote:
>
>> Hello,
>>
>> today i got the yosemite board with titan 1.2.
>> Currently I have problems to get the kernel 2.6.10.rc1 running (it 
>> runs on the old yosemite quite well).
>> The first thing I noticed is that after starting the kernel no output 
>> on the console is printed.
>> On the new yosemite board I got, the external UART chip (U36) is not 
>> mounted anymore. Could that cause my problems?
>>
>> Is there anybody how can send my a .config file to get the yosemite 
>> working?
>>
>> Best regards
>> TheNop
>>
>>
>
>
>
