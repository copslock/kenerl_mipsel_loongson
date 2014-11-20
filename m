Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 14:57:51 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:57683 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014097AbaKTN5tjLfFG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Nov 2014 14:57:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id EA60C2E2DB;
        Thu, 20 Nov 2014 14:57:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id e2NlYEPU-W12; Thu, 20 Nov 2014 14:57:41 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 4ACE52E2A6;
        Thu, 20 Nov 2014 14:57:41 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 348D1110B;
        Thu, 20 Nov 2014 14:57:41 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 28B67BD4;
        Thu, 20 Nov 2014 14:57:41 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id 26BE13E125;
        Thu, 20 Nov 2014 14:57:41 +0100 (CET)
Received: from [10.94.49.1] (10.94.49.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Thu, 20 Nov 2014 14:57:40
 +0100
Message-ID: <546DF354.6030803@axis.com>
Date:   Thu, 20 Nov 2014 14:57:40 +0100
From:   Niklas Svensson <niklas.svensson@axis.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: mips-cm: CM regions are disabled at boot
References: <1416486540-28681-1-git-send-email-niklass@axis.com> <20141120123434.GW1127@pburton-laptop>
In-Reply-To: <20141120123434.GW1127@pburton-laptop>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <niklas.svensson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niklas.svensson@axis.com
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

On 11/20/2014 01:34 PM, Paul Burton wrote:
> On Thu, Nov 20, 2014 at 01:29:00PM +0100, Niklas Svensson wrote:
>> Each CM_REGION_TARGET is set to disabled at boot,
> 
> That part is true...
> 
>> so there is no need to disable the matching
>> CM_GCR_REG explicitly.
> 
> ...however there is no guarantee that the bootloader, or another kernel,
> or some other piece of code didn't program the registers differently
> before Linux starts. So I believe this patch to be incorrect.


That is the reason for this patch. This will overwrite settings written by the bootloader.

Say if the bootloader sets up an iocu, then these writes will clear those settings.

> 
> Thanks,
>     Paul
> 
>>
>> Signed-off-by: Niklas Svensson <niklass@axis.com>
>> ---
>>  arch/mips/kernel/mips-cm.c | 10 ----------
>>  1 file changed, 10 deletions(-)
>>
>> diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
>> index f76f7a0..a4bbfd9 100644
>> --- a/arch/mips/kernel/mips-cm.c
>> +++ b/arch/mips/kernel/mips-cm.c
>> @@ -104,16 +104,6 @@ int mips_cm_probe(void)
>>  	base_reg |= CM_GCR_BASE_CMDEFTGT_MEM;
>>  	write_gcr_base(base_reg);
>>  
>> -	/* disable CM regions */
>> -	write_gcr_reg0_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
>> -	write_gcr_reg0_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
>> -	write_gcr_reg1_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
>> -	write_gcr_reg1_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
>> -	write_gcr_reg2_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
>> -	write_gcr_reg2_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
>> -	write_gcr_reg3_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
>> -	write_gcr_reg3_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
>> -
>>  	/* probe for an L2-only sync region */
>>  	mips_cm_probe_l2sync();
>>  
>> -- 
>> 2.1.3
>>
