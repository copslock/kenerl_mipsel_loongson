Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2011 22:50:15 +0200 (CEST)
Received: from imr4.ericy.com ([198.24.6.9]:50097 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491757Ab1JUUuL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Oct 2011 22:50:11 +0200
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id p9LKnxF3022182;
        Fri, 21 Oct 2011 15:50:01 -0500
Received: from [155.53.96.104] (147.117.20.214) by
 eusaamw0706.eamcs.ericsson.se (147.117.20.91) with Microsoft SMTP Server id
 8.3.137.0; Fri, 21 Oct 2011 16:49:58 -0400
Subject: Re: cause IP zero on interrupt
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To:     David Daney <david.daney@cavium.com>
CC:     Noor <noor.mubeen@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <4EA1D87A.1090708@cavium.com>
References: <CAMmEz3QV+kWvRK9KnUdmKFGqNA8XUspjc_cH7aYXfea5XYaRAg@mail.gmail.com>
         <4EA1D87A.1090708@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Ericsson
Date:   Fri, 21 Oct 2011 13:48:54 -0700
Message-ID: <1319230134.2583.39.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 31267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15985

On Fri, 2011-10-21 at 16:39 -0400, David Daney wrote:
> On 10/21/2011 01:18 PM, Noor wrote:
> > what does it mean if cause register IP bits are zero after
> > interrupt exception  has already been invoked ?
> >
> 
> It might mean that something was asserting a '1' on to those bits, but 
> quit doing so before you could read the cause register, or it could be 
> that you get random interrupt exceptions for no reason at all.
> 

In my case it was the following:

diff --git
a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index dedef7d..7500c55 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -63,6 +63,10 @@
        # CN30XX Disable instruction prefetching
        or  v0, v0, 0x2000
 skip:
+#ifdef CONFIG_ERICSSON_ASE
+       # Set CvmCtl[IPTI] to 7
+       ori     v0, v0, (7 << 4)
+#endif
        # First clear off CvmCtl[IPPCI] bit and move the performance
        # counters interrupt to IRQ 6
        li      v1, ~(7 << 7)

This should not be needed in the Linux code, but CvmCtl[IPTI] was set to
0 by ROMMON.

Guenter
