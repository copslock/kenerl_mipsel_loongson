Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Oct 2013 18:29:10 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:53648 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868761Ab3JJQ3HxT50y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Oct 2013 18:29:07 +0200
Received: from hanvin-mobl6.amr.corp.intel.com (fmdmzpr04-ext.fm.intel.com [192.55.55.39])
        (authenticated bits=0)
        by mail.zytor.com (8.14.7/8.14.5) with ESMTP id r9AGSWsP021938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Thu, 10 Oct 2013 09:28:33 -0700
Message-ID: <5256D5AB.4050105@zytor.com>
Date:   Thu, 10 Oct 2013 09:28:27 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Alexander Gordeev <agordeev@redhat.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux390@de.ibm.com,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement pattern
References: <cover.1380703262.git.agordeev@redhat.com> <5254D397.9030307@zytor.com> <1381292648.645.259.camel@pasglop> <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
In-Reply-To: <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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

On 10/10/2013 03:17 AM, Alexander Gordeev wrote:
> On Wed, Oct 09, 2013 at 03:24:08PM +1100, Benjamin Herrenschmidt wrote:
> 
> Ok, this suggestion sounded in one or another form by several people.
> What about name it pcim_enable_msix_range() and wrap in couple more
> helpers to complete an API:
> 
> int pcim_enable_msix_range(pdev, msix_entries, nvec, minvec);
> 	<0 - error code
> 	>0 - number of MSIs allocated, where minvec >= result <= nvec
> 
> int pcim_enable_msix(pdev, msix_entries, nvec);
> 	<0 - error code
> 	>0 - number of MSIs allocated, where 1 >= result <= nvec 
> 
> int pcim_enable_msix_exact(pdev, msix_entries, nvec);
> 	<0 - error code
> 	>0 - number of MSIs allocated, where result == nvec
> 
> The latter's return value seems odd, but I can not help to make
> it consistent with the first two.
> 

Is there a reason for the wrappers, as opposed to just specifying either
1 or nvec as the minimum?

	-hpa
