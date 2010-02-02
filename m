Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 10:29:46 +0100 (CET)
Received: from mail-ew0-f212.google.com ([209.85.219.212]:59056 "EHLO
        mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491916Ab0BBJ3m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 10:29:42 +0100
Received: by ewy4 with SMTP id 4so283341ewy.27
        for <multiple recipients>; Tue, 02 Feb 2010 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=dS52P877A5keSm9avAlhAPh1oWjyYrgwlsgsLIgbSgs=;
        b=YFMlXeZVt+ln9S66B4hSsD2uaiGS4ZB4ihMRM2wYYGQmuFz28O4E4PpZFVNAuF2/+F
         yWXmIfPUdSDvxxqZYIV8kFEmEbaZn3N8igSB2PS4mT7oO/xcb16J/pe4CwAECd6xuO2b
         z6E/ZJBD9FYa63AhYFFpTX3pUq5OEk5v5C+Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=FSPJ8ctJt2KRNjmRlFbdNDlfkoFrUt3rGw+p7W6feGSikk+l66QL+mKZ2AbN0/lSA9
         dAQY7KqXEUakcaA0h8G8ebtKNNHr4U5jGjvJRcA6l8kvZIi5n7BPJH4MeRc0uIpjY2ZP
         AOwhCEGIhPB85JdF76xpHcqj/I3qiCQSZ2Qd4=
Received: by 10.213.43.81 with SMTP id v17mr606622ebe.0.1265102977383;
        Tue, 02 Feb 2010 01:29:37 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 14sm4339274ewy.7.2010.02.02.01.29.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 01:29:35 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH 2/2] USB: add Broadcom 63xx integrated EHCI controller support.
Date:   Tue, 2 Feb 2010 10:29:08 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-server; KDE/4.3.2; x86_64; ; )
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Maxime Bizon <mbizon@freebox.fr>,
        David Brownell <dbrownell@users.sourceforge.net>,
        linux-usb@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
References: <1264874071-28851-3-git-send-email-mbizon@freebox.fr> <Pine.LNX.4.44L0.1001302110520.14199-100000@netrider.rowland.org> <20100201063934.GA13692@rhlx01.hs-esslingen.de>
In-Reply-To: <20100201063934.GA13692@rhlx01.hs-esslingen.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201002021029.08508.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi,

On Monday 01 February 2010 07:39:35 Andreas Mohr wrote:
> On Sat, Jan 30, 2010 at 09:11:45PM -0500, Alan Stern wrote:
> > On Sat, 30 Jan 2010, Maxime Bizon wrote:
> > > +static const struct hc_driver ehci_bcm63xx_hc_driver = {
> > > +	.description =		hcd_name,
> > > +	.product_desc =		"BCM63XX integrated EHCI controller",
> > > +	.hcd_priv_size =	sizeof(struct ehci_hcd),
> > > +
> > > +	.irq =			ehci_irq,
> > > +	.flags =		HCD_MEMORY | HCD_USB2,
> > > +
> > > +	.reset =		ehci_bcm63xx_setup,
> > > +	.start =		ehci_run,
> > > +	.stop =			ehci_stop,
> > > +	.shutdown =		ehci_shutdown,
> > > +
> > > +	.urb_enqueue =		ehci_urb_enqueue,
> > > +	.urb_dequeue =		ehci_urb_dequeue,
> > > +	.endpoint_disable =	ehci_endpoint_disable,
> > > +
> > > +	.get_frame_number =	ehci_get_frame,
> > > +
> > > +	.hub_status_data =	ehci_hub_status_data,
> > > +	.hub_control =		ehci_hub_control,
> > > +	.bus_suspend =		ehci_bus_suspend,
> > > +	.bus_resume =		ehci_bus_resume,
> > > +	.relinquish_port =	ehci_relinquish_port,
> > > +	.port_handed_over =	ehci_port_handed_over,
> > > +};
> >
> > You'll run into trouble if you don't include the standard
> > endpoint_reset method pointer.
> >
> > Alan Stern
> 
> And one will run into even more trouble (as did I! hung ports galore...)
> if one doesn't include the .clear_tt_buffer_complete callback either,
> due to using an outdated non-mainline-synchronized host driver
> (that was Broadcom as well, ehci-ssb.c).
> The best thing to do is a full review of all _diffs_ in _all_
> usb host kernel files in even moderately recent times (say 2.6.23 - 2.6.33)
> and add every missing required item to these bcm63xx host files, too.
> 
> Is your code coming from OpenWrt too by chance? :-P

It is not, Maxime wrote it from scratch, I integrated it as part of the 
brcm63xx port.
-- 
Regards, Florian
