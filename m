Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2012 22:07:13 +0200 (CEST)
Received: from mail-da0-f49.google.com ([209.85.210.49]:33438 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823102Ab2JZUHM4K0Hy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2012 22:07:12 +0200
Received: by mail-da0-f49.google.com with SMTP id q27so1335239daj.36
        for <multiple recipients>; Fri, 26 Oct 2012 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+rG7qIv0WXUwOIsvxebQ9BHxdXXvQ3DzGAmARhbLsHI=;
        b=LHSQ60zDqShZYtBmO/+dnmT+PzSpWTFOEErgK7F8knk1rgdw/8Bvhj8C1cWUJ9DVPK
         QC8kh32NFLdMLlzFXJEoNWQOmPKBocgIJsGm+QeMkbvUIQVEyTwU+tI3bj6sE3TpWtq+
         KieaY8ejz0q2QBe24DGtqe+EHylZOI+VnurInnuQ+5tKELljmFd4x5vC3FO7TRFZT9h1
         w7IBRpeqhcTEZ2T8qcTfIAmz0gP7NCZ4lAfu85wFpdc7qoZHN35PiU1Un+gZjPFeo4OH
         XkTLf8FjipAnVYp4vCfyrTUAQAdFnF1oyDzk2wQqqZiAmobOUpwhM6uiBQHiClTTtpXR
         FqBQ==
Received: by 10.68.237.167 with SMTP id vd7mr63170563pbc.161.1351282025890;
        Fri, 26 Oct 2012 13:07:05 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ho7sm1640021pbc.3.2012.10.26.13.07.03
        (version=SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 13:07:04 -0700 (PDT)
Message-ID: <508AED66.3040808@gmail.com>
Date:   Fri, 26 Oct 2012 13:07:02 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     shuah.khan@hp.com
CC:     ralf@linux-mips.org, kyungmin.park@samsung.com, arnd@arndb.de,
        andrzej.p@samsung.com, m.szyprowski@samsung.com,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        shuahkhan@gmail.com
Subject: Re: [PATCH RFT RESEND linux-next] mips: dma-mapping: support debug_dma_mapping_error
References: <1351208193.6851.17.camel@lorien2>  <1351267298.4013.12.camel@lorien2> <508ABE1D.5010106@gmail.com> <1351271198.4013.35.camel@lorien2>
In-Reply-To: <1351271198.4013.35.camel@lorien2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/26/2012 10:06 AM, Shuah Khan wrote:
> On Fri, 2012-10-26 at 09:45 -0700, David Daney wrote:
>> On 10/26/2012 09:01 AM, Shuah Khan wrote:
>>> Add support for debug_dma_mapping_error() call to avoid warning from
>>> debug_dma_unmap() interface when it checks for mapping error checked
>>> status. Without this patch, device driver failed to check map error
>>> warning is generated.
>>>
>>> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
>>> ---
>>>    arch/mips/include/asm/dma-mapping.h |    2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
>>> index be39a12..006b43e 100644
>>> --- a/arch/mips/include/asm/dma-mapping.h
>>> +++ b/arch/mips/include/asm/dma-mapping.h
>>> @@ -40,6 +40,8 @@ static inline int dma_supported(struct device *dev, u64 mask)
>>>    static inline int dma_mapping_error(struct device *dev, u64 mask)
>>>    {
>>>    	struct dma_map_ops *ops = get_dma_ops(dev);
>>> +
>>> +	debug_dma_mapping_error(dev, mask);
>>>    	return ops->mapping_error(dev, mask);
>>>    }
>>>
>>>
>>
>> Although this is a start, I don't think it is sufficient.
>>
>> As far as I can tell, there are many missing calls to debug_dma_*() in
>> the various MIPS commone and sub-architecture DMA code.
>>
>> Really you (or someone) needs to look at *all* the functions in
>> arch/mips/asm/dma-mapping.h, and arch/mips/mm/dma-default.c and find
>> places missing a debug_dma_*().
>
> Is it correct to assume that this patch is not needed on MIPS until
> debug_dma interfaces get added to MIPS common and sub-architecture DMA
> code.

No, you have a false predicate here.

debug_dma_* *is* already mostly added.  The problem is that it is 
incomplete.  That is the nature of the problem.  Your patch makes it 
slightly better, but doesn't fully fix the problems.


>
> When I didn't see dma_map_page() in arch/mips/include/asm/dma-mapping.h
> defined, and just an extern, I incorrectly assumed, it is getting picked
> up from <asm-generic/dma-mapping-common.h>, hence the need for this
> patch in the first place.
>
> -- Shuah
>
>
>
