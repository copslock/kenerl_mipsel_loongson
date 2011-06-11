Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 00:33:47 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:54367 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491784Ab1FKWdk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 00:33:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 0D7918BA0;
        Sun, 12 Jun 2011 00:33:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1JeNDCpP0zcS; Sun, 12 Jun 2011 00:33:35 +0200 (CEST)
Received: from [192.168.0.150] (host-091-097-251-232.ewe-ip-backbone.de [91.97.251.232])
        by hauke-m.de (Postfix) with ESMTPSA id 809008B94;
        Sun, 12 Jun 2011 00:33:34 +0200 (CEST)
Message-ID: <4DF3ED3D.6060003@hauke-m.de>
Date:   Sun, 12 Jun 2011 00:33:33 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     =?UTF-8?B?TWljaGFlbCBCw7xzY2g=?= <m@bues.ch>
CC:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Arend van Spriel <arend@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        George Kashperko <george@znau.edu.ua>,
        Greg KH <greg@kroah.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "mb@bu3sch.de" <mb@bu3sch.de>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "bernhardloos@googlemail.com" <bernhardloos@googlemail.com>
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>        <201106061503.14852.arnd@arndb.de>      <4DED48EA.7070001@hauke-m.de>   <201106062353.40470.arnd@arndb.de>      <4DEDF98C.6020905@broadcom.com> <4DEE9BCD.1030304@hauke-m.de>   <BANLkTikUqj-R72XaOXnifhKv-n1ZSJMxDQ@mail.gmail.com> <20110608102001.294a4ff2@maggie>
In-Reply-To: <20110608102001.294a4ff2@maggie>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9923

On 06/08/2011 10:20 AM, Michael Büsch wrote:
> On Wed, 8 Jun 2011 02:06:11 +0200
> Rafał Miłecki <zajec5@gmail.com> wrote:
> 
>> Because full scanning needs one of the following:
>> 1) Working alloc - not possible for SoCs
> 
> Isn't there a bootmem allocator available on MIPS?

The bootmem allocator is working on mips, but it is initialized after
plat_mem_setup() was called. To use it we have to move the start of bcma
to some other place in the bcm47xx code.

We need access to the common and mips core for different functions in
the bcm47xx code and these functions are getting called by the mips
code, so we can not store these struct bcma_devices on the stack.

I would use this struct on the embedded device and use it in the text
segment of the bcm47xx code.

In include/linux/bcma/bcma.h:
struct bcma_soc {
	struct bcma_bus bus;
	struct bcma_device core_cc;
	struct bcma_device core_mips;
};

In arch/mips/bcm47xx/setup.c
struct bcma_soc bus;

The chipcommon and mips core can be initilized early without the need
use of any alloc. The bcm47xx code will call
bcma_bus_early_register(struct bcma_soc *soc) and this code will find
these two cores, add then to the list of cores in bcma_bus and run the
init code for them. After that we have all we need to boot up the
device. After the kernel page allocator is fully set up we would search
for all the other cores and add them to the list of cores and do the
initialization for them. The two cores in struct bcma_soc will never be
accessed directly but only through struct bcma_bus so that there is no
difference from early boot and normal mode.

Hauke
