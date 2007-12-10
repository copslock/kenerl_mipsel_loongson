Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 01:55:46 +0000 (GMT)
Received: from rv-out-0910.google.com ([209.85.198.191]:28527 "EHLO
	rv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28573982AbXLJBzg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 01:55:36 +0000
Received: by rv-out-0910.google.com with SMTP id l15so1277696rvb
        for <linux-mips@linux-mips.org>; Sun, 09 Dec 2007 17:55:23 -0800 (PST)
Received: by 10.141.167.5 with SMTP id u5mr3928560rvo.1197251723015;
        Sun, 09 Dec 2007 17:55:23 -0800 (PST)
Received: from mythtv.cortland.com ( [209.162.137.90])
        by mx.google.com with ESMTPS id f13sm4662373rvb.2007.12.09.17.55.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Dec 2007 17:55:22 -0800 (PST)
Message-ID: <475C9C80.4030708@cortland.com>
Date:	Sun, 09 Dec 2007 17:55:12 -0800
From:	Steve Brown <sbrown@cortland.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: SSB Bus: Need advice representing 2 devices in a core (BCM5354 USB2.0
 core)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sbrown@cortland.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sbrown@cortland.com
Precedence: bulk
X-list: linux-mips

I'm posting to this list because I think this is basically a ssb bus 
issue. If it doesn't belong here, where should I go?

The USB 2.0 core in the BCM5354 is both a OHCI & EHCI device. I now have 
a OHCI & EHCI driver. The former is essentially the current ohci-ssb.c 
w/ a dma mask fix and the latter I derived from ohci-ssb and ehci-pci. 
Either one, but not both, will attach to the USB 2.0 core and mostly work.

1. Multiple devices per core

The ssb bus code seems to expect only one device per core. I modified 
drivers/ssb/scan.c to add an additional identical device in the case of 
the USB 2.0 core.  However, once a driver binds to one device, the other 
seems to no longer be available either. When the second driver loads, 
ssb_bus_match never sees the second device. I haven't figured out what's 
happening yet.

I also considered modifying drivers/ssb/scan.c to add a phony additional 
core/device for SSB_DEV_USB20_HOST and then add that phony core to the 
OHCI device list. But, this seems really ugly.

2. Avoiding multiple core initializations

I also need a way to determine if the core is already enabled, as I 
can't initialize it more than once. The initialization gets done in the 
probe code in ohci-ssb and ehci-ssb.  The first one loaded does that and 
the second driver needs to skip the initialization. Does the following 
look like a safe test for a reset core?

(ssb_read32(dev, SSB_TMSLOW) & SSB_TMSLOW_RESET)

As ssb_enable always first resets the core, maybe this test isn't always 
reliable. If it isn't, should I just add a flag to the ssb_device 
structure that follows ssb_enable/ssb_disable?

Any suggestions are appreciated. As I'm probably less than qualified to 
be doing this, I'll accept that as advice as well.

Steve
