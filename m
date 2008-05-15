Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 14:39:00 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:3015 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20034756AbYEONi5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 May 2008 14:38:57 +0100
Received: (qmail 22405 invoked by uid 1000); 15 May 2008 15:38:55 +0200
Date:	Thu, 15 May 2008 15:38:55 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	abhiruchi.g@vaultinfo.com
Cc:	linux-kernel@vger.kernel.org,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	kernel-testers <kernel-testers@vger.kernel.org>
Subject: Re: MIPS kernel hangs: Warning: unable to open an initial console.
	/sbin/init
Message-ID: <20080515133855.GA20300@roarinelk.homelinux.net>
References: <55815.192.168.1.71.1210856139.webmail@192.168.1.71>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55815.192.168.1.71.1210856139.webmail@192.168.1.71>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Thu, May 15, 2008 at 08:55:39AM -0400, abhiruchi.g@vaultinfo.com wrote:
> Hi,
> 
> My kernel hangs by initializing the system. My target is Alchemy DB1200. I use crosstool-ng to build MIPS cross toolchain and ptxdist to build ext2 filesystem.
> kernel version:linux-2.6.22

Try and add "console=ttyS0,115200" to the kernel commandline (either in
yamon or kernel config).


	Manuel Lauss
