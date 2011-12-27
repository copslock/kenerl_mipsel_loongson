Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2011 05:55:14 +0100 (CET)
Received: from qmta14.emeryville.ca.mail.comcast.net ([76.96.27.212]:38524
        "EHLO qmta14.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903554Ab1L0EzJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2011 05:55:09 +0100
Received: from omta04.emeryville.ca.mail.comcast.net ([76.96.30.35])
        by qmta14.emeryville.ca.mail.comcast.net with comcast
        id E4ue1i0010lTkoCAE4uv4E; Tue, 27 Dec 2011 04:54:55 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta04.emeryville.ca.mail.comcast.net with comcast
        id E4lh1i01T1rgsis8Q4liLC; Tue, 27 Dec 2011 04:45:43 +0000
Message-ID: <4EF94F8F.7060506@gentoo.org>
Date:   Mon, 26 Dec 2011 23:54:39 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
References: <4EED3A3D.9080503@gentoo.org> <4EF6803C.9060203@gentoo.org> <20111226.151713.2002746283994460284.davem@davemloft.net>
In-Reply-To: <20111226.151713.2002746283994460284.davem@davemloft.net>
X-Enigmail-Version: 1.3.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19801

On 12/26/2011 15:17, David Miller wrote:

> From: Joshua Kinard <kumba@gentoo.org>
> Date: Sat, 24 Dec 2011 20:45:32 -0500
> 
>> SGI IP32 (O2)'s ethernet driver (meth) lacks meth_set_rx_mode, which
>> prevents IPv6 from working completely because any ICMPv6 neighbor
>> solicitation requests aren't picked up by the driver.  So the machine can
>> ping out and connect to other systems, but other systems will have a very
>> hard time connecting to the O2.
>>
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> 
> Lots of completely unrelated changes here, the IRQ name string has
> nothing to do with specifically fixing the ICMPv6 neighbour discovery
> bug.
> 
> Do not mix changes like this, one change per patch please, thanks.


Noted.  I dropped the name change patch and minimized the changes to the
mace registers to just the two registers needed for this specific case.
I'll send two separate patches for the remaining registers and the name bit
to just linux-mips later on.  Patch to follow.

Thanks,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
