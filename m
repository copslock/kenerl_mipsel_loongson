Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 17:36:45 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:33011 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225463AbVBCRg3>; Thu, 3 Feb 2005 17:36:29 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 3BE8B18830; Thu,  3 Feb 2005 09:36:27 -0800 (PST)
Message-ID: <4202611A.4000302@mvista.com>
Date:	Thu, 03 Feb 2005 09:36:26 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix Kconfig for Broadcom SWARM
References: <20050201202835.GA10788@prometheus.mvista.com> <20050203142919.GB9796@linux-mips.org>
In-Reply-To: <20050203142919.GB9796@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Tue, Feb 01, 2005 at 12:28:35PM -0800, Manish Lachwani wrote:
>
>  
>
>>Attached patch adds necessary options for Broadcom SWARM. 
>>    
>>
>
>And forgets about all other Sibyte boards ...
>
>  Ralf
>  
>
The problem is that SIBYTE_SB1xxx_SOC is undefined. We need a small 
change in arch/mips/sibyte/Kconfig:

config SIBYTE_SB1xxx_SOC
        bool "Support for Broadcom BCM1xxx SOCs "

Since the ethernet driver, the serial driver and the CFE depend on this 
option to be selected else they wont be compiled in.

Thanks
Manish Lachwani
