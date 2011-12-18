Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 05:43:41 +0100 (CET)
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:35883 "EHLO
        qmta03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903692Ab1LREnh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 05:43:37 +0100
Received: from omta18.emeryville.ca.mail.comcast.net ([76.96.30.74])
        by qmta03.emeryville.ca.mail.comcast.net with comcast
        id AUds1i0021bwxycA3UjK5J; Sun, 18 Dec 2011 04:43:19 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta18.emeryville.ca.mail.comcast.net with comcast
        id AVFb1i0071rgsis8eVFcht; Sun, 18 Dec 2011 05:15:36 +0000
Message-ID: <4EED6F39.2030601@gentoo.org>
Date:   Sat, 17 Dec 2011 23:42:33 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net: meth: Some code cleanups for meth
References: <4EED418E.40501@gentoo.org> <20111217.220032.683061606470374131.davem@davemloft.net>
In-Reply-To: <20111217.220032.683061606470374131.davem@davemloft.net>
X-Enigmail-Version: 1.3.3
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-archive-position: 32133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14331

On 12/17/2011 22:00, David Miller wrote:

> From: Joshua Kinard <kumba@gentoo.org>
> Date: Sat, 17 Dec 2011 20:27:42 -0500
> 
>> -#define WAIT_FOR_PHY(___rval)					\
>> -	while ((___rval = mace->eth.phy_data) & MDIO_BUSY) {	\
>> -		udelay(25);					\
>> +#define WAIT_FOR_PHY(___rval)                               \
>> +	while ((___rval = mace->eth.phy_data) & MDIO_BUSY) {    \
>> +		udelay(25);                                         \
> 
> I think using tabs at the end of the line to line up the "\" is much
> better than what you're changing it to, that being spaces.


Mistake from when I still had my editor switched to spaces mode.  I set it
to tab mode a little bit later and didn't think to go back and correct this.


>> -		priv->phy_addr=i;
>> -		p2=mdio_read(priv,2);
>> -		p3=mdio_read(priv,3);
>> +
>> +	for (i = 0; i < 32; i++){
>> +		priv->phy_addr = i;
>> +		p2 = mdio_read(priv,2);
>> +		p3 = mdio_read(priv,3);
> 
> If you're going to put forth the effort to put spaces around the
> "=" characters, fix up the arguments to mdio_read() as well, there
> needs to be a space after the "," and right before the second
> argument.
> 


It's not that it took a lot of effort, I just simply missed the space after
the comma.  It still looks better :)


>> +		if ((p2 != 0xffff) && (p2 != 0x0000)) {
> 
> There is no need for the new parenthesis you are adding here.  It
> doesn't change things semantically, and it does not improve
> readability, it just makes for more characters a human has to parse in
> his mind.
> 


It's a habit -- I blame math from grade school years ago.  I'll remove them
in the next version.


>> - * Copyright (C) 2001 Alessandro Rubini and Jonathan Corbet
>> - * Copyright (C) 2001 O'Reilly & Associates
>> + * Copyright (C) 2001-2003 Ilya Volynets
>> + * Copyright (C) 2011 Joshua Kinard
>>   *
>> - * The source code in this file can be freely used, adapted,
>> - * and redistributed in source or binary form, so long as an
>> - * acknowledgment appears in derived source files.  The citation
>> - * should list that the code comes from the book "Linux Device
>> - * Drivers" by Alessandro Rubini and Jonathan Corbet, published
>> - * by O'Reilly & Associates.   No warranty is attached;
>> - * we cannot take responsibility for errors or fitness for use.
>> + *	This program is free software; you can redistribute it and/or
>> + *	modify it under the terms of the GNU General Public License
>> + *	as published by the Free Software Foundation; either version
>> + *	2 of the License, or (at your option) any later version.
>>   */
> 
> I'm not sure at all that you have the ability to make this kind of
> change to the copyright and attributions here.


Looking at the header file, I really cannot find anything that would bear in
common with sample code from a book.  If it was an actual driver file,
maybe.  But a header file containing specific definitions for hardware bits?
 I tracked down the first commit back in 2001 and put in the guy who
initially submitted it.  Is there a better way to handle this?  I doubt that
book had SGI O2 MACE Ethernet-specific defines in it.


> There are probably a lot more problems with this patch, but I'm
> exhausted look at this stuff as-is.


Probably :)


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
