Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2015 05:40:21 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:46742 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006154AbbDIDkTJvSbS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2015 05:40:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=UuyICfQOlr7dFgGmwRk45NBsSnl8NrFWxQSxI+cyXdg=;
        b=w7Lr5gXo68U0wjidUDhdAOIMsQlEtjcHe5msgrCr+gB3JcyN021fnPu3gf2HwjCqCblXqQk1RfFxO2DBuAe0xhZFb3lAGuQZ8J828ajMyeXRVusfIIb9kXQn4ZraHzwlvDYG4Ta4ipE/FTtzcEb3BiL8qCA3dTVptzmBc0ZMTuk=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1Yg3K9-000BAO-2k
        for linux-mips@linux-mips.org; Thu, 09 Apr 2015 03:40:13 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:49390 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1Yg3K5-000B83-B8; Thu, 09 Apr 2015 03:40:09 +0000
Message-ID: <5525F498.5040203@roeck-us.net>
Date:   Wed, 08 Apr 2015 20:40:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] mips: Fix build if PERF_EVENTS is configured
References: <1428524992-5979-1-git-send-email-linux@roeck-us.net> <20150409000934.GA21107@linux-mips.org>
In-Reply-To: <20150409000934.GA21107@linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020205.5525F49D.017D,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 10
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
X-archive-position: 46841
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

On 04/08/2015 05:09 PM, Ralf Baechle wrote:
> On Wed, Apr 08, 2015 at 01:29:52PM -0700, Guenter Roeck wrote:
>
>> mips builds fail in -next as follows if PERF_EVENTS is configured.
>>
>> kernel/built-in.o: In function `perf_sample_regs_user':
>> kernel/events/core.c:4828: undefined reference to `perf_get_regs_user'
>>
>> The problem is caused by commit 3478e32c1545 ("MIPS: Add user stack and
>> registers to perf.") in combination with commit 88a7c26af8da ("perf:
>> Move task_pt_regs sampling into arch code"), which introduces
>> perf_get_regs_user().
>>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: David Daney <david.daney@cavium.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> I've already applied the same change locally but due to patch ordering
> constraints I'm considering to temporarily pull this patch until the
> perf stuff and the remainder of the MIPS changes are in 4.1 or so.
>
Hi Ralf,

Does it hurt to have the function if 88a7c26af8da is not in the tree ?
Sure, you'll get a smatch and/or sparse warning, but I would consider that
to be less severe than build failures.

Thanks,
Guenter
