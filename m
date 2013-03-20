Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 00:12:47 +0100 (CET)
Received: from mail-da0-f47.google.com ([209.85.210.47]:47763 "EHLO
        mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834922Ab3CTXMquW-nr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Mar 2013 00:12:46 +0100
Received: by mail-da0-f47.google.com with SMTP id s35so1258182dak.6
        for <linux-mips@linux-mips.org>; Wed, 20 Mar 2013 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=WnooAuy1Brv3FVCMkwXeT4cjo78YSo1yaEAWRV9VQMo=;
        b=bSjTW2UcKj2WyPlD4Oz2gL8BrB03iTzMrlgZQKFbsO2oi6nf+MSFCAViBzAZF7fN+1
         hqTeGru0j70GAZVK9OfJs9MuFTu3NEq5kQv8Yasx7rgExG4HODsh1B5SAo4EDmZ3XnW7
         marGAvHAozuRiKGqj7Cd/7o/adQGGcM2xx4vmqztRncKdwyfyMSjS+CmJBZpNrlpoQ7M
         buGms74uwRIBh+DqFcp2hYGnf5W3RJzFdqEMzmq0Eu3SnMAShN4lNl6KxMB3VjjGc7Wi
         2FfZzCIrCCKnKtUVolHM5kZ/kDAQYo/lsWJ0e2oNvbwPrR1sbr/d/uBHzipPJGavCkYm
         CVWQ==
X-Received: by 10.68.135.136 with SMTP id ps8mr11642161pbb.2.1363821159997;
        Wed, 20 Mar 2013 16:12:39 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id f4sm3625657pbc.6.2013.03.20.16.12.38
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 16:12:39 -0700 (PDT)
Message-ID: <514A4265.2080709@gmail.com>
Date:   Wed, 20 Mar 2013 16:12:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
CC:     linux-mips@linux-mips.org
Subject: Re: MIPS: Add dependencies for HAVE_ARCH_TRANSPARENT_HUGEPAGE
References: <1362257499.3768.141.camel@deadeye.wl.decadent.org.uk> <1362370641.3768.291.camel@deadeye.wl.decadent.org.uk> <kiddfo$82s$1@ger.gmane.org>
In-Reply-To: <kiddfo$82s$1@ger.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35923
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

On 03/20/2013 03:33 PM, Sebastian Gottschall wrote:
> Am 04.03.2013 05:17, schrieb Ben Hutchings:
>> The MIPS implementation of transparent huge-pages (THP) is 64-bit only,
>> and of course also requires that the CPU supports huge-pages.
>>
>> Currently it's entirely possible to enable THP in other configurations,
>> which then fail to build due to pfn_pmd() not being defined.
>>
>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>> Cc: David Daney <david.daney@cavium.com>
>> ---
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -19,7 +19,7 @@ config MIPS
>>       select HAVE_KRETPROBES
>>       select HAVE_DEBUG_KMEMLEAK
>>       select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>> -    select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>> +    select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES
>> && 64BIT
>>       select RTC_LIB if !MACH_LOONGSON
>>       select GENERIC_ATOMIC64 if !64BIT
>>       select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>
> why? the mips32 74k platform (broadcom bcm4706 for instance) does
> support huge pages.

The hardware may support pages larger than 64K, but does the Linux 
kernel?  I think not.

> and some of these devices are also using highmem for
> accessing more than 128mb ram (which is totally broken in all current
> kernels too and causing filesystem corruptions)
> i was able to fix the highmem problem using a patch which was submitted
> but never taken into the mainline, but i just was able to get thb
> partially to work on mips32. but i think it would be possible to support
> this on mips32 as well. so why leaving it out?

As they say... Patches are welcome.  If you get Linux HUGE pages working 
for 32-bit kernels send a patch to enable the transparent variety as well.

David Daney
