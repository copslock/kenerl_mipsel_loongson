Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2016 13:02:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59238 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026986AbcEELCjxbopd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 May 2016 13:02:39 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 715A0F980023D;
        Thu,  5 May 2016 12:02:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 5 May 2016 12:02:31 +0100
Received: from localhost (10.100.200.56) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 5 May
 2016 12:02:31 +0100
Date:   Thu, 5 May 2016 12:02:30 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Joshua Kinard" <kumba@gentoo.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Jens Axboe <axboe@fb.com>, <linux-kernel@vger.kernel.org>,
        Yijing Wang <wangyijing@huawei.com>,
        "John Crispin" <blogic@openwrt.org>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 03/15] MIPS: PCI: Compatibility with ARM-like PCI host
 drivers
Message-ID: <20160505110230.GA8303@NP-P-BURTON>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
 <1454499045-5020-4-git-send-email-paul.burton@imgtec.com>
 <56FB0D90.8000200@gmail.com>
 <20160404100940.GA21568@NP-P-BURTON>
 <572AA3A0.5080201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <572AA3A0.5080201@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.56]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Wed, May 04, 2016 at 06:36:32PM -0700, Florian Fainelli wrote:
> Hi Paul,
> 
> On 04/04/16 03:09, Paul Burton wrote:
> > Hi Florian,
> > 
> > Just an FYI, the pcie-xilinx driver I wrote this for has since been
> > converted away from the ARM-like pci_common_init_dev & struct hw_pci to
> > use only functions provided by the core PCI subsystem[1]. As a result
> > I've stopped using this patch & don't plan to continue work on it.
> > Perhaps it would be cleanest to do a similar conversion for the driver
> > you're using?
> 
> Yes, I did just that, but as of v4.6-rc6, I am seeing a bunch of
> undefined references while doing so:
> 
> arch/mips/pci/built-in.o: In function `pcibios_enable_device':
> (.text+0x550): undefined reference to `pcibios_plat_dev_init'
> arch/mips/pci/built-in.o: In function `pcibios_init':
> pci.c:(.init.text+0x6c): undefined reference to `pcibios_map_irq'
> pci.c:(.init.text+0x78): undefined reference to `pcibios_map_irq'
> 
> and this makes perfect sense because arch/mips/pci/pci.c is referencing
> those functions, while I did not add anything for BMIPS_GENERIC.
> 
> At this point, I would very much prefer that the MIPS/Linux kernel did
> not rely on the different machines to provide those implementations
> (though it definitively is not a big deal to add them, it just feels
> unnecessary), I will try to cook a patch for that and provide dummy
> fallbacks.

Hi Florian,

I've done much the same for Boston already - do these patches work for
you?

    https://git.linux-mips.org/cgit/linux-mti.git/commit/?id=09f91e2742fa45ec6199e2657c4302ac432b7340
    https://git.linux-mips.org/cgit/linux-mti.git/commit/?id=7fa01b789d863eed17dd948266085c636d43786f
    https://git.linux-mips.org/cgit/linux-mti.git/commit/?id=7b070e41a9f7fc2c8e0cfd94baf90134f27e89eb
    https://git.linux-mips.org/cgit/linux-mti.git/commit/?id=c1f71dfc3de4ec018d2c4d8877e81da19e500211
    https://git.linux-mips.org/cgit/linux-mti.git/commit/?id=af3c4b3ed19d556489f67f7bb46f2dc83df7a617
    https://git.linux-mips.org/cgit/linux-mti.git/commit/?id=15229366d674bc4e846d5ef779f62f8bb730fe55
    https://git.linux-mips.org/cgit/linux-mti.git/commit/?id=75b59b3bdddefda806e1b82b5b3aa60741df2e73

Or you could fetch & cherry-pick them from the linux-mti.git repository:

    git remote add mti git://git.linux-mips.org/pub/scm/linux-mti.git
    git fetch mti
    git cherry-pick 75b59b3bddde~7..75b59b3bddde

They apply cleanly to v4.5, hopefully won't need much massaging to apply
to current master. When I get to resubmitting the Boston board support
these patches will be part of it.

Thanks,
    Paul
