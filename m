Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2015 10:46:23 +0100 (CET)
Received: from smtp.citrix.com ([66.165.176.89]:20131 "EHLO SMTP.CITRIX.COM"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012464AbbBJJqVI7WcP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Feb 2015 10:46:21 +0100
X-IronPort-AV: E=Sophos;i="5.09,549,1418083200"; 
   d="scan'208";a="224314350"
Message-ID: <54D9D363.5060904@citrix.com>
Date:   Tue, 10 Feb 2015 09:46:11 +0000
From:   David Vrabel <david.vrabel@citrix.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
MIME-Version: 1.0
To:     "Wang, Xiaoming" <xiaoming.wang@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "Zhang, Dongxing" <dongxing.zhang@intel.com>,
        "lauraa@codeaurora.org" <lauraa@codeaurora.org>,
        "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>,
        "david.vrabel@citrix.com" <david.vrabel@citrix.com>,
        "linux@horizon.com" <linux@horizon.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [Xen-devel] [PATCH] modify the IO_TLB_SEGSIZE to io_tlb_segsize
 configurable as flexible requirement about SW-IOMMU.
References: <1423177274-22118-1-git-send-email-xiaoming.wang@intel.com> <20150205193241.GC11646@x230.dumpdata.com> <FA47D36D6EC9FE4CB463299737C09B9901CF8CE6@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <FA47D36D6EC9FE4CB463299737C09B9901CF8CE6@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-DLP:  MIA2
Return-Path: <david.vrabel@citrix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.vrabel@citrix.com
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

On 06/02/15 00:10, Wang, Xiaoming wrote:
> 
> 
>> -----Original Message-----
>> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
>> Sent: Friday, February 6, 2015 3:33 AM
>> To: Wang, Xiaoming
>> Cc: ralf@linux-mips.org; boris.ostrovsky@oracle.com;
>> david.vrabel@citrix.com; linux-mips@linux-mips.org; linux-
>> kernel@vger.kernel.org; xen-devel@lists.xenproject.org; akpm@linux-
>> foundation.org; linux@horizon.com; lauraa@codeaurora.org;
>> heiko.carstens@de.ibm.com; d.kasatkin@samsung.com;
>> takahiro.akashi@linaro.org; chris@chris-wilson.co.uk; pebolle@tiscali.nl; Liu,
>> Chuansheng; Zhang, Dongxing
>> Subject: Re: [PATCH] modify the IO_TLB_SEGSIZE to io_tlb_segsize
>> configurable as flexible requirement about SW-IOMMU.
>>
>> On Fri, Feb 06, 2015 at 07:01:14AM +0800, xiaomin1 wrote:
>>> The maximum of SW-IOMMU is limited to 2^11*128 = 256K.
>>> While in different platform and different requirements this seems improper.
>>> So modify the IO_TLB_SEGSIZE to io_tlb_segsize as configurable is make
>> sense.
>>
>> More details please. What is the issue you are hitting?
>>
> Example:
> If 1M bytes are requied. There has an error like.

Instead of allowing the bouncing of such large buffers, could the gadget
driver be modified to submit the buffers to the hardware in smaller chunks?

David
