Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 18:52:50 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:53656 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903628Ab2DIQwg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 18:52:36 +0200
Received: by yenm10 with SMTP id m10so2144231yen.36
        for <linux-mips@linux-mips.org>; Mon, 09 Apr 2012 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Or3FR2dj3bWcMvWyhodj0Otlmnm+BD8D3wDpNWxeEMo=;
        b=kyUT25VaIjMGkCBZfagNq5pSHrzpnYp/8YdBaMH+RAlpwYz3diRNaOKkotTs/kWoRm
         X/yAUn+uY7yhwvwhePP1PhZhSuLU9KpYK2cqt1NEsWFd4uLy1uFhHPy9rRoneWDQf5z3
         TkUQu7W8pDKxFST1BxAh4BRo8Y2fsTuHAmcgDCs0dTL3t7+z7vIW+77xrQKsmviRjJj/
         a/YwrPQeydakutjNa5uM/lARdzSLFTxfQ20i+cOJ8DqCQCCaSSHSGm9XrZxDDUBMp6j+
         LEX6KxdN02eYOaHT6SogG/eFl5eoIdLfEVNMLVhXHv9KLmx7WVMpo4yOMKxjYCUZnRAw
         FRbQ==
Received: by 10.60.27.38 with SMTP id q6mr11834498oeg.20.1333990350768;
        Mon, 09 Apr 2012 09:52:30 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id r8sm13140952oer.6.2012.04.09.09.52.28
        (version=SSLv3 cipher=OTHER);
        Mon, 09 Apr 2012 09:52:29 -0700 (PDT)
Message-ID: <4F8313CB.3020105@gmail.com>
Date:   Mon, 09 Apr 2012 09:52:27 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq/irq_domain: Quit ignoring error returns from irq_alloc_desc_from().
References: <1333669933-25267-1-git-send-email-ddaney.cavm@gmail.com> <4F7E64E4.3080509@gmail.com> <4F7F1BDD.4070205@gmail.com> <20120406235607.DCCD53E15E9@localhost>
In-Reply-To: <20120406235607.DCCD53E15E9@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/06/2012 04:56 PM, Grant Likely wrote:
> On Fri, 06 Apr 2012 09:37:49 -0700, David Daney<ddaney.cavm@gmail.com>  wrote:
>> On 04/05/2012 08:37 PM, Rob Herring wrote:
>>> On 04/05/2012 06:52 PM, David Daney wrote:
>>>> From: David Daney<david.daney@cavium.com>
>>>> @@ -380,14 +381,14 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>>>>    	hint = hwirq % irq_virq_count;
>>>>    	if (hint == 0)
>>>>    		hint++;
>>>> -	virq = irq_alloc_desc_from(hint, 0);
>>>
>>> You are not looking at mainline. hint was removed in later versions, and
>>> the referenced commit ids don't exist.
>>
>> Please look at Linus' tree before making incorrect statements about
>> whether or not code exists on the 'mainline'
>
> Rob is indeed mistaken here, but please let's keep things civil.

Sorry about that.  You are correct that it is not acceptable.

David Daney
