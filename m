Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 09:53:15 +0100 (CET)
Received: from mga03.intel.com ([134.134.136.65]:64652 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007125AbbCEIxNzww3D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 09:53:13 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 05 Mar 2015 00:50:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,345,1422950400"; 
   d="scan'208";a="462826301"
Received: from pgsmsx108.gar.corp.intel.com ([10.221.44.103])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2015 00:46:43 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 PGSMSX108.gar.corp.intel.com (10.221.44.103) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Thu, 5 Mar 2015 16:53:00 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.62]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.192]) with mapi id 14.03.0195.001;
 Thu, 5 Mar 2015 16:52:59 +0800
From:   "Wang, Xiaoming" <xiaoming.wang@intel.com>
To:     Jan Beulich <JBeulich@suse.com>
CC:     "Liu@aserp2030.oracle.com" <Liu@aserp2030.oracle.com>,
        "Zhang@aserp2030.oracle.com" <Zhang@aserp2030.oracle.com>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
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
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] modify the IO_TLB_SEGSIZE and IO_TLB_DEFAULT_SIZE
 configurable as flexible requirement about SW-IOMMU.
Thread-Topic: [PATCH v5] modify the IO_TLB_SEGSIZE and IO_TLB_DEFAULT_SIZE
 configurable as flexible requirement about SW-IOMMU.
Thread-Index: AQHQVYnWYlmtHDmn0E2ZkLshdhx4b50MNYyAgAECbfD//9bSgIAAiBGQ
Date:   Thu, 5 Mar 2015 08:52:59 +0000
Message-ID: <FA47D36D6EC9FE4CB463299737C09B9901D05DF8@shsmsx102.ccr.corp.intel.com>
References: <1425370269-29658-1-git-send-email-xiaoming.wang@intel.com>
 <20150304194237.GA12884@l.oracle.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D05BBA@shsmsx102.ccr.corp.intel.com>
 <54F8247B02000078000667AF@mail.emea.novell.com>
In-Reply-To: <54F8247B02000078000667AF@mail.emea.novell.com>
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
X-archive-position: 46196
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
> Sent: Thursday, March 5, 2015 4:40 PM
> To: Wang, Xiaoming
> Cc: Liu@aserp2030.oracle.com; Zhang@aserp2030.oracle.com; chris@chris-
> wilson.co.uk; david.vrabel@citrix.com; lauraa@codeaurora.org;
> heiko.carstens@de.ibm.com; linux@horizon.com; Liu, Chuansheng; Zhang,
> Dongxing; takahiro.akashi@linaro.org; akpm@linux-foundation.org; linux-
> mips@linux-mips.org; ralf@linux-mips.org; xen-devel@lists.xenproject.org;
> boris.ostrovsky@oracle.com; Konrad Rzeszutek Wilk;
> d.kasatkin@samsung.com; pebolle@tiscali.nl; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v5] modify the IO_TLB_SEGSIZE and
> IO_TLB_DEFAULT_SIZE configurable as flexible requirement about SW-
> IOMMU.
> 
> >>> On 05.03.15 at 04:53, <xiaoming.wang@intel.com> wrote:
> >> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> >> Sent: Thursday, March 5, 2015 3:43 AM On Tue, Mar 03, 2015 at
> >> 04:11:09PM +0800, Wang Xiaoming wrote:
> >> > @@ -101,13 +119,32 @@ setup_io_tlb_npages(char *str)  {
> >> >  	if (isdigit(*str)) {
> >> >  		io_tlb_nslabs = simple_strtoul(str, &str, 0);
> >> > -		/* avoid tail segment of size < IO_TLB_SEGSIZE */
> >> > -		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> >> >  	}
> >> >  	if (*str == ',')
> >> >  		++str;
> >> > -	if (!strcmp(str, "force"))
> >> > +	if (!strncmp(str, "force", 5)) {
> >> >  		swiotlb_force = 1;
> >> > +		str += 5;
> >> > +	}
> >>
> >> So the format is now:
> >>
> >> 	Format: { <int> | force | <int> | <int>}
> >>
> >> which means I can do
> >> 	32,22323,force
> >>
> >> Or
> >> 	force,32
> >>
> >> Or
> >> 	32,force
> >>
> > If I use Format: { <int>,force,<int>,<int>} 32,22323,force can't
> > acceptable.
> > There are three  <int>  here, if there are out of order, that will
> > cause confuse.
> > Only 	32,force,32323
> > Or	32,,32323,2322
> > Or	,,323222,3232
> > Are available.
> 
> You need to make sure that all previously valid variants are still usable, i.e.
> force alone, a number alone, force,<number> and <number>,force. How
> many variants you want to support with your additions is mostly up to you;
> I'd recommend permitting force in any position.
> 
I don't think it's suitable to accept that "force" in any position.
If we defined Format: { <int>,force,<int>,<int>}
"force" must be located in second position. 
And we add comment for each <int> also.
Every position may be defined specifically.

> Jan
