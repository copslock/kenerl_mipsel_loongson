Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Feb 2015 10:10:23 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:41970 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012939AbbBRJKVZ8nSm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Feb 2015 10:10:21 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP; 18 Feb 2015 01:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,595,1418112000"; 
   d="scan'208";a="667962030"
Received: from pgsmsx108.gar.corp.intel.com ([10.221.44.103])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2015 01:10:06 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 PGSMSX108.gar.corp.intel.com (10.221.44.103) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Wed, 18 Feb 2015 17:10:05 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.62]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.197]) with mapi id 14.03.0195.001;
 Wed, 18 Feb 2015 17:09:58 +0800
From:   "Wang, Xiaoming" <xiaoming.wang@intel.com>
To:     Jan Beulich <JBeulich@suse.com>
CC:     "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "david.vrabel@citrix.com" <david.vrabel@citrix.com>,
        "lauraa@codeaurora.org" <lauraa@codeaurora.org>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "linux@horizon.com" <linux@horizon.com>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        "Zhang, Dongxing" <dongxing.zhang@intel.com>,
        "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Xen-devel] [PATCH v4] modify the IO_TLB_SEGSIZE and
 IO_TLB_DEFAULT_SIZE configurable as flexible requirement about SW-IOMMU.
Thread-Topic: [Xen-devel] [PATCH v4] modify the IO_TLB_SEGSIZE and
 IO_TLB_DEFAULT_SIZE configurable as flexible requirement about SW-IOMMU.
Thread-Index: AQHQSn5MlHyw4zGUu0iv4XBiMSuM7Jz0GFgAgAFLKCA=
Date:   Wed, 18 Feb 2015 09:09:59 +0000
Message-ID: <FA47D36D6EC9FE4CB463299737C09B9901D00FBD@shsmsx102.ccr.corp.intel.com>
References: <1424155903-4262-1-git-send-email-xiaoming.wang@intel.com>
 <54E321400200007800060865@mail.emea.novell.com>
In-Reply-To: <54E321400200007800060865@mail.emea.novell.com>
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
X-archive-position: 45845
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

Dear Jan

> -----Original Message-----
> From: Jan Beulich [mailto:JBeulich@suse.com]
> Sent: Tuesday, February 17, 2015 6:09 PM
> To: Wang, Xiaoming
> Cc: chris@chris-wilson.co.uk; david.vrabel@citrix.com;
> lauraa@codeaurora.org; heiko.carstens@de.ibm.com; linux@horizon.com;
> Liu, Chuansheng; Zhang, Dongxing; takahiro.akashi@linaro.org;
> akpm@linux-foundation.org; linux-mips@linux-mips.org; ralf@linux-
> mips.org; xen-devel@lists.xenproject.org; boris.ostrovsky@oracle.com;
> konrad.wilk@oracle.com; d.kasatkin@samsung.com; pebolle@tiscali.nl;
> linux-kernel@vger.kernel.org
> Subject: Re: [Xen-devel] [PATCH v4] modify the IO_TLB_SEGSIZE and
> IO_TLB_DEFAULT_SIZE configurable as flexible requirement about SW-
> IOMMU.
> 
> >>> On 17.02.15 at 07:51, <xiaoming.wang@intel.com> wrote:
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -3438,10 +3438,12 @@ bytes respectively. Such letter suffixes can
> > also be entirely omitted.
> >  			it if 0 is given (See
> Documentation/cgroups/memory.txt)
> >
> >  	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
> > -			Format: { <int> | force }
> > +			Format: { <int> | force | <int> | <int>}
> >  			<int> -- Number of I/O TLB slabs
> >  			force -- force using of bounce buffers even if they
> >  			         wouldn't be automatically used by the kernel
> > +			<int> -- Maximum allowable number of contiguous
> slabs to map
> > +			<int> -- The size of SW-MMU mapped.
> 
> This makes no sense - the new numbers added aren't position independent
> (nor were the previous <int> and "force").
> 
Use ","  can separate them one by one.
We do it at lib/swiotlb.c
> Also you are (supposedly) removing all uses of IO_TLB_DEFAULT_SIZE, yet
> you don't seem to remove the definition itself.
> 
I have change all uses of IO_TLB_DEFAULT_SIZE to io_tlb_default_size in lib/swiotlb.c
> Finally - are arbitrary numbers really okay for the newly added command line
> options? I.e. shouldn't you add some checking of their validity?
> 
I have validity these code is OK.
Example:
BOARD_KERNEL_CMDLINE += swiotlb=, ,512,268435456
Io_tlb_segsize has been changed from 128 to 512
Io_tlb_default_size has been changed from 64M to 268435456  (256M)

> Jan
Xiaoming.
