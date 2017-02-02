Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 11:42:15 +0100 (CET)
Received: from resqmta-ch2-08v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:40]:35828
        "EHLO resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993898AbdBBKmFTwjuL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 11:42:05 +0100
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-08v.sys.comcast.net with SMTP
        id ZEq3c8ZE3jvz4ZEq3cDO0P; Thu, 02 Feb 2017 10:42:03 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-11v.sys.comcast.net with SMTP
        id ZEq1cOT0eaESWZEq2cw3gB; Thu, 02 Feb 2017 10:42:03 +0000
Subject: Re: [PATCH] MIPS: Replace printk calls in cpu-bugs64.c with
 pr_info/pr_cont
To:     James Hogan <james.hogan@imgtec.com>
References: <29b7fc69-97f4-6a3a-0e65-2678f9c30cef@gentoo.org>
 <20170202100041.GA13058@jhogan-linux.le.imgtec.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <f0edc411-178c-7f18-9be6-9d40892c54b5@gentoo.org>
Date:   Thu, 2 Feb 2017 05:41:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170202100041.GA13058@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAj14bm6NUeGt1IW3Epa1bvluW8d9ZgmGbqw5YFjRMbtoM+Dl+T1f5Pjw8l4PEZkoU+yLHWv92hCbbYEQm5cb3airMT21nDTJys8c3azDwy5Go5dSIkS
 T9cd4TIXbmbQz6pQL2VV74rytCTiqqi0+v085xSn9E60aVW/QAXEHO9NKcKPBWKKpPG9ud9Nwq3V8wXbRWwnEhNmgITiOFccXKVyforiroFKd4AFnrBOlZLE
 AMR9sk1mWeo1wGnnM0EpyJMfO2K1RT+HePYRhe4eC2E=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56587
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

On 02/02/2017 05:00, James Hogan wrote:
> Hi Joshua,
> 
> On Thu, Feb 02, 2017 at 03:56:26AM -0500, Joshua Kinard wrote:
>> From: Joshua Kinard <kumba@gentoo.org>
>>
>> In arch/mips/kernel/cpu-bugs64.c, replace initial printk's in three
>> bug-checking functions with pr_info and replace several continuation
>> printk's with pr_info/pr_cont calls to avoid kernel log output like
>> this:
>>
>>     [    0.899065] Checking for the daddi bug...
>>     [    0.899098] no.
>>
>> This makes the output appear correctly:
>>
>>     [    0.898643] Checking for the daddi bug... no.
>>
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> 
> A variation of this patch is already applied, but without the change of
> printk -> pr_info:
> 
> https://patchwork.linux-mips.org/patch/14916/
> 
> https://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=35e7f7885e1b1b272a73c0de3227fc9a3e95a7e3

Oh, thanks for that.  I keep forgetting to go look at the upstream git queue.
I noticed the issue when trying to boot my Onyx2 back up and only checked the
main tree to see if it was fixed.

Shouldn't the printk's have a log level, though?  I thought that was the
motivation behind using the various pr_* calls.

--J
