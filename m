Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 22:38:00 +0000 (GMT)
Received: from imap.gmx.net ([IPv6:::ffff:213.165.64.20]:63193 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225007AbUKRWhz>;
	Thu, 18 Nov 2004 22:37:55 +0000
Received: (qmail 15737 invoked by uid 65534); 18 Nov 2004 22:37:49 -0000
Received: from c210132.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.210.132)
  by mail.gmx.net (mp025) with SMTP; 18 Nov 2004 23:37:49 +0100
X-Authenticated: #947741
Message-ID: <419D25A7.2090506@gmx.net>
Date: Thu, 18 Nov 2004 23:43:51 +0100
From: TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Titan ethernet driver broken
References: <419D03DE.8090403@gmx.net> <419D04AA.50508@mvista.com> <419D171E.5040507@gmx.net> <419D173E.6050602@mvista.com> <419D1A2D.5000009@gmx.net> <419D1F76.6010603@gmx.net> <419D20C9.10909@mvista.com>
In-Reply-To: <419D20C9.10909@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Manish Lachwani wrote:

> Hello !
>
> Thanks for sending this. I have one question regarding the Yosemite 
> board that you have. What is the version of the Titan chip on the 
> board? Is it 1.0, 1.1 or 1.2?
>
> This is because 1.0 and 1.1 have a problem where the IP header is not 
> aligned on the Rx side. As a result, there was an extra copy involved 
> in the driver, i.e. titan_ge_slowpath. The latest version of the 
> driver only support Titan chip revision 1.2 in which this problem is 
> fixed
>
> Thanks
> Manish Lachwani
>
>
>
I use the chip version 1.1.
Now I have the problem, that I can not use the newest code,  until 1.2 
version of the chip is available.
Is it possible to make the code usable for all chip version by choosing 
the version at the kernel configuration?

Best regards
TheNop
