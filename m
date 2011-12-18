Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 16:14:05 +0100 (CET)
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:53414
        "EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903729Ab1LRPOA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 16:14:00 +0100
Received: from omta18.emeryville.ca.mail.comcast.net ([76.96.30.74])
        by qmta12.emeryville.ca.mail.comcast.net with comcast
        id AfBP1i0011bwxycACfDnDh; Sun, 18 Dec 2011 15:13:47 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta18.emeryville.ca.mail.comcast.net with comcast
        id AfmH1i0061rgsis8efmJG6; Sun, 18 Dec 2011 15:46:19 +0000
Message-ID: <4EEE0319.3050305@gentoo.org>
Date:   Sun, 18 Dec 2011 10:13:29 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
References: <4EED3A3D.9080503@gentoo.org> <20111217.215630.640392276998191183.davem@davemloft.net>
In-Reply-To: <20111217.215630.640392276998191183.davem@davemloft.net>
X-Enigmail-Version: 1.3.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14491

On 12/17/2011 21:56, David Miller wrote:


>> +		netdev_for_each_mc_addr(ha, dev)
>> +			set_bit((ether_crc(ETH_ALEN, ha->addr) >> 26),
>> +				    (volatile long unsigned int *)&priv->mcast_filter);
> 
> This makes an assumption not only about the size of the "unsigned long"
> type, but also of the endianness of the architecture this runs on.
> 


Can you give me some tips on this one?  au1000_eth.c does the same thing,
and I'm not seeing what the endian issue is exactly.  Is it the >> 26 part
or the use of ether_crc?  I see there's an ether_crc_le, too, and some
drivers also do the >> 26 bit on it as well.

Which is correct?  The few drivers I've looked at don't exactly spell out
this part of the code, and are usually doing something different because
most seem to access the multicast filter register in either 8-bits or
32-bits.  MACE ethernet seems to be one of the few doing it in full 64-bits.


Thanks,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
