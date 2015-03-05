Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 09:40:17 +0100 (CET)
Received: from mail.emea.novell.com ([130.57.118.101]:53577 "EHLO
        mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007125AbbCEIkP1c5pp convert rfc822-to-8bit (ORCPT
        <rfc822;groupwise-linux-mips@linux-mips.org:10:1>);
        Thu, 5 Mar 2015 09:40:15 +0100
Received: from EMEA1-MTA by mail.emea.novell.com
        with Novell_GroupWise; Thu, 05 Mar 2015 08:40:13 +0000
Message-Id: <54F8247B02000078000667AF@mail.emea.novell.com>
X-Mailer: Novell GroupWise Internet Agent 14.0.1 
Date:   Thu, 05 Mar 2015 08:40:11 +0000
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Xiaoming Wang" <xiaoming.wang@intel.com>
Cc:     "Liu@aserp2030.oracle.com" <Liu@aserp2030.oracle.com>,
        "Zhang@aserp2030.oracle.com" <Zhang@aserp2030.oracle.com>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "david.vrabel@citrix.com" <david.vrabel@citrix.com>,
        "lauraa@codeaurora.org" <lauraa@codeaurora.org>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "linux@horizon.com" <linux@horizon.com>,
        "Chuansheng Liu" <chuansheng.liu@intel.com>,
        "Dongxing Zhang" <dongxing.zhang@intel.com>,
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
Subject: RE: [PATCH v5] modify the IO_TLB_SEGSIZE and
 IO_TLB_DEFAULT_SIZE configurable as flexible requirement about
 SW-IOMMU.
References: <1425370269-29658-1-git-send-email-xiaoming.wang@intel.com>
 <20150304194237.GA12884@l.oracle.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D05BBA@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <FA47D36D6EC9FE4CB463299737C09B9901D05BBA@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <JBeulich@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;groupwise-linux-mips@linux-mips.org:10:1
Original-Recipient: rfc822;groupwise-linux-mips@linux-mips.org:10:1
X-Envid: groupwise.54F8166B.B9F:78:76fe:N
Envelope-Id: groupwise.54F8166B.B9F:78:76fe:N
X-archive-position: 46195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: JBeulich@suse.com
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

>>> On 05.03.15 at 04:53, <xiaoming.wang@intel.com> wrote:
>> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
>> Sent: Thursday, March 5, 2015 3:43 AM
>> On Tue, Mar 03, 2015 at 04:11:09PM +0800, Wang Xiaoming wrote:
>> > @@ -101,13 +119,32 @@ setup_io_tlb_npages(char *str)  {
>> >  	if (isdigit(*str)) {
>> >  		io_tlb_nslabs = simple_strtoul(str, &str, 0);
>> > -		/* avoid tail segment of size < IO_TLB_SEGSIZE */
>> > -		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
>> >  	}
>> >  	if (*str == ',')
>> >  		++str;
>> > -	if (!strcmp(str, "force"))
>> > +	if (!strncmp(str, "force", 5)) {
>> >  		swiotlb_force = 1;
>> > +		str += 5;
>> > +	}
>> 
>> So the format is now:
>> 
>> 	Format: { <int> | force | <int> | <int>}
>> 
>> which means I can do
>> 	32,22323,force
>> 
>> Or
>> 	force,32
>> 
>> Or
>> 	32,force
>> 
> If I use Format: { <int>,force,<int>,<int>}
> 32,22323,force can't acceptable.
> There are three  <int>  here, if there are out of order, that will cause 
> confuse.
> Only 	32,force,32323
> Or	32,,32323,2322
> Or	,,323222,3232
> Are available.

You need to make sure that all previously valid variants are still
usable, i.e. force alone, a number alone, force,<number> and
<number>,force. How many variants you want to support with
your additions is mostly up to you; I'd recommend permitting force
in any position.

Jan
