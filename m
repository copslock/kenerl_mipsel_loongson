Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2002 13:29:35 +0100 (CET)
Received: from p508B6EFA.dip.t-dialin.net ([80.139.110.250]:10396 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122117AbSKSM3e>; Tue, 19 Nov 2002 13:29:34 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAJCTMp18057;
	Tue, 19 Nov 2002 13:29:22 +0100
Date: Tue, 19 Nov 2002 13:29:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: ?? <kevin@gv.com.tw>
Cc: linux-mips@linux-mips.org
Subject: Re: usb hotplug function with linux mips kernel
Message-ID: <20021119132922.A15266@linux-mips.org>
References: <20021118144212.A12262@linux-mips.org> <00a901c28fc4$76ace700$df0210ac@gv.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00a901c28fc4$76ace700$df0210ac@gv.com.tw>; from kevin@gv.com.tw on Tue, Nov 19, 2002 at 08:09:07PM +0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello double questionmark ;-)

On Tue, Nov 19, 2002 at 08:09:07PM +0800, ?? wrote:

> anyone successfully using usb hotplug function with linux mips kernel?
> 
> http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=102954820511328&w=2

There is nothing in the USB code that should be MIPS specific.  Despite
what Tom suspects everything is fine.  32-bit kernel symbols always start
with 0xffffffff and the value of usbdevfs_cleanup is an artefact of the
function having been discarded by the linker.

  Ralf
