Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 11:11:51 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:44722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992828AbeAOKLnsklHK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jan 2018 11:11:43 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7772160A00; Mon, 15 Jan 2018 10:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516011097;
        bh=Fvm6Bkz/aaGg+TDMmgXzKBnU+mH4xDvmXymcMcPgiC8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=McVMBaZ5/zUd/e/Xo22ELHhDpga2qyyXpsItlUhy1E/taqp3j39pjFCPbmez2S4q9
         sQ6xVcayPGyDab2qsTTGeBakIcgHnb9ckEAEUNHjtefoncmkbcfsSXBkAS3gdxvhxH
         VFwou1p2pmN2FJ9aAy2FD77kcAmNBbXDUXXBdoZg=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 544E8601A1;
        Mon, 15 Jan 2018 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1516011096;
        bh=Fvm6Bkz/aaGg+TDMmgXzKBnU+mH4xDvmXymcMcPgiC8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WEjVmBBcInzB6e7ACdmCnDuIu/AzbMxorRJJBPazSxIu3NGwlVuYlCR5V6NYIPLmP
         1NgxjH7un2NuCsHtAXSSRn6YLhPs37J3jcINhzYovB4INszwsYqyAs8szucUHy7ck/
         2NjvwNRI62ur22S2p1NkSzHniIcatgO7vq0r6fh4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 544E8601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        matt.redfearn@mips.com
Subject: Re: [PATCH] bcma: Fix 'allmodconfig' and BCMA builds on MIPS targets
References: <1515965642-16259-1-git-send-email-linux@roeck-us.net>
        <db5915ed-fc50-292f-c86b-4da7f3f0eddd@roeck-us.net>
Date:   Mon, 15 Jan 2018 12:11:33 +0200
In-Reply-To: <db5915ed-fc50-292f-c86b-4da7f3f0eddd@roeck-us.net> (Guenter
        Roeck's message of "Sun, 14 Jan 2018 13:40:50 -0800")
Message-ID: <87vag31ley.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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

Guenter Roeck <linux@roeck-us.net> writes:

> [ copying linux-mips ]
>
> On 01/14/2018 01:34 PM, Guenter Roeck wrote:
>> Mips builds with BCMA host mode enabled fail in mainline and -next
>> with:
>>
>> In file included from include/linux/bcma/bcma.h:10:0,
>>                   from drivers/bcma/bcma_private.h:9,
>> 		 from drivers/bcma/main.c:8:
>> include/linux/bcma/bcma_driver_pci.h:218:24: error:
>> 	field 'pci_controller' has incomplete type
>>
>> Bisect points to commit d41e6858ba58c ("MIPS: Kconfig: Set default MIPS
>> system type as generic") as the culprit. Analysis shows that the commmit
>> changes PCI configuration and enables PCI_DRIVERS_GENERIC. This in turn
>> disables PCI_DRIVERS_LEGACY. 'struct pci_controller' is, however, only
>> defined if PCI_DRIVERS_LEGACY is enabled.
>>
>> Ultimately that means that BCMA_DRIVER_PCI_HOSTMODE depends on
>> PCI_DRIVERS_LEGACY. Add the missing dependency.
>>
>> Fixes: d41e6858ba58c ("MIPS: Kconfig: Set default MIPS system type as ...")
>> Cc: Matt Redfearn <matt.redfearn@imgtec.com>
>> Cc: James Hogan <jhogan@kernel.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> I am aware that this problem has been reported several times. I have
>> not been able to find a fix, but I may have missed it. If so, my
>> apologies for the noise.
>>
> I should have said "I have not been able to find a patch fixing it".
>
>> Also note that this is not the only fix required; commit d41e6858ba58c,
>> as simple as it looks like, does a pretty good job messing up
>> "mips:allmodconfig" builds.
>>
> ... nor did I find patch(es) fixing the other build problem(s) introduced
> by d41e6858ba58c.

As I forgot to cc linux-mips on my previous email: I'm planning to queue
this for v4.15.

Over the weeked I got this bcma patch, but don't know if it's related or
not:

bcma: Prevent build of PCI host features in module
https://patchwork.kernel.org/patch/10161087/

And Guenter's patch is:

https://patchwork.kernel.org/patch/10162839/

Which one should I take? Adding also Matt.

And Matt also submitted similar patch for ssb:

ssb: Prevent build of PCI host features in module
https://patchwork.kernel.org/patch/10161131/

-- 
Kalle Valo
