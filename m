Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 10:45:41 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.134] ([IPv6:::ffff:145.253.187.134]:12524
	"EHLO mail01.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225197AbUJUJpg>; Thu, 21 Oct 2004 10:45:36 +0100
Received: from mail01.baslerweb.com (localhost.localdomain [127.0.0.1])
	by localhost.domain.tld (Basler) with ESMTP
	id 5782B134033; Thu, 21 Oct 2004 11:44:55 +0200 (CEST)
Received: from comm1.baslerweb.com (unknown [172.16.13.2])
	by mail01.baslerweb.com (Basler) with ESMTP
	id 54739134030; Thu, 21 Oct 2004 11:44:55 +0200 (CEST)
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 4YRPNK9Q; Thu, 21 Oct 2004 11:45:35 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: Re: yosemite interrupt setup
Date: Thu, 21 Oct 2004 11:49:35 +0200
User-Agent: KMail/1.6.2
Cc: Manish Lachwani <mlachwani@mvista.com>
References: <200410201952.29205.thomas.koeller@baslerweb.com> <4176A855.1000907@mvista.com> <4176AACA.3000206@mvista.com>
In-Reply-To: <4176AACA.3000206@mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410211149.35300.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Wednesday 20 October 2004 20:13, Manish Lachwani wrote:

>         TITAN_GE_WRITE(0x0024, 0x04000024);    /* IRQ vector */
>         TITAN_GE_WRITE(0x0020, 0x000fb000);    /* INTMSG base */

Hi Manish,

it was the location of these two lines that I was asking for. So they
are in the ethernet driver. Wouldn't you agree that they should go
into the platform instead? The interrrupt is shared with
other devices, the DUART to name just one example, and if I want to
write a driver for these, then that driver would depend on the
ethernet driver, if that does the interrupt setup.

So this covers the message interrupts, but I also have not been
able so far to spot the location where the corresponding setup
is done for the external interrupt lines, that is, setting up
the INTPINx registers. Any hints?

thank you,
Thomas

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
