Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2002 03:53:27 +0100 (CET)
Received: from r-bu.iij4u.or.jp ([210.130.0.89]:27107 "EHLO r-bu.iij4u.or.jp")
	by linux-mips.org with ESMTP id <S1122123AbSKTCx0>;
	Wed, 20 Nov 2002 03:53:26 +0100
Received: from pudding ([202.216.29.50])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id gAK2r6q27689;
	Wed, 20 Nov 2002 11:53:07 +0900 (JST)
Date: Wed, 20 Nov 2002 11:49:30 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: kevin@gv.com.tw
Cc: jsun@mvista.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
	ppopov@mvista.com
Subject: Re: usb hotplug function with linux mips kernel
Message-Id: <20021120114930.117a78bb.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <1037729027.17678.112.camel@zeus.mvista.com>
References: <20021118144212.A12262@linux-mips.org>
	<00a901c28fc4$76ace700$df0210ac@gv.com.tw>
	<20021119132922.A15266@linux-mips.org>
	<20021119095444.C18134@mvista.com>
	<1037729027.17678.112.camel@zeus.mvista.com>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__20_Nov_2002_11:49:30_+0900_08421100"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Wed__20_Nov_2002_11:49:30_+0900_08421100
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On 19 Nov 2002 10:03:47 -0800
Pete Popov <ppopov@mvista.com> wrote:

> On Tue, 2002-11-19 at 09:54, Jun Sun wrote:
> > On Tue, Nov 19, 2002 at 01:29:22PM +0100, Ralf Baechle wrote:
> > > Hello double questionmark ;-)
> > > 
> > > On Tue, Nov 19, 2002 at 08:09:07PM +0800, ?? wrote:
> > > 
> > > > anyone successfully using usb hotplug function with linux mips kernel?
> > > > 
> > > > http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=102954820511328&w=2
> > > 
> > > There is nothing in the USB code that should be MIPS specific.  Despite
> > > what Tom suspects everything is fine.  32-bit kernel symbols always start
> > > with 0xffffffff and the value of usbdevfs_cleanup is an artefact of the
> > > function having been discarded by the linker.
> > >
> > 
> > Additional info:
> > 
> > USB has been working on MIPS for well over a year now.  There was a problem
> > early on due to non-coherent MIPS cache, but it was solved back then.
> > 
> > We have been using USB on global span IVR successfully.  
> 
> ... among many other mips boards.
> 
> > Maybe there are still some patches missing in linux-mips tree.  I will 
> > take a look later.

I don't have a problem with current CVS tree(linux_2_4 tag) and a small patch.

I tested by the following system.
Hot plug is fine.

NEC VR4122(Eagle)
USB OCHI Controller
SanDisk SDDR-31
128MB CF

I attached a small patch.

Yoichi
--Multipart_Wed__20_Nov_2002_11:49:30_+0900_08421100
Content-Type: text/plain;
 name="usb.diff"
Content-Disposition: attachment;
 filename="usb.diff"
Content-Transfer-Encoding: 7bit

--- linux.orig/drivers/usb/hub.c	Thu Sep 12 13:09:25 2002
+++ linux/drivers/usb/hub.c	Wed Nov 20 11:43:34 2002
@@ -698,12 +698,6 @@
 		return;
 	}
 
-	if (usb_hub_port_debounce(hub, port)) {
-		err("connect-debounce failed, port %d disabled", port+1);
-		usb_hub_port_disable(hub, port);
-		return;
-	}
-
 	down(&usb_address0_sem);
 
 	tempstr = kmalloc(1024, GFP_KERNEL);

--Multipart_Wed__20_Nov_2002_11:49:30_+0900_08421100--
