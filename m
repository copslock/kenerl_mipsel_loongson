Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:15:48 +0100 (BST)
Received: from smtp-out.comcast.net ([IPv6:::ffff:24.153.64.115]:58957 "EHLO
	smtp-out.comcast.net") by linux-mips.org with ESMTP
	id <S8225235AbTDNQPh>; Mon, 14 Apr 2003 17:15:37 +0100
Received: from gentoo.org
 (pcp02545003pcs.waldrf01.md.comcast.net [68.48.92.102])
 by mtaout09.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0HDC0033LD4KLG@mtaout09.icomcast.net> for
 linux-mips@linux-mips.org; Mon, 14 Apr 2003 12:14:44 -0400 (EDT)
Date: Mon, 14 Apr 2003 12:16:45 -0400
From: Kumba <kumba@gentoo.org>
Subject: Re: Oddities with CVS Kernels, Memory on Indigo2
In-reply-to: <wrpbrz9vzkl.fsf@hina.wild-wind.fr.eu.org>
To: linux-mips@linux-mips.org
Reply-to: kumba@gentoo.org
Message-id: <3E9ADEED.7050106@gentoo.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3)
 Gecko/20030312
References: <3E98F206.5050206@gentoo.org> <20030414140717.GA805@simek>
 <3E9AD98B.90808@gentoo.org> <wrpbrz9vzkl.fsf@hina.wild-wind.fr.eu.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


	As am I.  I've also gotten an NE2000 ISA 10mbps network card to be 
detected and work under `ifconfig', but forgot how to deal with multiple 
network cards, so I didn't actually get it hooked up to the network. 
I've got a 3com 3c597 EISA card in there at the moment, but I think it's 
cooked, since it's MAC Address reports itself as all ff's.  I'm also 
hunting for an EISA Mach32 video card to see if maybe on the offchance, 
it's possible to build a VESA Compatible framebuffer for the system. 
That will prove to be an interesting experiment.

--Kumba



Marc Zyngier wrote:
>>>>>>"kumba" == kumba  <kumba@gentoo.org> writes:
> 
> 
> kumba> Mind you, that's an ISA Parallel Port card I dropped in.  I
> kumba> noticed the SGI's parallel port never worked, so I dug up a
> kumba> spare and tried it.
> 
> So you're the first to try an ISA card on the I2. I must say I'm
> quite pleased it worked ! :-)
> 
>         M.
