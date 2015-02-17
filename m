Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2015 11:08:55 +0100 (CET)
Received: from mail.emea.novell.com ([130.57.118.101]:42691 "EHLO
        mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013424AbbBQKIx4ku4W convert rfc822-to-8bit (ORCPT
        <rfc822;groupwise-linux-mips@linux-mips.org:9:1>);
        Tue, 17 Feb 2015 11:08:53 +0100
Received: from EMEA1-MTA by mail.emea.novell.com
        with Novell_GroupWise; Tue, 17 Feb 2015 10:08:52 +0000
Message-Id: <54E321400200007800060865@mail.emea.novell.com>
X-Mailer: Novell GroupWise Internet Agent 14.0.1 
Date:   Tue, 17 Feb 2015 10:08:48 +0000
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Wang Xiaoming" <xiaoming.wang@intel.com>
Cc:     <chris@chris-wilson.co.uk>, <david.vrabel@citrix.com>,
        <lauraa@codeaurora.org>, <heiko.carstens@de.ibm.com>,
        <linux@horizon.com>, "Chuansheng Liu" <chuansheng.liu@intel.com>,
        "Zhang Dongxing" <dongxing.zhang@intel.com>,
        <takahiro.akashi@linaro.org>, <akpm@linux-foundation.org>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <xen-devel@lists.xenproject.org>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>, <d.kasatkin@samsung.com>,
        <pebolle@tiscali.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v4] modify the IO_TLB_SEGSIZE and
 IO_TLB_DEFAULT_SIZE configurable as flexible requirement about
 SW-IOMMU.
References: <1424155903-4262-1-git-send-email-xiaoming.wang@intel.com>
In-Reply-To: <1424155903-4262-1-git-send-email-xiaoming.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <JBeulich@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;groupwise-linux-mips@linux-mips.org:9:1
Original-Recipient: rfc822;groupwise-linux-mips@linux-mips.org:9:1
X-Envid: groupwise.54E31330.215:78:76fe:N
Envelope-Id: groupwise.54E31330.215:78:76fe:N
X-archive-position: 45840
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

>>> On 17.02.15 at 07:51, <xiaoming.wang@intel.com> wrote:
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -3438,10 +3438,12 @@ bytes respectively. Such letter suffixes can also be 
> entirely omitted.
>  			it if 0 is given (See Documentation/cgroups/memory.txt)
>  
>  	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
> -			Format: { <int> | force }
> +			Format: { <int> | force | <int> | <int>}
>  			<int> -- Number of I/O TLB slabs
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
> +			<int> -- Maximum allowable number of contiguous slabs to map
> +			<int> -- The size of SW-MMU mapped.

This makes no sense - the new numbers added aren't position
independent (nor were the previous <int> and "force").

Also you are (supposedly) removing all uses of
IO_TLB_DEFAULT_SIZE, yet you don't seem to remove the
definition itself.

Finally - are arbitrary numbers really okay for the newly added
command line options? I.e. shouldn't you add some checking of
their validity?

Jan
