Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 23:46:37 +0200 (CEST)
Received: from webmail.solarflare.com ([12.187.104.25]:33126 "EHLO
        webmail.solarflare.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868693Ab3JCVqfcQkIV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Oct 2013 23:46:35 +0200
Received: from [10.17.20.137] (10.17.20.137) by ocex02.SolarFlarecom.com
 (10.20.40.31) with Microsoft SMTP Server (TLS) id 14.3.158.1; Thu, 3 Oct 2013
 14:46:25 -0700
Message-ID: <1380836781.3419.17.camel@bwh-desktop.uk.level5networks.com>
Subject: Re: [PATCH RFC 01/77] PCI/MSI: Fix return value when
 populate_msi_sysfs() failed
From:   Ben Hutchings <bhutchings@solarflare.com>
To:     Jon Mason <jon.mason@intel.com>
CC:     Alexander Gordeev <agordeev@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Ingo Molnar" <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux390@de.ibm.com>, <linux-s390@vger.kernel.org>,
        <x86@kernel.org>, <linux-ide@vger.kernel.org>,
        <iss_storagedev@hp.com>, <linux-nvme@lists.infradead.org>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
        <e1000-devel@lists.sourceforge.net>, <linux-driver@qlogic.com>,
        "Solarflare linux maintainers" <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        <linux-scsi@vger.kernel.org>
Date:   Thu, 3 Oct 2013 22:46:21 +0100
In-Reply-To: <20131003003905.GK6768@jonmason-lab>
References: <cover.1380703262.git.agordeev@redhat.com>
         <3ff5236944aae69f2cd934b5b6da7c1c269df7c1.1380703262.git.agordeev@redhat.com>
         <20131003003905.GK6768@jonmason-lab>
Organization: Solarflare
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.6.4 (3.6.4-3.fc18) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.137]
X-TM-AS-Product-Ver: SMEX-10.0.0.1412-7.000.1014-20192.004
X-TM-AS-Result: No--20.388900-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Return-Path: <bhutchings@solarflare.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhutchings@solarflare.com
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

On Wed, 2013-10-02 at 17:39 -0700, Jon Mason wrote:
> On Wed, Oct 02, 2013 at 12:48:17PM +0200, Alexander Gordeev wrote:
> > Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> 
> Since you are changing the behavior of the msix_capability_init
> function on populate_msi_sysfs error, a comment describing why in this
> commit would be nice.
[...]

This function was already treating that error as fatal, and freeing the
MSIs.  The change in behaviour is that it now returns the error code in
this case, rather than 0.  This is obviously correct and properly
described by the one-line summary.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
