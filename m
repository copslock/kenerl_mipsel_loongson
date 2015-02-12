Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2015 01:56:06 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:19965 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013280AbbBLA4DPRf4Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Feb 2015 01:56:03 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 11 Feb 2015 16:55:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,562,1418112000"; 
   d="scan'208";a="676662871"
Received: from pgsmsx107.gar.corp.intel.com ([10.221.44.105])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2015 16:55:50 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.110.15) by
 PGSMSX107.gar.corp.intel.com (10.221.44.105) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Thu, 12 Feb 2015 08:55:49 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.62]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.161]) with mapi id 14.03.0195.001;
 Thu, 12 Feb 2015 08:55:48 +0800
From:   "Wang, Xiaoming" <xiaoming.wang@intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     David Vrabel <david.vrabel@citrix.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "Zhang, Dongxing" <dongxing.zhang@intel.com>,
        "lauraa@codeaurora.org" <lauraa@codeaurora.org>,
        "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>,
        "linux@horizon.com" <linux@horizon.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [Xen-devel] [PATCH] modify the IO_TLB_SEGSIZE to io_tlb_segsize
 configurable as flexible requirement about SW-IOMMU.
Thread-Topic: [Xen-devel] [PATCH] modify the IO_TLB_SEGSIZE to
 io_tlb_segsize configurable as flexible requirement about SW-IOMMU.
Thread-Index: AQHQQRJJKhpis9DUDUadJ41Llkm2a5zh7MKAgADSw2CABmUHgIACAXdQgABJ+ICAAMPnAA==
Date:   Thu, 12 Feb 2015 00:55:48 +0000
Message-ID: <FA47D36D6EC9FE4CB463299737C09B9901CFE6ED@shsmsx102.ccr.corp.intel.com>
References: <1423177274-22118-1-git-send-email-xiaoming.wang@intel.com>
 <20150205193241.GC11646@x230.dumpdata.com>
 <FA47D36D6EC9FE4CB463299737C09B9901CF8CE6@shsmsx102.ccr.corp.intel.com>
 <54D9D363.5060904@citrix.com>
 <FA47D36D6EC9FE4CB463299737C09B9901CFE255@shsmsx102.ccr.corp.intel.com>
 <20150211204841.GB30585@l.oracle.com>
In-Reply-To: <20150211204841.GB30585@l.oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <xiaoming.wang@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiaoming.wang@intel.com
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

Dear Wilk:

> -----Original Message-----
> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> Sent: Thursday, February 12, 2015 4:49 AM
> To: Wang, Xiaoming
> Cc: David Vrabel; linux-mips@linux-mips.org; pebolle@tiscali.nl; Zhang,
> Dongxing; lauraa@codeaurora.org; d.kasatkin@samsung.com;
> heiko.carstens@de.ibm.com; linux-kernel@vger.kernel.org; ralf@linux-
> mips.org; chris@chris-wilson.co.uk; takahiro.akashi@linaro.org;
> linux@horizon.com; xen-devel@lists.xenproject.org;
> boris.ostrovsky@oracle.com; Liu, Chuansheng; akpm@linux-foundation.org
> Subject: Re: [Xen-devel] [PATCH] modify the IO_TLB_SEGSIZE to
> io_tlb_segsize configurable as flexible requirement about SW-IOMMU.
> 
> On Wed, Feb 11, 2015 at 08:38:29AM +0000, Wang, Xiaoming wrote:
> > Dear David
> >
> > > -----Original Message-----
> > > From: David Vrabel [mailto:david.vrabel@citrix.com]
> > > Sent: Tuesday, February 10, 2015 5:46 PM
> > > To: Wang, Xiaoming; Konrad Rzeszutek Wilk
> > > Cc: linux-mips@linux-mips.org; pebolle@tiscali.nl; Zhang, Dongxing;
> > > lauraa@codeaurora.org; d.kasatkin@samsung.com;
> > > heiko.carstens@de.ibm.com; linux-kernel@vger.kernel.org; ralf@linux-
> > > mips.org; chris@chris-wilson.co.uk; takahiro.akashi@linaro.org;
> > > david.vrabel@citrix.com; linux@horizon.com; xen-
> > > devel@lists.xenproject.org; boris.ostrovsky@oracle.com; Liu,
> > > Chuansheng; akpm@linux-foundation.org
> > > Subject: Re: [Xen-devel] [PATCH] modify the IO_TLB_SEGSIZE to
> > > io_tlb_segsize configurable as flexible requirement about SW-IOMMU.
> > >
> > > On 06/02/15 00:10, Wang, Xiaoming wrote:
> > > >
> > > >
> > > >> -----Original Message-----
> > > >> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> > > >> Sent: Friday, February 6, 2015 3:33 AM
> > > >> To: Wang, Xiaoming
> > > >> Cc: ralf@linux-mips.org; boris.ostrovsky@oracle.com;
> > > >> david.vrabel@citrix.com; linux-mips@linux-mips.org; linux-
> > > >> kernel@vger.kernel.org; xen-devel@lists.xenproject.org;
> > > >> akpm@linux- foundation.org; linux@horizon.com;
> > > >> lauraa@codeaurora.org; heiko.carstens@de.ibm.com;
> > > >> d.kasatkin@samsung.com; takahiro.akashi@linaro.org;
> > > >> chris@chris-wilson.co.uk; pebolle@tiscali.nl; Liu, Chuansheng;
> > > >> Zhang, Dongxing
> > > >> Subject: Re: [PATCH] modify the IO_TLB_SEGSIZE to io_tlb_segsize
> > > >> configurable as flexible requirement about SW-IOMMU.
> > > >>
> > > >> On Fri, Feb 06, 2015 at 07:01:14AM +0800, xiaomin1 wrote:
> > > >>> The maximum of SW-IOMMU is limited to 2^11*128 = 256K.
> > > >>> While in different platform and different requirements this
> > > >>> seems
> > > improper.
> > > >>> So modify the IO_TLB_SEGSIZE to io_tlb_segsize as configurable
> > > >>> is make
> > > >> sense.
> > > >>
> > > >> More details please. What is the issue you are hitting?
> > > >>
> > > > Example:
> > > > If 1M bytes are requied. There has an error like.
> > >
> > > Instead of allowing the bouncing of such large buffers, could the
> > > gadget driver be modified to submit the buffers to the hardware in
> smaller chunks?
> > >
> > > David
> >
> > Our target is try to make IO_TLB_SEGSIZE configurable.
> > Neither 256 bytes  or 1M bytes seems suitable value, I think.
> > It's better to use the tactics something like kmem_cache_create  in
> > kmalloc function.
> > But SW-IOMMU seems more lighter.
> > So we choose variable rather than function.
> 
> Would it be possible to understand why the gadget needs such large buffer?
> That is irrespective of the patchset you are proposing.
> 
> In regards to the pathchset - I don't see anything fundamentally wrong with
> the patch. What I am afraid is that this fixes the symptoms instead of the
> underlaying problem. The problem I think is that with this large 1MB requests
> you risk of using the SWIOTLB bounce buffer which can result in poor
> performance.
> 
> So eventually somebody will have to figure out why the performance is poor
> and have a hard time figuring what is wrong - as the symptoms have been
> removed.
> 
> Hence looking at potentially using an scatter gather mechanism and chop up
> the requests in smaller sizes might be an better option. But I don't know?
> Perhaps you are more familiar with the gadget and could tell me why it needs
> an 1MB size request?
> 
> 
The 1M size is requested when doing flash fastboot in 
system/core/fastbootd/commands/flash.c  defined by Google.
I listed a partial code from flash.c  here.
#define BUFFER_SIZE 1024 * 1024
int current_size = MIN(size - written, BUFFER_SIZE);
(gpt_mmap(&input, written + skip, current_size, data_fd))
mapping->size = ALIGN(size + location_diff, PAGE_SIZE);

> >
> > Xiaoming.
