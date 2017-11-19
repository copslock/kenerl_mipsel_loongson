Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2017 04:06:09 +0100 (CET)
Received: from resqmta-ch2-07v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:39]:60120
        "EHLO resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990720AbdKSDGCFUSah (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2017 04:06:02 +0100
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-07v.sys.comcast.net with ESMTP
        id GFtBeLyhu4gARGFtKehFkp; Sun, 19 Nov 2017 03:03:30 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-ch2-17v.sys.comcast.net with SMTP
        id GFtIe7KX3RomNGFtJeQhfc; Sun, 19 Nov 2017 03:03:30 +0000
Subject: Re: [PATCH v3] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
From:   Joshua Kinard <kumba@gentoo.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux/MIPS <linux-mips@linux-mips.org>
References: <23fb0d7b-347a-195d-38f3-383ac59cc69d@gentoo.org>
 <alpine.DEB.2.00.1711171715020.3888@tp.orcam.me.uk>
 <ddc2ba6e-ab17-114c-fdc2-bdb2900bc57a@gentoo.org>
Message-ID: <7ea6747e-4d60-52e1-6ec8-447b5ca41e5a@gentoo.org>
Date:   Sat, 18 Nov 2017 22:03:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <ddc2ba6e-ab17-114c-fdc2-bdb2900bc57a@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH6DhDdvI5PLdYiwPfPBNKzTEqpEE8YvlEqjbYaRPJak4yDd/fOPByK2sK3fgWwk0QnIHLTVmAyRn0ntgreAK1j1Q+j8gMYFzEs+5hM9wJBkRs8xuGmF
 kyBN3yt+NOW5xMyDu0XliL5q7GIw3MXFx7GqLqxO0lhrP44byo6GoqD5hpIoLQp1GTo+lTY6tWPXCq1gs+wvcqMMkaeF1T8DorOJsrzCIqW/U+NiqyC2UhgB
 ZQW3YWJuXJLZ61yqrM3/hDUC5L6p02j0UKFzP/bokVsba3a/oC34oj4wv0RFzfCgniuHJo9tKhWVL80mA06kSAHw4zt+PlTASMGarzVJI2s=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61002
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

On 11/18/2017 21:18, Joshua Kinard wrote:
> On 11/17/2017 12:45, Maciej W. Rozycki wrote:

[snip]

>>
>>  I think the BEQZL delay slot bug fixes to `atomic_sub_if_positive' and 
>> `atomic64_sub_if_positive' should be split off and submitted separately as 
>> a preparatory patch, so that they can be backported to stable branches; 
>> please do so.  It'll also make your original clean up that follows 
>> clearer.
> 
> I'll make it a stand-alone patch.  Will also CC stable for backporting.

Actually, thinking about it some, I think a separate patch strictly for stable
that only fixes the beqzl case, and leaves the beqz case alone, makes more
sense.  Because for the preparatory patch, the subu/dsubu issue really only
affects the beqzl case.  But I am applying the same fix to the beqz case to
make the follow-on patch to collapse the R10000_LLSC_WAR cases down clearer,
and I don't think this follow-on patch will need to be backported.

Or is a patch for stable really needed, since the branch-likely case really
only applies to R10K machines, which right now in mainline means IP27 and IP28?

I'll skip on CC'ing stable right now so I can get both patches queued up.  Can
re-visit if it's deemed to really be an issue.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
