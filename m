Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2007 21:41:24 +0100 (BST)
Received: from smtp1.linux-foundation.org ([207.189.120.13]:45991 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20022040AbXEXUlX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 May 2007 21:41:23 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4OKeIOw016981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2007 13:40:19 -0700
Received: from akpm.corp.google.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l4OKeFTF002013;
	Thu, 24 May 2007 13:40:15 -0700
Date:	Thu, 24 May 2007 13:40:15 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	rmk@arm.linux.kernel.org, spyro@f2s.com, <starvik@axis.com>,
	<ysato@users.sourceforge.jp>, "Luck, Tony" <tony.luck@intel.com>,
	<takata@linux-m32r.org>, chris@zankel.net,
	<uclinux-v850@lsi.nec.co.jp>, kyle@parisc-linux.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] m68k: Enable arbitary speed tty support
Message-Id: <20070524134015.e89843db.akpm@linux-foundation.org>
In-Reply-To: <20070523205645.07b03581@the-village.bc.nu>
References: <20070523174446.37abfa7a@the-village.bc.nu>
	<Pine.LNX.4.64.0705232117260.10610@anakin>
	<20070523205645.07b03581@the-village.bc.nu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

Alan, I'm all dazed and confused about these patches:

arm-enable-arbitary-speed-tty-ioctls-and-split.patch
arm26-enable-arbitary-speed-tty-ioctls-and-split.patch
ia64-arbitary-speed-tty-ioctl-support.patch
xtensa-enable-arbitary-tty-speed-setting-ioctls.patch
h8300-enable-arbitary-speed-tty-port-setup.patch
m32r-enable-arbitary-speed-tty-rate-setting.patch
etrax-enable-arbitary-speed-setting-on-tty-ports.patch
v850-enable-arbitary-speed-tty-ioctls.patch
lots-of-architectures-enable-arbitary-speed-tty-support.patch

are there any interdependencies here, or can the various patches
go into the various trees in random order without ill effects?

Thanks.
