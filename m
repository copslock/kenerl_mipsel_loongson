Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 06:45:52 +0100 (CET)
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:33642 "EHLO
        qmta04.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491044Ab1BQFpt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 06:45:49 +0100
Received: from omta02.emeryville.ca.mail.comcast.net ([76.96.30.19])
        by qmta04.emeryville.ca.mail.comcast.net with comcast
        id 8tlZ1g0030QkzPwA4tlh4t; Thu, 17 Feb 2011 05:45:41 +0000
Received: from [192.168.1.13] ([69.251.104.163])
        by omta02.emeryville.ca.mail.comcast.net with comcast
        id 8tld1g00P3XYSBH8NtlfcU; Thu, 17 Feb 2011 05:45:41 +0000
Message-ID: <4D5CB5FB.20305@gentoo.org>
Date:   Thu, 17 Feb 2011 00:45:31 -0500
From:   Kumba <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Linux MIPS List <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/2]: Add support for Dallas/Maxim DS1685/1687 RTC
References: <4D5A65E3.1050707@gentoo.org> <4D5C5C66.6060205@metafoo.de>
In-Reply-To: <4D5C5C66.6060205@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

On 02/16/2011 18:23, Lars-Peter Clausen wrote:
> I think you should really use readb(pdata->regs + REG) instead of the following
> structs. Maybe add a helper function in the form of:
> static uint8_t ds1685_read(struct ds1685_priv *ds1685, unsigned int reg) {
> 	return readb(pdata->regs + REG);
> }
>
> That should also help with the different paddings introduced in patch 2.

Lots of good feedback, thanks!  Ralf already suggested using offsets instead of 
a struct.  I'm tinkering now with getting this to work, as I have to have this 
done before I can address many of your other points.

I have determined the following formula specific to the SGI O2 to read the RTC 
registers:

readb(pdata->regs + RTC_<REGISTER> * 0x100);

is equivalent to

readb(pdata->regs.time.<REGISTER>);

I'll assume writeb() changes are the same.  The question is, how do I wire in 
the 0x100 padding value in such a way that I keep the IP32-specific bits out of 
generic code?  Ralf mentioned using some field in platform_data, but I haven't 
quite learned the platform stuff (this is my first real attempt at a kernle driver).

Also, one thing I can quickly address, I put the ds1685.h file under 
include/linux/rtc because I saw that folder as already existing.  I figured 
that's where rtc header files went.  Right now, nothing outside of the driver 
uses it, but SGI O2 will need to eventually, as it uses the RTC to trigger a 
system poweroff by accessing a few of the extended control registers.

It currently uses similarly-duplicated #defines in a local header file, but I 
figured, if I can get this driver fully working, and other platforms could 
theoretically use the same trick, would not include/linux/rtc be the best place 
for the header?  If there's a better place, please let me know!

Thanks,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
