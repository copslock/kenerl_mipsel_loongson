Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2014 01:48:02 +0200 (CEST)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:58000 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854398AbaFCXsAvS29S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jun 2014 01:48:00 +0200
Received: by mail-ig0-f179.google.com with SMTP id hn18so407230igb.0
        for <multiple recipients>; Tue, 03 Jun 2014 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xzblnQfF2n4mB5P9d+62ZHRQImRAruFKKMZ0o+wL/jc=;
        b=Em/Aym5XMcosY7fv47Edq/pwbyDJ6cxyGFSMUNwtSz0n6dROXHCTYjpc/Bs3RFJlp8
         2vYth/dGsGNsN0o1fu4EmjJEX31qDgkK1m9E/wqCTsNdK224Y/GbB2tAb8k5ULv94vl0
         bz/LlDYMP8Aav03++vo7YXUoUyDC3xNB2H6Ffmfju2auHwIoAunILu1ES2cKBH3h5frI
         E482f9dDOz0rzWD0IrlyT3jcX2BcjBSHJOpwtVmDuL/0Uso7G5tBB2PtqUDF01W7A9yC
         dhIU8D6s2SA9Vpdz0Zpy2fyuZ1OBkin2wg0vSGZ3X64iTcxDkykoPteHIcFZJVdPQG49
         mmlg==
X-Received: by 10.50.78.66 with SMTP id z2mr34489071igw.27.1401839274562;
        Tue, 03 Jun 2014 16:47:54 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ri2sm6009956igc.1.2014.06.03.16.47.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 03 Jun 2014 16:47:54 -0700 (PDT)
Message-ID: <538E5EA8.8010907@gmail.com>
Date:   Tue, 03 Jun 2014 16:47:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Huacai Chen <chenhc@lemote.com>, John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 4/8] MIPS: Add NUMA support for Loongson-3
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com> <1397348662-22502-5-git-send-email-chenhc@lemote.com> <20140603224739.GU17197@linux-mips.org>
In-Reply-To: <20140603224739.GU17197@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40427
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

On 06/03/2014 03:47 PM, Ralf Baechle wrote:
[...]
>> --- a/arch/mips/include/asm/addrspace.h
>> +++ b/arch/mips/include/asm/addrspace.h
>> @@ -51,8 +51,14 @@
>>    * Returns the physical address of a CKSEGx / XKPHYS address
>>    */
>>   #define CPHYSADDR(a)		((_ACAST32_(a)) & 0x1fffffff)
>> +
>> +#ifndef CONFIG_NUMA
>>   #define XPHYSADDR(a)		((_ACAST64_(a)) &			\
>>   				 _CONST64_(0x000000ffffffffff))
>> +#else
>> +#define XPHYSADDR(a)		((_ACAST64_(a)) &			\
>> +				 _CONST64_(0x0000ffffffffffff))
>> +#endif
>
> The mask in XPHYSADDR is a function of the processor architecture, not
> imlementation, not NUMA.  The latest version of the MIPS architecture
> permits PABITS to be as large as 49 bits, so the mask should be
> 0x0001ffffffffffff.  Always.
>
>> diff --git a/arch/mips/include/asm/sparsemem.h b/arch/mips/include/asm/sparsemem.h
>> index d2da53c..c001a90 100644
>> --- a/arch/mips/include/asm/sparsemem.h
>> +++ b/arch/mips/include/asm/sparsemem.h
>> @@ -11,7 +11,12 @@
>>   #else
>>   # define SECTION_SIZE_BITS	28
>>   #endif
>> +
>> +#ifdef CONFIG_NUMA
>> +#define MAX_PHYSMEM_BITS	48
>> +#else
>>   #define MAX_PHYSMEM_BITS	35
>> +#endif
>
> Essentially the same comment as for XPHYSADDR above.

Are you saying to change it to 49 unconditionally for all configurations?

That would work for OCTEON too, where we have had to increase it to 42.

What are the implications for kernel data structures if this is set many 
orders of magnitude greater than the actual number of bits used on a system?


>
>    Ralf
>
>
>
