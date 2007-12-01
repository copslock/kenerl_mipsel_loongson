Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Dec 2007 21:57:37 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:22407 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20026116AbXLAV5V (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 1 Dec 2007 21:57:21 +0000
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IyaKm-0001AY-Q8; Sat, 01 Dec 2007 21:57:13 +0000
Message-ID: <4751D8B7.1060508@pobox.com>
Date:	Sat, 01 Dec 2007 16:57:11 -0500
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] SGISEEQ: use cached memory access to make driver work
 on IP28
References: <20071126223934.84BE7C2B26@solo.franken.de>
In-Reply-To: <20071126223934.84BE7C2B26@solo.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> Following patch is clearly 2.6.25 material and is needed to get SGI IP28
> machines supported.
> 
> Thomas.
> 
> SGI IP28 machines would need special treatment (enable adding addtional
> wait states) when accessing memory uncached. To avoid this pain I changed
> the driver to use only cached access to memory.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

applied.  As I have noted to you previously, /please/ put extraneous 
comments /after/ a "---" separator, so that they are not copied by 
git-am (Linus's email patch import tool) into the permanent kernel 
changelog.

The above should look like:

<snip>
SGI IP28 machines would need special treatment (enable adding addtional 
wait states) when accessing memory uncached. To avoid this pain I 
changed the driver to use only cached access to memory.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
Following patch is clearly 2.6.25 material and is needed to get SGI IP28 
machines supported.

Thomas.

  drivers/net/sgiseeq.c |  239 
++++++++++++++++++++++++++++++++++---------------
  1 files changed, 166 insertions(+), 73 deletions(-)
</snip>


See Documentation/SubmittingPatches for more details, in particular "14) 
The canonical patch format" or http://linux.yyz.us/patch-format.html

	Jeff
