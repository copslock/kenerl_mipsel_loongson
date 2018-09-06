Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 04:17:49 +0200 (CEST)
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:62914 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990423AbeIFCRppQgNP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 04:17:45 +0200
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65b908e3f4b4-f8a2f; Thu, 06 Sep 2018 10:17:35 +0800 (CST)
X-RM-TRANSID: 2ee65b908e3f4b4-f8a2f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.81] (unknown[112.25.154.148])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65b908e3e48e-c7e9c;
        Thu, 06 Sep 2018 10:17:34 +0800 (CST)
X-RM-TRANSID: 2ee65b908e3e48e-c7e9c
Subject: Re: [PATCH V2] mips: txx9: fix resource leak after register fail
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <1536146539-26131-1-git-send-email-dingxiang@cmss.chinamobile.com>
 <20180906.003701.1191480642819924726.anemo@mba.ocn.ne.jp>
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
Message-ID: <d0386546-cb09-0ff6-2cc6-c6816f723289@cmss.chinamobile.com>
Date:   Thu, 6 Sep 2018 10:17:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180906.003701.1191480642819924726.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <dingxiang@cmss.chinamobile.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dingxiang@cmss.chinamobile.com
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


On 9/5/2018 11:37 PM, Atsushi Nemoto wrote:
> On Wed,  5 Sep 2018 19:22:19 +0800, Ding Xiang <dingxiang@cmss.chinamobile.com> wrote:
>> the memory allocated and ioremap address need free after
>> device_register return error.
> ...
>>   exit_put:
>>   	put_device(&dev->dev);
>> -	return;
>> +exit_free:
>> +	iounmap(dev->base);
>> +	kfree(dev);
> This change will break exit_put error path.
> I think kfree will be called from txx9_device_release by put_device.
>
> Please refer James's comment on previous trial:
> <https://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20180305221833.GJ4197%40saruman>

yes, put_device will call txx9_device_release and free txx9_sramc_dev, 
and kfree in  sysfs_create_bin_file() error handle

is also unneeded, I will send a new patch soon
