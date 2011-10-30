Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Oct 2011 23:34:31 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:43881 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903677Ab1J3WeY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 30 Oct 2011 23:34:24 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1RKdxP-0001R7-00; Sun, 30 Oct 2011 23:34:23 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 4204B1D248; Sun, 30 Oct 2011 23:34:18 +0100 (CET)
Date:   Sun, 30 Oct 2011 23:34:18 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org,
        ralf@linux-mips.org, FlorianSchandinat@gmx.de
Subject: Re: [PATCH v2] GIO bus support for SGI IP22/28
Message-ID: <20111030223418.GA16346@alpha.franken.de>
References: <20111020221928.0C2191DA27@solo.franken.de>
 <4EADB701.9040506@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EADB701.9040506@gentoo.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21706

On Sun, Oct 30, 2011 at 04:43:45PM -0400, Joshua Kinard wrote:
> Does this handle any glue logic for add-on NIC cards found for Indy and I2?

no, but it will make live a lot easier, because address and interrupts don't
need to be probed by the driver. Right now interrupts are on my todo, since
there is some weirdness between guiness and fullhouse boxes...

>  I have a G130 Phobus and a rare ThunderLAN card in my Indy.  The Phobus has
> an Altera GIO/PCI glue chip.  Not sure about the ThunderLAN.  Both have
> normal driver support in the kernel (Phobus is just a Tulip chip).

it still needs something to setup the PCI bus on the card and issue
the probing. The problem with the Tulip Phobos cards is, that they
messed up the endianess, so that none of the Linux Tulip drivers will
work out of the box...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
