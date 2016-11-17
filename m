Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2016 15:16:59 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:55900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990451AbcKQOQtMqtNo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2016 15:16:49 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DC9C1610;
        Thu, 17 Nov 2016 06:16:43 -0800 (PST)
Received: from [10.1.210.28] (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DADD3F218;
        Thu, 17 Nov 2016 06:16:41 -0800 (PST)
Subject: Re: [RFC PATCH] of: base: add support to get machine model name
To:     Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
References: <1479383450-19183-1-git-send-email-sudeep.holla@arm.com>
 <3670336.mMHByOpDl4@wuerfel> <622ddcbc-69b9-98f2-51f3-e256764ecb93@arm.com>
 <2202339.ajrKjCY7Ro@wuerfel>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <d4839046-49f6-b375-fc64-acf64b450540@arm.com>
Date:   Thu, 17 Nov 2016 14:16:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <2202339.ajrKjCY7Ro@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sudeep.holla@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudeep.holla@arm.com
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



On 17/11/16 14:13, Arnd Bergmann wrote:
> On Thursday, November 17, 2016 2:08:30 PM CET Sudeep Holla wrote:
>> On 17/11/16 13:50, Arnd Bergmann wrote:
>>> On Thursday, November 17, 2016 11:50:50 AM CET Sudeep Holla wrote:
>>>> Currently platforms/drivers needing to get the machine model name are
>>>> replicating the same snippet of code. In some case, the OF reference
>>>> counting is either missing or incorrect.
>>>>
>>>> This patch adds support to read the machine model name either using
>>>> the "model" or the "compatible" property in the device tree root node.
>>>>
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>> I like the idea. One small comment:
>>>
>>
>> Thanks. I prefer it as single patch but it can't be applied to any tree.
>> Any suggestions on handling this patch to fix the warning in -next ?
>>
> The patch that causes the warning is currently in the mmc tree, and I
> don't think it would be good to have your entire patch in there too.
>
> It's probably best to just fix the warning there now by adding another
> open-coded copy of that function, and then apply your patch on top
> for v4.11.

Sure, that's much simpler to deal with for now.

-- 
Regards,
Sudeep
