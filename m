Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2005 22:55:10 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:60922 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225325AbVBAWyy>; Tue, 1 Feb 2005 22:54:54 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 0812818963; Tue,  1 Feb 2005 14:54:51 -0800 (PST)
Message-ID: <420008BA.6070104@mvista.com>
Date:	Tue, 01 Feb 2005 14:54:50 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix Kconfig for Broadcom SWARM
References: <20050201202835.GA10788@prometheus.mvista.com> <Pine.LNX.4.61L.0502012241010.18883@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0502012241010.18883@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Tue, 1 Feb 2005, Manish Lachwani wrote:
>
>  
>
>>Attached patch adds necessary options for Broadcom SWARM. 
>>    
>>
>
> What is it supposed to do?
>
>  Maciej
>  
>
libs-$(CONFIG_SIBYTE_CFE)       += arch/mips/sibyte/cfe/

in arch/mips/Makefile

So, without the above, contents of arch/mips/sibyte/cfe/ are not compiled.

SIBYTE_HAS_LDT is needed for the LDT specific stuff in 
arch/mips/pci/pci-sb1250.c

Btw, there are other issues as well. More options need to be defined to 
compile in the serial driver, ethernet driver and to compile for a PASS 
2 CPU. For example, the ethernet driver drivers/net/sb1250-mac.c 
compiles only if SIBYTE_SB1xxx_SOC is defined. And SIBYTE_SB1xxx_SOC no 
longer exists in arch/mips/Kconfig.

Thanks
Manish Lachwani
