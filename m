Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2014 06:57:09 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:39994 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822096AbaE0E5G6Yt0I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 May 2014 06:57:06 +0200
Received: from 172.24.2.119 (EHLO szxeml208-edg.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BWA79438;
        Tue, 27 May 2014 12:56:56 +0800 (CST)
Received: from SZXEML419-HUB.china.huawei.com (10.82.67.158) by
 szxeml208-edg.china.huawei.com (172.24.2.57) with Microsoft SMTP Server (TLS)
 id 14.3.158.1; Tue, 27 May 2014 12:56:55 +0800
Received: from [10.177.18.230] (10.177.18.230) by smtpscn.huawei.com
 (10.82.67.158) with Microsoft SMTP Server (TLS) id 14.3.158.1; Tue, 27 May
 2014 12:56:47 +0800
Message-ID: <53841B0A.1030404@huawei.com>
Date:   Tue, 27 May 2014 12:56:42 +0800
From:   Li Zefan <lizefan@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang@windriver.com>
CC:     <ralf@linux-mips.org>, <huawei.libin@huawei.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH V2] MIPS: change type of asid_cache to unsigned long
References: <1400650563-1033-1-git-send-email-yong.zhang@windriver.com> <5384119E.7010606@huawei.com> <20140527043433.GA16193@pek-yzhang-d1>
In-Reply-To: <20140527043433.GA16193@pek-yzhang-d1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.18.230]
X-CFilter-Loop: Reflected
Return-Path: <lizefan@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizefan@huawei.com
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

On 2014/5/27 12:34, Yong Zhang wrote:
> On Tue, May 27, 2014 at 12:16:30PM +0800, Li Zefan wrote:
>> I'm not quite happy about what happaned here. There's a story behind
>> this patch.
>>
>> One of our Huawei product encountered a bug, and they're using WindRiver4,
>> so the kernel is 2.6.34.
>>
>> Because they bought your licnece, they asked for your help, but
>> you were reluctant on this issue, and the problem remained there
>> for about one month.
>>
>> At last they turned to us for help. We're the kernel department in
>> Huawei, but maintaining this product kernel isn't our job. Still
>> Li Bin devoted his time to analyzing this bug, and he did a great
>> job.
>>
>> Li Bin told the product team what was wrong and was about to send
>> a fix for upstream kernel.
> 
> You have time to do that but you didn't.
> 

Hah yeah, we do have time. we spent lots of time analyzing the bug,
and we were taking our time to write good changelog. As I've pointed
out that your changelog isn't informative.

>> They told you our analysis for further
>> confirmation,
> 
> So you realy didn't make the patch, right? Because you are not
> sure the right fix.
> 

We're confident about our analysis and we know how to fix it.

It's the product team wasn't sure about this, and they wasn't
able to contact with Li Bin for confirmation at that time, so they
asked you.

>> and you were so reluctant to help but so quick to
>> send the fix.
> 
> We have responsed to you.
> 

You responded to us but you did nothing to help, that's why the
product team found us.

>>
>> Li Bin never reported this bug, but he fixed it. It's a shame that
>> you took the credit from us.
> 
> I just saw a bug report and ananysis. And I agreed and confirmed it's
> a bug.
> 

And that's our work and our credit, and I don't think you're gonna
to deny it.
