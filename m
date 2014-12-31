Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Dec 2014 10:45:35 +0100 (CET)
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:32825 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008756AbaLaJpdVrrul (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Dec 2014 10:45:33 +0100
Received: from resomta-po-17v.sys.comcast.net ([96.114.154.241])
        by resqmta-po-04v.sys.comcast.net with comcast
        id a9lS1p0045Clt1L019lVdY; Wed, 31 Dec 2014 09:45:29 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-po-17v.sys.comcast.net with comcast
        id a9lT1p0090gJalY019lU1w; Wed, 31 Dec 2014 09:45:29 +0000
Message-ID: <54A3C5B2.8090501@gentoo.org>
Date:   Wed, 31 Dec 2014 04:45:22 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Linux MIPS List <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/02 resend] MIPS: IP32: Add platform data hooks to use
 DS1685 driver
References: <548B689A.1010007@gentoo.org> <20141215162957.GC26674@linux-mips.org>
In-Reply-To: <20141215162957.GC26674@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1420019129;
        bh=51CG2m/FeOAcb4f0rK7eUcfQHUjR7KZGIQGrGsPGenY=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=Vhli9dKXQVUorxt9gVppfiF0cmbCrUq6bQtRIrh83O0tDSPC36DkQvsu703z/kc4T
         QlZpIQk+g6xLUfFCuD5TkY74UBZzVmhWXyS0nyA3PMJ7cAUwDchAAyEFE4Tr8p1Vvj
         Qv2eMKBtDj+SuPbySTJ3LZzz7wRsv1KFB5jRWH7Ia3pPVxuJbWpAf67Q1sv5QqGelt
         nTNxhsXpIpTz5NKhJmL6oQLOXSfzDbC7ROkX16uULZdu7AR2RiqJngrJI6dYhlmMX9
         VuiwA7veWinRBtwK2VoLu9eKk6fMqkQO1F1uukHE01t7RmoSoBjhB4plFXuqURf6s7
         8ZmVOnuhlz54Q==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44950
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

On 12/15/2014 11:29, Ralf Baechle wrote:
> On Fri, Dec 12, 2014 at 05:13:46PM -0500, Joshua Kinard wrote:
> 
>> This modifies the IP32 (SGI O2) platform and reset code to utilize the new
>> rtc-ds1685 driver.  The old mc146818rtc.h header is removed and ip32_defconfig
>> is updated as well.
>>
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
>> ---
>>  arch/mips/configs/ip32_defconfig              |    3
>>  arch/mips/include/asm/mach-ip32/mc146818rtc.h |   36 ----
>>  arch/mips/sgi-ip32/ip32-platform.c            |   52 +++++-
>>  arch/mips/sgi-ip32/ip32-reset.c               |  132 ++++------------
>>  4 files changed, 85 insertions(+), 138 deletions(-)
>>  delete mode 100644 arch/mips/include/asm/mach-ip32/mc146818rtc.h
>>
>> Ralf,
>>
>>   Similar to Maciej's DEC/RTC patches from a few months ago, this patch
>> requires the rtc-ds1685 driver be added upstream first before this can go into
>> into the LMO tree.  If you can queue this someplace until that makes it in,
>> that would be great.  Thanks!
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Alessandro,
> 
> I don't think there is much of a chance of this patch conflicting with
> others so feel free to funnel this through the RTC tree.  Or I carry
> both patches - I don't care which way.
> 
> Cheers,
> 
>   Ralf

I haven't seen any reaction or feedback from Alessandro or the rtc-linux
upstream yet.  What are the odds these two patches can go in under the MIPS
tree?  If so, would it be queued for 3.20 or 3.21?

Thanks!,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28
