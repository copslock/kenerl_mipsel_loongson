Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 14:19:32 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:13447 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225002AbVAGOT2>; Fri, 7 Jan 2005 14:19:28 +0000
Received: from sjhill by real.realitydiluted.com with local (Exim 4.34 #1 (Debian))
	id 1CmuxT-0002LO-TO; Fri, 07 Jan 2005 08:19:19 -0600
Subject: Re: Problem with MV64340 serial driver
In-Reply-To: <41DE5C1C.3090406@enix.org>
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Date: Fri, 7 Jan 2005 08:19:19 -0600 (CST)
CC: linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1CmuxT-0002LO-TO@real.realitydiluted.com>
From: sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> 
> I've implemented a serial driver for the Marvell 64340 chipset. This 
> driver works fairly well. It uses SDMA for both input and input. SDMA 
> buffers and descriptors are stored in Marvell SRAM.
> 
My first question is, "Why?". You are aware that a serial driver already
exists for PPC using the 64360 which is the same chip as the 64340
except that it has a PPC 60x bus interface instead of MIPS? We do NOT
want multiple drivers. We just went through this with the ethernet
driver on 64340/64360. Go pull the latest stuff from:

   bk://source.mvista.com/linux-2.5-marvell

and look in 'drivers/serial/mpsc'. You should use this as your starting
point and make the necessary changes to get it working on the 64340.
Another serial driver will not be accepted into the kernel. Thanks.

-Steve
