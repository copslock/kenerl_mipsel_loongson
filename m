Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:35:06 +0100 (BST)
Received: from lopsy-lu.misterjones.org ([IPv6:::ffff:62.4.18.26]:24332 "EHLO
	young-lust.wild-wind.fr.eu.org") by linux-mips.org with ESMTP
	id <S8225237AbTDNQfF>; Mon, 14 Apr 2003 17:35:05 +0100
Received: from hina.wild-wind.fr.eu.org ([192.168.70.139])
	by young-lust.wild-wind.fr.eu.org with esmtp (Exim 3.35 #1 (Debian))
	id 1956oZ-0006sI-00; Mon, 14 Apr 2003 18:28:15 +0200
Received: from maz by hina.wild-wind.fr.eu.org with local (Exim 3.36 #1 (Debian))
	id 1956o1-0004la-00; Mon, 14 Apr 2003 18:27:41 +0200
To: kumba@gentoo.org
Cc: linux-mips@linux-mips.org
Subject: Re: Oddities with CVS Kernels, Memory on Indigo2
References: <3E98F206.5050206@gentoo.org> <20030414140717.GA805@simek>
	<3E9AD98B.90808@gentoo.org> <wrpbrz9vzkl.fsf@hina.wild-wind.fr.eu.org>
	<3E9ADEED.7050106@gentoo.org>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 14 Apr 2003 18:27:41 +0200
Message-ID: <wrp65phvybm.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <3E9ADEED.7050106@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <maz@misterjones.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mzyngier@freesurf.fr
Precedence: bulk
X-list: linux-mips

>>>>> "kumba" == kumba  <kumba@gentoo.org> writes:

kumba> As am I.  I've also gotten an NE2000 ISA 10mbps network card to
kumba> be detected and work under `ifconfig', but forgot how to deal
kumba> with multiple network cards, so I didn't actually get it hooked
kumba> up to the network.

Very nice, indeed.

kumba> I've got a 3com 3c597 EISA card in there at the moment, but I
kumba> think it's cooked, since it's MAC Address reports itself as all
kumba> ff's.

Maybe not. 3c597 may be tricky to support, because it does
bus-mastering, which is really a no-go given the state of the current
EISA code on IP22. I'll try to do something about it when 2.5 is
running on the IP22 (if it ever runs...).

kumba> I'm also hunting for an EISA Mach32 video card to see if maybe
kumba> on the offchance, it's possible to build a VESA Compatible
kumba> framebuffer for the system. That will prove to be an
kumba> interesting experiment.

Interesting is quite an understatement... :-)

        M.
-- 
Places change, faces change. Life is so very strange.
