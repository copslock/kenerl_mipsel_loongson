Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 15:03:38 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.171]:64257 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491043Ab1FFND2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 15:03:28 +0200
Received: from klappe2.localnet (deibp9eh1--blueice3n2.emea.ibm.com [195.212.29.180])
        by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
        id 0MM2UC-1QUfOB3eVI-008FHZ; Mon, 06 Jun 2011 15:03:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     George Kashperko <george@znau.edu.ua>
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
Date:   Mon, 6 Jun 2011 15:03:14 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.35-22-generic; KDE/4.3.2; x86_64; ; )
Cc:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, Greg KH <greg@kroah.com>,
        linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de> <201106061332.51661.arnd@arndb.de> <1307363399.28734.25.camel@dev.znau.edu.ua>
In-Reply-To: <1307363399.28734.25.camel@dev.znau.edu.ua>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106061503.14852.arnd@arndb.de>
X-Provags-ID: V02:K0:hZV8R3EjRVRaad34k9tVlwXZ9t38o3krGavE4YOnfRR
 nZjHpumAbrbrjJoYMlj+H1rzL2KuSTX8YygqZs4yEr9lZTi2Ra
 SCAp7fxY/+eAfJbhz3Q4KOK5jKYwU+g/aM+DsvOYSvA0rgaWKE
 LStP1t5SyTtyvmj6fAsJHO31EoanzMHFHcGBiQcad6nIsgXbtJ
 OimjiUDobW0Swyoci7ijQ==
X-archive-position: 30257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4233

On Monday 06 June 2011, George Kashperko wrote:
> > For an interrupt controller, it should be ok to have it initialized
> > late, as long as it's only responsible for the devices on the same
> > bus and not for instance for IPI interrupts. Just make sure that you
> > do the bus scan and the initialization of the IRQ driver before you
> > initialize any drivers that rely in on the interrupts to be working.
>
> Without proper timer init (which requires both the chipcommon and mips
> cores knowledge) kernel will get hung somewhere inside calibrate_delay.
> It could get addressed if get bus scan called in arch_init_irq or
> plat_time_init - both are executed before calibrate_delay and with slab
> available.

Ok, so you need the interrupt controller to be working for the timer tick,
right? I think another option (if that's not what you mean already) would
be to have a simpler way to find a device on the bus that can be called
before doing a full scan.

Early drivers would then have to know what is there and call a function
like "bcma_find_device(BCMA_DEV_ID_IRQ)", while drivers that are not
required to be up just register a regular device driver with a probe
function that gets called after the bus scan creates device structures.

	Arnd
