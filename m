Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 15:58:45 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:35491 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S3458487AbWBFP6d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Feb 2006 15:58:33 +0000
Received: from zidane.cc.vt.edu (IDENT:mirapoint@evil-zidane.cc.vt.edu [10.1.1.13])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id k16G3mSb010822;
	Mon, 6 Feb 2006 11:03:48 -0500
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by zidane.cc.vt.edu (MOS 3.7.3a-GA)
	with ESMTP id FBA28602;
	Mon, 6 Feb 2006 11:03:45 -0500 (EST)
Message-ID: <43E7735B.4050307@gentoo.org>
Date:	Mon, 06 Feb 2006 11:03:39 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060116)
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
CC:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Has anyone seen O2 crashes?
References: <20060206151754.GA22181@deprecation.cyrius.com>
In-Reply-To: <20060206151754.GA22181@deprecation.cyrius.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> I got a report that Debian's experimental 2.6.15 mips patches
> (2.6.15.2 plus linux-mips git from a few weeks ago plus random
> patches) sometimes crashes, posibly under high load - there's
> nothing on the serial console.
> 
> I was just wondering if anyone else (in particular the Gentoo folks)
> has seem something similar, or is O2 rock solid for you?

I don't know how Debian is patching things up for O2 (ths care to 
comment?), but ip32 has been absolutely rock solid for me the past 
several releases.  The only modifications I make to the source tree are 
a small gbefb patch and a minor Makefile patch (however, this is 
probably different from other Gentoo folks...I hate using our kernel 
source ebuilds which apply a number of patches for other platforms and 
issues).

I had over 60 days of uptime recently with some variant of 2.6.15 (-rc5 
I think), and the machine was hammered fairly hard during that time with 
plenty of compiling, including significant portions of KDE.  I have run 
both the 2.6.15 tag from lmo git, and now I'm on 2.6.16-rc1.  It still 
seems solid as ever.

-Steve
