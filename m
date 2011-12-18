Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 05:38:06 +0100 (CET)
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:35005
        "EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903692Ab1LREiD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 05:38:03 +0100
Received: from omta24.emeryville.ca.mail.comcast.net ([76.96.30.92])
        by qmta12.emeryville.ca.mail.comcast.net with comcast
        id AUaw1i0021zF43QACUdonG; Sun, 18 Dec 2011 04:37:48 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta24.emeryville.ca.mail.comcast.net with comcast
        id AVGc1i00c1rgsis8kVGd8n; Sun, 18 Dec 2011 05:16:38 +0000
Message-ID: <4EED6DED.50308@gentoo.org>
Date:   Sat, 17 Dec 2011 23:37:01 -0500
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
X-archive-position: 32132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14330

On 12/17/2011 21:56, David Miller wrote:

> From: Joshua Kinard <kumba@gentoo.org>
> Date: Sat, 17 Dec 2011 19:56:29 -0500
> 
>> +/* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
>> + * MACE Ethernet uses a 64 element hash table based on the Ethernet CRC.
>> + */
>> +static int multicast_filter_limit = 32;
>> +
>> +
> 
> Unnecessary empty line, only one is sufficient.  I also don't see a reason
> to even define this value.  If it's a constant then use a const type.


Lifted straight out of another driver already in the tree and checked
against the docs.  I can spin a new patch to constify it, but the same fix
is needed for several other drivers, too.


>> +	/* Multicast filter. */
>> +	unsigned long mcast_filter;
>> +
>  ...
>> +		priv->mcast_filter = 0xffffffffffffffffUL;
> 
> You're assuming that unsigned long is 64-bits here.  You need to use a
> type which matches your expections regardless of the architecture that
> the code is built on.


MACE Ethernet only ever appears on the SGI O2 systems.  It's part of the
MACE chip and doesn't exist (as far as I know) in any kind of standalone
form.  It's virtually impossible for it to appear outside of any other
architecture/machine.

That said, would using 'u64' over 'unsigned long' work?  The O2 codebase is
far from pretty, and would need a LOT of cleanups along similar lines.  This
code simply matches what is already existing in-tree.


>> +		netdev_for_each_mc_addr(ha, dev)
>> +			set_bit((ether_crc(ETH_ALEN, ha->addr) >> 26),
>> +				    (volatile long unsigned int *)&priv->mcast_filter);
> 
> This makes an assumption not only about the size of the "unsigned long"
> type, but also of the endianness of the architecture this runs on.
> 
> Please recode this to remove both assumptions.

See note above regarding the 'unsigned long' bit.  The endian assumption is
not directly visible to me, however.  What, specifically, is incorrect?  The
call to ether_crc?  The bitwise right-shift?  set_bit?

I lifted this out of au1000_eth.c (which is a little-endian MIPS device, if
I recall correctly), and all the digging I could do states that the Ethernet
CRC algorithm is LE anyways (ether_crc() calls crc32_le, bitrev32, and
such).  I couldn't find anything big-endian about it, even when I tested it
against several other code samples that computed the 6-bit hash key from the
Dst MAC address.


Thanks,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
