Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 04:52:20 +0100 (CET)
Received: from g4t0016.houston.hp.com ([15.201.24.19]:27939 "EHLO
        g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490967Ab0BYDv5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 04:51:57 +0100
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
        by g4t0016.houston.hp.com (Postfix) with ESMTP id 9FC9214050;
        Thu, 25 Feb 2010 03:51:50 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g4t0009.houston.hp.com (Postfix) with ESMTP id 3E1A7C194;
        Thu, 25 Feb 2010 03:51:50 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id 36841CF009B;
        Wed, 24 Feb 2010 20:51:50 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PVnvNcz7Q6eo; Wed, 24 Feb 2010 20:51:50 -0700 (MST)
Received: from [192.168.1.2] (squirrel.fc.hp.com [15.11.146.57])
        by ldl (Postfix) with ESMTP id AF037CF0095;
        Wed, 24 Feb 2010 20:51:49 -0700 (MST)
Subject: Re: RFC: [MIPS] BCM1480/BCM1480HT remove io_offset
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <201002241630.42987.bjorn.helgaas@hp.com>
References: <201002241338.41501.bjorn.helgaas@hp.com>
         <20100224221053.GB20280@alpha.franken.de>
         <201002241630.42987.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date:   Wed, 24 Feb 2010 20:45:02 -0700
Message-Id: <1267069502.8811.7.camel@dc7800.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Content-Transfer-Encoding: 7bit
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-02-24 at 16:30 -0700, Bjorn Helgaas wrote:
> Are there registers to control the CPU-to-PCI address translation, or
> is it just fixed at:
> 
>   PCI ioport = CPU addr - 0x2C000000 (for BCM1480) and
>   PCI ioport = CPU addr - 0xDC000000 (for BCM1480HT)?
> 
> If you can control the translation, you could define nice CPU-side
> I/O port ranges like we do on ia64, e.g.,
> 
>   [0x0000000-0x0ffffff] for BCM1480
>   [0x1000000-0x1ffffff] for BCM1480HT
> 
> That would also allow you to make inb() and friends work on both
> hoses by replacing "mips_io_port_base + port" with something like
> __ia64_mk_io_addr().
> 
> I guess you could do the same thing even if you can't control the
> translation, but the ranges would be a little uglier because they
> both have to be relative to the same base, e.g.,
> 
>   [0x0000000-0x0ffffff] for BCM1480
>   [0xb000000-0xbffffff] for BCM1480HT

Actually, you should be able to make this work with CPU I/O resources of
your choice even if you can't control the translation.  It just requires
a little more indirection, like most computer science problems :-)  On
ia64, we map multiple I/O port spaces with arbitrary translations into a
0xSPPPPPP scheme (S = space number, PPPPPP = port number).

But my main concern is just making sure that my IORESOURCE_PCI_FIXED
change didn't break BCM1480, and I don't think it will.

Bjorn
