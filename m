Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 21:12:15 +0000 (GMT)
Received: from astoria.ccjclearline.com ([64.235.106.9]:31673 "EHLO
	astoria.ccjclearline.com") by ftp.linux-mips.org with ESMTP
	id S20033659AbXLQVMH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Dec 2007 21:12:07 +0000
Received: from [142.161.33.250] (helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1J4NCq-0000An-1A
	for linux-mips@linux-mips.org; Mon, 17 Dec 2007 16:08:56 -0500
Date:	Mon, 17 Dec 2007 16:08:49 -0500 (EST)
From:	"Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:	linux-mips@linux-mips.org
Subject: [OT?] is there something strange about __builtin_ffs these days?
Message-ID: <alpine.LFD.0.9999.0712171602090.13289@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips


  i'm hoping i'm not abusing this list overly by asking for some help
with debugging an OpenWRT issue.  the trac ticket is here:

https://dev.openwrt.org/ticket/2735

and involves cross-compiling an image for the MIPS-based linksys
WRT54GL router.  i've verified that this error still exists in the
latest svn update of openwrt and, in a nutshell, it involves the claim
that "__builtin_ffs" is undefined:

...
 CC [M]  /home/openwrt/builds/trunk_brcm47xx/build_dir/linux-brcm47xx/spca5xx-le/spca_core.o
/home/openwrt/builds/trunk_brcm47xx/build_dir/linux-brcm47xx/spca5xx-le/spca_core.c:538:5:
  warning: "__builtin_ffs" is not defined
/home/openwrt/builds/trunk_brcm47xx/build_dir/linux-brcm47xx/spca5xx-le/spca_core.c:538:5:
  error: missing binary operator before token "("
...

  that line in the source file is simply:

   #if PUD_SHIFT

i have no idea what the problem is here and, as you can see from the
trac ticket, this seems to have started because of the kernel version
upgrade from 2.6.22 to 2.6.23.  but what about that would affect the
usage of __builtin_ffs?

  does anyone have an idea why something this basic might be going
wrong now?  any suggestions appreciated.  thanks.

rday
--
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
