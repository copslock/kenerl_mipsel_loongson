Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 11:00:22 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:53777 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903685Ab1KAKAR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Nov 2011 11:00:17 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1RLB8i-0003uV-00; Tue, 01 Nov 2011 11:00:16 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 58ABF1BB71D; Tue,  1 Nov 2011 11:00:09 +0100 (CET)
Date:   Tue, 1 Nov 2011 11:00:09 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org,
        ralf@linux-mips.org, FlorianSchandinat@gmx.de
Subject: Re: [PATCH v2] GIO bus support for SGI IP22/28
Message-ID: <20111101100009.GA29087@alpha.franken.de>
References: <20111020221928.0C2191DA27@solo.franken.de>
 <4EADB701.9040506@gentoo.org>
 <20111030223418.GA16346@alpha.franken.de>
 <4EAE5681.2090103@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EAE5681.2090103@gentoo.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 307

On Mon, Oct 31, 2011 at 04:04:17AM -0400, Joshua Kinard wrote:
> A.k.a., Tulip (and possibly ThunderLAN) assume little-endian, when we're
> talking big-endian archs here.  Interesting.  Simple fix, as in defining a
> few driver structures with little- and big-endian versions (if they're doing
> something like packing bits or using bitfields)?  Or is it more complex than
> that?

iirc, the PCI bridge on the cards do 32bit swaps (address invariant) so
tulip chips need to run in big endian mode, which in turn makes descriptors
also big endian. But none of the tulip driver supports big endian descriptors.
That's fixable of course.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
