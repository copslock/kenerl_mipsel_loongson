Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 11:32:50 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:40161 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993003AbeHFJcqfVPKy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Aug 2018 11:32:46 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 02:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="70509848"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.42]) ([10.226.39.42])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2018 02:32:40 -0700
Subject: Re: [PATCH v2 08/18] serial: intel: Get serial id from dts
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-9-songjun.wu@linux.intel.com>
 <20180803054304.GA2214@kroah.com>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <198e6e8a-cb42-f6b5-b1c0-e3f0bfd3124a@linux.intel.com>
Date:   Mon, 6 Aug 2018 17:32:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180803054304.GA2214@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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



On 8/3/2018 1:43 PM, Greg Kroah-Hartman wrote:
> On Fri, Aug 03, 2018 at 11:02:27AM +0800, Songjun Wu wrote:
>> Get serial id from dts.
>>
>> "#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
>> macro is defined in lantiq_soc.h.
>> lantiq_soc.h is in arch path for legacy product support.
>>
>> arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
>>
>> If "#ifdef preprocessor" is changed to
>> "if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
>> code using LTQ_EARLY_ASC is compiled.
>> Compilation will fail for no LTQ_EARLY_ASC defined.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/tty/serial/lantiq.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
>> index 044128277248..836ca51460f2 100644
>> --- a/drivers/tty/serial/lantiq.c
>> +++ b/drivers/tty/serial/lantiq.c
>> @@ -6,6 +6,7 @@
>>    * Copyright (C) 2007 Felix Fietkau <nbd@openwrt.org>
>>    * Copyright (C) 2007 John Crispin <john@phrozen.org>
>>    * Copyright (C) 2010 Thomas Langer, <thomas.langer@lantiq.com>
>> + * Copyright (C) 2018 Intel Corporation.
> Your changes here do not warrent the addition of a copyright line, don't
> you agree?  If not, please get a signed-off-by from your corporate
> lawyer who does this this is warrented when you resend this patch.
>
> thanks,
>
> greg k-h
>
Thanks.
The copyright line will be removed when we resend this patch.
