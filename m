Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 17:51:27 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45413 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825663Ab2KAQvXbmXRe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2012 17:51:23 +0100
Received: by mail-pb0-f49.google.com with SMTP id xa7so1732503pbc.36
        for <linux-mips@linux-mips.org>; Thu, 01 Nov 2012 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QQ22acoo2fc6grFQ98slHv3Wr4wH2Lqg70rd5umPm5Y=;
        b=pGshCvQMZ8Zdv/yDxAwqItCPJi+2dLWiyTriIyS2rxO0aG70peVPKWeizBC3Gpslt8
         zqnR6pQJduiRe/YKH9TRM+nTjMRQu30+e42R3VSNdRs8PEIyX1UZTh8ODVHYMnOeaPUl
         sm5w2lg/2xsihbnk1DDXs0HOL/47zAHmBE2OivVedbnaQbU6jpJ2M//xJMcniY0nqD3w
         PlPG/bhopio0U0bePBBK7jRG9ID/9VkDlbqwLa9V5/b5j6PX8Sbl/khNSorHqlsmWgyq
         VqukBadKbqwIFKYRTSUgZ0ROcTLX2JO+TJV7kvU1nhNACa4QhgrzFyD4i8SaKBGjkel7
         yXvg==
Received: by 10.68.137.234 with SMTP id ql10mr62395478pbb.158.1351788676939;
        Thu, 01 Nov 2012 09:51:16 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ty4sm4266195pbc.57.2012.11.01.09.51.10
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 09:51:13 -0700 (PDT)
Message-ID: <5092A87E.60907@gmail.com>
Date:   Thu, 01 Nov 2012 09:51:10 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Avi Kivity <avi@redhat.com>, Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 02/20] KVM/MIPS32: Arch specific KVM data structures.
References: <54507365-0EF7-480A-8A54-75E12B3677D9@kymasys.com> <50928F87.4060309@redhat.com>
In-Reply-To: <50928F87.4060309@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34849
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

On 11/01/2012 08:04 AM, Avi Kivity wrote:
> On 10/31/2012 05:18 PM, Sanjay Lal wrote:
>>
>> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
>> ---
>>   arch/mips/include/asm/kvm.h      |  58 ++++
>>   arch/mips/include/asm/kvm_host.h | 672 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 730 insertions(+)
>>   create mode 100644 arch/mips/include/asm/kvm.h
>>   create mode 100644 arch/mips/include/asm/kvm_host.h
>>
>> diff --git a/arch/mips/include/asm/kvm.h b/arch/mips/include/asm/kvm.h
>> new file mode 100644
>> index 0000000..39bb715
>> --- /dev/null
>> +++ b/arch/mips/include/asm/kvm.h
>> @@ -0,0 +1,58 @@
>> +/*
>> +* This file is subject to the terms and conditions of the GNU General Public
>> +* License.  See the file "COPYING" in the main directory of this archive
>> +* for more details.
>> +*
>> +*
>> +* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
>> +* Authors: Sanjay Lal <sanjayl@kymasys.com>
>> +*/
>> +
>> +
>> +#ifndef __LINUX_KVM_MIPS_H
>> +#define __LINUX_KVM_MIPS_H
>> +
>> +#include <linux/types.h>
>> +
>> +#define __KVM_MIPS
>> +
>> +#define N_MIPS_COPROC_REGS      32
>> +#define N_MIPS_COPROC_SEL   	8
>> +
>> +/* for KVM_GET_REGS and KVM_SET_REGS */
>> +struct kvm_regs {
>> +    __u32 gprs[32];
>> +    __u32 hi;
>> +    __u32 lo;
>> +    __u32 pc;
>> +
>> +    ulong cp0reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
>> +};
>
> ulong changes size in 64-bit archs, requiring compat translations when
> issuing 32-bit syscalls on a 64-bit kernel.  I don't know MIPS enough to
> know whether that's a useful scenario.

For a 32-bit machine all the registers are 32-bits wide.

For a 64-bit machine, they are ... yes 64-bits wide.

Since this entire structure seems to be useless for a 64-bit 
implementation just use __u32 for everything.

This does beg the question though, how will you handle 64-bit machines?

Why not name the entire structure something like struct kvm_regs_mips32? 
  Then for the 64-bit implementation use struct kvm_regs_mips64.

I haven't studied it enough to know if you can do this.  if it needs to 
be called exactly 'struct kvm_regs', then you have to make everything 
__u64 and only populate the lower halves of the fields for mips32. 
Watch out for endian issues in this case.

David Daney
