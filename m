Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2005 23:12:24 +0100 (BST)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:51880
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225937AbVC2WMK>;
	Tue, 29 Mar 2005 23:12:10 +0100
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Tue, 29 Mar 2005 14:12:07 -0800
  id 0000C338.4249D2B7.00003F8D
Message-ID: <4249D27D.20700@jg555.com>
Date:	Tue, 29 Mar 2005 14:11:09 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Peter Horton <pdh@colonel-panic.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Build 64bit on RaQ2
References: <42449F47.8010002@jg555.com> <20050326091218.GA2471@skeleton-jack> <42488DFC.20408@jg555.com> <20050329214641.GA5152@skeleton-jack>
In-Reply-To: <20050329214641.GA5152@skeleton-jack>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Peter Horton wrote:

>On Mon, Mar 28, 2005 at 03:06:36PM -0800, Jim Gifford wrote:
>  
>
>>   Got it to compile, but the tulip driver is giving me fits. I built 
>>it as a module and into the kernel
>>
>>
>>0000:00:07.0: tulip_stop_rxtx() failed
>>0000:00:07.0: tulip_stop_rxtx() failed
>>0000:00:07.0: tulip_stop_rxtx() failed
>>0000:00:07.0: tulip_stop_rxtx() failed
>>0000:00:07.0: tulip_stop_rxtx() failed
>>0000:00:07.0: tulip_stop_rxtx() failed
>>
>>    
>>
>
>Tulip driver gave me problems also. I landed up inserting a printk()
>which made it work, see the patch. I didn't get round to debugging it
>any further, sorry.
>
>P.
>
>  
>
I posted a simliar question to the linux-net list, a lot of people don't 
understand why the driver doesn't work in 64 bit, but works perfectly in 
32 bit.

-- 
----
Jim Gifford
maillist@jg555.com
