Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 02:37:34 +0100 (CET)
Received: from ripley.ciena.com ([63.118.34.24]:40903 "EHLO ripley.ciena.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492020Ab0BYBha (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2010 02:37:30 +0100
Message-ID: <4B85D445.2090700@ciena.com>
Date:   Wed, 24 Feb 2010 20:37:09 -0500
From:   Brian Daniels <bdaniels@ciena.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: udelay() too slow by a factor of 2 on Cavium chips
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2010 01:37:19.0021 (UTC) FILETIME=[117A25D0:01CAB5BB]
Return-Path: <bdaniels@ciena.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bdaniels@ciena.com
Precedence: bulk
X-list: linux-mips

We've noticed that udelay() and related functions are too slow by a
factor of 2 on Cavium CPUs. I did some investigation and it seems to be
related to the fact that Cavium is the only MIPS CPU family that has
ARCH_HAS_READ_CURRENT_TIMER defined to use its hardware cycle counter
(CvmCount) to calibrate loops-per-jiffy. Since udelay() uses lpj to
calculate the number of loops to wait in __delay() it is affected by the
lpj calibration.

On a 600MHz Cavium system running 2.6.33-rc8 with HZ=250 the lpj is
2404728. This results in udelay() passing 601 to __delay() for a 1us
delay which would work if __delay took 1 cycle per loop however it takes
2 cycles giving a delay of 2us.

It seems the easiest way to fix the problem would be to remove the
definition of ARCH_HAS_READ_CURRENT_TIMER for Cavium which would use the
same lpj calibration delay loop as other MIPS CPUs. With this change on
the same 600MHz system lpj is 1196032 which results in udelay() passing
299 to __delay() which would yield close to the desired 1us delay.

I'm not sure what all of the implications would be of effectively
halving lpj on Cavium CPUs or what the rationale was for defining
ARCH_HAS_READ_CURRENT_TIMER for Cavium CPUs in the first place. I'm
hoping someone more informed can take a look at it and propose a fix if
what I've proposed isn't good enough.
