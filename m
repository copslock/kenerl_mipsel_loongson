Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0AJwR821824
	for linux-mips-outgoing; Thu, 10 Jan 2002 11:58:27 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0AJwNg21821
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 11:58:23 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0AIvAB00713;
	Thu, 10 Jan 2002 10:57:10 -0800
Subject: Re: usb-problems with Au1000
From: Pete Popov <ppopov@mvista.com>
To: Wolfgang Heidrich <wolfgang.heidrich@esk.fhg.de>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <3C3DE1F0.F45307FB@esk.fhg.de>
References: <3B7DA3A3.8010000@pacbell.net>  <3C3DD208.45B5BC29@esk.fhg.de>
	<1010684946.29315.82.camel@zeus>  <3C3DE1F0.F45307FB@esk.fhg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Jan 2002 11:00:48 -0800
Message-Id: <1010689248.12706.109.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-01-10 at 10:48, Wolfgang Heidrich wrote:
> Hello Pete,
> 
> Pete Popov wrote:
> > 
> > On Thu, 2002-01-10 at 09:40, Wolfgang Heidrich wrote:
> > > Hello,
> > >
> 
> > > During booting the kernel initalizes the usb-device-driver and
> > > a little later prints "USB device not accepting new address...":
> > 
> > Which LSP version do you have? Do an "rpm -qa | grep hhl- | grep lsp".
> 
> hhl-cross-mips_fp_le-lsp-mips-malta-2.4.2_hhl20-hhl2.0.2
> hhl-cross-mips_fp_le-lsp-alchemy-pb1000-2.4.2_hhl20-hhl2.0.2
 
That LSP is old.  Get the _hhl20_hhl2.0.3 release. Alchemy should have
it on their ftp site by now.  Let me know if you still have problems
with 2.0.3.

Pete
 
> > There was a hardware errata in the usb controller, but a software fix is
> > already in the kernel (assuming you have a late enough kernel).  Also,
> > the usb switches, S4, should be set to:
> > 
> > 1-4 off
> > 5-6 on
> > 7-8 off
> 
> I used these settings. But as far as I know these settings are only
> relevant for the second USB.
> 
> Thanks in advance
> -- 
> Wolfgang
