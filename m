Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2011 21:56:57 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:35072 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491063Ab1E1T4v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 May 2011 21:56:51 +0200
Received: by pzk28 with SMTP id 28so1384079pzk.36
        for <multiple recipients>; Sat, 28 May 2011 12:56:44 -0700 (PDT)
Received: by 10.142.209.19 with SMTP id h19mr285664wfg.271.1306612604221;
        Sat, 28 May 2011 12:56:44 -0700 (PDT)
Received: from [192.168.43.191] (m872736d0.tmodns.net [208.54.39.135])
        by mx.google.com with ESMTPS id j14sm2131782wfg.2.2011.05.28.12.56.40
        (version=SSLv3 cipher=OTHER);
        Sat, 28 May 2011 12:56:42 -0700 (PDT)
Message-ID: <4DE15373.8050708@landley.net>
Date:   Sat, 28 May 2011 14:56:35 -0500
From:   Rob Landley <rob@landley.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: MIPS panic in 2.6.39 (bisected to 7eaceaccab5f)
References: <4DDB5673.5060206@landley.net> <20110524143937.GB30117@linux-mips.org> <4DDCB1EB.4020707@landley.net> <20110527075512.GE30117@linux-mips.org> <20110527140011.GF30117@linux-mips.org> <4DE0D303.8000106@landley.net> <20110528162807.GB7150@linux-mips.org>
In-Reply-To: <20110528162807.GB7150@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
Precedence: bulk
X-list: linux-mips

On 05/28/2011 11:28 AM, Ralf Baechle wrote:
> On Sat, May 28, 2011 at 05:48:35AM -0500, Rob Landley wrote:
> 
>> Your missing hunk at the top of this file is:
>>
>> @@ -29,6 +29,7 @@
>>  #include <asm/system.h>
>>  #include <asm/cacheflush.h>
>>  #include <asm/traps.h>
>> +#include <asm/smp-ops.h>
>>
>>  #include <asm/gcmpregs.h>
>>  #include <asm/mips-boards/prom.h>
>>
>> And then the patch works!  Yay!  Thank you.
> 
> Thanks Rob!  I fixed that and the patch is now in the MIPS git.
> 
>   Ralf

Do you think it's a candidate for stable?

Ro
