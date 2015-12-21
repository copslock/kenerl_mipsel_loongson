Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Dec 2015 22:33:19 +0100 (CET)
Received: from vs19.mail.saunalahti.fi ([62.142.117.200]:45602 "EHLO
        vs19.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008831AbbLUVdR6XVOv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Dec 2015 22:33:17 +0100
Received: from vams (localhost [127.0.0.1])
        by vs19.mail.saunalahti.fi (Postfix) with SMTP id 7435128016A;
        Mon, 21 Dec 2015 23:33:12 +0200 (EET)
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi [195.197.172.111])
        by vs19.mail.saunalahti.fi (Postfix) with ESMTP id 6053F28016A;
        Mon, 21 Dec 2015 23:33:12 +0200 (EET)
Received: from Orion (91-157-120-53.elisa-laajakaista.fi [91.157.120.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gw03.mail.saunalahti.fi (Postfix) with ESMTPSA id 4A46220009;
        Mon, 21 Dec 2015 23:33:10 +0200 (EET)
From:   "Matti Laakso" <malaakso@elisanet.fi>
To:     <Liviu.Dudau@arm.com>
Cc:     <linux-mips@linux-mips.org>
References: <56732950.4060201@elisanet.fi> <20151218114210.GJ960@e106497-lin.cambridge.arm.com> <010801d13a6d$31eb3740$95c1a5c0$@elisanet.fi> <20151221104900.GN960@e106497-lin.cambridge.arm.com>
In-Reply-To: <20151221104900.GN960@e106497-lin.cambridge.arm.com>
Subject: RE: Unable to allocate PCI I/O resources
Date:   Mon, 21 Dec 2015 23:33:06 +0200
Message-ID: <001201d13c37$2faa41d0$8efec570$@elisanet.fi>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQABAgME7K2rcGz0btYjkKrajbWSxQDxiSx3om7O3tA=
Content-Language: fi
Return-Path: <malaakso@elisanet.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malaakso@elisanet.fi
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

> On Sat, Dec 19, 2015 at 04:54:41PM +0200, Matti Laakso wrote:
> > Second try after webmail messed up my first message.
> >
> > > On Thu, Dec 17, 2015 at 11:29:52PM +0200, Matti Laakso wrote:
> > > > Hello all,
> > > > 
> > > > I have some oldish MIPS-based (Lantiq Danube) routers that have a 
> > > > PCI bus and a VIA 6212 USB-controller connected to it. The USB 
> > > > controller requires I/O resources in addition to memory. It seems 
> > > > that with kernel
> > > > 3.18 and newer PCI I/O resources can no longer be allocated on 
> > > > this platform. I tracked the problem down to a patch set from 
> > > > Liviu Dudau (Support for creating generic PCI host bridges from 
> > > > DT). After this patch the function pci_address_to_pio in 
> > > > drivers/of/address.c hits the check
> > > >
> > > > address > IO_SPACE_LIMIT
> > > >
> > > > since address on this SoC is 0x1AE00000 and IO_SPACE_LIMIT is 
> > > > 0xFFFF on MIPS (PCI_IOBASE is not defined). Changing 
> > > > IO_SPACE_LIMIT to 0xFFFFFFFF I can work around the problem, but I think that is not the proper solution.
> > >
> > > if PCI_IOBASE is not defined then you should not hit the code I have added with commit 41f8bba7f5552d0 but the old code path, in which case I would guess the code was broken before my change?
> > >
> > 
> > Well, before your change of_pci_range_to_resource() simply filled the resource struct without any checks. Now it fills it with OF_BAD_ADDR. Maybe it was broken, but at least it worked in this case.
>
> Yes, but if you look in the git log the change was not due to my commit, but Rob Herring's 25ff7944 where he removed the MIPS specific version of pci_address_to_pio(). But even then, that version had a BUG_ON(address > IO_SPACE_LIMIT) so that would not have worked for you either. And IO_SPACE_LIMIT has been set to 0xffff since the beginning of GIT history, so there must have been a different reason why your system worked before.
>

The commit that breaks my device is 0b0b0893 (of/pci: Fix the conversion of IO ranges into IO resources, from you). Sorry, should've been more specific earlier. It is easy to see that when the user of of_pci_range_to_resource(), in my case pci_load_of_ranges() from arch/mips/pci/pci.c, simply passes the CPU address in the range struct, it no longer works as before. Neither the MIPS specific nor general pci_address_to_pio() used to be called in my case (following code from ltq_pci_probe() in arch/mips/pci/pci-lantiq.c).

> > 
> > > > 
> > > > Any ideas on how to fix this?
> > > >
> > >
> > > There is a distinction between IO range being visible from the CPU @ 0x1AE00000 and the IO address being used by the PCI subsystem. The IO address is a bus address and it should be between 0 - IO_SPACE_LIMIT.
> > >
> > 
> > From reading the code in of_pci_range_to_resource() I'd expect pci_address_to_pio(range->cpu_addr) to get the CPU address as its argument. Why is it checked against IO_SPACE_LIMIT? Or is the IO address yet different from PCI address (meaning, range->pci_addr)?
>
> The kernel treats all supported architectures as being x86 compatible. That means the IO space from a CPU point of view is limited to the [0 - 0xffff] range inside each bus. Because most non-x86 architectures don't have a special instruction for reading from IO space, we play various tricks to make the CPU see the flat address, while still keeping the kernel happy that the IO space is limited on PCI.
>
> Now, of_pci_range_to_resource() is parsing the OF range description that ignores the kernel internal view of IO space and lists the addresses as seen from CPU point of view if such limitation did not exist. We use those addresses (stored in range->cpu_addr) to build the "IO port" address that gets put into the struct resource.
>
> It might be useful if you give a bit more information on your setup. Are you using a device tree? If so, can you post the PCI node here?
>

Thanks for the explanation. My PCI node looks basically like this:

pci0: pci@E105400 {
	#address-cells = <3>;
	#size-cells = <2>;
	#interrupt-cells = <1>;
	compatible = "lantiq,pci-xway";
	bus-range = <0x0 0x0>;
	ranges = <0x2000000 0 0x8000000 0x8000000 0 0x2000000
		0x1000000 0 0x00000000 0xAE00000 0 0x200000>;
	reg = <0x7000000 0x8000 0xE105400 0x400>;
	lantiq,bus-clock = <33333333>;
	interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
	
	status = "okay";
	lantiq,external-clock;
	interrupt-map = <
		0x6000 0 0 1 &icu0 135
		0x7800 0 0 1 &icu0 66
		0x7800 0 0 2 &icu0 66
		0x7800 0 0 3 &icu0 66
	>;
	gpio-reset = <&gpio 21 0>;
	req-mask = <0x7>;
};

ROM, IO and SoC registers are mapped above 0x10000000.

> 
> > > I would look into the actual user of pci_address_to_pio(), and maybe define PCI_IOBASE for your platform to tell it where the IO space starts from CPU point of view.
>
> Also, have you tried my suggestion?

Not yet, as I wasn't quite sure what to set it to. I suppose 0x1AE00000?

Best regards,
Matti Laakso
