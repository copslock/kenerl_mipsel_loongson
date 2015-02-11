Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Feb 2015 21:49:53 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:46768 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013265AbbBKUtvQ3mFR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Feb 2015 21:49:51 +0100
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t1BKmqdc010610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 11 Feb 2015 20:48:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t1BKmpiY008638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 11 Feb 2015 20:48:51 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t1BKmmxG019736;
        Wed, 11 Feb 2015 20:48:50 GMT
Received: from l.oracle.com (/10.137.178.253)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Feb 2015 12:48:43 -0800
Received: by l.oracle.com (Postfix, from userid 1000)
        id 069E26A3C8F; Wed, 11 Feb 2015 15:48:41 -0500 (EST)
Date:   Wed, 11 Feb 2015 15:48:41 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "Wang, Xiaoming" <xiaoming.wang@intel.com>
Cc:     David Vrabel <david.vrabel@citrix.com>,
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
Subject: Re: [Xen-devel] [PATCH] modify the IO_TLB_SEGSIZE to io_tlb_segsize
 configurable as flexible requirement about SW-IOMMU.
Message-ID: <20150211204841.GB30585@l.oracle.com>
References: <1423177274-22118-1-git-send-email-xiaoming.wang@intel.com>
 <20150205193241.GC11646@x230.dumpdata.com>
 <FA47D36D6EC9FE4CB463299737C09B9901CF8CE6@shsmsx102.ccr.corp.intel.com>
 <54D9D363.5060904@citrix.com>
 <FA47D36D6EC9FE4CB463299737C09B9901CFE255@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA47D36D6EC9FE4CB463299737C09B9901CFE255@shsmsx102.ccr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <konrad.wilk@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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

On Wed, Feb 11, 2015 at 08:38:29AM +0000, Wang, Xiaoming wrote:
> Dear David
> 
> > -----Original Message-----
> > From: David Vrabel [mailto:david.vrabel@citrix.com]
> > Sent: Tuesday, February 10, 2015 5:46 PM
> > To: Wang, Xiaoming; Konrad Rzeszutek Wilk
> > Cc: linux-mips@linux-mips.org; pebolle@tiscali.nl; Zhang, Dongxing;
> > lauraa@codeaurora.org; d.kasatkin@samsung.com;
> > heiko.carstens@de.ibm.com; linux-kernel@vger.kernel.org; ralf@linux-
> > mips.org; chris@chris-wilson.co.uk; takahiro.akashi@linaro.org;
> > david.vrabel@citrix.com; linux@horizon.com; xen-
> > devel@lists.xenproject.org; boris.ostrovsky@oracle.com; Liu, Chuansheng;
> > akpm@linux-foundation.org
> > Subject: Re: [Xen-devel] [PATCH] modify the IO_TLB_SEGSIZE to
> > io_tlb_segsize configurable as flexible requirement about SW-IOMMU.
> > 
> > On 06/02/15 00:10, Wang, Xiaoming wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> > >> Sent: Friday, February 6, 2015 3:33 AM
> > >> To: Wang, Xiaoming
> > >> Cc: ralf@linux-mips.org; boris.ostrovsky@oracle.com;
> > >> david.vrabel@citrix.com; linux-mips@linux-mips.org; linux-
> > >> kernel@vger.kernel.org; xen-devel@lists.xenproject.org; akpm@linux-
> > >> foundation.org; linux@horizon.com; lauraa@codeaurora.org;
> > >> heiko.carstens@de.ibm.com; d.kasatkin@samsung.com;
> > >> takahiro.akashi@linaro.org; chris@chris-wilson.co.uk;
> > >> pebolle@tiscali.nl; Liu, Chuansheng; Zhang, Dongxing
> > >> Subject: Re: [PATCH] modify the IO_TLB_SEGSIZE to io_tlb_segsize
> > >> configurable as flexible requirement about SW-IOMMU.
> > >>
> > >> On Fri, Feb 06, 2015 at 07:01:14AM +0800, xiaomin1 wrote:
> > >>> The maximum of SW-IOMMU is limited to 2^11*128 = 256K.
> > >>> While in different platform and different requirements this seems
> > improper.
> > >>> So modify the IO_TLB_SEGSIZE to io_tlb_segsize as configurable is
> > >>> make
> > >> sense.
> > >>
> > >> More details please. What is the issue you are hitting?
> > >>
> > > Example:
> > > If 1M bytes are requied. There has an error like.
> > 
> > Instead of allowing the bouncing of such large buffers, could the gadget
> > driver be modified to submit the buffers to the hardware in smaller chunks?
> > 
> > David
> 
> Our target is try to make IO_TLB_SEGSIZE configurable.
> Neither 256 bytes  or 1M bytes seems suitable value, I think.
> It's better to use the tactics something like
> kmem_cache_create  in kmalloc function.
> But SW-IOMMU seems more lighter.
> So we choose variable rather than function.

Would it be possible to understand why the gadget needs such
large buffer? That is irrespective of the patchset you are proposing.

In regards to the pathchset - I don't see anything fundamentally
wrong with the patch. What I am afraid is that this fixes the
symptoms instead of the underlaying problem. The problem I think
is that with this large 1MB requests you risk of using the
SWIOTLB bounce buffer which can result in poor performance.

So eventually somebody will have to figure out why the performance
is poor and have a hard time figuring what is wrong - as the
symptoms have been removed.

Hence looking at potentially using an scatter gather mechanism
and chop up the requests in smaller sizes might be an better
option. But I don't know? Perhaps you are more familiar with the
gadget and could tell me why it needs an 1MB size request?


> 
> Xiaoming.
