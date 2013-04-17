Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Apr 2013 16:25:28 +0200 (CEST)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42236 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6816285Ab3DQQWmto02F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Apr 2013 18:22:42 +0200
Received: from pool-72-84-113-162.nrflva.fios.verizon.net ([72.84.113.162] helo=titan)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1USV7t-000Fg5-QT; Wed, 17 Apr 2013 16:22:29 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id 252CA41904C;
        Wed, 17 Apr 2013 12:22:23 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 72.84.113.162
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19gwcDWZvcdD87ticAuqS7cfAl+WojUIho=
Date:   Wed, 17 Apr 2013 12:22:23 -0400
From:   Jason Cooper <jason@lakedaemon.net>
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "jg1.han@samsung.com" <jg1.han@samsung.com>,
        "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
        "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "thomas.petazzoni@free-electrons.com" 
        <thomas.petazzoni@free-electrons.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Murray <andrew.murray@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v7 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
Message-ID: <20130417162223.GC27197@titan.lakedaemon.net>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com>
 <20130416103005.GB12726@arm.com>
 <20130417160015.777453E2B73@localhost>
 <20130417161036.GB27197@titan.lakedaemon.net>
 <CACxGe6sNk=wNinTcMHbJa5o-56Tyh=0CnFSEW+Hk-ujpjeg2gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACxGe6sNk=wNinTcMHbJa5o-56Tyh=0CnFSEW+Hk-ujpjeg2gQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36292
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

On Wed, Apr 17, 2013 at 05:17:48PM +0100, Grant Likely wrote:
> On Wed, Apr 17, 2013 at 5:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Wed, Apr 17, 2013 at 05:00:15PM +0100, Grant Likely wrote:
> >> On Tue, 16 Apr 2013 11:30:06 +0100, Andrew Murray <andrew.murray@arm.com> wrote:
> >> > On Tue, Apr 16, 2013 at 11:18:26AM +0100, Andrew Murray wrote:
> >> > > The pci_process_bridge_OF_ranges function, used to parse the "ranges"
> >> > > property of a PCI host device, is found in both Microblaze and PowerPC
> >> > > architectures. These implementations are nearly identical. This patch
> >> > > moves this common code to a common place.
> >> > >
> >> > > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> >> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> >> > > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> >> > > Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >> > > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> >> > > Acked-by: Michal Simek <monstr@monstr.eu>
> >> > > ---
> >> > >  arch/microblaze/include/asm/pci-bridge.h |    5 +-
> >> > >  arch/microblaze/pci/pci-common.c         |  192 ----------------------------
> >> > >  arch/powerpc/include/asm/pci-bridge.h    |    5 +-
> >> > >  arch/powerpc/kernel/pci-common.c         |  192 ----------------------------
> >> >
> >> > Is there anyone on linuxppc-dev/linux-mips that can help test this patchset?
> >> >
> >> > I've tested that it builds on powerpc with a variety of configs (some which
> >> > include fsl_pci.c implementation). Though I don't have hardware to verify that
> >> > it works.
> >> >
> >> > I haven't tested this builds or runs on MIPS.
> >> >
> >> > You shouldn't see any difference in behaviour or new warnings and PCI devices
> >> > should continue to operate as before.
> >>
> >> I've got through a line-by-line comparison between powerpc, microblaze,
> >> and then new code. The differences are purely cosmetic, so I have
> >> absolutely no concerns about this patch. I've applied it to my tree.
> >
> > oops.  Due to the number of dependencies the mvebu-pcie series has (this
> > being one of them, we (arm-soc/mvebu) asked if we could take this
> > through our tree.  Rob Herring agreed to this several days ago.  Is this
> > a problem for you?
> >
> > It would truly (dogs and cats living together) upset the apple cart for
> > us at this stage to pipe these through a different tree...
> 
> Not a problem at all. I'll drop it.

Great!  Thanks.

Jason.
