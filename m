Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2010 23:00:15 +0200 (CEST)
Received: from imr1.ericy.com ([198.24.6.9]:33605 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491765Ab0GHVAI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jul 2010 23:00:08 +0200
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o68L852e031620;
        Thu, 8 Jul 2010 16:08:12 -0500
Received: from [155.53.128.111] (147.117.20.213) by
 eusaamw0707.eamcs.ericsson.se (147.117.20.92) with Microsoft SMTP Server id
 8.2.234.1; Thu, 8 Jul 2010 16:59:54 -0400
Subject: Re: Questions about BCM91250A
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To:     Matt Turner <mattst88@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <AANLkTilwCgYls4BesQLZJnZieezRU0WlW0sZ9f9gt08J@mail.gmail.com>
References: <AANLkTilwCgYls4BesQLZJnZieezRU0WlW0sZ9f9gt08J@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Ericsson
Date:   Thu, 8 Jul 2010 13:59:53 -0700
Message-ID: <1278622793.11618.54.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <guenter.roeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-07-08 at 16:46 -0400, Matt Turner wrote:
> Hi,
> I'm trying to figure out how to access a Compact Flash card via a
> PCMCIA->CF adapter on my BCM91250A.
> 

I suspect it is not supported. If you search for PCMCIA_CS, you'll
notice  that it is defined but never used. Maybe that code was not
ported from 2.4.

Guenter

> I've added
> --- PCCard (PCMCIA/CardBus) support
> <*>   16-bit PCMCIA support
>  [*]     Load CIS updates from userspace (EXPERIMENTAL)
> [*]   32-bit CardBus support
>        *** PC-card bridges ***
> <*>   CardBus yenta-compatible bridge support
> [*]     Special initialization for O2Micro bridges
> [*]     Special initialization for Ricoh bridges
> [*]     Special initialization for TI and EnE bridges
> [*]       Auto-tune EnE bridges for CB cards
> [*]     Special initialization for Toshiba ToPIC bridges
> <*>   Cirrus PD6729 compatible bridge support
> <*>   i82092 compatible bridge support
> 
> and
> 
> --- Serial ATA and Parallel ATA drivers
> <*>     PCMCIA PATA support
> <*>     Generic platform device PATA support
> 
> But I see nothing in dmesg about this.
> 
> Also, I can't get access to the rtc. I've tried a lot of different
> drivers. Any clues which is the right one?
> 
> Thanks!
> Matt
> 
