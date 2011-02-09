Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2011 16:25:13 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:36552 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491779Ab1BIPZK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Feb 2011 16:25:10 +0100
Received: by eyd9 with SMTP id 9so138215eyd.36
        for <multiple recipients>; Wed, 09 Feb 2011 07:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=+J0VW9KmvbHhZPSA1E7OOlfwaPHCz5ZqWh7CoO1d8Bo=;
        b=T2p67478xTowl2tS+W6UTT1lX52QjfAu1FFwzH1ZGc0VkfMSM8NJK3+Nt9hNKBZW1b
         NcTCXNZetlXByijbqVflC8mxFR9aMGjn/5AzsJBIBquRfkHhmCp5SsQqxNsTWm9k/SML
         74/w/26NSUKeErXT/vtHHmHurCQeK8yb0Obn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Q4dmV5HavU17ldy3osWUuQqHst4IOSgRNTygkVD+RgeeWV5K6pxPGOCZn+fOuj9PdS
         I4cbRiV/30YT2K5ekcth49dsnwU+fyewqqObC61eKGJpewuQN/5M80mOpBiNBA8FDvbV
         nDI//EBMuCoWgcLB6DmOh7uMkToReT5UnhwNQ=
Received: by 10.223.96.198 with SMTP id i6mr12106912fan.10.1297265103869;
        Wed, 09 Feb 2011 07:25:03 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id n2sm203790fam.28.2011.02.09.07.24.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 07:25:02 -0800 (PST)
Subject: Re: [PATCH v3] EHCI bus glue for on-chip PMC MSP USB controller.
From:   Anoop P A <anoop.pa@gmail.com>
To:     Matthieu CASTET <matthieu.castet@parrot.com>
Cc:     "gregkh@suse.de" <gregkh@suse.de>,
        "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>,
        "ust@denx.de" <ust@denx.de>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gadiyar@ti.com" <gadiyar@ti.com>,
        "alek.du@intel.com" <alek.du@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
In-Reply-To: <4D52AE7E.8000907@parrot.com>
References: <AANLkTimu_gzsd3NY+HDp7jV+EMtrHGZq7qNc3OedyT3C@mail.gmail.com>
         <1296127736-28208-1-git-send-email-anoop.pa@gmail.com>
         <4D52AE7E.8000907@parrot.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 09 Feb 2011 21:14:56 +0530
Message-ID: <1297266296.29250.69.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 8bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2011-02-09 at 16:10 +0100, Matthieu CASTET wrote:
> Anoop P.A a écrit :
> 
> >  config XPS_USB_HCD_XILINX
> > diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> > index 6fee3cd..a591890 100644
> > --- a/drivers/usb/host/ehci-hcd.c
> > +++ b/drivers/usb/host/ehci-hcd.c
> > @@ -262,6 +262,8 @@ static void tdi_reset (struct ehci_hcd *ehci)
> >         if (ehci_big_endian_mmio(ehci))
> >                 tmp |= USBMODE_BE;
> >         ehci_writel(ehci, tmp, reg_ptr);
> > +       if (ehci->pmc_msp_tdi)
> > +               usb_hcd_tdi_set_mode(ehci);
> >  }
> This is ugly to add callback to your driver here.
> How this will build on other platform, usb_hcd_tdi_set_mode is only 
> defined on ehci-pmcmsp.c

I got that will remove it from patch and resend.the patch got carried
from an older kernel :( .

Thanks

> 
> 
> > +void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci)
> > +{
> > +	u8 *base;
> > +	u8 *statreg;
> > +	u8 *fiforeg;
> > +	u32 val;
> > +	struct ehci_regs *reg_base = ehci->regs;
> > +
> > +	/* get register base */
> > +	base = (u8 *)reg_base + USB_EHCI_REG_USB_MODE;
> > +	statreg = (u8 *)reg_base + USB_EHCI_REG_USB_STATUS;
> > +	fiforeg = (u8 *)reg_base + USB_EHCI_REG_USB_FIFO;
> > +
> > +	/* set the controller to host mode and BIG ENDIAN */
> > +	ehci_writel(ehci, (USB_CTRL_MODE_HOST | USB_CTRL_MODE_BIG_ENDIAN
> > +		| USB_CTRL_MODE_STREAM_DISABLE), (u32 *)base);
> > +
> We have done that in tdi_reset, why do you do it again ?
> 
> 
> Matthieu
