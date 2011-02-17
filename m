Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 10:57:38 +0100 (CET)
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:46355
        "EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491075Ab1BQJ5f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 10:57:35 +0100
Received: from omta04.westchester.pa.mail.comcast.net ([76.96.62.35])
        by qmta12.westchester.pa.mail.comcast.net with comcast
        id 8xx61g0010ldTLk5CxxTRU; Thu, 17 Feb 2011 09:57:27 +0000
Received: from [192.168.1.13] ([69.251.104.163])
        by omta04.westchester.pa.mail.comcast.net with comcast
        id 8xxR1g00H3XYSBH3QxxSuK; Thu, 17 Feb 2011 09:57:27 +0000
Message-ID: <4D5CF0EE.7000308@gentoo.org>
Date:   Thu, 17 Feb 2011 04:57:02 -0500
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
X-archive-position: 29202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

On 02/16/2011 18:23, Lars-Peter Clausen wrote:

> Just pass the error up to rtc core.

How?  I looked at a few other drivers, but they, too, call dev_err() or 
dev_dbg().  Others don't appear to send any kind of string-based error value 
anywhere, they just return a -E* value.


> There is no need for these checks the core takes care that the values are valid.

I've seen a few other RTC drivers implement these checks.  It's really hard to 
tell what drivers are, I guess, "right" and which ones are "wrong" in their 
approach when you've got already-accepted drivers in the tree doing things that 
I'm trying to fix in this driver.

That said, how is the core running these checks when I quickly turn around and 
write the values back to the RTC?


> 	return rtc_valid_tm(&arlm->time);

Noted -- Probably form when I copied one of the time read functions or such. 
Alarm support wasn't in the original version of this driver when I found it.


> Why has 'enabled' to be a pointer?

No idea to be honest.  I think I copied it from another driver.  I'll re-review 
it when I get to that point in fixing things.


> resource_size(res) instead of res->end - res->start + 1
> and it would be easier to just save the pointer to res instead of saving both
> size and start;

Noted, I see a few drivers using this syntax, so I'll adapt to it.


> If CONFIG_SYSFS is not defined you'll get an compile error.

Noted, thanks!


> Since the irq handler references the rtc device it should be freed before the
> rtc device.

Noted, thanks!


> There doesn't seem to be any code inside this file which is used outside of
> ds1685.c so it might be a good idea to merge the two files, or at least move
> this file to drivers/rtc/

I wasn't quite sure where headers typically went.  include/linux/rtc already 
existed, so I thought it was created at some point for holding .h files for RTC 
drivers.  IP32 will need to reference this header down the road anyways.  No 
harm if it has to look into drivers/rtc?


> Just use BIT(x) instead of adding these defines

Noted, will research.


> I think you should really use readb(pdata->regs + REG) instead of the following
> structs. Maybe add a helper function in the form of:
> static uint8_t ds1685_read(struct ds1685_priv *ds1685, unsigned int reg) {
> 	return readb(pdata->regs + REG);
> }
>
> That should also help with the different paddings introduced in patch 2.

Working on this now.  Ran into some road blocks with gcc and inlining, but I 
worked around it.


> All these macros that follow should really be functions.

Even the large ds1685_begin_data_access macro?  I can stick it into a inlined 
function, but I thought a macro was better.  Or am I trying to outfox the 
compiler by doing so?

If I do inline it, I need a fix for passing errors back to the RTC core.  I 
can't use dev_err() because it needs the device struct to work with, and I want 
to avoid passing too many arguments to an inlinable function.

Thoughts?  The rest should be easy to convert into inlined functions.


Thanks!,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
