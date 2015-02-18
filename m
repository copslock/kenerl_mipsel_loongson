Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Feb 2015 10:34:54 +0100 (CET)
Received: from mail.emea.novell.com ([130.57.118.101]:41471 "EHLO
        mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012905AbbBRJewsCaGR convert rfc822-to-8bit (ORCPT
        <rfc822;groupwise-linux-mips@linux-mips.org:9:1>);
        Wed, 18 Feb 2015 10:34:52 +0100
Received: from EMEA1-MTA by mail.emea.novell.com
        with Novell_GroupWise; Wed, 18 Feb 2015 09:34:51 +0000
Message-Id: <54E46ACA0200007800060F5C@mail.emea.novell.com>
X-Mailer: Novell GroupWise Internet Agent 14.0.1 
Date:   Wed, 18 Feb 2015 09:34:50 +0000
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Xiaoming Wang" <xiaoming.wang@intel.com>
Cc:     "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
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
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Xen-devel] [PATCH v4] modify the IO_TLB_SEGSIZE and
 IO_TLB_DEFAULT_SIZE configurable as flexible requirement about
 SW-IOMMU.
References: <1424155903-4262-1-git-send-email-xiaoming.wang@intel.com>
 <54E321400200007800060865@mail.emea.novell.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D00FBD@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <FA47D36D6EC9FE4CB463299737C09B9901D00FBD@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <JBeulich@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;groupwise-linux-mips@linux-mips.org:9:1
Original-Recipient: rfc822;groupwise-linux-mips@linux-mips.org:9:1
X-Envid: groupwise.54E45CBA.ECD:78:76fe:N
Envelope-Id: groupwise.54E45CBA.ECD:78:76fe:N
X-archive-position: 45846
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

>>> On 18.02.15 at 10:09, <xiaoming.wang@intel.com> wrote:
>> From: Jan Beulich [mailto:JBeulich@suse.com]
>> Sent: Tuesday, February 17, 2015 6:09 PM
>> >>> On 17.02.15 at 07:51, <xiaoming.wang@intel.com> wrote:
>> > --- a/Documentation/kernel-parameters.txt
>> > +++ b/Documentation/kernel-parameters.txt
>> > @@ -3438,10 +3438,12 @@ bytes respectively. Such letter suffixes can
>> > also be entirely omitted.
>> >  			it if 0 is given (See
>> Documentation/cgroups/memory.txt)
>> >
>> >  	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
>> > -			Format: { <int> | force }
>> > +			Format: { <int> | force | <int> | <int>}
>> >  			<int> -- Number of I/O TLB slabs
>> >  			force -- force using of bounce buffers even if they
>> >  			         wouldn't be automatically used by the kernel
>> > +			<int> -- Maximum allowable number of contiguous
>> slabs to map
>> > +			<int> -- The size of SW-MMU mapped.
>> 
>> This makes no sense - the new numbers added aren't position independent
>> (nor were the previous <int> and "force").
>> 
> Use ","  can separate them one by one.
> We do it at lib/swiotlb.c

Right, but the documentation above doesn't say so.

>> Also you are (supposedly) removing all uses of IO_TLB_DEFAULT_SIZE, yet
>> you don't seem to remove the definition itself.
>> 
> I have change all uses of IO_TLB_DEFAULT_SIZE to io_tlb_default_size in 
> lib/swiotlb.c

Then are there any left elsewhere? If not, again - why don't you
remove the definition of IO_TLB_DEFAULT_SIZE?

>> Finally - are arbitrary numbers really okay for the newly added command line
>> options? I.e. shouldn't you add some checking of their validity?
>> 
> I have validity these code is OK.
> Example:
> BOARD_KERNEL_CMDLINE += swiotlb=, ,512,268435456
> Io_tlb_segsize has been changed from 128 to 512
> Io_tlb_default_size has been changed from 64M to 268435456  (256M)

I specifically said "arbitrary numbers", which in particular includes
zero and non-power-of-2 values. If there are any restrictions on
which numbers can validly be passed here (and it very much looks
like there are), such restrictions should be enforced imo.

Jan
