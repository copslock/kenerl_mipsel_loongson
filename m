Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2011 09:05:23 +0100 (CET)
Received: from qmta11.emeryville.ca.mail.comcast.net ([76.96.27.211]:53717
        "EHLO qmta11.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903554Ab1JaIFQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2011 09:05:16 +0100
Received: from omta20.emeryville.ca.mail.comcast.net ([76.96.30.87])
        by qmta11.emeryville.ca.mail.comcast.net with comcast
        id rL0P1h0021smiN4ABL5143; Mon, 31 Oct 2011 08:05:01 +0000
Received: from [192.168.1.13] ([76.106.65.35])
        by omta20.emeryville.ca.mail.comcast.net with comcast
        id rKyM1h00M0leNgC8gKyPJf; Mon, 31 Oct 2011 07:58:24 +0000
Message-ID: <4EAE5681.2090103@gentoo.org>
Date:   Mon, 31 Oct 2011 04:04:17 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org,
        ralf@linux-mips.org, FlorianSchandinat@gmx.de
Subject: Re: [PATCH v2] GIO bus support for SGI IP22/28
References: <20111020221928.0C2191DA27@solo.franken.de> <4EADB701.9040506@gentoo.org> <20111030223418.GA16346@alpha.franken.de>
In-Reply-To: <20111030223418.GA16346@alpha.franken.de>
X-Enigmail-Version: 1.3.3
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-archive-position: 31326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21802

On 10/30/2011 18:34, Thomas Bogendoerfer wrote:

> 
> no, but it will make live a lot easier, because address and interrupts don't
> need to be probed by the driver. Right now interrupts are on my todo, since
> there is some weirdness between guiness and fullhouse boxes...


It wouldn't be an SGI machine if it didn't implement something weird or just
plain backwards...


> it still needs something to setup the PCI bus on the card and issue
> the probing. The problem with the Tulip Phobos cards is, that they
> messed up the endianess, so that none of the Linux Tulip drivers will
> work out of the box...


A.k.a., Tulip (and possibly ThunderLAN) assume little-endian, when we're
talking big-endian archs here.  Interesting.  Simple fix, as in defining a
few driver structures with little- and big-endian versions (if they're doing
something like packing bits or using bitfields)?  Or is it more complex than
that?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
