Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Dec 2010 10:21:05 +0100 (CET)
Received: from mail-yi0-f49.google.com ([209.85.218.49]:39962 "EHLO
        mail-yi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491016Ab0LWJVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Dec 2010 10:21:02 +0100
Received: by yib2 with SMTP id 2so867689yib.36
        for <multiple recipients>; Thu, 23 Dec 2010 01:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=vWTCy3Nn+wkiGSZRYYyOLutQltazPLhTcAjo1t6+EAU=;
        b=b2t4EtU31wKLoJT0I89eK5VuJ92T0pJGJOZUdw7PJ2ftcWG2dL3dSLoG3g2oK1dVgD
         njCGBbYDUAO7QPY3aOnJriGGuk+tpYJ//MJOW9wXDxokC1i9OtLxHWIoCwkG4yca7TwF
         MEhRzUYZoLD9K0v+4IW9FeajlAdksu2U1bDhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=cR3S1rnYr0qwFLZh+nRGId1TU+aENBLWQJLzR597fXK2ZZ15l3xlgVKc0Mu+OMTL/q
         PDuCcKgvPR4AhUKViix78WzfRcFkvWhDRea1fT65NmwGG3ATELM4ZfGBhb4gxOtoMPJI
         1L8FxdtIi511yiz/8iv5wsC1WhGUtJ7xVeUF4=
Received: by 10.91.121.3 with SMTP id y3mr9815936agm.156.1293096056185;
        Thu, 23 Dec 2010 01:20:56 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id 35sm12269091ano.11.2010.12.23.01.20.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Dec 2010 01:20:54 -0800 (PST)
Subject: Re: [PATCH V2 2/2] MSP onchip root hub over current quirk.
From:   Anoop P A <anoop.pa@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Anatolij Gustschin <agust@denx.de>,
        Anand Gadiyar <gadiyar@ti.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Sarah Sharp <sarah.a.sharp@linux.intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Mortier <mortier@btinternet.com>,
        Andiry Xu <andiry.xu@amd.com>
In-Reply-To: <Pine.LNX.4.44L0.1012222112200.26667-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1012222112200.26667-100000@netrider.rowland.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 23 Dec 2010 14:59:01 +0530
Message-ID: <1293096541.27661.46.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-12-22 at 21:18 -0500, Alan Stern wrote:
> On Wed, 22 Dec 2010, Anoop P.A wrote:
> 
> > From: Anoop P A <anoop.pa@gmail.com>
> > 
> > Adding chip specific code under quirk.
> 
> NAK.  See below.
> 
> > Signed-off-by: Anoop P A <anoop.pa@gmail.com>
> > ---
> >  drivers/usb/core/hub.c     |   45 ++++++++++++++++++++++++++++++++++++++-----
> >  drivers/usb/core/quirks.c  |    3 ++
> >  include/linux/usb/quirks.h |    3 ++
> >  3 files changed, 45 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 27115b4..4bff994 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -3377,12 +3377,45 @@ static void hub_events(void)
> >  			}
> >  			
> >  			if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
> > -				dev_err (hub_dev,
> > -					"over-current change on port %d\n",
> > -					i);
> > -				clear_port_feature(hdev, i,
> > -					USB_PORT_FEAT_C_OVER_CURRENT);
> > -				hub_power_on(hub, true);
> > +				usb_detect_quirks(hdev);
> 
> This line is wrong.  usb_detect_quirks() gets called only once per 
> device, when the device is initialized.  Besides, you probably want to 
> use a hub-specific flag for this rather than a device-specific flag.

Can you point me to an example for the recommended way of doing the
hack. I don't have much exposure to USB subsystem.

> 
> > +				if (hdev->quirks & USB_QUIRK_MSP_OVERCURRENT) {
> 
> Also, it would be better to put this code in a separate subroutine 
> instead of indenting it so far.
> 
> > +					/* clear OCC bit */
> > +					clear_port_feature(hdev, i,
> > +						USB_PORT_FEAT_C_OVER_CURRENT);
> > +
> > +					/* This step is required to toggle the
> > +					* PP bit to 0 and 1 (by hub_power_on)
> > +					* in order the CSC bit to be
> > +					* transitioned properly for device
> > +					* hotplug
> > +					*/
> > +					/* clear PP bit */
> > +					clear_port_feature(hdev, i,
> > +						USB_PORT_FEAT_POWER);
> > +
> > +					/* resume power */
> > +					hub_power_on(hub, true);
> > +
> > +					/* delay 100 usec */
> > +					udelay(100);
> > +
> > +					/* read OCA bit */
> > +					if (portstatus &
> > +					(1<<USB_PORT_FEAT_OVER_CURRENT)) {
> > +						/* declare overcurrent */
> > +						dev_err(hub_dev,
> > +						"over-current change \
> > +							on port %d\n", i);
> > +					}
> > +				} else {
> > +					dev_err(hub_dev,
> > +						"over-current change \
> > +							on port %d\n", i);
> > +					clear_port_feature(hdev, i,
> > +						USB_PORT_FEAT_C_OVER_CURRENT);
> > +					hub_power_on(hub, true);
> > +				}
> > +
> >  			}
> >  
> >  			if (portchange & USB_PORT_STAT_C_RESET) {
> > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > index 25719da..59843b9 100644
> > --- a/drivers/usb/core/quirks.c
> > +++ b/drivers/usb/core/quirks.c
> > @@ -88,6 +88,9 @@ static const struct usb_device_id usb_quirk_list[] = {
> >  	/* INTEL VALUE SSD */
> >  	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
> >  
> > +	/* PMC MSP over current quirk */
> > +	{ USB_DEVICE(0x1d6b, 0x0002), .driver_info = USB_QUIRK_MSP_OVERCURRENT },
> > +
> 
> This implementation is completely wrong.  It applies to all USB-2.0
> root hubs in Linux, not just the PMC MSP.
> 
> >  	{ }  /* terminating entry must be last */
> >  };
> >  
> > diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
> > index 3e93de7..97ab168 100644
> > --- a/include/linux/usb/quirks.h
> > +++ b/include/linux/usb/quirks.h
> > @@ -30,4 +30,7 @@
> >     descriptor */
> >  #define USB_QUIRK_DELAY_INIT		0x00000040
> >  
> > +/*MSP SoC onchip EHCI overcurrent issue */
> > +#define USB_QUIRK_MSP_OVERCURRENT	0x00000080
> > +
> >  #endif /* __LINUX_USB_QUIRKS_H */
> > 
> 
Thanks
Anoop
