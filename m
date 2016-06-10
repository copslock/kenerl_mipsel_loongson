Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 12:56:18 +0200 (CEST)
Received: from smtprelay.synopsys.com ([198.182.60.111]:44934 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041564AbcFJK4PJ0Od8 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2016 12:56:15 +0200
Received: from us02secmta1.synopsys.com (us02secmta1.synopsys.com [10.12.235.96])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6251610C14FA;
        Fri, 10 Jun 2016 03:56:01 -0700 (PDT)
Received: from us02secmta1.internal.synopsys.com (us02secmta1.internal.synopsys.com [127.0.0.1])
        by us02secmta1.internal.synopsys.com (Service) with ESMTP id DF3964E214;
        Fri, 10 Jun 2016 03:56:01 -0700 (PDT)
Received: from mailhost.synopsys.com (unknown [10.13.184.66])
        by us02secmta1.internal.synopsys.com (Service) with ESMTP id EA3B54E202;
        Fri, 10 Jun 2016 03:56:00 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id A4D8F683;
        Fri, 10 Jun 2016 03:56:00 -0700 (PDT)
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2A030658;
        Fri, 10 Jun 2016 03:55:53 -0700 (PDT)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0195.001; Fri,
 10 Jun 2016 03:55:52 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Haavard Skinnemoen" <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, "Arnd Bergmann" <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mark Yao <mark.yao@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        "Heiko Stuebner" <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Kyungmin Park" <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        Rabin Vincent <rabin@rab.in>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alex Smith <alex.smith@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: [PATCH v4 43/44] dma-mapping: Remove dma_get_attr
Thread-Topic: [PATCH v4 43/44] dma-mapping: Remove dma_get_attr
Thread-Index: AQHRwwDiJBPEkAQaUUSOcrcZk/kYQg==
Date:   Fri, 10 Jun 2016 10:55:52 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501069390A9@US01WEMBX2.internal.synopsys.com>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
 <1465553521-27303-44-git-send-email-k.kozlowski@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

On Friday 10 June 2016 03:44 PM, Krzysztof Kozlowski wrote:
> After switching DMA attributes to unsigned long it is easier to just
> compare the bits.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> [for avr32]
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>

Acked-by: Vineet Gupta <vgupta@synopsys.com>   #for arch/arc
