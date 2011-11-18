Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 18:14:37 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:63913 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904127Ab1KRRO2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 18:14:28 +0100
Received: by ggnb1 with SMTP id b1so3243132ggn.36
        for <multiple recipients>; Fri, 18 Nov 2011 09:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=C4wsFfYEn13/ruHNhUKwGkPltcavw8TkzVDcw3e33tc=;
        b=PxZGKV67RXMXM8CEGsYB1B4DjkRyuw7NZsWQ9+AQP+6bN9hF2BzH0LqIpR0HZVmSGq
         Z2rHDnH10wci8R9O91LnJlO0nHYeB38VgJXpzuFnU1z+A13yNPJMNnvSfelJecxm2N2J
         9QO48pa/PC3dgQcq3hqM3PxHspB4LHk2GYpqM=
Received: by 10.236.114.195 with SMTP id c43mr6835470yhh.12.1321636460495;
        Fri, 18 Nov 2011 09:14:20 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id v5sm3703185anf.3.2011.11.18.09.14.18
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 09:14:18 -0800 (PST)
Message-ID: <4EC69269.7060505@gmail.com>
Date:   Fri, 18 Nov 2011 09:14:17 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 2/2] hugetlb: Provide safer dummy values for HPAGE_MASK
 and HPAGE_SIZE
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com> <1321567050-13197-3-git-send-email-ddaney.cavm@gmail.com> <4EC61DB1.3090608@mvista.com>
In-Reply-To: <4EC61DB1.3090608@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15669

On 11/18/2011 12:56 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 18-11-2011 1:57, David Daney wrote:
>
>> From: David Daney<david.daney@cavium.com>
>
>> It was pointed out by David Rientjes that the dummy values for
>> HPAGE_MASK and HPAGE_SIZE are quite unsafe. It they are inadvertently
>> used with !CONFIG_HUGETLB_PAGE, compilation would succeed, but the
>> resulting code would surly not do anything sensible.
>>
>> Place BUG() in the these dummy definitions, as we do in similar
>> circumstances in other places, so any abuse can be easily detected.
>>
>> Since the only sane place to use these symbols when
>> !CONFIG_HUGETLB_PAGE is on dead code paths, the BUG() cause any actual
>> code to be emitted by the compiler.
>
> You mean "doesn't cause"?

Yes.

I mentioned this in a different message to akpm, but I am not sure if I 
should resend the patch with a corrected change log.

David Daney

>
>> Cc: David Rientjes<rientjes@google.com>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>
> WBR, Sergei
>
>
