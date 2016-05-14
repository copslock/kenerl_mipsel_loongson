Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2016 18:16:29 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:42319 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028931AbcENQQ2U2eAL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 May 2016 18:16:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=35K79/Co5Yvwzr6tVG37P6Gts/HQJErzSUh4QYbOqsU=; b=eGXunHKRZXp4DYA2QKCDuYYWDj
        OhVGfPLaQK/uBKYLvsY06QHGFOlDMhX6/cinV/1jhdz36cupkQFTJPB7fwoHaKbVO+aS/8iZdcIhf
        Ak8kVM5IeKesDIBMAUTOwfv+wBBkg8GC24Jtp5PwCkxUeN3FebFaStrQ1asQWNBxLn8n4Sm4oeFfH
        7Q7HQCmAlaKPVG9EcxTBzxEptujY0ihaw26DU4z7840C70SHsiBX07oLXyi3gQDMVuAkUvtcFXed6
        R9y5S6NcbrdSPLLsc3Yj1W/Je2GlTAysDHpEOnhM5PIoQawhWl9GQTWhmVWhgXeZmAf/wc4etpZeU
        S/OL7oNQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38718 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <private@roeck-us.net>)
        id 1b1cEc-000bNC-SB; Sat, 14 May 2016 16:16:11 +0000
Subject: Re: next: Build errors due to 'MIPS: Add probing & defs for VZ &
 guest features'
To:     James Hogan <james.hogan@imgtec.com>
References: <57374216.10307@roeck-us.net>
 <20160514155206.GE1124@jhogan-linux.le.imgtec.org>
Cc:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Guenter Roeck <private@roeck-us.net>
Message-ID: <57374F4D.70305@roeck-us.net>
Date:   Sat, 14 May 2016 09:16:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160514155206.GE1124@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: private@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: private@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: private@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <private@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: private@roeck-us.net
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

Hi James,

On 05/14/2016 08:52 AM, James Hogan wrote:
> On Sat, May 14, 2016 at 08:19:50AM -0700, Guenter Roeck wrote:
>> James,
>>
>> your patch 'MIPS: Add probing & defs for VZ & guest features' causes build errors
>> in -next when using gcc 4.7.4 / binutils 2.24. This affects almost all mips builds.
> Thanks Guenter. Hmm, I thought virt extensions were supported since
> binutils 2.24, odd.

Actually, turns out it was binutils 2.22 (from the compiler that came with poky 1.3).
Sorry for the confusion.

Guenter
