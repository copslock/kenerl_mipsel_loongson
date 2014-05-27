Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2014 07:07:44 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:42547 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822096AbaE0FHmP1Fgx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 May 2014 07:07:42 +0200
Received: from 172.24.2.119 (EHLO szxeml210-edg.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BWA80175;
        Tue, 27 May 2014 13:07:32 +0800 (CST)
Received: from SZXEML402-HUB.china.huawei.com (10.82.67.32) by
 szxeml210-edg.china.huawei.com (172.24.2.183) with Microsoft SMTP Server
 (TLS) id 14.3.158.1; Tue, 27 May 2014 13:07:31 +0800
Received: from [10.177.18.230] (10.177.18.230) by smtpscn.huawei.com
 (10.82.67.32) with Microsoft SMTP Server (TLS) id 14.3.158.1; Tue, 27 May
 2014 13:07:23 +0800
Message-ID: <53841D88.3040306@huawei.com>
Date:   Tue, 27 May 2014 13:07:20 +0800
From:   Li Zefan <lizefan@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang@windriver.com>
CC:     <ralf@linux-mips.org>, <huawei.libin@huawei.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH V2] MIPS: change type of asid_cache to unsigned long
References: <1400650563-1033-1-git-send-email-yong.zhang@windriver.com> <5384119E.7010606@huawei.com> <20140527045038.GB16193@pek-yzhang-d1>
In-Reply-To: <20140527045038.GB16193@pek-yzhang-d1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.18.230]
X-CFilter-Loop: Reflected
Return-Path: <lizefan@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40275
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

On 2014/5/27 12:50, Yong Zhang wrote:
> BTW, I realy don't care who credits the patch and Ralf said that
> he will applied the one which moves the place of udelay_val.
> 
> Anyway, if your company pays you more money if you contribute to
> the community, just take it and talk about it with Ralf ;-)
> 

We don't do contribution for money, and I don't think you do,
but crediting properly is one of the reason that our kernel
community keeps prosperous for so many years, and that's one
of the reason we introduced Reported-by and Tested-by tags.

> Thanks,
> Yong
