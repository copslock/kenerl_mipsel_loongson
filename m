Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 14:06:19 +0100 (CET)
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:37980 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014853AbcAVNGRtu0kD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 14:06:17 +0100
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-06v.sys.comcast.net with comcast
        id 91671s00C26dK1R0116BfK; Fri, 22 Jan 2016 13:06:11 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-01v.sys.comcast.net with comcast
        id 916A1s00E0w5D380116A6V; Fri, 22 Jan 2016 13:06:11 +0000
Subject: Re: [PATCH 1/2] MIPS: c-r4k: Sync icache when it fills from dcache
To:     James Hogan <james.hogan@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>
References: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
 <1453460306-8505-2-git-send-email-james.hogan@imgtec.com>
 <CAOLZvyGeAgMt1KbmQR7c96WWXNJLr89b8hNSi9SePtjUK5K5fg@mail.gmail.com>
 <20160122121908.GG31243@jhogan-linux.le.imgtec.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <56A22936.8050601@gentoo.org>
Date:   Fri, 22 Jan 2016 08:05:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101
 Thunderbird/42.0
MIME-Version: 1.0
In-Reply-To: <20160122121908.GG31243@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1453467971;
        bh=udOW38zWtDsaH1uiVj2Nr1I4IakMa4b+RuAdW+V/g+Q=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=qn2a1SWVRWiJIqPHH7gm8xVbN8kqSoK+QViV5r0vrpgZD99zAeNwc4dmkFgdY7dR3
         J0beciVppUQuxSNVXRpFKskh6cpkMtRNntY529gGYYgiU+U2QYqL1TU82illTSHtl5
         0jVOvU1d2Nvwpn0MTQQ/mh64P9eUvqY61HVVW2k+e8903RJYihvjXZQts3PuN7p5H0
         tcXNKHS2slAAObnwVc714N8Fph2Z21gQe3OMhRl2AG+713k+l2ZFFLfIS3D7rJ4Bgw
         lLbpT7YIwlIpEJm3vmi2TnNzZK0KX/6UXie0aP+38LJzPcJIS8NdNvwKkPm7i8Dy8B
         Qy8ctq/EMp+5A==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51305
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

On 01/22/2016 07:19, James Hogan wrote:
> On Fri, Jan 22, 2016 at 01:06:14PM +0100, Manuel Lauss wrote:
>> Hi James,
[snip]
> 
> Thanks Manuel.
> 
> FWIW, attached is the test program I mentioned, which hits the first
> part of this patch (flush_cache_range) via mprotect(2) and checks if
> icache seems to have been flushed (tested on mips64r6, but should be
> portable).

Here's the output on my Octane, R14000 CPU (mips4):

# ./mprotect
Initial mprotect SUCCESS
Looped { mprotect RW, modify, mprotect RX, test } SUCCESS

This is without your patch applied.  That look good?  I'm assuming this CPU is
too old to be affected.  I can test with your patch after the blizzard is over
later this weekend.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
