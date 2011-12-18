Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 15:40:51 +0100 (CET)
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:46127
        "EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903728Ab1LROkr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 15:40:47 +0100
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
        by qmta03.westchester.pa.mail.comcast.net with comcast
        id Aedd1i00317dt5G53eghu9; Sun, 18 Dec 2011 14:40:41 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta13.westchester.pa.mail.comcast.net with comcast
        id Aegh1i00G1rgsis3Zeghhy; Sun, 18 Dec 2011 14:40:41 +0000
Message-ID: <4EEDFB58.20904@gentoo.org>
Date:   Sun, 18 Dec 2011 09:40:24 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
References: <4EED3A3D.9080503@gentoo.org> <20111217.215630.640392276998191183.davem@davemloft.net> <4EED6DED.50308@gentoo.org> <20111218.001925.2108645748994734084.davem@davemloft.net>
In-Reply-To: <20111218.001925.2108645748994734084.davem@davemloft.net>
X-Enigmail-Version: 1.3.3
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-archive-position: 32138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14477

On 12/18/2011 00:19, David Miller wrote:

> From: Joshua Kinard <kumba@gentoo.org>
> Date: Sat, 17 Dec 2011 23:37:01 -0500
> 
>> MACE Ethernet only ever appears on the SGI O2 systems.
> 
> That has no bearing on my feedback, we simply do not put non-portable
> code like this into the tree at this point.
> 
> Just because this driver has been maintained in an non-portable manner
> up to this point, doesn't mean we continue doing that.


Agreed.  However, I was simply trying to fix a problem that prevents IPv6
from working, not fix every little thing wrong with the code.  While I want
to tackle re-writing the driver to be more in line with existing network
drivers, that's a future project.  I'm still new to driver
development/kernel work in general, so I'm learning here.


Thanks for the feedback, though,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
