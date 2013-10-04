Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2013 10:33:50 +0200 (CEST)
Received: from mx0.aculab.com ([213.249.233.131]:60591 "HELO mx0.aculab.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6817090Ab3JDIdsNMhew convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Oct 2013 10:33:48 +0200
Received: (qmail 23121 invoked from network); 4 Oct 2013 08:33:41 -0000
Received: from localhost (127.0.0.1)
  by mx0.aculab.com with SMTP; 4 Oct 2013 08:33:41 -0000
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 20084-09 for <linux-mips@linux-mips.org>;
 Fri,  4 Oct 2013 09:33:41 +0100 (BST)
Received: (qmail 22969 invoked by uid 599); 4 Oct 2013 08:33:40 -0000
Received: from unknown (HELO saturn3.Aculab.com) (10.202.163.5)
    by mx0.aculab.com (qpsmtpd/0.28) with ESMTP; Fri, 04 Oct 2013 09:33:40 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement pattern
Date:   Fri, 4 Oct 2013 09:31:49 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7371@saturn3.aculab.com>
In-Reply-To: <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement pattern
Thread-Index: Ac7A24Xh24Ru1N/rSJKnB/t2ngSngQAAEvWg
References: <cover.1380703262.git.agordeev@redhat.com> <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com> <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
From:   "David Laight" <David.Laight@ACULAB.COM>
To:     "Alexander Gordeev" <agordeev@redhat.com>,
        "Ben Hutchings" <bhutchings@solarflare.com>
Cc:     <linux-mips@linux-mips.org>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        <linux-nvme@lists.infradead.org>, <linux-ide@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, "Andy King" <acking@vmware.com>,
        <linux-scsi@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <x86@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
        <linux-pci@vger.kernel.org>, <iss_storagedev@hp.com>,
        <linux-driver@qlogic.com>, "Tejun Heo" <tj@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Jon Mason" <jon.mason@intel.com>,
        "Solarflare linux maintainers" <linux-net-drivers@solarflare.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        <e1000-devel@lists.sourceforge.net>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        <linux390@de.ibm.com>, <linuxppc-dev@lists.ozlabs.org>
X-Virus-Scanned: by iCritical at mx0.aculab.com
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
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

> > It seems to me that a more useful interface would take a minimum and
> > maximum number of vectors from the driver.  This wouldn't allow the
> > driver to specify that it could only accept, say, any even number within
> > a certain range, but you could still leave the current functions
> > available for any driver that needs that.
> 
> Mmmm.. I am not sure I am getting it. Could you please rephrase?

One possibility is for drivers than can use a lot of interrupts to
request a minimum number initially and then request the additional
ones much later on.
That would make it less likely that none will be available for
devices/drivers that need them but are initialised later.

	David
