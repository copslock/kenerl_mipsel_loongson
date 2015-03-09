Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 01:31:37 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:32065 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007666AbbCIAbgGLStM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 01:31:36 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP; 08 Mar 2015 17:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,364,1422950400"; 
   d="scan'208";a="695672789"
Received: from kmsmsx151.gar.corp.intel.com ([172.21.73.86])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2015 17:31:24 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 KMSMSX151.gar.corp.intel.com (172.21.73.86) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Mon, 9 Mar 2015 08:31:23 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.62]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.197]) with mapi id 14.03.0195.001;
 Mon, 9 Mar 2015 08:31:22 +0800
From:   "Wang, Xiaoming" <xiaoming.wang@intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     Jan Beulich <JBeulich@suse.com>,
        "Liu@aserp2030.oracle.com" <Liu@aserp2030.oracle.com>,
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
        "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>
Subject: RE: [PATCH v5] modify the IO_TLB_SEGSIZE and IO_TLB_DEFAULT_SIZE
 configurable as flexible requirement about SW-IOMMU.
Thread-Topic: [PATCH v5] modify the IO_TLB_SEGSIZE and IO_TLB_DEFAULT_SIZE
 configurable as flexible requirement about SW-IOMMU.
Thread-Index: AQHQVYnWYlmtHDmn0E2ZkLshdhx4b50MNYyAgAECbfD//9bSgIAAiBGQ//99igCAAY/FQIAAbIiAgAREbIA=
Date:   Mon, 9 Mar 2015 00:31:22 +0000
Message-ID: <FA47D36D6EC9FE4CB463299737C09B9901D07E7B@shsmsx102.ccr.corp.intel.com>
References: <1425370269-29658-1-git-send-email-xiaoming.wang@intel.com>
 <20150304194237.GA12884@l.oracle.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D05BBA@shsmsx102.ccr.corp.intel.com>
 <54F8247B02000078000667AF@mail.emea.novell.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D05DF8@shsmsx102.ccr.corp.intel.com>
 <54F8292E02000078000667F9@mail.emea.novell.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D061EB@shsmsx102.ccr.corp.intel.com>
 <20150306151931.GC4808@l.oracle.com>
In-Reply-To: <20150306151931.GC4808@l.oracle.com>
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
X-archive-position: 46278
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



> -----Original Message-----
> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> Sent: Friday, March 6, 2015 11:20 PM
> To: Wang, Xiaoming
> Cc: Jan Beulich; Liu@aserp2030.oracle.com; Zhang@aserp2030.oracle.com;
> chris@chris-wilson.co.uk; david.vrabel@citrix.com; lauraa@codeaurora.org;
> heiko.carstens@de.ibm.com; linux@horizon.com; Liu, Chuansheng; Zhang,
> Dongxing; takahiro.akashi@linaro.org; akpm@linux-foundation.org; linux-
> mips@linux-mips.org; ralf@linux-mips.org; xen-devel@lists.xenproject.org;
> boris.ostrovsky@oracle.com; d.kasatkin@samsung.com; pebolle@tiscali.nl;
> linux-kernel@vger.kernel.org; jkosina@suse.cz
> Subject: Re: [PATCH v5] modify the IO_TLB_SEGSIZE and
> IO_TLB_DEFAULT_SIZE configurable as flexible requirement about SW-
> IOMMU.
> 
> . snip..
> 
> > Format: { <int>,force,<int>,<int>} is suitable I think.
> > And fixing  "force" is follow the code design previously in
> setup_io_tlb_npages.
> 
> It is a bug. It should have been smart enough to deal with the 'force' being in
> any order.
> 
> If you are willing to make a patch to fix this - either folded into this patch I
> am responding to or as a seperate one - that would be most excellent!
> 
OK, I will try to make a patch to deal with the 'force'  in any order.
> However, I can also do it - but my plate is full so it will take me some time to
> get to it.
