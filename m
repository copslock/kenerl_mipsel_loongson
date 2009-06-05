Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2009 21:04:06 +0100 (WEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:60400 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023152AbZFEUD7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Jun 2009 21:03:59 +0100
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id B59F1E08124;
	Fri,  5 Jun 2009 22:03:53 +0200 (CEST)
Received: from [192.168.1.189] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 57D81E08142;
	Fri,  5 Jun 2009 22:03:50 +0200 (CEST)
Message-ID: <4A297A25.6010402@free.fr>
Date:	Fri, 05 Jun 2009 22:03:49 +0200
From:	matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081204 Iceape/1.1.14 (Debian-1.1.14-1)
MIME-Version: 1.0
To:	Andrew Morton <akpm@linux-foundation.org>
CC:	wim@iguana.be, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, biblbroks@sezampro.rs
Subject: Re: add bcm47xx watchdog driver
References: <4A282D98.6020004@free.fr> <20090605125023.d968c58e.akpm@linux-foundation.org>
In-Reply-To: <20090605125023.d968c58e.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
> On Thu, 04 Jun 2009 22:24:56 +0200
> matthieu castet <castet.matthieu@free.fr> wrote:
> 
>> This add watchdog driver for broadcom 47xx device.
>> It uses the ssb subsytem to access embeded watchdog device.
>>
>> ...
>>
>> --- linux-2.6.orig/drivers/watchdog/Kconfig	2009-05-25 22:22:02.000000000 +0200
>> +++ linux-2.6/drivers/watchdog/Kconfig	2009-05-25 22:26:06.000000000 +0200
>> @@ -764,6 +764,12 @@
>>  	help
>>  	  Hardware driver for the built-in watchdog timer on TXx9 MIPS SoCs.
>>  
>> +config BCM47XX_WDT
>> +    tristate "Broadcom BCM47xx Watchdog Timer"
>> +    depends on BCM47XX
>> +    help
>> +      Hardware driver for the Broadcom BCM47xx Watchog Timer.
> 
> Shouldn't there be some SSB dependencies in Kconfig here?
No, because :
config BCM47XX
     bool "BCM47XX based boards"
[...]
     select SSB
     select SSB_DRIVER_MIPS
     select SSB_DRIVER_EXTIF
     select SSB_EMBEDDED
     select SSB_PCICORE_HOSTMODE if PCI
