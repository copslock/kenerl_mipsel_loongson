Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 06:25:10 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:33854 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817237Ab3JIEZGurCjG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 06:25:06 +0200
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r994O8uH030583;
        Tue, 8 Oct 2013 23:24:09 -0500
Message-ID: <1381292648.645.259.camel@pasglop>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Alexander Gordeev <agordeev@redhat.com>,
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
        VMware@dhcp-26-207.brq.redhat.com, "Inc." <pv-drivers@vmware.com>,
        linux-scsi@vger.kernel.org
Date:   Wed, 09 Oct 2013 15:24:08 +1100
In-Reply-To: <5254D397.9030307@zytor.com>
References: <cover.1380703262.git.agordeev@redhat.com>
         <5254D397.9030307@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
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

On Tue, 2013-10-08 at 20:55 -0700, H. Peter Anvin wrote:
> Why not add a minimum number to pci_enable_msix(), i.e.:
> 
> pci_enable_msix(pdev, msix_entries, nvec, minvec)
> 
> ... which means "nvec" is the number of interrupts *requested*, and
> "minvec" is the minimum acceptable number (otherwise fail).

Which is exactly what Ben (the other Ben :-) suggested and that I
supports...

Cheers,
Ben.
