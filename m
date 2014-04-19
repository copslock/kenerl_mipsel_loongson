Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2014 01:23:26 +0200 (CEST)
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:43056
        "EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818667AbaDSXXQIPurV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Apr 2014 01:23:16 +0200
Received: from omta04.westchester.pa.mail.comcast.net ([76.96.62.35])
        by qmta14.westchester.pa.mail.comcast.net with comcast
        id ryi21n0080ldTLk5EzP8kL; Sat, 19 Apr 2014 23:23:08 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta04.westchester.pa.mail.comcast.net with comcast
        id rzP81n00J0JZ7Re01zP8r7; Sat, 19 Apr 2014 23:23:08 +0000
Message-ID: <53530544.3010308@gentoo.org>
Date:   Sat, 19 Apr 2014 19:22:44 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] RTC: rtc-cmos: drivers/char/rtc.c features for DECstation
 support
References: <alpine.LFD.2.11.1404192224250.11598@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1404192224250.11598@eddie.linux-mips.org>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1397949788;
        bh=OXuLKeT8cY/HSjdASHcCKALPV8//RvDc3hslRlH1Z44=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=Aa6eL3eDslp/w1DToLDSiTC5L7x3m/+9wIQE4wtK6cFhKhPb0gux4KDfmHIfSbxrN
         t2Ac8GG29pLBDO1yg7udjhuv75vatGR5mnZW5nFuUki5Liepwxzn0UR372RoNBa6V+
         0uDlewzGBu/nrQDNTE1gAmln64BQP+RFHUY8Wb28VWpgDBxqEuLY5N2EB9wgzj5DHc
         GYnvQgAhsChV3Ta3tPquaMGuO8yVf59SaL/Ulh/6nIPOHN+V2CtwhmVOSTDta9TOvW
         rzQy8hXSpfu2ET+vbsy3X5z2x4HIjEzXNahlQegA8IEL4LLveEHpFMstrtd0M2w6kC
         2Bgyhf+XEhLMg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 04/19/2014 18:58, Maciej W. Rozycki wrote:
> This brings in drivers/char/rtc.c functionality required for DECstation 
> and, should the maintainers decide to switch, Alpha systems to use 
> rtc-cmos.
> 
> Specifically these features are made available:
> 
[snip]
> * The ability to use the RTC periodic interrupt as a system clock device,
>   which is implemented by arch/mips/kernel/cevt-ds1287.c for DECstation 
>   systems and takes the RTC interrupt away from the RTC driver.  
>   Eventually hooking back to the clock device's interrupt handler should 
>   be possible for the purpose of the alarm clock and possibly also 
>   update-in-progress interrupt, but this is not done by this change.

I had this implemented myself in the DS1685 driver I've still yet to send in
(for SGI IP32).  But the upper-level RTC code for periodic and update
interrupts was removed sometime between 2.6.39 and 3.0 and uses the kernel's
hrtimers to replace it.  No idea if they'll ever re-add that code for RTC
drivers that can use the hardware implementation instead.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
