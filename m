Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 18:54:35 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.134] ([IPv6:::ffff:145.253.187.134]:51644
	"EHLO mail01.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225204AbUJURy2>; Thu, 21 Oct 2004 18:54:28 +0100
Received: from mail01.baslerweb.com (localhost.localdomain [127.0.0.1])
	by localhost.domain.tld (Basler) with ESMTP
	id 47C3A134032; Thu, 21 Oct 2004 19:53:42 +0200 (CEST)
Received: from comm1.baslerweb.com (unknown [172.16.13.2])
	by mail01.baslerweb.com (Basler) with ESMTP
	id 454A7134029; Thu, 21 Oct 2004 19:53:42 +0200 (CEST)
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 4YRPNV5L; Thu, 21 Oct 2004 19:54:23 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: Manish Lachwani <mlachwani@mvista.com>
Subject: Re: yosemite interrupt setup
Date: Thu, 21 Oct 2004 19:58:24 +0200
User-Agent: KMail/1.6.2
Cc: linux-mips@linux-mips.org
References: <200410201952.29205.thomas.koeller@baslerweb.com> <200410211149.35300.thomas.koeller@baslerweb.com> <4177E5F6.3010100@mvista.com>
In-Reply-To: <4177E5F6.3010100@mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410211958.24269.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Thursday 21 October 2004 18:38, Manish Lachwani wrote:
> Hi Thomas
>
> No, these should remain in the Ethernet driver. Thats because no other
> driver depends on these. Those registers are MAC subsystem registers
> only. The ethernet driver does not do any interrupt setup for other
> devices.

Hi Manish,

first of all, forget about the yosemite, as I am no longer using it. I
am currently working on our own platform port.

All the components of the Ethernet/GPI subsystem interrupt the CPU
through the interrupt vector established by writing to the CPCFG0 and
CPCFG1 registers. So if I want to write a driver that uses one of
the GPIs, or the DUART, or a watchdog counter, or the two-bit interface,
or any other component of the subsystem, then this driver will be
dependent of the ethernet driver. Have a look at the manual if
you do not believe me. The titan ethernet driver is the only one to
use this interrupt _on_the_yosemite_, but this is only because all the
other components are not used at all.

The interrupt setup should definitly be in the platform - please reconsider
your position.

thanks,
Thomas

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
