Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 10:58:26 +0200 (CEST)
Received: from [119.145.14.66] ([119.145.14.66]:47715 "EHLO
        szxga03-in.huawei.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819446AbaE2I5oo0Zl1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 10:57:44 +0200
Received: from 172.24.2.119 (EHLO szxeml211-edg.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id APH43772;
        Thu, 29 May 2014 16:57:21 +0800 (CST)
Received: from SZXEML405-HUB.china.huawei.com (10.82.67.60) by
 szxeml211-edg.china.huawei.com (172.24.2.182) with Microsoft SMTP Server
 (TLS) id 14.3.158.1; Thu, 29 May 2014 16:57:20 +0800
Received: from [10.177.18.230] (10.177.18.230) by smtpscn.huawei.com
 (10.82.67.60) with Microsoft SMTP Server (TLS) id 14.3.158.1; Thu, 29 May
 2014 16:57:12 +0800
Message-ID: <5386F663.4010401@huawei.com>
Date:   Thu, 29 May 2014 16:57:07 +0800
From:   Li Zefan <lizefan@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Yong Zhang <yong.zhang@windriver.com>, <ralf@linux-mips.org>,
        <huawei.libin@huawei.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH V2] MIPS: change type of asid_cache to unsigned long
References: <1400650563-1033-1-git-send-email-yong.zhang@windriver.com> <5384119E.7010606@huawei.com> <20140528200929.GA30528@drone.musicnaut.iki.fi>
In-Reply-To: <20140528200929.GA30528@drone.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.18.230]
X-CFilter-Loop: Reflected
Return-Path: <lizefan@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40320
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

On 2014/5/29 4:09, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, May 27, 2014 at 12:16:30PM +0800, Li Zefan wrote:
>> On 2014/5/21 13:36, Yong Zhang wrote:
>>> asid_cache must be unsigned long otherwise on 64bit system
>>> it will become 0 if the value in get_new_mmu_context()
>>> reaches 0xffffffff and in the end the assumption of
>>> ASID_FIRST_VERSION is not true anymore thus leads to
>>> more dangerous things.
>>
>> We should describe what problem this bug can lead to, which
>> will help people who encounter the same problem and google it.
> 
> Please describe it, then. Even if the patch is already committed,
> googling would probably still find this e-mail thread.
> 

I don't think Ralf has committed it, so we'll send out a fix
with detailed changelog.
