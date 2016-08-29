Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Aug 2016 13:59:22 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:36258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992185AbcH2L7OmS7uA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Aug 2016 13:59:14 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F5194E4C7;
        Mon, 29 Aug 2016 11:59:06 +0000 (UTC)
Received: from [10.36.112.50] (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7TBx1Bg020323
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 29 Aug 2016 07:59:03 -0400
Subject: Re: [PATCH 5/5] mips/kvm: Audit and remove any unnecessary uses of
 module.h
To:     James Hogan <james.hogan@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
References: <20160821195817.5802-1-paul.gortmaker@windriver.com>
 <20160821195817.5802-6-paul.gortmaker@windriver.com>
 <20160822121415.GB13232@jhogan-linux.le.imgtec.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72d97cd8-4417-1c94-dea7-0194f69ea130@redhat.com>
Date:   Mon, 29 Aug 2016 13:59:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160822121415.GB13232@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 29 Aug 2016 11:59:06 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 22/08/2016 14:14, James Hogan wrote:
> On Sun, Aug 21, 2016 at 03:58:17PM -0400, Paul Gortmaker wrote:
>> Historically a lot of these existed because we did not have
>> a distinction between what was modular code and what was providing
>> support to modules via EXPORT_SYMBOL and friends.  That changed
>> when we forked out support for the latter into the export.h file.
>>
>> This means we should be able to reduce the usage of module.h
>> in code that is obj-y Makefile or bool Kconfig.  In the case of
>> kvm where it is modular, we can extend that to also include files
>> that are building basic support functionality but not related
>> to loading or registering the final module; such files also have
>> no need whatsoever for module.h
>>
>> The advantage in removing such instances is that module.h itself
>> sources about 15 other headers; adding significantly to what we feed
>> cpp, and it can obscure what headers we are effectively using.
>>
>> Since module.h was the source for init.h (for __init) and for
>> export.h (for EXPORT_SYMBOL) we consider each instance for the
>> presence of either and replace as needed.  In this case, we did
>> not need to add either to any files.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
>> Cc: James Hogan <james.hogan@imgtec.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: kvm@vger.kernel.org
>> Cc: linux-mips@linux-mips.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Thanks, looks good and builds fine with KVM enabled for me.
> 
> Acked-by: James Hogan <james.hogan@imgtec.com>

Please merge through the MIPS tree.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

> Cheers
> James
> 
>> ---
>>  arch/mips/kvm/commpage.c  | 1 -
>>  arch/mips/kvm/dyntrans.c  | 1 -
>>  arch/mips/kvm/emulate.c   | 1 -
>>  arch/mips/kvm/interrupt.c | 1 -
>>  arch/mips/kvm/trap_emul.c | 1 -
>>  5 files changed, 5 deletions(-)
>>
>> diff --git a/arch/mips/kvm/commpage.c b/arch/mips/kvm/commpage.c
>> index a36b77e1705c..f43629979a0e 100644
>> --- a/arch/mips/kvm/commpage.c
>> +++ b/arch/mips/kvm/commpage.c
>> @@ -12,7 +12,6 @@
>>  
>>  #include <linux/errno.h>
>>  #include <linux/err.h>
>> -#include <linux/module.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/fs.h>
>>  #include <linux/bootmem.h>
>> diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
>> index d280894915ed..b36c8ddc03ea 100644
>> --- a/arch/mips/kvm/dyntrans.c
>> +++ b/arch/mips/kvm/dyntrans.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/err.h>
>>  #include <linux/highmem.h>
>>  #include <linux/kvm_host.h>
>> -#include <linux/module.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/fs.h>
>>  #include <linux/bootmem.h>
>> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
>> index e788515f766b..68fd666f8cb9 100644
>> --- a/arch/mips/kvm/emulate.c
>> +++ b/arch/mips/kvm/emulate.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/err.h>
>>  #include <linux/ktime.h>
>>  #include <linux/kvm_host.h>
>> -#include <linux/module.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/fs.h>
>>  #include <linux/bootmem.h>
>> diff --git a/arch/mips/kvm/interrupt.c b/arch/mips/kvm/interrupt.c
>> index ad28dac6b7e9..e88403b3dcdd 100644
>> --- a/arch/mips/kvm/interrupt.c
>> +++ b/arch/mips/kvm/interrupt.c
>> @@ -11,7 +11,6 @@
>>  
>>  #include <linux/errno.h>
>>  #include <linux/err.h>
>> -#include <linux/module.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/fs.h>
>>  #include <linux/bootmem.h>
>> diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
>> index 091553942bcb..21d80274ccff 100644
>> --- a/arch/mips/kvm/trap_emul.c
>> +++ b/arch/mips/kvm/trap_emul.c
>> @@ -11,7 +11,6 @@
>>  
>>  #include <linux/errno.h>
>>  #include <linux/err.h>
>> -#include <linux/module.h>
>>  #include <linux/vmalloc.h>
>>  
>>  #include <linux/kvm_host.h>
>> -- 
>> 2.8.4
>>
