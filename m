Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2005 16:15:15 +0000 (GMT)
Received: from pop.gmx.net ([IPv6:::ffff:213.165.64.20]:34496 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225202AbVBQQPA>;
	Thu, 17 Feb 2005 16:15:00 +0000
Received: (qmail invoked by alias); 17 Feb 2005 16:14:54 -0000
Received: from c209082.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.209.82)
  by mail.gmx.net (mp008) with SMTP; 17 Feb 2005 17:14:54 +0100
X-Authenticated: #947741
Message-ID: <4214C381.8070107@gmx.net>
Date:	Thu, 17 Feb 2005 17:17:05 +0100
From:	TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: configuration of yosemite board with titan 1.2
References: <42146C27.8080404@gmx.net> <42148926.8040306@schenk.isar.de> <4214913A.7000601@gmx.net> <4214BF8A.5090206@schenk.isar.de>
In-Reply-To: <4214BF8A.5090206@schenk.isar.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Hi, 

thanx, now I found the 2.6 sources with internal UART support.
I was probably blind. :-)

Best regards


Rojhalat Ibrahim wrote:

> TheNop wrote:
>
>> Hi,
>>
>> on the ftp site of PMC I only found kernel 2.4.26 sources supporting
>> internal UART.
>> I need kernel 2.6.
>
>
> They have recently (about one week ago) uploaded a kernel 2.6
> that supports the internal UART.
>
>
>> Is it planed to integrate internal UART support to linux-mips.org 2.6
>> sources?
>>
>> Why PMC-Sierra removed the external UART chip?
>> So it is not possible to use current yosemite boards with 
>> linux-mips.org :-(
>>
>
> Not without the external UART chip. On my board with chip revision 1.2
> the external UART chip is still present. I just had to change some
> resistor stuffing option to make it work.
>
>
>
