Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 06:11:09 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:38823 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006151AbbDUELHxDgWs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 06:11:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=orANe+nIm0s0sloQhRgG/I6YhWZvBIKZkdZpt5l4GJo=;
        b=Iu8xCnHmvC2qYHyHSjRXJO/TQ0OKY2Wab71Mr7gVhWl9jdY2xf4lLl5zCk/e/lhx0Vzcc2+lmCyDSayJi9y2Qjg5IyzpXB/IrMKOMsgk0qdPwxsCKqwrDhdkoD1H/iXimvDEaP4AwvfBKsBpu6Dy3D7iHzJfY7TSg9EXJSBrPvI=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1YkPWY-003CQm-IY
        for linux-mips@linux-mips.org; Tue, 21 Apr 2015 04:11:02 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34547 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1YkPWX-003CNX-Rs; Tue, 21 Apr 2015 04:11:02 +0000
Message-ID: <5535CDD4.8090900@roeck-us.net>
Date:   Mon, 20 Apr 2015 21:11:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: mips build failures due to commit 8dd928915a73 (mips: fix up
 obsolete cpu function usage)
References: <20150420194028.GA10814@roeck-us.net> <20150420210933.GB31618@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150420210933.GB31618@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020201.5535CDD6.016E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 04/20/2015 02:09 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Apr 20, 2015 at 12:40:28PM -0700, Guenter Roeck wrote:
>> the upstream kernel fails to build mips:nlm_xlp_defconfig,
>> mips:nlm_xlp_defconfig, mips:cavium_octeon_defconfig, and possibly
>> other targets, with errors such as
>>
>> arch/mips/kernel/smp.c:211:2: error:
>> 	passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier
>> 	from pointer target type
>> arch/mips/kernel/process.c:52:2: error:
>> 	passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier
>> 	from pointer target type
>> arch/mips/cavium-octeon/smp.c:242:2: error:
>> 	passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier
>> 	from pointer target type
>>
>> The problem was introduced with commit 8dd928915a73 (" mips: fix up
>> obsolete cpu function usage"). I would send a patch to fix it, but I
>> am not sure if removing 'volatile' from the variable declaration(s)
>> would be a good idea.
>
> I think removing volatile from cpu_callin_map declaration should be OK,
> since test_cpu (only reader) uses test_bit which takes care of it:
>
> 	static inline int test_bit(int nr, const volatile unsigned long *addr)
>

I ran two tests with nlm_xlp_defconfig:

- add volatile to the second argument of cpumask_set_cpu() and cpumask_test_cpu():
   vmlinux image size 194664946
- remove volatile from cpu_callin_map:
   vmlinux image size 194664066

Given that, I am not sure I understand the impact of removing volatile
from cpu_callin_map. Maybe it is just better optimization without
volatile. Maybe there is no impact. Maybe the use of volatile is wrong
to start with ('Volatile Considered Harmful' comes into mind).
Maybe the use of volatile for cpu_callin_map is wrong for other architectures
as well (powerpc, ia64). Either case, I don't know to code well enough to
make this call.

Guenter
