Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2002 19:00:56 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:22269 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S1122123AbSKSSAz>;
	Tue, 19 Nov 2002 19:00:55 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA22725;
	Tue, 19 Nov 2002 10:00:38 -0800
Subject: Re: usb hotplug function with linux mips kernel
From: Pete Popov <ppopov@mvista.com>
To: Jun Sun <jsun@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, ?? <kevin@gv.com.tw>,
	linux-mips@linux-mips.org
In-Reply-To: <20021119095444.C18134@mvista.com>
References: <20021118144212.A12262@linux-mips.org>
	<00a901c28fc4$76ace700$df0210ac@gv.com.tw>
	<20021119132922.A15266@linux-mips.org>  <20021119095444.C18134@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Nov 2002 10:03:47 -0800
Message-Id: <1037729027.17678.112.camel@zeus.mvista.com>
Mime-Version: 1.0
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2002-11-19 at 09:54, Jun Sun wrote:
> On Tue, Nov 19, 2002 at 01:29:22PM +0100, Ralf Baechle wrote:
> > Hello double questionmark ;-)
> > 
> > On Tue, Nov 19, 2002 at 08:09:07PM +0800, ?? wrote:
> > 
> > > anyone successfully using usb hotplug function with linux mips kernel?
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=102954820511328&w=2
> > 
> > There is nothing in the USB code that should be MIPS specific.  Despite
> > what Tom suspects everything is fine.  32-bit kernel symbols always start
> > with 0xffffffff and the value of usbdevfs_cleanup is an artefact of the
> > function having been discarded by the linker.
> >
> 
> Additional info:
> 
> USB has been working on MIPS for well over a year now.  There was a problem
> early on due to non-coherent MIPS cache, but it was solved back then.
> 
> We have been using USB on global span IVR successfully.  

... among many other mips boards.

> Maybe there are still some patches missing in linux-mips tree.  I will 
> take a look later.

Pete
