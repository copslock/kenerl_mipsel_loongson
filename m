Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2012 20:20:52 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:39697 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903657Ab2CFTUq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2012 20:20:46 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q26JKd68023581
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 6 Mar 2012 11:20:39 -0800 (PST)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.1.255.0; Tue, 6 Mar 2012
 11:20:38 -0800
Message-ID: <4F566384.5050501@windriver.com>
Date:   Tue, 6 Mar 2012 14:20:36 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/5] MIPS: module.h usage cleanup.
References: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com> <20120306190826.GJ4519@linux-mips.org>
In-Reply-To: <20120306190826.GJ4519@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.146.65]
X-archive-position: 32606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 12-03-06 02:08 PM, Ralf Baechle wrote:
> On Tue, Feb 28, 2012 at 02:24:43PM -0500, Paul Gortmaker wrote:
> 
>> Hi Ralf,
>>
>> Not a lot to see here, really.  MIPS had usages of module.h tucked
>> away in a couple asm files, and that was masking some of the other
>> implicit users, plus preventing MIPS from getting the full benefit
>> of not having to feed module.h to cpp 35,000 times.
>>
>> I've left the two drivers/serial commits separate, in case there
>> is a desire to have them go in via Greg's trees, but they are a
>> required dependency for the arch/mips fixes, so I think it makes
>> sense they stay together with the other changes here.
>>
>> I will have some arch independent module.h cleanups (in fs and lib)
>> that will require me to create a module.h tree for 3.4, so I can
>> carry this there if required.  But this lot is all self-contained
>> to MIPS and so I'd be fine with (and actually prefer) this going in
>> via the MIPS tree.  No strong preference - either way, let me know.
> 
> Haven't received any comment and the patches are trivial so I'm going
> to queue them hopeing that Alan Cox (not on cc ...) doesn't mind ...

I stuck them in linux-next for additional sanity testing above the
defconfig builds that I did and nothing caught fire.  I'll back
them out from my for-next branch now that I know you've got them queued
via the mips for-next.

Thanks!
Paul.

> 
>   Ralf
