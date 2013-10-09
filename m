Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 05:56:43 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:45103 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817326Ab3JID4edv3YQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 05:56:34 +0200
Received: from tazenda.hos.anvin.org ([IPv6:2601:9:3340:50:3c60:74ff:feb0:5242])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id r993tsTL009705
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Tue, 8 Oct 2013 20:55:56 -0700
Message-ID: <5254D397.9030307@zytor.com>
Date:   Tue, 08 Oct 2013 20:55:03 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130923 Thunderbird/17.0.9
MIME-Version: 1.0
To:     Alexander Gordeev <agordeev@redhat.com>
CC:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
        VMware@dhcp-26-207.brq.redhat.com, "Inc." <pv-drivers@vmware.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement pattern
References: <cover.1380703262.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38278
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

On 10/02/2013 03:29 AM, Alexander Gordeev wrote:
> 
> As result, device drivers will cease to use the overcomplicated
> repeated fallbacks technique and resort to a straightforward
> pattern - determine the number of MSI/MSI-X interrupts required
> before calling pci_enable_msi_block() and pci_enable_msix()
> interfaces:
> 
> 
> 	rc = pci_msix_table_size(adapter->pdev);
> 	if (rc < 0)
> 		return rc;
> 
> 	nvec = min(nvec, rc);
> 	if (nvec < FOO_DRIVER_MINIMUM_NVEC) {
> 		return -ENOSPC;
> 
> 	for (i = 0; i < nvec; i++)
> 		adapter->msix_entries[i].entry = i;
> 
> 	rc = pci_enable_msix(adapter->pdev,
> 			     adapter->msix_entries, nvec);
> 	return rc;
> 

Why not add a minimum number to pci_enable_msix(), i.e.:

pci_enable_msix(pdev, msix_entries, nvec, minvec)

... which means "nvec" is the number of interrupts *requested*, and
"minvec" is the minimum acceptable number (otherwise fail).

	-hpa
