Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 03:56:10 +0200 (CEST)
Received: from mouse.start.ca ([64.140.120.56]:46881 "EHLO mouse.start.ca"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868753Ab3JIB4ALNFwD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 03:56:00 +0200
Received: from mail.rtr.ca (dhcp-24-53-240-101.cable.user.start.ca [24.53.240.101])
        by mouse.start.ca (8.14.3/8.13.5) with ESMTP id r991tSwi004851;
        Tue, 8 Oct 2013 21:55:30 -0400
Received: by mail.rtr.ca (Postfix, from userid 1003)
        id 1FCB934062B; Tue,  8 Oct 2013 21:55:27 -0400 (EDT)
Received: from [10.0.0.7] (peppy.localnet [10.0.0.7])
        by mail.rtr.ca (Postfix) with ESMTP id E2A293402EE;
        Tue,  8 Oct 2013 21:55:26 -0400 (EDT)
Message-ID: <5254B78E.3020009@start.ca>
Date:   Tue, 08 Oct 2013 21:55:26 -0400
From:   Mark Lord <kernel@start.ca>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     Alexander Gordeev <agordeev@redhat.com>,
        linux-kernel@vger.kernel.org
CC:     Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-scsi@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement pattern
References: <cover.1380703262.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <kernel@start.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kernel@start.ca
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

On 13-10-02 06:29 AM, Alexander Gordeev wrote:
..
> This update converts pci_enable_msix() and pci_enable_msi_block()
> interfaces to canonical kernel functions and makes them return a
> error code in case of failure or 0 in case of success.

Rather than silently break dozens of drivers in mysterious ways,
please invent new function names for the replacements to the
existing pci_enable_msix() and pci_enable_msi_block() functions.

That way, both in-tree and out-of-tree drivers will notice the API change,
rather than having it go unseen and just failing for unknown reasons.

Thanks.
