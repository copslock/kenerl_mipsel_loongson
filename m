Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 20:50:56 +0100 (CET)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:40964
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991685AbdLOTusi5Me- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Dec 2017 20:50:48 +0100
Received: by mail-io0-x243.google.com with SMTP id o2so3777124ioe.8;
        Fri, 15 Dec 2017 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R0TD0p4OgN+wX4CKlEo5gsWfENWGA8AU5ebSsAf/RIA=;
        b=Jx2ru9PcHM+Whd3LUEkwlewQAM6UvfT5gFADtCSPnQ3Q1Pfd5PgO06172W6mV1Jhs/
         /RNCQHUfxHkPyR7GNsGgMEd3a4n8aBmCnUzPfm1Tu/sbCKaLm/RTAVTnlJUZ13x6hebz
         wy/nCJc/IlAkFh0dvXwPrcuft/3Oy5O7v2aEBBfbCs0E+7cwuSuacEjgvl3H7kqpvnmX
         2EHt0Zd1vjJ6iIXWQ4PMwbIP/oFOlQoNDLsbso7uR0dsKdPBKUteu6DKMs+jY0IH0aRp
         4Z6U63FElguVFriYItSyFcHs/F0o+zNtihlTJHPCZTcbgJzp3QADD8UTdZFxqR/LyWRO
         FmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R0TD0p4OgN+wX4CKlEo5gsWfENWGA8AU5ebSsAf/RIA=;
        b=bOg1L6p/nIrvDpe2j07IbLiNzI17hV25bbQ+CchVtnU9+wGxQf0ut6b8EwtvCAvNCl
         ZnQKInuqFQ0lmVjkdOx2/CpCJew5icQHj4gHVld7MGOY3RGbaJQe7ulhIxTyS+e6y1H2
         X3A/F2sGu6S4T4BW1JUO9EDijvlkmxwYH43KoqVitweqmS3BwUQ+GCUmwaXnL3yYlw/2
         maX0tmcVirU+M4mnl5uSLGJFcuYysvbyKPPhW3AHMre2HpKXBogy3IN76qV7CN+EdxbF
         pjcdAP0AIotrio9Vl1C+o5a4SWMVp/1sm80133a+v3dTJLUW1bPqKDRkKPKyXS/XiJAI
         9H+g==
X-Gm-Message-State: AKGB3mJo50rpkA3cJ2i6SZTjRUMJvR7hMXRWslKvLGjnL4E3RVx6wbWF
        8AuaaDbxcCS5AGy9ci2m3vppymW6UIhlSytkZOA=
X-Google-Smtp-Source: ACJfBoth512UhfuwQy5J0u0/jUFKugEpSmEVjCXRDH13O36elRVcpAahEq33GY49mtbdLELTxjGXn0Frlcr+b0pDiP8=
X-Received: by 10.107.137.33 with SMTP id l33mr3374942iod.190.1513367442316;
 Fri, 15 Dec 2017 11:50:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.16.227 with HTTP; Fri, 15 Dec 2017 11:50:41 -0800 (PST)
In-Reply-To: <20171215171440.GB32131@red-moon>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-2-git-send-email-jim2101024@gmail.com> <20171205205926.GJ23510@bhelgaas-glaptop.roam.corp.google.com>
 <CANCKTBvoXpF-H8Pck5TsH+7tNM=di1-uoedqACE+kjNEAUodYg@mail.gmail.com>
 <20171212211404.GA95453@bhelgaas-glaptop.roam.corp.google.com> <20171215171440.GB32131@red-moon>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 15 Dec 2017 14:50:41 -0500
Message-ID: <CANCKTBsFQ7iTeaJ9GjELhYrY-e1C12-+b=EMy=p7npZutFVvvQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] SOC: brcmstb: add memory API
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

On Fri, Dec 15, 2017 at 12:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Dec 12, 2017 at 03:14:04PM -0600, Bjorn Helgaas wrote:
>> [+cc Lorenzo]
>>
>> On Tue, Dec 12, 2017 at 03:53:28PM -0500, Jim Quinlan wrote:
>> > On Tue, Dec 5, 2017 at 3:59 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > > On Tue, Nov 14, 2017 at 05:12:05PM -0500, Jim Quinlan wrote:
>> > >> From: Florian Fainelli <f.fainelli@gmail.com>
>> > >>
>> > >> This commit adds a memory API suitable for ascertaining the sizes of
>> > >> each of the N memory controllers in a Broadcom STB chip.  Its first
>> > >> user will be the Broadcom STB PCIe root complex driver, which needs
>> > >> to know these sizes to properly set up DMA mappings for inbound
>> > >> regions.
>> > >>
>> > >> We cannot use memblock here or anything like what Linux provides
>> > >> because it collapses adjacent regions within a larger block, and here
>> > >> we actually need per-memory controller addresses and sizes, which is
>> > >> why we resort to manual DT parsing.
>> > >>
>> > >> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> > >> ---
>> > >>  drivers/soc/bcm/brcmstb/Makefile |   2 +-
>> > >>  drivers/soc/bcm/brcmstb/memory.c | 172 +++++++++++++++++++++++++++++++++++++++
>> > >>  include/soc/brcmstb/memory_api.h |  25 ++++++
>> > >>  3 files changed, 198 insertions(+), 1 deletion(-)
>> > >>  create mode 100644 drivers/soc/bcm/brcmstb/memory.c
>> > >>  create mode 100644 include/soc/brcmstb/memory_api.h
>> > >>
>> > >> diff --git a/drivers/soc/bcm/brcmstb/Makefile b/drivers/soc/bcm/brcmstb/Makefile
>> > >> index 9120b27..4cea7b6 100644
>> > >> --- a/drivers/soc/bcm/brcmstb/Makefile
>> > >> +++ b/drivers/soc/bcm/brcmstb/Makefile
>> > >> @@ -1 +1 @@
>> > >> -obj-y                                += common.o biuctrl.o
>> > >> +obj-y                                += common.o biuctrl.o memory.o
>> > >> diff --git a/drivers/soc/bcm/brcmstb/memory.c b/drivers/soc/bcm/brcmstb/memory.c
>> > >> new file mode 100644
>> > >> index 0000000..eb647ad9
>> > >> --- /dev/null
>> > >> +++ b/drivers/soc/bcm/brcmstb/memory.c
>> > >
>> > > I sort of assume based on [1] that every new file should have an SPDX
>> > > identifier ("The Linux kernel requires the precise SPDX identifier in
>> > > all source files") and that the actual text of the GPL can be omitted.
>> > >
>> > > Only a few files in drivers/pci currently have an SPDX identifier.  I
>> > > don't know if that's oversight or work-in-progress or what.
>> > >
>> > > [1] https://lkml.kernel.org/r/20171204212120.484179273@linutronix.de
>> > >
>> >
>> > Bjorn, Did you get a chance to review the other commits of this
>> > submission (V3)?  I would like any additional feedback before I send
>> > out a V4 with SPDX fixes.  Thanks, JimQ
>>
>> Lorenzo is taking over drivers/pci/host/* and he'll no doubt have some
>> comments when he gets to this.  I'll point out a few quick formatting
>> things in the meantime.
>
> I need some time to review the code but overall I am quite worried about
> patches 1 and 4 in particular, it is ok to have platform host bridge
> drivers but we can't rewrite a DMA layer for a specific host bridge, I
> really do not like that - it is just not manageable from a maintenance
> perspective for the mainline kernel.
>
> Lorenzo
Hi Lorenzo,
First I note that the file drivers/pci/host/vmd.c appears to do the
same thing -- rewrite a layer over the DMA ops.  Secondly, there seems
to be no other way to accomplish what we need to do, especially that
will work with ARM, ARM64, and MIPs.  Someone raised the same point
you did and suggested I involve ARM/ARM64 maintainers, so I expanded
my "--to" list to include Russell.  I'm open to ideas.  I've asked the
HW PCIe folks to redesign the controller to accommodate an
identity-map for inbound memory, but it will be a while if that
happens, if ever. --Jim
