Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:57:57 +0100 (BST)
Received: from smtp-out.comcast.net ([IPv6:::ffff:24.153.64.109]:6277 "EHLO
	smtp-out.comcast.net") by linux-mips.org with ESMTP
	id <S8225202AbTDNQ54>; Mon, 14 Apr 2003 17:57:56 +0100
Received: from gentoo.org
 (pcp02545003pcs.waldrf01.md.comcast.net [68.48.92.102])
 by mtaout11.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0HDC00A1OF2IEV@mtaout11.icomcast.net> for
 linux-mips@linux-mips.org; Mon, 14 Apr 2003 12:56:42 -0400 (EDT)
Date: Mon, 14 Apr 2003 12:58:42 -0400
From: Kumba <kumba@gentoo.org>
Subject: Re: Oddities with CVS Kernels, Memory on Indigo2
In-reply-to: <20030414173510.A2133@ftp.linux-mips.org>
To: linux-mips@linux-mips.org
Reply-to: kumba@gentoo.org
Message-id: <3E9AE8C2.50409@gentoo.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3)
 Gecko/20030312
References: <3E98F206.5050206@gentoo.org> <20030414140717.GA805@simek>
 <3E9AD98B.90808@gentoo.org> <wrpbrz9vzkl.fsf@hina.wild-wind.fr.eu.org>
 <3E9AE0D6.5060401@gentoo.org> <20030414173510.A2133@ftp.linux-mips.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ladislav Michl wrote:
> On Mon, Apr 14, 2003 at 12:24:54PM -0400, Kumba wrote:
> 
> Several chips used in Indy (and Indigo2) are used in much complicated machines
> (not supported by linux) and SGI always designed its machines with modularity
> in mind. local3_irq is another cascade where nothing is hooked on Indy, so you
> can't get this irq. and if it happens there is sometning strange with our
> system. there are no comments because you need to understand it before coding
> and once you read documentation comments are useless ;-)
> 
> 	ladis
> 
> ps. there is driver for built-in parport now by Vincent Stehle
> http://vincent.stehle.free.fr/sgi/parport.php3


Ah ha, interesting.  I noticed it, because testing both the parallel 
port and NE2000 ISA card, I had to avoid that IRQ.  The parallel port 
card had physical jumpers I set on it to get around trying to use IRQ3, 
and the NE2000 Card you *have* to know the IRQ.  Can't use the 
ether=0,0,ethX line on the kernel, because if the kernel attempts to 
probe for IRQs, it runs into that panic.  Enabling it didn't seem to do 
anything bad either, except that odd message which sounded pretty weird 
for a kernel.

--Kumba
