Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0AJnWE21593
	for linux-mips-outgoing; Thu, 10 Jan 2002 11:49:32 -0800
Received: from scan1.fhg.de (scan1.fhg.de [153.96.1.35])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0AJnRg21590
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 11:49:28 -0800
Received: from scan1.fhg.de (localhost [127.0.0.1])
	by scan1.fhg.de (8.11.1/8.11.1) with ESMTP id g0AInOb16893;
	Thu, 10 Jan 2002 19:49:24 +0100 (MET)
Received: from esk.esk.fhg.de (esk.esk.fhg.de [153.96.161.2])
	by scan1.fhg.de (8.11.1/8.11.1) with ESMTP id g0AInN216886;
	Thu, 10 Jan 2002 19:49:23 +0100 (MET)
Received: from esk.fhg.de (host4-40 [192.168.4.40])
	by esk.esk.fhg.de (8.9.3/8.9.3) with ESMTP id TAA07175;
	Thu, 10 Jan 2002 19:49:21 +0100 (MET)
Message-ID: <3C3DE1F0.F45307FB@esk.fhg.de>
Date: Thu, 10 Jan 2002 19:48:16 +0100
From: Wolfgang Heidrich <wolfgang.heidrich@esk.fhg.de>
Organization: FhG - ESK
X-Mailer: Mozilla 4.7 [de] (WinNT; I)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
CC: Pete Popov <ppopov@mvista.com>
Subject: Re: usb-problems with Au1000
References: <3B7DA3A3.8010000@pacbell.net>  <3C3DD208.45B5BC29@esk.fhg.de> <1010684946.29315.82.camel@zeus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello Pete,

Pete Popov wrote:
> 
> On Thu, 2002-01-10 at 09:40, Wolfgang Heidrich wrote:
> > Hello,
> >

> > During booting the kernel initalizes the usb-device-driver and
> > a little later prints "USB device not accepting new address...":
> 
> Which LSP version do you have? Do an "rpm -qa | grep hhl- | grep lsp".

hhl-cross-mips_fp_le-lsp-mips-malta-2.4.2_hhl20-hhl2.0.2
hhl-cross-mips_fp_le-lsp-alchemy-pb1000-2.4.2_hhl20-hhl2.0.2

> 
> There was a hardware errata in the usb controller, but a software fix is
> already in the kernel (assuming you have a late enough kernel).  Also,
> the usb switches, S4, should be set to:
> 
> 1-4 off
> 5-6 on
> 7-8 off

I used these settings. But as far as I know these settings are only
relevant for the second USB.

Thanks in advance
-- 
Wolfgang
