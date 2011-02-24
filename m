Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2011 19:21:47 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56261 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491010Ab1BXSVp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Feb 2011 19:21:45 +0100
Received: by pzk7 with SMTP id 7so137119pzk.36
        for <linux-mips@linux-mips.org>; Thu, 24 Feb 2011 10:21:38 -0800 (PST)
Received: by 10.142.109.20 with SMTP id h20mr878616wfc.420.1298571698675;
        Thu, 24 Feb 2011 10:21:38 -0800 (PST)
Received: from [192.168.2.3] ([118.95.25.226])
        by mx.google.com with ESMTPS id o11sm12642098wfa.12.2011.02.24.10.21.36
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 10:21:37 -0800 (PST)
Message-ID: <4D66A1AC.2090007@nulltrace.org>
Date:   Thu, 24 Feb 2011 23:51:32 +0530
From:   Himanshu Chauhan <hschauhan@nulltrace.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@paralogos.com>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: Kernel link address assumption
References: <4D669FCE.8000601@nulltrace.org> <4D66A08F.7050605@paralogos.com>
In-Reply-To: <4D66A08F.7050605@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <hschauhan@nulltrace.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hschauhan@nulltrace.org
Precedence: bulk
X-list: linux-mips

On Thursday 24 February 2011 11:46 PM, Kevin D. Kissell wrote:
> On 02/24/11 10:13, Himanshu Chauhan wrote:
>> Hi,
>>
>> Does Linux kernel for MIPS assumes that its link address is always in 
>> Kseg0?
>> What if I change the link address to somewhere in useg?

> Your page fault handlers will be in for an interesting time. ;o)
>
> What you describe can be, and is done, for virtualized kernels running 
> on top
> of a hypervisor, but there's a bit more involved than just changing 
> the link address.
Hi Kevin,

You just caught that. Thats what I am trying to evaluate. What all I 
would need to do apart from changing the link address. I am working on a 
bare metal hypervisor for MIPS architecture.

Any pointers?

Regards
Himanshu
