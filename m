Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 18:03:05 +0200 (CEST)
Received: from smtp-out4.electric.net ([192.162.216.181]:51903 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993376AbdJCQCye0Ja3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Oct 2017 18:02:54 +0200
Received: from 1dzPe5-0007Wf-Tg by out4a.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1dzPee-0005RM-U7; Tue, 03 Oct 2017 09:02:44 -0700
Received: by emcmailer; Tue, 03 Oct 2017 09:02:44 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out4a.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1dzPe5-0007Wf-Tg; Tue, 03 Oct 2017 09:02:09 -0700
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Tue, 3 Oct 2017 17:02:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 02/11] x86: make dma_cache_sync a no-op
Thread-Topic: [PATCH 02/11] x86: make dma_cache_sync a no-op
Thread-Index: AQHTPDT4y1gt6BpuJ0WjoGP/hvSJ8KLSSINg
Date:   Tue, 3 Oct 2017 16:02:10 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0088B73@AcuExch.aculab.com>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-3-hch@lst.de>
In-Reply-To: <20171003104311.10058-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.99.200]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuExch.aculab.com
X-TLS:  TLSv1:AES128-SHA:128
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60239
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

From: Christoph Hellwig
> Sent: 03 October 2017 11:43
> x86 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
> make any sense to do any work in dma_cache_sync given that it must be a
> no-op when dma_alloc_attrs returns coherent memory.

I believe it is just about possible to require an explicit
write flush on x86.
ISTR this can happen with something like write combining.

Whether this can actually happen is the kernel is another matter.

	David
