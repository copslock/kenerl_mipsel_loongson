Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 23:48:30 +0100 (BST)
Received: from frank.harvard.edu ([IPv6:::ffff:140.247.122.99]:41383 "EHLO
	frank.harvard.edu") by linux-mips.org with ESMTP
	id <S8225208AbTDXWsa>; Thu, 24 Apr 2003 23:48:30 +0100
Received: from frank.harvard.edu (frank.harvard.edu [140.247.122.99])
	by frank.harvard.edu (8.11.6/8.11.6) with ESMTP id h3OMmSI19126;
	Thu, 24 Apr 2003 18:48:28 -0400
Date: Thu, 24 Apr 2003 18:48:28 -0400 (EDT)
From: Chip Coldwell <coldwell@frank.harvard.edu>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips@linux-mips.org
Subject: Re: NCD900 port?
In-Reply-To: <Pine.LNX.4.44.0304241744520.18155-100000@frank.harvard.edu>
Message-ID: <Pine.LNX.4.44.0304241839110.19067-100000@frank.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <coldwell@frank.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: coldwell@frank.harvard.edu
Precedence: bulk
X-list: linux-mips

On Thu, 24 Apr 2003, Chip Coldwell wrote:

> On Thu, 24 Apr 2003, Kevin D. Kissell wrote:
> > 
> > What PCI bridge is being used?  Galileo?
> 
> Good question.  Short answer: I don't know.  I'll pry off the hood
> and take a peek at what's on the board, unless this is something that
> shares a die with the CPU.

It was easy to identify once I took off the cover.  The PCI bridge is
made by V3 Semiconductor (now a part of QuickLogic?), part number
V32OUSC-75LP (Rev. B1):

http://www.quicklogic.com/home.asp?PageID=235&sMenuID=126

Is this the one called "Galileo"?

There's also two RS-232 line drivers/receivers, MAX3185 made by Maxim
(now part of Dallas Semiconductor) and some nearby Samsung parts that
I suppose are probably UARTs (this thing has two serial ports).  I
would guess that getting something to come out on a serial console is
going to be my first step.

Digitally signed images and bootloaders that enforce them sounds
particularly nasty.  That's a show stopper for me, if it turns out to
be that way.

Chip

-- 
Charles  M. "Chip" Coldwell
"Turn on, log in, tune out"
