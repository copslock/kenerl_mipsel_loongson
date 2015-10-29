Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 22:35:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52098 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011853AbbJ2VftTqrkn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Oct 2015 22:35:49 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t9TLZkCl012541;
        Thu, 29 Oct 2015 22:35:46 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t9TLZjA8012540;
        Thu, 29 Oct 2015 22:35:45 +0100
Date:   Thu, 29 Oct 2015 22:35:45 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Subject: Re: old OCTEON bootloaders and .MIPS.abiflags
Message-ID: <20151029213544.GL26009@linux-mips.org>
References: <20151028195436.GB1838@blackmetal.musicnaut.iki.fi>
 <6D39441BF12EF246A7ABCE6654B0235361C6AA6F@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235361C6AA6F@LEMAIL01.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, Oct 28, 2015 at 09:02:43PM +0000, Matthew Fortune wrote:

> Aaro Koskinen <aaro.koskinen@iki.fi> writes:
> > Current binutils adds .MIPS.abiflags section to the kernel vmlinux.
> > 
> > This seems break the boot on some old (buggy) OCTEON bootloaders:
> > 
> > 	ELF file is 64 bit
> > 	Attempting to allocate memory for ELF segment: addr: 0xffffffff816e67f0 (adjusted to:
> > 0x00000000016e67f0), size 0x18
> > 	Allocated memory for ELF segment: addr: 0xffffffff816e67f0, size 0x18
> > 	Attempting to allocate memory for ELF segment: addr: 0xffffffff81100000 (adjusted to:
> > 0x0000000001100000), size 0x1b86360
> > 	Error allocating memory for elf image!
> > 	## ERROR loading File!
> > 
> > The workaround is to remove the .MIPS.abiflags with "strip" - I guess that
> > is safe for the kernel... Not sure if there is nothing much else to be
> > done, and already a similar hack needs to be done for the .notes section.
> > 
> > I just wanted to post this in case some else faces the same issue.
> 
> It seems reasonably sensible to /DISCARD/ the .MIPS.abiflags section in the kernel link
> scripts as I don't think the kernel needs that information for any purpose. I assume
> .reginfo is discarded as well at some point.

Historically discarding .reginfo didn't work because it is generated
by ld after it has generated all the output sections according to the
linker script.  So no matter what, one always ended up with a .reginfo.
This has been fixed at some point but I'm concerned the same behaviour
might have existed for .MIPS.abiflags as well and versions that do the
same thing with .MIPS.abiflags might still be around.

  Ralf
