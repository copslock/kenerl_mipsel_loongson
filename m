Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2005 11:14:47 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:63510 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226231AbVDOKOd>; Fri, 15 Apr 2005 11:14:33 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3FAENrI007330;
	Fri, 15 Apr 2005 11:14:23 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3FAEMxL007329;
	Fri, 15 Apr 2005 11:14:22 +0100
Date:	Fri, 15 Apr 2005 11:14:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
Cc:	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: [OFF-TOPIC] Cobalt 64-bit, what for? (was: 64-bit fix)
Message-ID: <20050415101422.GB5414@linux-mips.org>
References: <20050414185949.GA5578@skeleton-jack> <425F8776.6080703@kilimandjaro.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425F8776.6080703@kilimandjaro.dyndns.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 15, 2005 at 11:20:54AM +0200, Dominique Quatravaux wrote:

> Just out of curiosity, is there any practical interest in going 64bit on 
> Cobalt besides the fun of it?

Second hand Cobalt MIPS hardware is available fairly cheaply so it's being
used by various Linux developers for doing development work, including
64-bit work.

> One cannot possibly squeeze more than 4 Gb of RAM into a Cobalt box right?

No, the limit is significantly less.  64-bit kernels are advantagous if

 - running N32 or N64 software is desired
 - anything that takes advantage of 64-bit registers or the 32/32 fpr model
 - software is using large amounts of virtual address space.  Process size
   is limited to 2GB which is tight for some of todays codes which do their
   I/O by memory mapping files.
 - and of the course there is the "more inches" factor ;-)

> And doesn't 64 bit mode have costs of its own (doubled i-fetch bandwidth
> for starters)?

Fortunately not double and caches will further blurr the picture - but on
a system with a 32-bit processor and memory bus there will be very
noticable impact.  We're using a bunch of tricks to keep the overhead under
control.

  Ralf
