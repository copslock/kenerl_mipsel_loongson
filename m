Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 10:34:34 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35231 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011509AbbHMIeanh9bh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 10:34:30 +0200
Received: by pacgr6 with SMTP id gr6so33181547pac.2
        for <linux-mips@linux-mips.org>; Thu, 13 Aug 2015 01:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=p6AXR+NvmMDhZ8p6pDTFgqgXpRrWJRcyqd9gad8rVZg=;
        b=KWeEXNWI4JIE6ifomp+COH0wRV21elKmJjDwi5uAiyrtzAP8zkJKDPF4/8VyDIALaf
         TyARgB0b9M4rAvAoPWNiKAoAunRDkC/+knJzRrz/WwmR5gXKfsjnEqvANhp7ixf/c7jk
         IZfraKxPehWwlT7UgWmwxTgTIwUgkWUBkIDqmbgI3vVhFTsVXd4IlN3lpIyQhavvjkup
         zKayrFSf1NfrQQiDHYdcjRLUJCZy4DFB4JWrGEGYtgkttzqFp5T81tLBCroeMySOlNIx
         IfLQFW+SUqNoi8nLX9Lt0RBeFQKGsYn0k2rTaXKj0939HhLm8UsOi255MZDq9xCEO3aw
         qPUQ==
X-Gm-Message-State: ALoCoQncxUEbcCMO/wMAHEpp6HDxGTYFjYWM//tbCtiKdJWKIlgVuS3aFFj+hOntPw4pwrnEXufG
X-Received: by 10.66.218.42 with SMTP id pd10mr76570230pac.106.1439454864573;
        Thu, 13 Aug 2015 01:34:24 -0700 (PDT)
Received: from [10.10.1.18] ([104.207.83.5])
        by smtp.googlemail.com with ESMTPSA id rg6sm1703033pdb.40.2015.08.13.01.34.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 01:34:23 -0700 (PDT)
Message-ID: <55CC5685.4000807@linaro.org>
Date:   Thu, 13 Aug 2015 16:34:13 +0800
From:   Hanjun Guo <hanjun.guo@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     mark.rutland@arm.com, linux-mips@linux-mips.org,
        david.daney@cavium.com, netdev@vger.kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, tomasz.nowicki@linaro.org,
        rrichter@cavium.com, linux-acpi@vger.kernel.org,
        ddaney.cavm@gmail.com, sgoutham@cavium.com,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] net: thunder: Add ACPI support.
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com> <20150811.114908.1384923604512568161.davem@davemloft.net> <55CA5567.9010002@caviumnetworks.com> <20150812152337.GB5393@e104818-lin.cambridge.arm.com> <55CB67E4.8030001@caviumnetworks.com>
In-Reply-To: <55CB67E4.8030001@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <hanjun.guo@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hanjun.guo@linaro.org
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

On 08/12/2015 11:36 PM, David Daney wrote:
> On 08/12/2015 08:23 AM, Catalin Marinas wrote:
>> On Tue, Aug 11, 2015 at 01:04:55PM -0700, David Daney wrote:
>>> On 08/11/2015 11:49 AM, David Miller wrote:
>>>> From: David Daney <ddaney.cavm@gmail.com>
>>>> Date: Mon, 10 Aug 2015 17:58:35 -0700
>>>>
>>>>> Change from v1:  Drop PHY binding part, use fwnode_property* APIs.
>>>>>
>>>>> The first patch (1/2) rearranges the existing code a little with no
>>>>> functional change to get ready for the second.  The second (2/2) does
>>>>> the actual work of adding support to extract the needed information
>>>> >from the ACPI tables.
>>>>
>>>> Series applied.
>>>
>>> Thank you very much.
>>>
>>>> In the future it might be better structured to try and get the OF
>>>> node, and if that fails then try and use the ACPI method to obtain
>>>> these values.
>>>
>>> Our current approach, as you can see in the patch, is the opposite.
>>> If ACPI
>>> is being used, prefer that over the OF device tree.
>>>
>>> You seem to be recommending precedence for OF.  It should be consistent
>>> across all drivers/sub-systems, so do you really think that OF before
>>> ACPI
>>> is the way to go?
>>
>> On arm64 (unless you use a vendor kernel), DT takes precedence over ACPI
>> if both arm provided to the kernel (and it's a fair assumption given
>> that ACPI on ARM is still in the early days). You could also force ACPI
>> with acpi=force on the kernel cmd line and the arch code will not
>> unflatten the DT even if it is provided, therefore is_of_node(fwnode)
>> returning false.

Yes. on the other hand, if no DT is provided, will try ACPI even
if no acpi=force on the kernel cmd line.

>>
>> I haven't looked at your driver in detail but something like AMD's
>> xgbe_probe() uses a single function for both DT and ACPI with
>> device_property_read_*() functions getting the information from the
>> correct place in either case. The ACPI vs DT precedence is handled by
>> the arch boot code, we never mix the two and confuse the drivers.
>>
>
> My long term plan is to create something like
> firmware_get_mac_address(), that would encapsulate  of_get_mac_address()
> and the ACPI equivalent.
>
> Same for firmware_phy_find_device().

I'm very keen on seeing that happens :)

Thanks
Hanjun
