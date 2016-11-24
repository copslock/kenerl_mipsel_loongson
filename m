Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2016 10:14:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63800 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993008AbcKXJOSD88JG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Nov 2016 10:14:18 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 94A696BD6DF13;
        Thu, 24 Nov 2016 09:14:09 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 24 Nov
 2016 09:14:11 +0000
Subject: Re: [PATCH 2/5] MIPS: Fix vmlinux.64 target for CONFIG_RELOCATABLE
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <6f8e21bd-ca22-5866-83dc-d70e4e10842b@cavium.com>
 <9FCBB1D1936B2F4DB2DD02BA3957FB504CF9EBF8@HHMAIL01.hh.imgtec.org>
 <a8bbc895-6069-a14b-c5de-52af655adc6d@cavium.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <62830a9b-ef2b-8c68-c115-2e53657cba07@imgtec.com>
Date:   Thu, 24 Nov 2016 09:14:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <a8bbc895-6069-a14b-c5de-52af655adc6d@cavium.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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



On 23/11/16 12:15, Steven J. Hill wrote:
> On 11/22/2016 03:05 PM, Matt Redfearn wrote:
>> Please could you see if https://patchwork.linux-mips.org/patch/14554/ fixes this issue?
>>
> Hey Matt.
>
> Unfortunately when objcopy runs, I get a segfault and my image is
> corrupted. I can send you the output when I add the 'V=1' flag if
> you would like.
>
> Steve

Hi Steve,
 From your output it looks like th relocs tool has not been run before 
the objcopy is attempted. As the comment in the original code said, 
objcopy has issues copying the relocs so they have to be removed by the 
tool before that is done.
What version kernel are your patches based on? The commit that I 
referenced in the patch (fbe6e37dab97) is only present in v4.9-rc1 
onwards. Without that commit this patch will not work.

Thanks,
Matt
