Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 00:39:00 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:46604 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990412AbeDLWisq9zi8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 00:38:48 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3E45C607EF; Thu, 12 Apr 2018 22:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523572722;
        bh=I318nWpUI17AdKyMOjpJrAwJ3nFcOW7z/O/wD4KzMuI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C/g7/WIMWG3k0rAe7SfhEXGjuN0Ra25MDQNetLmVy93OjukmRoE5aX0vyekrHE/Zh
         rbA4aGmMnBWG+hhFC9MOHlBMZ44JXJLwfHmjBKAydY6XkRduHm4u+NzFZW5jCtKyz4
         frqztzpqMo1ICxJ/Mjvfhq4c08c/1id+U+gkcWio=
Received: from [10.235.228.150] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A795B60264;
        Thu, 12 Apr 2018 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523572721;
        bh=I318nWpUI17AdKyMOjpJrAwJ3nFcOW7z/O/wD4KzMuI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nykPcnD4MHgDHMV3CHrjxWgl1lOTSV2dZeZdwhCkKhq9qsHNDomuLCmRpqpPEBAl/
         fsRnBeXqj1+NDImuaqJSS11ZXWFKoV1YKaLS5dyIBxRt63onwho8VDit5nxSwd3hzB
         2YLL0krClf8Es6qMooCeZzavlbMBZyhj2dUndX74=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A795B60264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman> <20180412215855.GB27802@saruman>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <33c9c074-e0a5-7552-9993-269cd85101aa@codeaurora.org>
Date:   Thu, 12 Apr 2018 18:38:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412215855.GB27802@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63515
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

On 4/12/2018 5:58 PM, James Hogan wrote:
> On Thu, Apr 12, 2018 at 10:51:49PM +0100, James Hogan wrote:
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
> Though having said that, a comment to go with the rmb() (as suggested by
> checkpatch) to detail the situation we're concerned about would be nice
> to have.

I can send a new version. No worries. 

Functional correctness is more important at this moment. I can accommodate
any nice to haves.

> 
> Cheers
> James
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
