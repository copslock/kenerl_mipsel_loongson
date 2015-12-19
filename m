Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Dec 2015 15:54:51 +0100 (CET)
Received: from vs14.mail.saunalahti.fi ([62.142.117.201]:37305 "EHLO
        vs14.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007487AbbLSOytxuSW8 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Dec 2015 15:54:49 +0100
Received: from vams (localhost [127.0.0.1])
        by vs14.mail.saunalahti.fi (Postfix) with SMTP id 236AC74008F;
        Sat, 19 Dec 2015 16:54:44 +0200 (EET)
Received: from gw02.mail.saunalahti.fi (gw02.mail.saunalahti.fi [195.197.172.116])
        by vs14.mail.saunalahti.fi (Postfix) with ESMTP id 0577774008F;
        Sat, 19 Dec 2015 16:54:44 +0200 (EET)
Received: from Orion (91-157-120-53.elisa-laajakaista.fi [91.157.120.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gw02.mail.saunalahti.fi (Postfix) with ESMTPSA id E5093400A3;
        Sat, 19 Dec 2015 16:54:41 +0200 (EET)
From:   "Matti Laakso" <malaakso@elisanet.fi>
To:     <Liviu.Dudau@arm.com>
Cc:     <linux-mips@linux-mips.org>
References: <56732950.4060201@elisanet.fi> <20151218114210.GJ960@e106497-lin.cambridge.arm.com>
In-Reply-To: <20151218114210.GJ960@e106497-lin.cambridge.arm.com>
Subject: RE: Unable to allocate PCI I/O resources
Date:   Sat, 19 Dec 2015 16:54:41 +0200
Message-ID: <010801d13a6d$31eb3740$95c1a5c0$@elisanet.fi>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQABAgME7K2rcGz0btYjkKrajbWSxaJy0ctA
Content-Language: fi
Return-Path: <malaakso@elisanet.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50699
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

Second try after webmail messed up my first message.

> On Thu, Dec 17, 2015 at 11:29:52PM +0200, Matti Laakso wrote:
> > Hello all,
> > 
> > I have some oldish MIPS-based (Lantiq Danube) routers that have a PCI 
> > bus and a VIA 6212 USB-controller connected to it. The USB controller 
> > requires I/O resources in addition to memory. It seems that with 
> > kernel
> > 3.18 and newer PCI I/O resources can no longer be allocated on this 
> > platform. I tracked the problem down to a patch set from Liviu Dudau 
> > (Support for creating generic PCI host bridges from DT). After this 
> > patch the function pci_address_to_pio in drivers/of/address.c hits the 
> > check
> >
> > address > IO_SPACE_LIMIT
> >
> > since address on this SoC is 0x1AE00000 and IO_SPACE_LIMIT is 0xFFFF 
> > on MIPS (PCI_IOBASE is not defined). Changing IO_SPACE_LIMIT to 
> > 0xFFFFFFFF I can work around the problem, but I think that is not the proper solution.
>
> if PCI_IOBASE is not defined then you should not hit the code I have added with commit 41f8bba7f5552d0 but the old code path, in which case I would guess the code was broken before my change?
>

Well, before your change of_pci_range_to_resource() simply filled the resource struct without any checks. Now it fills it with OF_BAD_ADDR. Maybe it was broken, but at least it worked in this case.

> > 
> > Any ideas on how to fix this?
> >
>
> There is a distinction between IO range being visible from the CPU @ 0x1AE00000 and the IO address being used by the PCI subsystem. The IO address is a bus address and it should be between 0 - IO_SPACE_LIMIT.
>

From reading the code in of_pci_range_to_resource() I'd expect pci_address_to_pio(range->cpu_addr) to get the CPU address as its argument. Why is it checked against IO_SPACE_LIMIT? Or is the IO address yet different from PCI address (meaning, range->pci_addr)?

> I would look into the actual user of pci_address_to_pio(), and maybe define PCI_IOBASE for your platform to tell it where the IO space starts from CPU point of view.
>

Best regards,
Matti Laakso
