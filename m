Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2002 18:54:51 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:23036 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122123AbSKSRyv>;
	Tue, 19 Nov 2002 18:54:51 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gAJHsib26702;
	Tue, 19 Nov 2002 09:54:44 -0800
Date: Tue, 19 Nov 2002 09:54:44 -0800
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: ?? <kevin@gv.com.tw>, linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: usb hotplug function with linux mips kernel
Message-ID: <20021119095444.C18134@mvista.com>
References: <20021118144212.A12262@linux-mips.org> <00a901c28fc4$76ace700$df0210ac@gv.com.tw> <20021119132922.A15266@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021119132922.A15266@linux-mips.org>; from ralf@linux-mips.org on Tue, Nov 19, 2002 at 01:29:22PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 19, 2002 at 01:29:22PM +0100, Ralf Baechle wrote:
> Hello double questionmark ;-)
> 
> On Tue, Nov 19, 2002 at 08:09:07PM +0800, ?? wrote:
> 
> > anyone successfully using usb hotplug function with linux mips kernel?
> > 
> > http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=102954820511328&w=2
> 
> There is nothing in the USB code that should be MIPS specific.  Despite
> what Tom suspects everything is fine.  32-bit kernel symbols always start
> with 0xffffffff and the value of usbdevfs_cleanup is an artefact of the
> function having been discarded by the linker.
>

Additional info:

USB has been working on MIPS for well over a year now.  There was a problem
early on due to non-coherent MIPS cache, but it was solved back then.

We have been using USB on global span IVR successfully.  Maybe there are
still some patches missing in linux-mips tree.  I will take a look later.

Jun 
