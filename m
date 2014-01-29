Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2014 18:10:12 +0100 (CET)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:47490 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827297AbaA2RKJvXf0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jan 2014 18:10:09 +0100
Received: by mail-lb0-f171.google.com with SMTP id c11so1722966lbj.30
        for <linux-mips@linux-mips.org>; Wed, 29 Jan 2014 09:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qV6TYo3TThC1VASnHTBlbq5vzJzuIepnQ/2S2+asOvg=;
        b=WHj8xnJ2TafYmTXzPTgC/fHHNKiJ2/IItKzn08U862is5JJPwmsRIiASXT9Qxliemv
         h67BxKYPJgFc6VziCcvwL4s2mZkqww1H9ETAkoWl65zkchE3CtJ8ltaUslqIUgev0MQV
         oWaULlGMsdqFGe9rfEngyyIBXZNh52VB++dq4DCN8TfpMn9ADZO2vOj6yV67vRbUkMbN
         trtMsT1aLcOH6Uz49zBCUTYmDgt7T9h8Itmb8FDx8lR35FP1OfgsKuX3UFWCnbXgZ1uR
         mv5Y4gjxCl/Cob2ON4v8SPd15O4KvWCHW1Q+7IFDgIZd1OHAejGGawyCd8nPLPAnnGOe
         hhog==
X-Gm-Message-State: ALoCoQl1BbUM1BbyGd492S8VPg2LB/EX65rfuS8x9GetbiU4Pr4zlvHUvKlRkVjyDIux+8hcO2nE
X-Received: by 10.152.5.199 with SMTP id u7mr6282309lau.16.1391015404008;
        Wed, 29 Jan 2014 09:10:04 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp85-140-141-243.pppoe.mtu-net.ru. [85.140.141.243])
        by mx.google.com with ESMTPSA id s9sm4369837laj.0.2014.01.29.09.10.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 09:10:03 -0800 (PST)
Message-ID: <52E94404.8050303@cogentembedded.com>
Date:   Wed, 29 Jan 2014 21:10:12 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: mm: c-r4k: Detect instruction cache aliases
References: <1391001009-19580-1-git-send-email-markos.chandras@imgtec.com> <52E9029C.80300@cogentembedded.com> <52E90525.7010704@imgtec.com>
In-Reply-To: <52E90525.7010704@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 01/29/2014 04:41 PM, Markos Chandras wrote:

>>> The *Aptiv cores can use the CONF7/IAR bit to detect if the core
>>> has hardware support to remove instruction cache aliasing.

>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>> This patch is for the upstream-sfr/mips-for-linux-next tree
>> [...]

>>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>>> index 13b549a..e790524 100644
>>> --- a/arch/mips/mm/c-r4k.c
>>> +++ b/arch/mips/mm/c-r4k.c
>>> @@ -1110,7 +1110,10 @@ static void probe_pcache(void)
>>>       case CPU_PROAPTIV:
>>>           if (current_cpu_type() == CPU_74K)
>>>               alias_74k_erratum(c);
>>> -        if ((read_c0_config7() & (1 << 16))) {
>>> +        if (!(read_c0_config7() & MIPS_CONF7_IAR))
>>> +            if (c->icache.waysize > PAGE_SIZE)

>>     Why not fold these to a single *if*?

> I suppose I could do that. Thanks

>>> +                c->icache.flags |= MIPS_CACHE_ALIASES;
>>> +        if (read_c0_config7() & MIPS_CONF7_AR) {

>>     You didn't document this change. Ideally, it should be in a separate
>> patch.

> Nothing has changed. Instead of using the '16' magic value, I just documented
> that bit along with the IAR one.

    You should have noted that in the changelog, at least.

WBR, Sergei
