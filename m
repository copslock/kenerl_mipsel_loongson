Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 18:46:37 +0000 (GMT)
Received: from p508B7A49.dip.t-dialin.net ([IPv6:::ffff:80.139.122.73]:16153
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225300AbUCVSqg>; Mon, 22 Mar 2004 18:46:36 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2MIkZoM017326;
	Mon, 22 Mar 2004 19:46:35 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2MIkYIO017325;
	Mon, 22 Mar 2004 19:46:34 +0100
Date: Mon, 22 Mar 2004 19:46:34 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Frezell <dfrezell@speakeasy.net>
Cc: linux-mips@linux-mips.org
Subject: Re: mounting fs from memory
Message-ID: <20040322184634.GC6720@linux-mips.org>
References: <9C1F2DDC-7BAF-11D8-A797-00039394886E@speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9C1F2DDC-7BAF-11D8-A797-00039394886E@speakeasy.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 21, 2004 at 10:18:37PM -0500, Andrew Frezell wrote:

> 1.  Is there some way to protect the memory regions in RAM from linux 
> just trashing it?  I saw a function add_memory_region in 
> arch/mips/kernel/setup.c that seems to do something, does anyone know 
> what exactly this does?

The kernel won't touch any memory below the kernel itself.  I consider that
a bug so will change that for now that's a save region to place something.
add_memory_region takes a third argument which can be BOOT_MEM_RAM,
BOOT_MEM_ROM_DATA or BOOT_MEM_RESERVED.  You should pass BOOT_MEM_RESERVED
for to tell the kernel that a certain region should not be considered
usable memory.  For completeness sake BOOT_MEM_RAM is free memory and
BOOT_MEM_ROM_DATA will be free at the end of kernel initialization so is
usually used to describe free memory regions which hold firmware data that
becomes useless after initialization.

  Ralf
