Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Feb 2011 12:02:31 +0100 (CET)
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:39324
        "EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491055Ab1BRLC1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Feb 2011 12:02:27 +0100
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
        by qmta13.westchester.pa.mail.comcast.net with comcast
        id 9Nzd1g0011ap0As5DP2N3J; Fri, 18 Feb 2011 11:02:22 +0000
Received: from [192.168.1.13] ([69.251.104.163])
        by omta22.westchester.pa.mail.comcast.net with comcast
        id 9P2L1g0063XYSBH3iP2Mb2; Fri, 18 Feb 2011 11:02:22 +0000
Message-ID: <4D5E51A8.8070408@gentoo.org>
Date:   Fri, 18 Feb 2011 06:02:00 -0500
From:   Kumba <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Linux MIPS List <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/2]: Add support for Dallas/Maxim DS1685/1687 RTC
References: <4D5A65E3.1050707@gentoo.org> <4D5C5C66.6060205@metafoo.de> <4D5CF0EE.7000308@gentoo.org> <4D5D09FF.6010005@metafoo.de>
In-Reply-To: <4D5D09FF.6010005@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

On 02/17/2011 06:43, Lars-Peter Clausen wrote:
>
> That is what I meant. Pass the return value of rtc_valid_tm on, instead of
> setting the time to 0 and pretend everything went fine.
> You can still keep the dev_err though, no problem with that.

Okay, I got confused by this and thought you were referring to the quoted test 
box below in your first response.  My bad.  You're referring to the tail end of 
ds1685_rtc_read_time.

To clarify, this construct exists in four existing RTC drivers.  If this is 
wrong, I suggest fixing these four drivers, lest someone else come along and try 
to copy the idea, thinking it's the RightThing();

	drivers/rtc/rtc-ds1553.c:131
	drivers/rtc/rtc-ds1742.c:119
	drivers/rtc/rtc-rs5c348.c:136
	drivers/rtc/rtc-stk17ta8.c:133

I am going to assume the proper approach is:
	return rtc_Valid_tm(tm);


Cheers!,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
