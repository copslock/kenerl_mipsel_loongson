Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 14:51:01 +0100 (BST)
Received: from web11302.mail.yahoo.com ([IPv6:::ffff:216.136.131.205]:14898
	"HELO web11302.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225753AbUDWNvA>; Fri, 23 Apr 2004 14:51:00 +0100
Message-ID: <20040423135056.68405.qmail@web11302.mail.yahoo.com>
Received: from [66.93.100.212] by web11302.mail.yahoo.com via HTTP; Fri, 23 Apr 2004 06:50:56 PDT
Date: Fri, 23 Apr 2004 06:50:56 -0700 (PDT)
From: Alex Deucher <agd5f@yahoo.com>
Subject: Re: few questions about linux on sgi machines
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040422204013.GA2506@kopretinka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <agd5f@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agd5f@yahoo.com
Precedence: bulk
X-list: linux-mips


--- Ladislav Michl <ladis@linux-mips.org> wrote:
> On Thu, Apr 22, 2004 at 10:49:16AM -0700, Alex Deucher wrote:
> > Is the PCI slot supported on the o2 (i.e., could I put a linux
> > supported pci card in and use it)?  Also is the o2 AV IO board
> > supported?  Is that encompassed by VICE or is that separate?
> 
> PCI is supported with some limitations. MMIO doesn't work for certain
> endianess combinations, but PIO should be okay.
> 
> O2's AV IO is part of VICE. Vivien Chappelier wrote original ALSA
> driver
> and I did some work on it later, but stopped due to some buzz world
> stuff (am I shy to show unfinished code ;-)). You may find Vivien's
> patches here: http://www.linux-mips.org/~glaurung/
> Video input is currently unsupported (no video4linux driver)

Are there databooks floating around for the AV stuff or does it have to
be reverse engineered?  Does it use standard chips or is it custom sgi
stuff?

Thanks,

Alex

> 
> 	ladis



	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
