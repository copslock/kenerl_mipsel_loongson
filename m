Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 18:36:51 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:52562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993612AbeDMQgnxFISD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 18:36:43 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4971F60BFA; Fri, 13 Apr 2018 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523637396;
        bh=RE+eupLpw84eANqvQ67LQoTJFvjxF4GRG/ETDuX857s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QBKjhn3ox8jPRq6JHTAe3fm3R5eJkiklHrqUhTBF61CU0dBhOIWezFTMG1pBmEWQ8
         LqzyxZWbDOFxxX5vpBLlGSb34kMp8dYYcLxBp+P40GdjvNCYsafHpiptiP2yH7m6HU
         10PDeH0cshtYYPmZZt8YX7oz6aGNaDZF2YO/f7R0=
Received: from [10.235.228.150] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBF936072E;
        Fri, 13 Apr 2018 16:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523637395;
        bh=RE+eupLpw84eANqvQ67LQoTJFvjxF4GRG/ETDuX857s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K/EUYbXEWZ2qiZosaLOcYs0Bm3QLw2W5CNAHRLLJ45Zo9hPY3IoUdUuPB5twbPSTf
         X4EKeS+aI+yVe5KFVLxbTG/s7Os13nm+SyLB4spDr71KjVr31mSVNradLXB+23+Won
         o2FK0bRLajpxcyKbuWWF6hNqf573QwlyXTmynKRM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBF936072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
To:     David Laight <David.Laight@ACULAB.COM>,
        'James Hogan' <jhogan@kernel.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman>
 <e38a329dfb9c461ab3e91de7b96db3dc@AcuMS.aculab.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <3688d54c-85f3-6eba-7f13-1cef0a0b5d85@codeaurora.org>
Date:   Fri, 13 Apr 2018 12:36:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e38a329dfb9c461ab3e91de7b96db3dc@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okaya@codeaurora.org
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

On 4/13/2018 11:41 AM, David Laight wrote:
> From: James Hogan
>> Sent: 12 April 2018 22:52
>> On Tue, Apr 03, 2018 at 08:55:04AM -0400, Sinan Kaya wrote:
>>> While a barrier is present in writeX() function before the register write,
>>> a similar barrier is missing in the readX() function after the register
>>> read. This could allow memory accesses following readX() to observe
>>> stale data.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Both patches look like obvious improvements to me, so I'm happy to apply
>> to my fixes branch.
> 
> Don't you also need at least barrier() between the register write in writeX()
> and the register read in readX()?
> On ppc you probably need eieio.
> Or are drivers expected to insert that one?
> If they need to insert that one then why not all the others??
> 

Good question. The volatile in here should prevent compiler from reordering the
register read or write instructions. 

static inline type pfx##read##bwlq(const volatile void __iomem *mem)

This is the solution all other architectures rely on especially via
__raw_readX() and __raw_writeX() API.

Now, things can get reordered when it leaves the CPU. This is guaranteed by
embedding wmb() and rmb() into the writeX() and readX() functions in other
architectures.

This ordering guarantee has been agreed to be the responsibility of the
architecture not drivers.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
