Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 17:08:26 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:44525 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491193Ab0HRPIT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Aug 2010 17:08:19 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o7IF8Bma027964;
        Wed, 18 Aug 2010 08:08:11 -0700
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o7IF8ATn009454;
        Wed, 18 Aug 2010 08:08:11 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o7IF8AY26010;
        Wed, 18 Aug 2010 08:08:10 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Does Mips Linux rely on Yamon h/w initialization (other than DDR memory which is strictly necessary)?
Date:   Wed, 18 Aug 2010 08:08:08 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D076FC3C42@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20100818135115.GC25740@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: Does Mips Linux rely on Yamon h/w initialization (other than DDR memory which is strictly necessary)?
thread-index: Acs+3BUcAjUYruQ4TUeN15aGwVMTIQACqR4g
References: <AEA634773855ED4CAD999FBB1A66D076FC3BDF@CORPEXCH1.na.ads.idt.com> <20100818135115.GC25740@linux-mips.org>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Could you point me to some files or folder where I can find the h/w
initialization sequence done by Linux for Malta? I would like to take a
look maybe I can figure out some details.

Thanks,
Andrei


-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org] 
Sent: Wednesday, August 18, 2010 9:51 AM
To: Ardelean, Andrei
Cc: linux-mips@linux-mips.org
Subject: Re: Does Mips Linux rely on Yamon h/w initialization (other
than DDR memory which is strictly necessary)?

On Wed, Aug 18, 2010 at 06:31:42AM -0700, Ardelean, Andrei wrote:

> Malta board has Yamon monitor which initializes the DDR memory and
other
> h/w. Does Mips Linux rely on Yamon h/w initialization (except memory)
> like PCI, NET, UART, etc in order to boot? Does Mips Linux
re-initialize
> the h/w again? 
> I am booting Linux on Malta with a small monitor which initializes
only
> the memory. I pass the environment vars array, command line arguments
> and memory size as Yamon would do. The ASCII display shows "Linux on
> Malta" scrolling text so Linux kernel it seems that at least it
started
> but there is no NET activity and no messages on UART.

That's a bit of an ugly topic and some black art is involved here.  We
leave the initialization of CPU, caches and memory controllers entirely
to the firmware.

For the remainder Linux tries to perform the initilization itself but
sometimes by accident not intention a register that was already
initialized by firmware will not be initialized by Linux but the
omission will not be notized because it already has a correct value.

PCI is particularl problem.  On some platforms firmware initializes the
bus and re-initializing the bus would break the firmware or be very
complex.  On such a system Linux will just scan the PCI bus and re-use
the existing configuration.  On most platforms however Linux will do a
better job than the existing firmware and fully reinitialize the entire
PCI bus hierarchy.

  Ralf
