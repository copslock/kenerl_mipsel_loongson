Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Sep 2006 06:43:14 +0100 (BST)
Received: from out001.atlarge.net ([129.41.63.69]:54547 "EHLO
	out001.atlarge.net") by ftp.linux-mips.org with ESMTP
	id S20037798AbWIGFnM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Sep 2006 06:43:12 +0100
Received: from hpmailfe-01.atlarge.net ([10.100.60.156]) by out001.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 7 Sep 2006 00:41:43 -0500
Received: from localhost ([213.250.36.225]) by hpmailfe-01.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 7 Sep 2006 00:41:41 -0500
Date:	Thu, 7 Sep 2006 07:43:02 +0200
From:	Domen Puncer <domen.puncer@telargo.com>
To:	Tomasz Chmielewski <mangoo@wpkg.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: no USB device other than storage detected
Message-ID: <20060907054302.GF5361@domen.puncer.telargo.com>
References: <44FD6CE4.6010001@wpkg.org> <44FF25BE.5020901@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FF25BE.5020901@wpkg.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 07 Sep 2006 05:41:42.0567 (UTC) FILETIME=[4C407370:01C6D240]
Return-Path: <domen.puncer@telargo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@telargo.com
Precedence: bulk
X-list: linux-mips

On 06/09/06 21:47 +0200, Tomasz Chmielewski wrote:
> Tomasz Chmielewski wrote:
> >I have a tiny router (ASUS WL-500g deluxe, MIPS CPU, 32 MB RAM, 2x 
> >USB2), and would like to make it work with a USB DSL modem.
> >
> >Right now, it's running Debian and kernel 2.6.17, and boots off a 
> >USB-stick.
> >
> >My problem is, that it only sees USB storage devices (USB sticks etc.).
> >
> >When I connect other devices (USB modem, webcam, microphone, keyboard, 
> >printer etc.), they are not detected.
> >By "not detected" I mean there are no "dmesg" entries with the device 
> >name, and no devices, other than "USB storage", listed with "lsusb".
> >
> >I even compiled "USB verbose logging" in, but it only gives me a couple 
> >of debug infos, no clue why the devices doesn't show up.
> 
> It looks that something's borked in 2.6.17 kernel.
> 
> When I load ohci module, it complains a lot:

You say Ohci, but output is from Uhci, and the output in the first
e-mail is from Ehci. :-)


	Domen
> 
> USB Universal Host Controller Interface driver v3.0
> PCI: Fixing up device 0000:01:02.0
> uhci_hcd 0000:01:02.0: no i/o regions available
> uhci_hcd 0000:01:02.0: init 0000:01:02.0 fail, -16
> uhci_hcd: probe of 0000:01:02.0 failed with error -16
> PCI: Fixing up device 0000:01:02.1
> uhci_hcd 0000:01:02.1: no i/o regions available
> uhci_hcd 0000:01:02.1: init 0000:01:02.1 fail, -16
> uhci_hcd: probe of 0000:01:02.1 failed with error -16
> 
> 
> With 2.4.30 kernel, ohci module loads fine, and I can use all USB devices:
> 
> # lsusb
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
> Bus 001 Device 004: ID 03f0:3011 Hewlett-Packard
> Bus 001 Device 003: ID 0471:0310 Philips PCVC730K WebCam [pwc]
> 
> 
> Ideas what can be wrong?
> 
> 
> -- 
> Tomasz Chmielewski
> http://wpkg.org
