Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 07:26:12 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:53230 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225226AbUKUH0G>; Sun, 21 Nov 2004 07:26:06 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id AA3AA185CB; Sat, 20 Nov 2004 23:26:03 -0800 (PST)
Message-ID: <41A0430B.6080201@mvista.com>
Date: Sat, 20 Nov 2004 23:26:03 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Cc: TheNop <TheNop@gmx.net>, linux-mips@linux-mips.org
Subject: Re: Titan ethernet driver broken
References: <419D03DE.8090403@gmx.net> <419D04AA.50508@mvista.com> <419D171E.5040507@gmx.net> <419D173E.6050602@mvista.com> <419D1A2D.5000009@gmx.net> <419D1F76.6010603@gmx.net> <419D20C9.10909@mvista.com> <419D25A7.2090506@gmx.net> <20041120095445.GA12870@linux-mips.org>
In-Reply-To: <20041120095445.GA12870@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Nov 18, 2004 at 11:43:51PM +0100, TheNop wrote:
> 
> 
>>I use the chip version 1.1.
>>Now I have the problem, that I can not use the newest code,  until 1.2 
>>version of the chip is available.
>>Is it possible to make the code usable for all chip version by choosing 
>>the version at the kernel configuration?
> 
> 
> Titan 1.2 is available since quite a while - the dust on my board is
> proof ;-)  Since Titan 1.0 and 1.0 were shipped in very low numbers to
> early customers only and will never be available in volume production the
> support for them was removed.  As I recall there were at least these
> problems with Titan 1.0 and 1.1 in Linux:
> 
>   - Linux uses the prefetch prepare for store operation.
>   - Coherency mode 5 which is mandatory for good performance and any kind
>     of sanity on SMP is now being used.
>   - The problem with the third ethernet port which Manish just had
>     described.
> 
> You can dig through XCVS, WebCVS or the linux-cvs archive to find where
> I broke backward compatibility.
> 
>   Ralf
> 
Hello !

Ralf, thanks for the good description. Anyways, just to make it a little 
more clear. Port #2 (third ethernet port) was not working on Titan 1.0 
and 1.1. This is because there is no interrupt line on which interrupts 
for port #2 could be routed. And Titan MACs cannot share interrupts.

One other problem with 1.0 and 1.1 was that for incoming packets, the IP 
header is not aligned. As a result, an extra copy was implemented in the 
driver to align this IP header. This problem exists on all ports (0 and 1).

With Titan 1.2, there is no need for the extra copy and port #2 can be 
enabled since there is an interrupt line which it can use.

And of course, 1.0 and 1.1 did not support the five state MOESI 
protocol. They supported MEI only.

Thanks
Manish Lachwani
