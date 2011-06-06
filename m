Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 23:39:05 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45177 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491783Ab1FFVjC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 23:39:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6BB218B0D;
        Mon,  6 Jun 2011 23:39:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nlt3emItTxkE; Mon,  6 Jun 2011 23:38:52 +0200 (CEST)
Received: from [192.168.0.151] (host-091-097-241-128.ewe-ip-backbone.de [91.97.241.128])
        by hauke-m.de (Postfix) with ESMTPSA id A9C9F8B06;
        Mon,  6 Jun 2011 23:38:51 +0200 (CEST)
Message-ID: <4DED48EA.7070001@hauke-m.de>
Date:   Mon, 06 Jun 2011 23:38:50 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>
CC:     George Kashperko <george@znau.edu.ua>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg KH <greg@kroah.com>, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, mb@bu3sch.de, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de> <201106061332.51661.arnd@arndb.de> <1307363399.28734.25.camel@dev.znau.edu.ua> <201106061503.14852.arnd@arndb.de>
In-Reply-To: <201106061503.14852.arnd@arndb.de>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 30267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4915

On 06/06/2011 03:03 PM, Arnd Bergmann wrote:
> On Monday 06 June 2011, George Kashperko wrote:
>>> For an interrupt controller, it should be ok to have it initialized
>>> late, as long as it's only responsible for the devices on the same
>>> bus and not for instance for IPI interrupts. Just make sure that you
>>> do the bus scan and the initialization of the IRQ driver before you
>>> initialize any drivers that rely in on the interrupts to be working.
>>
>> Without proper timer init (which requires both the chipcommon and mips
>> cores knowledge) kernel will get hung somewhere inside calibrate_delay.
>> It could get addressed if get bus scan called in arch_init_irq or
>> plat_time_init - both are executed before calibrate_delay and with slab
>> available.
> 
> Ok, so you need the interrupt controller to be working for the timer tick,
> right? I think another option (if that's not what you mean already) would
> be to have a simpler way to find a device on the bus that can be called
> before doing a full scan.
> 
> Early drivers would then have to know what is there and call a function
> like "bcma_find_device(BCMA_DEV_ID_IRQ)", while drivers that are not
> required to be up just register a regular device driver with a probe
> function that gets called after the bus scan creates device structures.
> 
> 	Arnd
Accessing chip common should be possible without scanning the hole bus
as it is at the first position and initializing most things just needs
chip common. For initializing the interrupts scanning is needed as we do
not know where the mips core is located.

As we can not use kalloc on early boot we could use a function which
uses kalloc under normal conditions and when on early boot the
architecture code which starts the bcma code should also provide a
function which returns a pointer to some memory in its text segment to
use. We need space for 16 cores in the architecture code.

In addition bcma_bus_register(struct bcma_bus *bus) has to be divided
into two parts. The first part will scan the bus and initialize chip
common and mips core. The second part will initialize pci core and
register the devices in the system. When using this under normal
conditions they will be called directly after each other.

Hauke
