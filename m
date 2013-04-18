Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 14:48:47 +0200 (CEST)
Received: from mail-we0-f175.google.com ([74.125.82.175]:58697 "EHLO
        mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826581Ab3DRMsmRAyWF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Apr 2013 14:48:42 +0200
Received: by mail-we0-f175.google.com with SMTP id t11so2315879wey.34
        for <linux-mips@linux-mips.org>; Thu, 18 Apr 2013 05:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:subject:to:cc:in-reply-to:references:date
         :message-id:x-gm-message-state;
        bh=5VSNEjLWX8es+MJWSiMkpkpR1iK6fhp4mNpC3fj7QbY=;
        b=ViPXJ69mVUb0/Q8Ygf7LMk0SiF7zPNBmn+lSnGZ2lM7UlJ4MzUJobJpjHslfmFTOh4
         9cEimJXcaPyv2qQXhUZ/YHvZusEFrHfPmZrKfWzrRfsNlcKdiyMuTLIlGc8YFT4RzO6u
         llW3vqBS9YB8MunnXLZOu4kM0x4C4NaXfN0q/DZJnDhig2/e4FjG/EDx6zbVoyv1KqqS
         Ns/2eZ+CxSa5tBpxY3n9KDBTSiR6Yh0Hf2XWDwHvzW8t95t/aB+9F9F2GugGtAa8yF6c
         pPZcLGW4tYkzw+psRa+xyYWD48QHiMh/PF/2zfyr+aYUGpei61KK+/LVn3I4mL32rvWK
         NhdQ==
X-Received: by 10.180.36.235 with SMTP id t11mr17921117wij.1.1366289316810;
        Thu, 18 Apr 2013 05:48:36 -0700 (PDT)
Received: from localhost (host31-53-18-197.range31-53.btcentralplus.com. [31.53.18.197])
        by mx.google.com with ESMTPS id t7sm31289783wij.2.2013.04.18.05.48.33
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 05:48:35 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id D2C733E118C; Thu, 18 Apr 2013 13:48:32 +0100 (BST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 1/3] of/pci: Unify pci_process_bridge_OF_ranges from Microblaze and PowerPC
To:     Jason Cooper <jason@lakedaemon.net>
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
        "bhelgaas@g oogle.com" <bhelgaas@google.com>,
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
In-Reply-To: <20130417162223.GC27197@titan.lakedaemon.net>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com> <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com> <20130416103005.GB12726@arm.com> <20130417160015.777453E2B73@localhost> <20130417161036.GB27197@titan.lakedaemon.net> <CACxGe6sNk=wNinTcMHbJa5o-56Tyh=0CnFSEW+Hk-ujpjeg2gQ@mail.gmail.com> <20130417162223.GC27197@titan.lakedaemon.net>
Date:   Thu, 18 Apr 2013 13:48:32 +0100
Message-Id: <20130418124832.D2C733E118C@localhost>
X-Gm-Message-State: ALoCoQnC0+dywkjDYKbLKqVPuadStmU3y6vum4frC0kioKXVDtXfhyEEn+svYcziaDncrlcX1C+s
Return-Path: <grant.likely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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

On Wed, 17 Apr 2013 12:22:23 -0400, Jason Cooper <jason@lakedaemon.net> wrote:
> On Wed, Apr 17, 2013 at 05:17:48PM +0100, Grant Likely wrote:
> > On Wed, Apr 17, 2013 at 5:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > > On Wed, Apr 17, 2013 at 05:00:15PM +0100, Grant Likely wrote:
> > >> On Tue, 16 Apr 2013 11:30:06 +0100, Andrew Murray <andrew.murray@arm.com> wrote:
> > >> > On Tue, Apr 16, 2013 at 11:18:26AM +0100, Andrew Murray wrote:
> > >> > > The pci_process_bridge_OF_ranges function, used to parse the "ranges"
> > >> > > property of a PCI host device, is found in both Microblaze and PowerPC
> > >> > > architectures. These implementations are nearly identical. This patch
> > >> > > moves this common code to a common place.
> > >> > >
> > >> > > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> > >> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > >> > > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> > >> > > Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > >> > > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > >> > > Acked-by: Michal Simek <monstr@monstr.eu>
> > >> > > ---
> > >> > >  arch/microblaze/include/asm/pci-bridge.h |    5 +-
> > >> > >  arch/microblaze/pci/pci-common.c         |  192 ----------------------------
> > >> > >  arch/powerpc/include/asm/pci-bridge.h    |    5 +-
> > >> > >  arch/powerpc/kernel/pci-common.c         |  192 ----------------------------
> > >> >
> > >> > Is there anyone on linuxppc-dev/linux-mips that can help test this patchset?
> > >> >
> > >> > I've tested that it builds on powerpc with a variety of configs (some which
> > >> > include fsl_pci.c implementation). Though I don't have hardware to verify that
> > >> > it works.
> > >> >
> > >> > I haven't tested this builds or runs on MIPS.
> > >> >
> > >> > You shouldn't see any difference in behaviour or new warnings and PCI devices
> > >> > should continue to operate as before.
> > >>
> > >> I've got through a line-by-line comparison between powerpc, microblaze,
> > >> and then new code. The differences are purely cosmetic, so I have
> > >> absolutely no concerns about this patch. I've applied it to my tree.
> > >
> > > oops.  Due to the number of dependencies the mvebu-pcie series has (this
> > > being one of them, we (arm-soc/mvebu) asked if we could take this
> > > through our tree.  Rob Herring agreed to this several days ago.  Is this
> > > a problem for you?
> > >
> > > It would truly (dogs and cats living together) upset the apple cart for
> > > us at this stage to pipe these through a different tree...
> > 
> > Not a problem at all. I'll drop it.
> 
> Great!  Thanks.

You can add my Acked-by: Grant Likely <grant.likely@linaro.org> to the
first patch. I've not reviewed out the second or third patches yet.

None of this appears to be in linux-next yet. I've boot tested on
PowerPC, but that isn't the same as an ack by the PowerPC maintainers.
It is probably too late for the whole now since we're after -rc7.
However, if you ask me to, I have absolutely no problem putting the
first patch into my tree for v3.10 merging. I went over the patch
line-by-line and am convinced that it is functionally identical.

Let me know if you need me to do this.

g.
