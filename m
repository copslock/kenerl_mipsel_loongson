Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Dec 2010 17:08:43 +0100 (CET)
Received: from netrider.rowland.org ([192.131.102.5]:33567 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1491031Ab0LWQIk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Dec 2010 17:08:40 +0100
Received: (qmail 6003 invoked by uid 500); 23 Dec 2010 11:08:36 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Dec 2010 11:08:36 -0500
Date:   Thu, 23 Dec 2010 11:08:36 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Anoop P A <anoop.pa@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Anatolij Gustschin <agust@denx.de>,
        Anand Gadiyar <gadiyar@ti.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Sarah Sharp <sarah.a.sharp@linux.intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Mortier <mortier@btinternet.com>,
        Andiry Xu <andiry.xu@amd.com>
Subject: Re: [PATCH V2 2/2] MSP onchip root hub over current quirk.
In-Reply-To: <1293096541.27661.46.camel@paanoop1-desktop>
Message-ID: <Pine.LNX.4.44L0.1012231104060.5617-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+4d08bae8@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips

On Thu, 23 Dec 2010, Anoop P A wrote:

> > > +				usb_detect_quirks(hdev);
> > 
> > This line is wrong.  usb_detect_quirks() gets called only once per 
> > device, when the device is initialized.  Besides, you probably want to 
> > use a hub-specific flag for this rather than a device-specific flag.
> 
> Can you point me to an example for the recommended way of doing the
> hack. I don't have much exposure to USB subsystem.

One example, suitable for PCI devices, can be found in 
drivers/usb/host/ehci-pci.c:ehci_pci_setup().

However the best approach would be for you to avoid adding any
special-purpose code at all.  Is it possible to handle
overcurrent-change events in a way that will work just as well for
normal hubs as for your MSP root hub?

Alan Stern
