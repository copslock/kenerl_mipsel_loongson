Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 11:13:06 +0200 (CEST)
Received: from mx0.aculab.com ([213.249.233.131]:53105 "HELO mx0.aculab.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6817535AbaGDJNEvJ0h7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jul 2014 11:13:04 +0200
Received: (qmail 30622 invoked from network); 4 Jul 2014 09:13:02 -0000
Received: from localhost (127.0.0.1)
  by mx0.aculab.com with SMTP; 4 Jul 2014 09:13:02 -0000
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 28971-07 for <linux-mips@linux-mips.org>;
 Fri,  4 Jul 2014 10:12:55 +0100 (BST)
Received: (qmail 30526 invoked by uid 599); 4 Jul 2014 09:12:55 -0000
Received: from unknown (HELO AcuExch.aculab.com) (10.202.163.4)
    by mx0.aculab.com (qpsmtpd/0.28) with ESMTP; Fri, 04 Jul 2014 10:12:55 +0100
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Fri, 4 Jul 2014 10:11:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexander Gordeev' <agordeev@redhat.com>
CC:     'Bjorn Helgaas' <bhelgaas@google.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
Thread-Topic: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
Thread-Index: AQHPljNB2YNqvD5cNkq3/QaNLPhjzpuOEsDAgAF8RoCAABKQ0A==
Date:   Fri, 4 Jul 2014 09:11:50 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1726C717@AcuExch.aculab.com>
References: <cover.1402405331.git.agordeev@redhat.com>
 <4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
 <20140702202201.GA28852@google.com>
 <063D6719AE5E284EB5DD2968C1650D6D1726BF4E@AcuExch.aculab.com>
 <20140704085816.GB12247@dhcp-26-207.brq.redhat.com>
In-Reply-To: <20140704085816.GB12247@dhcp-26-207.brq.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.99.200]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Virus-Scanned: by iCritical at mx0.aculab.com
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41019
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

From: Alexander Gordeev
...
> > Even if you do that, you ought to write valid interrupt information
> > into the 4th slot (maybe replicating one of the earlier interrupts).
> > Then, if the device does raise the 'unexpected' interrupt you don't
> > get a write to a random kernel location.
> 
> I might be missing something, but we are talking of MSI address space
> here, aren't we? I am not getting how we could end up with a 'write'
> to a random kernel location when a unclaimed MSI vector sent. We could
> only expect a spurious interrupt at worst, which is handled and reported.
> 
> Anyway, as I described in my reply to Bjorn, this is not a concern IMO.

I'm thinking of the following - which might be MSI-X ?
1) Hardware requests some interrupts and tells the host the BAR (and offset)
   where the 'vectors' should be written.
2) To raise an interrupt the hardware uses the 'vector' as the address
   of a normal PCIe write cycle.

So if the hardware requests 4 interrupts, but the driver (believing it
will only use 3) only write 3 vectors, and then the hardware uses the
4th vector it can write to a random location.

Debugging that would be hard!

	David
