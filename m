Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2003 18:15:44 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:57074 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225229AbTGXRPm>;
	Thu, 24 Jul 2003 18:15:42 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6OHFZS23215;
	Thu, 24 Jul 2003 10:15:35 -0700
Date: Thu, 24 Jul 2003 10:15:35 -0700
From: Jun Sun <jsun@mvista.com>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: boot requirements
Message-ID: <20030724101535.C19920@mvista.com>
References: <Pine.GSO.4.44.0307241019450.23101-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.44.0307241019450.23101-100000@ares.mmc.atmel.com>; from dkesselr@mmc.atmel.com on Thu, Jul 24, 2003 at 10:27:16AM -0400
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jul 24, 2003 at 10:27:16AM -0400, David Kesselring wrote:
> I am trying to determine what has to be included in our boot code to start
> linux. I didn't think I needed to port yamon. What does yamon or pmon
> provide for starting or debugging(gdb) linux? Does the processor need to
> be in a specific state or context before jumping from the boot code to the
> linux downloaded image? If someone can point me to a simple example, I
> would greatly appreciate it.
>

This is a good question.  I am listing what I can think of on top of my
head.  Some items might be missing:

. cold initialize board
. RAM should be ready
. kernel binary is in place
. cache is consistent.
. any kernel command line args are set up (set prom_init() for the 
  "protocol")
. Normally you would enable cache, and jump to the KSEG0 kernel_entry.
  (I have seen exceptions, in which case you need to modified a little
   in kernel)
. Obviously CPU is setup in kernel mode and a few configs are setup correctly
  (such as data path width, timing, etc).  Interrupt should be
  turned off.
 
All the rest bootloader work are negotiable between the linux kernel
and bootloader.  For example, if bootloader assigns PCI resources,
then kenel can skip pci_auto.  In other words, beyond the above
minimum requirement, other bootloader work _can_ be done in Linux board
setup routine.

Jun
