Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2008 10:52:21 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:21985 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022352AbYCSKwS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Mar 2008 10:52:18 +0000
Received: (qmail 29940 invoked by uid 1000); 19 Mar 2008 11:52:17 +0100
Date:	Wed, 19 Mar 2008 11:52:17 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Nico Coesel <ncoesel@DEALogic.nl>
Cc:	linux-mips@linux-mips.org
Subject: Re: Serial console on Au1100
Message-ID: <20080319105217.GA28497@roarinelk.homelinux.net>
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF86E@dealogicserver.DEALogic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF86E@dealogicserver.DEALogic.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Wed, Mar 19, 2008 at 10:34:40AM +0100, Nico Coesel wrote:
> Sergei,
> I'm using kernel 2.6.24 now (before I used 2.6.21-rc4). I do see the
> console messages on the framebuffer device.
> 
> Kernel options:
> console=ttyS0 root=/dev/mtdblock0 rootfstype=jffs2 rw

try adding a baudrate to the commandline, like so:
 console=ttyS0,115200

-- 
 Manuel Lauss
