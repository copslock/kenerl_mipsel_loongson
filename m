Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 02:13:06 +0100 (CET)
Received: from mga03.intel.com ([134.134.136.65]:39591 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008234AbbCFBNEyVM0w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 02:13:04 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 05 Mar 2015 17:10:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,350,1422950400"; 
   d="scan'208";a="694678826"
Received: from pgsmsx104.gar.corp.intel.com ([10.221.44.91])
  by orsmga002.jf.intel.com with ESMTP; 05 Mar 2015 17:12:53 -0800
Received: from kmsmsx154.gar.corp.intel.com (172.21.73.14) by
 PGSMSX104.gar.corp.intel.com (10.221.44.91) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Fri, 6 Mar 2015 09:12:51 +0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.110.15) by
 KMSMSX154.gar.corp.intel.com (172.21.73.14) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Fri, 6 Mar 2015 09:12:50 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.62]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.161]) with mapi id 14.03.0195.001;
 Fri, 6 Mar 2015 09:12:49 +0800
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
        "Konrad RzeszutekWilk" <konrad.wilk@oracle.com>,
        "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>
Subject: RE: [PATCH v5] modify the IO_TLB_SEGSIZE and IO_TLB_DEFAULT_SIZE
 configurable as flexible requirement about SW-IOMMU.
Thread-Topic: [PATCH v5] modify the IO_TLB_SEGSIZE and IO_TLB_DEFAULT_SIZE
 configurable as flexible requirement about SW-IOMMU.
Thread-Index: AQHQVYnWYlmtHDmn0E2ZkLshdhx4b50MNYyAgAECbfD//9bSgIAAiBGQ//99igCAAY/FQA==
Date:   Fri, 6 Mar 2015 01:12:48 +0000
Message-ID: <FA47D36D6EC9FE4CB463299737C09B9901D061EB@shsmsx102.ccr.corp.intel.com>
References: <1425370269-29658-1-git-send-email-xiaoming.wang@intel.com>
 <20150304194237.GA12884@l.oracle.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D05BBA@shsmsx102.ccr.corp.intel.com>
 <54F8247B02000078000667AF@mail.emea.novell.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D05DF8@shsmsx102.ccr.corp.intel.com>
 <54F8292E02000078000667F9@mail.emea.novell.com>
In-Reply-To: <54F8292E02000078000667F9@mail.emea.novell.com>
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
X-archive-position: 46217
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
> Sent: Thursday, March 5, 2015 5:00 PM
> To: Wang, Xiaoming
> Cc: Liu@aserp2030.oracle.com; Zhang@aserp2030.oracle.com; chris@chris-
> wilson.co.uk; david.vrabel@citrix.com; lauraa@codeaurora.org;
> heiko.carstens@de.ibm.com; linux@horizon.com; Liu, Chuansheng; Zhang,
> Dongxing; takahiro.akashi@linaro.org; akpm@linux-foundation.org; linux-
> mips@linux-mips.org; ralf@linux-mips.org; xen-devel@lists.xenproject.org;
> boris.ostrovsky@oracle.com; Konrad RzeszutekWilk;
> d.kasatkin@samsung.com; pebolle@tiscali.nl; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v5] modify the IO_TLB_SEGSIZE and
> IO_TLB_DEFAULT_SIZE configurable as flexible requirement about SW-
> IOMMU.
> 
> >>> On 05.03.15 at 09:52, <xiaoming.wang@intel.com> wrote:
> >> From: Jan Beulich [mailto:JBeulich@suse.com]
> >> Sent: Thursday, March 5, 2015 4:40 PM
> >> >>> On 05.03.15 at 04:53, <xiaoming.wang@intel.com> wrote:
> >> >> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> >> >> Sent: Thursday, March 5, 2015 3:43 AM On Tue, Mar 03, 2015 at
> >> >> 04:11:09PM +0800, Wang Xiaoming wrote:
> >> >> > @@ -101,13 +119,32 @@ setup_io_tlb_npages(char *str)  {
> >> >> >  	if (isdigit(*str)) {
> >> >> >  		io_tlb_nslabs = simple_strtoul(str, &str, 0);
> >> >> > -		/* avoid tail segment of size < IO_TLB_SEGSIZE */
> >> >> > -		io_tlb_nslabs = ALIGN(io_tlb_nslabs,
> IO_TLB_SEGSIZE);
> >> >> >  	}
> >> >> >  	if (*str == ',')
> >> >> >  		++str;
> >> >> > -	if (!strcmp(str, "force"))
> >> >> > +	if (!strncmp(str, "force", 5)) {
> >> >> >  		swiotlb_force = 1;
> >> >> > +		str += 5;
> >> >> > +	}
> >> >>
> >> >> So the format is now:
> >> >>
> >> >> 	Format: { <int> | force | <int> | <int>}
> >> >>
> >> >> which means I can do
> >> >> 	32,22323,force
> >> >>
> >> >> Or
> >> >> 	force,32
> >> >>
> >> >> Or
> >> >> 	32,force
> >> >>
> >> > If I use Format: { <int>,force,<int>,<int>} 32,22323,force can't
> >> > acceptable.
> >> > There are three  <int>  here, if there are out of order, that will
> >> > cause confuse.
> >> > Only 	32,force,32323
> >> > Or	32,,32323,2322
> >> > Or	,,323222,3232
> >> > Are available.
> >>
> >> You need to make sure that all previously valid variants are still
> >> usable,
> > i.e.
> >> force alone, a number alone, force,<number> and <number>,force. How
> >> many variants you want to support with your additions is mostly up to
> >> you; I'd recommend permitting force in any position.
> >>
> > I don't think it's suitable to accept that "force" in any position.
> > If we defined Format: { <int>,force,<int>,<int>} "force" must be
> > located in second position.
> > And we add comment for each <int> also.
> > Every position may be defined specifically.
> 
> As said, with the old format allowing force in either first or second position,
> you have to at least accept that in the new version too.
> Accepting force in any position would be a (desirable) courtesy to the user.
> 
I have checked the code and do some test.

First "|" in Format  means *or*  in Documentation/kernel-parameters.txt
For example:
        acpi=           [HW,ACPI,X86]
                        Advanced Configuration and Power Interface
                        Format: { force | off | strict | noirq | rsdt }

        acpi_sci=       [HW,ACPI] ACPI System Control Interrupt trigger mode
                        Format: { level | edge | high | low }

Second the code in lib/swiotlb.c can't realize the function that
"force" in either first or second position with the Format
       swiotlb=        [ARM,IA-64,PPC,MIPS,X86]
                       Format: { <int> | force }
                       <int> -- Number of I/O TLB slabs

I test with parameter
BOARD_KERNEL_CMDLINE += swiotlb=force,500
The result is io_tlb_nslabs=32768, swiotlb_force=0x0,
io_tlb_nslabs=32768 because that if io_tlb_nslabs can't get from 
early_param("swiotlb", setup_io_tlb_npages);
It will be valued at swiotlb_init with default.
So both  "<int>"  and "force" can't recognized with original code below.

static int __init
setup_io_tlb_npages(char *str)
{
        if (isdigit(*str)) {
                io_tlb_nslabs = simple_strtoul(str, &str, 0);
                /* avoid tail segment of size < IO_TLB_SEGSIZE */
                io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
        }
        if (*str == ',')
                ++str;
        if (!strcmp(str, "force"))
                swiotlb_force = 1;

        return 0;
}
early_param("swiotlb", setup_io_tlb_npages);

So we can't use Format: { <int> | force | <int> | <int>} any more
as there are four parameters.
Format: { <int>,force,<int>,<int>} is suitable I think.
And fixing  "force" is follow the code design previously in setup_io_tlb_npages.

> Jan
