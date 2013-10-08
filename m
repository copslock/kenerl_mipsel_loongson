Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 09:55:15 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:27676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823119Ab3JHHzNSX85k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 09:55:13 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r987sqKN028615
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 8 Oct 2013 03:54:52 -0400
Received: from dhcp-26-207.brq.redhat.com (vpn-57-75.rdu2.redhat.com [10.10.57.75])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r987si4G030073
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 8 Oct 2013 03:54:46 -0400
Date:   Tue, 8 Oct 2013 09:56:59 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH RFC 05/77] PCI/MSI: Convert pci_msix_table_size() to a
 public interface
Message-ID: <20131008075658.GE10669@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
 <20131007181043.GA27396@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131007181043.GA27396@htj.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agordeev@redhat.com
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

On Mon, Oct 07, 2013 at 02:10:43PM -0400, Tejun Heo wrote:
> On Wed, Oct 02, 2013 at 12:48:21PM +0200, Alexander Gordeev wrote:
> > Make pci_msix_table_size() to return a error code if the device
> > does not support MSI-X. This update is needed to facilitate a
> > forthcoming re-design MSI/MSI-X interrupts enabling pattern.
> > 
> > Device drivers will use this interface to obtain maximum number
> > of MSI-X interrupts the device supports and use that value in
> > the following call to pci_enable_msix() interface.
> 
> Hmmm... I probably missed something but why is this necessary?  To
> discern between -EINVAL and -ENOSPC?  If so, does that really matter?

pci_msix_table_size() is kind of helper and returns 0 if a device does
not have MSI-X table. If we want drivers to use it we need return -EINVAL
for MSI-X incapable/disabled devices. Nothing about -ENOSPC.

> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
