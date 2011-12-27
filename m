Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2011 22:30:26 +0100 (CET)
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:41440 "EHLO
        qmta10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903627Ab1L0VaU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2011 22:30:20 +0100
Received: from omta21.emeryville.ca.mail.comcast.net ([76.96.30.88])
        by qmta10.emeryville.ca.mail.comcast.net with comcast
        id EM4e1i0251u4NiLAAMW6fv; Tue, 27 Dec 2011 21:30:06 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta21.emeryville.ca.mail.comcast.net with comcast
        id EMx71i00E1rgsis8hMx8dP; Tue, 27 Dec 2011 21:57:10 +0000
Message-ID: <4EFA38D5.1000602@gentoo.org>
Date:   Tue, 27 Dec 2011 16:29:57 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Stephen Hemminger <shemminger@vyatta.com>
CC:     netdev@vger.kernel.org, Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
References: <4EED3A3D.9080503@gentoo.org> <4EF95247.7000403@gentoo.org> <20111227103408.01aad10e@nehalam.linuxnetplumber.net>
In-Reply-To: <20111227103408.01aad10e@nehalam.linuxnetplumber.net>
X-Enigmail-Version: 1.3.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20153

On 12/27/2011 13:34, Stephen Hemminger wrote:

> On Tue, 27 Dec 2011 00:06:15 -0500
> Joshua Kinard <kumba@gentoo.org> wrote:
> 
>> @@ -95,7 +95,7 @@ struct mace_video {
>>   * Ethernet interface
>>   */
>>  struct mace_ethernet {
>> -	volatile unsigned long mac_ctrl;
>> +	volatile u64 mac_ctrl;
>>  	volatile unsigned long int_stat;
>>  	volatile unsigned long dma_ctrl;
>>  	volatile unsigned long timer;
> 
> 
> This device driver writer needs to read:
>   Documentation/volatile-considered-harmful.txt

MIPS I/O registers are always memory-mapped, and to prevent the compiler
from trying to over-optimize, volatile is used to make sure we always read a
value from the hardware and not from some cached value.

See MIPS Run (2nd Ed), pp 307, section 10.5.2 highlights an example of this,
which is viewable here:
http://books.google.com/books?id=kk8G2gK4Tw8C&pg=PA307&lpg=PA308#v=onepage&q&f=false

But other than that, yeah, this driver needs to pretty much be stripped down
to the nuts and bolts and re-written.  Maybe something to tackle in the
future.  I still haven't gotten around to submitting the RTC driver for O2's
(that I re-wrote from a patch sent into LKML years ago) upstream yet.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
