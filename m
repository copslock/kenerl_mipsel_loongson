Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2011 01:56:02 +0200 (CEST)
Received: from gateway06.websitewelcome.com ([67.18.44.20]:46755 "HELO
        gateway06.websitewelcome.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1491754Ab1H2Xzz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2011 01:55:55 +0200
Received: (qmail 11800 invoked from network); 29 Aug 2011 23:56:18 -0000
Received: from ham.websitewelcome.com (HELO ham01.websitewelcome.com) (173.192.111.52)
  by gateway06.websitewelcome.com with SMTP; 29 Aug 2011 23:56:18 -0000
Received: by ham01.websitewelcome.com (Postfix, from userid 666)
        id 96C1CA85E662B; Mon, 29 Aug 2011 18:55:06 -0500 (CDT)
Received: from gator750.hostgator.com (gator750.hostgator.com [174.132.194.2])
        by ham01.websitewelcome.com (Postfix) with ESMTP id 69684A85E65DA
        for <linux-mips@linux-mips.org>; Mon, 29 Aug 2011 18:55:06 -0500 (CDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type:Content-Transfer-Encoding:X-BWhitelist:X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:X-Email-Count:X-Source-Cap;
        b=HwJKOTdh6/SNmN9quYpmhXgcfBFpzci0X1q240yDgnXGvm3vhezO2bfGdMD5jFFnmYM4/ZkBPauVHAnJGvGhrnCzSdmxU2wKyCJcy9/hAhBbFLeXw18VjipEdy1SMj1d;
Received: from [216.239.45.4] (port=13350 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1QyBfO-0005vP-Tz; Mon, 29 Aug 2011 18:54:59 -0500
Message-ID: <4E5C26D4.3000906@paralogos.com>
Date:   Mon, 29 Aug 2011 16:55:00 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
References: <20110829232029.GA15763@zapo> <4E5C2490.6040203@cavium.com>
In-Reply-To: <4E5C2490.6040203@cavium.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-BWhitelist: no
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 216-239-45-4.google.com (kkissell.mtv.corp.google.com) [216.239.45.4]:13350
X-Source-Auth: kevink@kevink.net
X-Email-Count: 2
X-Source-Cap: a2tpc3NlbGw7a2tpc3NlbGw7Z2F0b3I3NTAuaG9zdGdhdG9yLmNvbQ==
X-archive-position: 31011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21962

I submitted that exact patch (David's more minimal version) in December
2010 (and I did test it).  Did it not take?  See the thread "SMTC
support status in latest git head".  The patch went out on December 24
(why I was spending my Christmas Eve fixing MIPS Linux is another
question... :op )

            Kevin K.

On 08/29/11 16:45, David Daney wrote:
> On 08/29/2011 04:20 PM, Edgar E. Iglesias wrote:
>> Hi,
>>
>> Commit 362e696428590f7d0a5d0971a2d04b0372a761b8
>> reorders a bunch of insns to improve the flow of the pipeline but
>> for MT_SMTC kernels, AFAICT, the saving of CP0_STATUS seems wrong.
>
> Indeed.
>
>>
>> Am I missing something?
>>
>
> It does look like in the MIPS_MT_SMTC case we are clobbering the value
> in v1.
>
>> If not here is a patch, tested with qemu.
>>
>
> How about the attached completely untested one instead?
>
> David Daney
