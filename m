Return-Path: <SRS0=1uEU=QB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519F0C282C0
	for <linux-mips@archiver.kernel.org>; Fri, 25 Jan 2019 07:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A809218D9
	for <linux-mips@archiver.kernel.org>; Fri, 25 Jan 2019 07:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfAYHn1 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:43:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbfAYHn0 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 25 Jan 2019 02:43:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B8728DC5D5BAE763E73E;
        Fri, 25 Jan 2019 15:43:24 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Fri, 25 Jan 2019
 15:43:22 +0800
Subject: Re: [PATCH -next] MIPS: fix debugfs_simple_attr.cocci warnings
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1548384137-171488-1-git-send-email-yuehaibing@huawei.com>
 <20190125071159.GA11891@kroah.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, <linux-mips@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <efbbf61d-0c4a-e7f6-8ce1-b5e6417afff1@huawei.com>
Date:   Fri, 25 Jan 2019 15:43:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190125071159.GA11891@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 2019/1/25 15:11, Greg Kroah-Hartman wrote:
> On Fri, Jan 25, 2019 at 02:42:17AM +0000, YueHaibing wrote:
>> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
>> for debugfs files.
>>
>> Semantic patch information:
>> Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
>> imposes some significant overhead as compared to
>> DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
> 
> What kind of overhead is this adding, and how are you measuring it?

The log message on the commit introducing the semantic patch says the
following:

commit 5103068eaca2 ("debugfs, coccinelle: check for obsolete DEFINE_SIMPLE_ATTRIBUTE() usage")

    In order to protect against file removal races, debugfs files created via
    debugfs_create_file() now get wrapped by a struct file_operations at their
    opening.

    If the original struct file_operations are known to be safe against removal
    races by themselves already, the proxy creation may be bypassed by creating
    the files through debugfs_create_file_unsafe().

    In order to help debugfs users who use the common
      DEFINE_SIMPLE_ATTRIBUTE() + debugfs_create_file()
    idiom to transition to removal safe struct file_operations, the helper
    macro DEFINE_DEBUGFS_ATTRIBUTE() has been introduced.

    Thus, the preferred strategy is to use
      DEFINE_DEBUGFS_ATTRIBUTE() + debugfs_create_file_unsafe()
    now.


> 
>>
>> Generated by: scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  arch/mips/kernel/spinlock_test.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/mips/kernel/spinlock_test.c b/arch/mips/kernel/spinlock_test.c
>> index ab4e3e1..509de1e 100644
>> --- a/arch/mips/kernel/spinlock_test.c
>> +++ b/arch/mips/kernel/spinlock_test.c
>> @@ -35,7 +35,7 @@ static int ss_get(void *data, u64 *val)
>>  	return 0;
>>  }
>>  
>> -DEFINE_SIMPLE_ATTRIBUTE(fops_ss, ss_get, NULL, "%llu\n");
>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_ss, ss_get, NULL, "%llu\n");
>>  
>>  
>>  
>> @@ -114,14 +114,14 @@ static int multi_get(void *data, u64 *val)
>>  	return 0;
>>  }
>>  
>> -DEFINE_SIMPLE_ATTRIBUTE(fops_multi, multi_get, NULL, "%llu\n");
>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_multi, multi_get, NULL, "%llu\n");
>>  
>>  static int __init spinlock_test(void)
>>  {
>> -	debugfs_create_file("spin_single", S_IRUGO, mips_debugfs_dir, NULL,
>> -			    &fops_ss);
>> -	debugfs_create_file("spin_multi", S_IRUGO, mips_debugfs_dir, NULL,
>> -			    &fops_multi);
>> +	debugfs_create_file_unsafe("spin_single", 0444, mips_debugfs_dir,
>> +				   NULL, &fops_ss);
>> +	debugfs_create_file_unsafe("spin_multi", 0444, mips_debugfs_dir,
>> +				   NULL, &fops_multi);
>>  	return 0;
>>  }
>>  device_initcall(spinlock_test);
> 
> This is just testing code, right?  Why is using the unsafe methods
> needed?
> 
> thanks,
> 
> greg k-h
> 
> .
> 

