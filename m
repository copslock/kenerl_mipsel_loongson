Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2018 23:43:28 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:44546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990409AbeDGVnU2DaJI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2018 23:43:20 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 74D07601D9; Sat,  7 Apr 2018 21:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523137393;
        bh=7wrXeDc//laV/ZMfla++91b0xvXiRxeH3zPJ6Y3reNE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C6FsPwx588SoaMtvi6llYnovdF1JXsyvSm5DOWo1pHcEbyezJ2MBWLBvAALnitP3i
         4cLY9BNPAhsUcGv2F2Vzi8CFLrx3UMYZTfHhW8WcH0x7bceJ+uUZs8xE563u3SsTBs
         DLtahXR64bNwCv5DPyO9okPmPR6e56qjj8HjHVnU=
Received: from [10.235.228.150] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5E7B605A5;
        Sat,  7 Apr 2018 21:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523137392;
        bh=7wrXeDc//laV/ZMfla++91b0xvXiRxeH3zPJ6Y3reNE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DiJN2xHdZ/cjV+bag/v61Ua9VNsm1ti9qiJC6J7CfHd9Y6/imtWcvFMbCYIsLy51w
         FIxUVNKpRGxDdepOtrFrWeVI0XWGQ6CY9lIlnVHWus2GWMG9zgkiEjF/V3uJU5hxLf
         nG8Yk2rKbpM2lrSYCluK3HYNjsJz2lY4s69/bics=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5E7B605A5
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
 <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
 <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
 <20180406212601.GA1730@saruman>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0f1a4719-9a6f-0df0-7fd9-a25c10e824f5@codeaurora.org>
Date:   Sat, 7 Apr 2018 17:43:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406212601.GA1730@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63426
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

On 4/6/2018 5:26 PM, James Hogan wrote:
> On Fri, Apr 06, 2018 at 02:15:57PM -0400, Sinan Kaya wrote:
>> On 4/5/2018 9:34 PM, Sinan Kaya wrote:
>>> Can we get these merged to 4.17? 
>>>
>>> There was a consensus to fix the architectures having API violation issues.
>>> https://www.mail-archive.com/netdev@vger.kernel.org/msg225971.html
>>>
>>>
>>
>> Any news on the MIPS front? Is this something that Arnd can merge? or does it have
>> to go through the MIPS tree.
> 
> It needs some MIPS input really. I'll try and take a look soon. Thanks
> for the nudge.
> 
>> It feels like the MIPS is dead since nobody replied to me in the last few weeks on
>> a very important topic.
> 
> Not dead, just both maintainers heavily distracted by real life right
> now (which sadly, for me at least, trumps this very important topic) and
> doing the best they can given the circumstances.

Thanks for the reply. Glad to hear somebody cares.

> 
> Cheers
> James
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
