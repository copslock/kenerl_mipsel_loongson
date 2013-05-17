Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 06:50:27 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:17467 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816906Ab3EQEuWN-Ul3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 May 2013 06:50:22 +0200
Received: from 172.24.2.119 (EHLO szxeml212-edg.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.4-GA FastPath queued)
        with ESMTP id BBR93798;
        Fri, 17 May 2013 12:50:09 +0800 (CST)
Received: from SZXEML415-HUB.china.huawei.com (10.82.67.154) by
 szxeml212-edg.china.huawei.com (172.24.2.181) with Microsoft SMTP Server
 (TLS) id 14.1.323.7; Fri, 17 May 2013 12:49:32 +0800
Received: from [127.0.0.1] (10.135.72.158) by szxeml415-hub.china.huawei.com
 (10.82.67.154) with Microsoft SMTP Server id 14.1.323.7; Fri, 17 May 2013
 12:49:31 +0800
Message-ID: <5195B6D6.7030504@huawei.com>
Date:   Fri, 17 May 2013 12:49:26 +0800
From:   Libo Chen <clbchenlibo.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     <grant.likely@linaro.org>, <rob.herring@calxeda.com>,
        <linux-mips@linux-mips.org>, LKML <linux-kernel@vger.kernel.org>,
        <devicetree-discuss@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] usb: omap2430: fix memleak in err case
References: <5192E650.3070303@huawei.com> <519377C4.1040800@cogentembedded.com>
In-Reply-To: <519377C4.1040800@cogentembedded.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.135.72.158]
X-CFilter-Loop: Reflected
Return-Path: <libo.chen@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clbchenlibo.chen@huawei.com
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

On 2013/5/15 19:55, Sergei Shtylyov wrote:
> Hello.
> 
> On 15-05-2013 5:35, Libo Chen wrote:
> 
>> when omap_get_control_dev fail, we should release relational platform_device
> 
>    s/fail/fails/, s/relational/related/?
> 
>> Signed-off-by: Libo Chen <libo.chen@huawei.com>
> 
>    You've posted this to the wrong mailing list, linux-mips; devicetree-discuss also seems hardly related.
> 
> WBR, Sergei
> 
> 
> 

Hi Sergei,

Thank you for your remind.
