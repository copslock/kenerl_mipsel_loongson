Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Apr 2013 18:18:18 +0200 (CEST)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:53476 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823124Ab3DQQSPixpPF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Apr 2013 18:18:15 +0200
Received: by mail-ie0-f181.google.com with SMTP id as1so2109121iec.26
        for <linux-mips@linux-mips.org>; Wed, 17 Apr 2013 09:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=bwiOVgoWULFHcpHhtzULNdlpwTbzMryd3QEeAx9IWSs=;
        b=hxsA25qibQOP1/atpKIjjLemBtnczB5/7kr6avjt/V+wXyU2cakMJsYyflJg4OytPb
         1aCjT9fcdfdKqviZEcQTva7gmvy69DVwOSh0ZtRmJpfuKDS5j3Ri7irD5ZMYlUh9xdpW
         3BkqvfPOQXNliMPqId3gEyT/ZBzkS3d8d7bu8QC7t4nPyAPd2PiiosKM+ngUnait09K5
         rKipA9BZA4nFhoIIBmUwUnPFQjpjHX5qR7riIkVzoTuheYBh/1o9A0u3i9670kLd0IWU
         DfX3spvr/UfTnIa1I+Qqp8iKic75PYEplQR6Zuok8HuaS+u7Mkxs0j4n0fGRmS0Ebd0B
         Y1yQ==
X-Received: by 10.50.103.33 with SMTP id ft1mr4602684igb.26.1366215489251;
 Wed, 17 Apr 2013 09:18:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.71 with HTTP; Wed, 17 Apr 2013 09:17:48 -0700 (PDT)
In-Reply-To: <20130417161036.GB27197@titan.lakedaemon.net>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com> <20130416103005.GB12726@arm.com>
 <20130417160015.777453E2B73@localhost> <20130417161036.GB27197@titan.lakedaemon.net>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Wed, 17 Apr 2013 17:17:48 +0100
X-Google-Sender-Auth: KFg0Xu32U3b5M6OzvYh4lQSLom4
Message-ID: <CACxGe6sNk=wNinTcMHbJa5o-56Tyh=0CnFSEW+Hk-ujpjeg2gQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
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
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQkw7b2RuX7548UCzZeOBO42FZBiTUgBtRs3GnpiHdtwR9NDRxrm8JgdnBCL3MnZEMVJwhIM
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36253
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

On Wed, Apr 17, 2013 at 5:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Wed, Apr 17, 2013 at 05:00:15PM +0100, Grant Likely wrote:
>> On Tue, 16 Apr 2013 11:30:06 +0100, Andrew Murray <andrew.murray@arm.com> wrote:
>> > On Tue, Apr 16, 2013 at 11:18:26AM +0100, Andrew Murray wrote:
>> > > The pci_process_bridge_OF_ranges function, used to parse the "ranges"
>> > > property of a PCI host device, is found in both Microblaze and PowerPC
>> > > architectures. These implementations are nearly identical. This patch
>> > > moves this common code to a common place.
>> > >
>> > > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
>> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>> > > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
>> > > Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> > > Tested-by: Linus Walleij <linus.walleij@linaro.org>
>> > > Acked-by: Michal Simek <monstr@monstr.eu>
>> > > ---
>> > >  arch/microblaze/include/asm/pci-bridge.h |    5 +-
>> > >  arch/microblaze/pci/pci-common.c         |  192 ----------------------------
>> > >  arch/powerpc/include/asm/pci-bridge.h    |    5 +-
>> > >  arch/powerpc/kernel/pci-common.c         |  192 ----------------------------
>> >
>> > Is there anyone on linuxppc-dev/linux-mips that can help test this patchset?
>> >
>> > I've tested that it builds on powerpc with a variety of configs (some which
>> > include fsl_pci.c implementation). Though I don't have hardware to verify that
>> > it works.
>> >
>> > I haven't tested this builds or runs on MIPS.
>> >
>> > You shouldn't see any difference in behaviour or new warnings and PCI devices
>> > should continue to operate as before.
>>
>> I've got through a line-by-line comparison between powerpc, microblaze,
>> and then new code. The differences are purely cosmetic, so I have
>> absolutely no concerns about this patch. I've applied it to my tree.
>
> oops.  Due to the number of dependencies the mvebu-pcie series has (this
> being one of them, we (arm-soc/mvebu) asked if we could take this
> through our tree.  Rob Herring agreed to this several days ago.  Is this
> a problem for you?
>
> It would truly (dogs and cats living together) upset the apple cart for
> us at this stage to pipe these through a different tree...

Not a problem at all. I'll drop it.

g.
