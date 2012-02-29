Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Feb 2012 23:18:47 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:53472 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903792Ab2B2WSk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Feb 2012 23:18:40 +0100
Received: by ggnf2 with SMTP id f2so3703470ggn.36
        for <multiple recipients>; Wed, 29 Feb 2012 14:18:34 -0800 (PST)
Received-SPF: pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.178.65 as permitted sender) client-ip=10.236.178.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.178.65 as permitted sender) smtp.mail=ddaney.cavm@gmail.com; dkim=pass header.i=ddaney.cavm@gmail.com
Received: from mr.google.com ([10.236.178.65])
        by 10.236.178.65 with SMTP id e41mr3265010yhm.130.1330553914296 (num_hops = 1);
        Wed, 29 Feb 2012 14:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZlgRfTw8aCL8+uEaYUbvVOyDrGCupQ37exnzxaOsxbY=;
        b=FlcRWnz7PklMa30sUfoq1Ku8uPaNeSm+gfGfwM58c5rkTEOKJPmClPAy9hGVgLAWjU
         OxZo3cBDmU8+Y6HeVpi3YYy/7/4hyRMt/bqjcGu70RS9pnm60/WxXYjrCyM+vngbfn+8
         wwPdBzcG/M4ICOm3f2sCoGXz8PYoEtGqFyOVw=
Received: by 10.236.178.65 with SMTP id e41mr2580142yhm.130.1330553914238;
        Wed, 29 Feb 2012 14:18:34 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id e45sm59363102yhk.2.2012.02.29.14.18.32
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 14:18:33 -0800 (PST)
Message-ID: <4F4EA437.1040501@gmail.com>
Date:   Wed, 29 Feb 2012 14:18:31 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     David Miller <davem@davemloft.net>, grant.likely@secretlab.ca,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] of: Make of_find_node_by_path() traverse /aliases
 for relative paths.
References: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com>   <1330543264-18103-3-git-send-email-ddaney.cavm@gmail.com> <20120229.153633.249570825230282737.davem@davemloft.net> <4F4E99E2.2000607@cavium.com>
In-Reply-To: <4F4E99E2.2000607@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Grant and others,

Really this patch 2/2 is not so critical for me.  I am using it, but can 
(and perhaps should) avoid using of_find_node_by_path() altogether, thus 
making the patch unneeded.

If you would like, we can drop this one, but I would still very much 
like '[PATCH v6 1/2] of/lib: Allow scripts/dtc/libfdt to be used from 
kernel code' to be merged.

Do you want me to send the first patch separately, or could you just 
'cherry-pick' it from this set?

Thanks,
David Daney


On 02/29/2012 01:34 PM, David Daney wrote:
> On 02/29/2012 12:36 PM, David Miller wrote:
>> From: David Daney<ddaney.cavm@gmail.com>
>> Date: Wed, 29 Feb 2012 11:21:04 -0800
>>
>>> Currently all paths passed to of_find_node_by_path() must begin with a
>>> '/', indicating a full path to the desired node.
>>>
>>> Augment the look-up code so that if a path does *not* begin with '/',
>>> the path is used as the name of an /aliases property. The value of
>>> this alias is then used as the full node path to be found.
>>>
>>> Signed-off-by: David Daney<david.daney@cavium.com>
>>
>> But as the caller you sure as hell know whether you have a "/"
>> prefixed name or not.
>
> Yes, worst case we could just examine the first character of the string.
>
>>
>> Why complicate an incredibly well designed and simple function for
>> something you can create another interface for?
>>
>
> Because in this message:
>
> http://www.linux-mips.org/archives/linux-mips/2011-02/msg00147.html
>
> Grant explicitly asked me to do it this way when he said:
>
> of_find_node_by_path() needs to be fixed to also accept alias
> values so that a string that starts with a '/' is a full path, but
> no leading '/' means start with an alias. This code will lose a
> level of indentation if you can make that change to the common
> code.
>
> And then in follow ups to that conversation, we eventually came up
> with this patch.
>
> If you find it particularly objectionable, convince Grant to NACK the
> patch (but please keep me CCed on the conversation), and I will open
> code the equivalent in my drivers.
>
> Thanks,
> David Daney
>
