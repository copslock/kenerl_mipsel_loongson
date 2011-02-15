Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 12:40:05 +0100 (CET)
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:52050 "EHLO
        qmta05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491003Ab1BOLkC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Feb 2011 12:40:02 +0100
Received: from omta07.emeryville.ca.mail.comcast.net ([76.96.30.59])
        by qmta05.emeryville.ca.mail.comcast.net with comcast
        id 8Bep1g0021GXsucA5Bftn9; Tue, 15 Feb 2011 11:39:53 +0000
Received: from [192.168.1.13] ([69.251.104.163])
        by omta07.emeryville.ca.mail.comcast.net with comcast
        id 8Bf61g0023XYSBH8UBfrpT; Tue, 15 Feb 2011 11:39:53 +0000
Message-ID: <4D5A65A2.7040101@gentoo.org>
Date:   Tue, 15 Feb 2011 06:38:10 -0500
From:   Kumba <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH 0/2]: Add support for Dallas/Maxim DS1685/1687 RTC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Okay, it's been a while since I last did this, so bear with me if I make any 
mistakes.

Following this are two parts of a patch to add an RTC class driver for the 
Dallas/Maxim DS1685/1687 RTC chip.  I'm routing it through this ML because A) I 
don't know any better and B) only the SGI O2 currently makes use of it.  Plus 
people here have a really keen eye for things and can tell me if I need to do 
something better.

The first patch is derived from an older version of the DS1685 driver I found on 
Google. That patch apparently made it up to akpm's -mm branch, but never made it 
into a -mm release and as far as I can tell, died at some undetermined point.  I 
haven't tried contacting the original author, either.  I just used the DS1685 
data sheet, O2's original CMOS RTC driver, and the old code for the IP30 
(Octane) RTC driver (which is the same chip) to get this working.

The second patch adds in the IP32-specific bits.  I can't think of a sane way to 
avoid mixing arch-specific code with generic code, but the register padding that 
IP32 needs is, as far as I can tell, unavoidable.  The second patch also adds in 
minor differences for the DS17285/17287 RTC, which is extremely similar to the 1685.

IRIX suggests IP32 is supposed to have the 17287 chips by default, but I 
examined four separate O2 boards and all of them have DS1687-5 chips.  Even two 
of my Octane system boards had DS1687-5 chips.  But the differences were minor 
enough, that they can be enabled by flipping a menuconfig item.  You can even 
run them w/ a 1687-5 chip with no ill effects.

Also, the second patch removes the old RTC access code from IP32, but it does 
NOT touch the power down code.  That can be modified to include the ds1685.h 
file and allow for the deletion of 17287rtc.h down the road.  The current RTC 
framework doesn't appear to support the extended registers used for power down 
anyways, so there's no way to build this into the driver itself.  Though it 
wouldn't be very hard to add it once the base RTC class code picks up the support.

Thoughts?
-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
