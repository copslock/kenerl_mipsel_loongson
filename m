Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 09:18:12 +0100 (CET)
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:33269
        "EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491103Ab1BQISD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 09:18:03 +0100
Received: from omta13.emeryville.ca.mail.comcast.net ([76.96.30.52])
        by qmta12.emeryville.ca.mail.comcast.net with comcast
        id 8wHi1g00517UAYkACwHv8l; Thu, 17 Feb 2011 08:17:55 +0000
Received: from [192.168.1.13] ([69.251.104.163])
        by omta13.emeryville.ca.mail.comcast.net with comcast
        id 8wHq1g0053XYSBH8ZwHsFR; Thu, 17 Feb 2011 08:17:54 +0000
Message-ID: <4D5CD99E.6030300@gentoo.org>
Date:   Thu, 17 Feb 2011 03:17:34 -0500
From:   Kumba <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Linux MIPS List <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/2]: Add support for Dallas/Maxim DS1685/1687 RTC
References: <4D5A65E3.1050707@gentoo.org>       <4D5C5C66.6060205@metafoo.de>   <4D5CB5FB.20305@gentoo.org> <AANLkTimLjhY+sNuMh_gOXNuxZuFOvi25KMYFU4Xp1hbY@mail.gmail.com>
In-Reply-To: <AANLkTimLjhY+sNuMh_gOXNuxZuFOvi25KMYFU4Xp1hbY@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

On 02/17/2011 02:31, Manuel Lauss wrote:
>
> Have a look at i2c-ocores.c:    Basically you use platform_data to specify
> register spacing on the bus.
>
> Manuel

I think I get most of it here.  i2c-ocores.c defines `struct ocores_i2c`, which 
has regstep in it.  I assume the equivalent to this in the RTC driver is going 
to be ds1685_priv.  But in i2c_ocores.h, `struct ocores_i2c_platform_data` is 
defined, which also carries a regstep.  In i2c-ocores.c, this struct becomes 
*pdata while ocores_i2c becomes *i2c, and *i2c is used to access the registers.

I don't think I have an equivalent to either of these two with the way the 
driver was originally written and how I modified it.  The ds1685_priv kinda does 
both right now.  I assume platform_data is not really defined...I have to 
implement one specific to this RTC driver, giving it specific variables that 
need to be customizable at the platform level, and then set those in the 
machine-specific areas, i.e., somewhere in IP32's platform file.

Sound correct?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
