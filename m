Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 01:15:42 +0100 (CET)
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:27956 "EHLO
        g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491970Ab0BWAPc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2010 01:15:32 +0100
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
        by g5t0007.atlanta.hp.com (Postfix) with ESMTP id 35463143E2;
        Tue, 23 Feb 2010 00:15:26 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g5t0030.atlanta.hp.com (Postfix) with ESMTP id C770C1407A;
        Tue, 23 Feb 2010 00:15:25 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id 90DDACF004A;
        Mon, 22 Feb 2010 17:15:25 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EFMAYtJ3hrgo; Mon, 22 Feb 2010 17:15:25 -0700 (MST)
Received: from tigger.helgaas (lart.fc.hp.com [15.11.146.31])
        by ldl (Postfix) with ESMTP id 7B97ECF0011;
        Mon, 22 Feb 2010 17:15:25 -0700 (MST)
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: Reverting old hack
Date:   Mon, 22 Feb 2010 17:15:24 -0700
User-Agent: KMail/1.9.10
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <20100220113134.GA27194@linux-mips.org> <201002221355.28939.bjorn.helgaas@hp.com> <20100223085143.aeb1fa53.yuasa@linux-mips.org>
In-Reply-To: <20100223085143.aeb1fa53.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002221715.24674.bjorn.helgaas@hp.com>
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

On Monday 22 February 2010 04:51:43 pm Yoichi Yuasa wrote:
> Hi Bjorn,
> 
> On Mon, 22 Feb 2010 13:55:28 -0700
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> > On Sunday 21 February 2010 12:45:31 am Yoichi Yuasa wrote:
> > > > I'd like to understand the PCI architecture of Cobalt better.  Would you
> > > > mind turning on CONFIG_PCI_DEBUG and posting the dmesg log?
> > > 
> > > If you want to know what happen, you can see my old e-mail. 
> > > 
> > > http://marc.info/?l=linux-kernel&m=118792430424186&w=2
> > 
> > There's not much detail there.  It would save me a lot of time if
> > you could collect the complete dmesg log, /proc/iomem, and /proc/ioports.
> 
> It cannot boot without old hack.

I know; I meant that the information from a kernel with the old
hack would be useful.  But I think I'm starting to understand anyway.

The Linux I/O port number space is defined here:

    static struct resource cobalt_io_resource = {
        .start  = 0x1000,
        .end    = GT_DEF_PCI0_IO_SIZE - 1,  /* 0x1ffffff */

[As an aside, I'm not sure 0x1000 is the correct start -- for example,
I think Linux I/O port 0x1f0 is forwarded by the host bridge.]

The corresponding PCI I/O port numbers are determined by the PCI
I/O decoder address, so I agree that we need the io_offset to convert
between the Linux port numbers and ports that appear on the PCI bus.

I think the IDE device is a problem because pci_setup_device() fills
in legacy resources with ports 0x1f0-0x1f7, etc.  We expect those
resources to contain PCI bus addresses at this point, but we could
never see those addresses on the Cobalt PCI bus (we would only see
things in the range 0x10000000-0x11ffffff).

When we convert 0x1f0 with pcibios_bus_to_resource() (or with
pcibios_fixup_device_resources() without the IORESOURCE_PCI_FIXED
hack), we get 0x1f0 + 0xf0000000 == 0xf00001f0, when we want 0x1f0
instead.

> pata_via 0000:00:09.1: BAR 0: can't reserve [io  0xf00001f0-0xf00001f7]

I still don't know the best way to fix this, but does this make sense
so far?

Bjorn
