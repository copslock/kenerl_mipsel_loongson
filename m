Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2006 18:39:22 +0100 (BST)
Received: from p549F5FD7.dip.t-dialin.net ([84.159.95.215]:9675 "EHLO
	p549F5FD7.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133858AbWGIRjL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Jul 2006 18:39:11 +0100
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:62143 "EHLO
	rwcrmhc11.comcast.net") by lappi.linux-mips.net with ESMTP
	id S1097688AbWGIRjN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Jul 2006 19:39:13 +0200
Received: from [127.0.0.1] (unknown[69.140.185.142])
          by comcast.net (rwcrmhc11) with ESMTP
          id <20060709173824m1100i3fnse>; Sun, 9 Jul 2006 17:38:25 +0000
Message-ID: <44B13F02.5020002@gentoo.org>
Date:	Sun, 09 Jul 2006 13:38:10 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Julien BLACHE <jblache@debian.org>
Subject: Re: [PATCH] IP22: fix serial console hangs
References: <87irm6naxt.fsf@frigate.technologeek.org>
In-Reply-To: <87irm6naxt.fsf@frigate.technologeek.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Julien BLACHE wrote:
> Hi,
> 
> The patch below fixes serial console hangs as seen on IP22
> machines. Typically, while booting, the machine hangs for ~1 minute
> displaying "INIT: ", then the same thing happens again when init
> enters in the designated runlevel and finally the getty process on
> ttyS0 hangs indefinitely (though strace'ing it helps).
> 

Out of curiosity, don't suppose you've seen the oops on IP22 that can sometimes 
be triggered by closing the serial client on another box?  Haven't investigated 
it too much, but I've seen the odd case on Indy and IP28 (which also uses the 
zilog driver) where shutting down my serial client or sometimes rebooting the 
system running the client oopses the driver.  I suspect some rogue data gets 
passed that zilog doesn't know how to handle properly.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
