Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAP2hJb20654
	for linux-mips-outgoing; Sat, 24 Nov 2001 18:43:19 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAP2hHo20650
	for <linux-mips@oss.sgi.com>; Sat, 24 Nov 2001 18:43:17 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAP1hGV09707
	for linux-mips@oss.sgi.com; Sun, 25 Nov 2001 12:43:16 +1100
Date: Sun, 25 Nov 2001 12:43:16 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com
Subject: Re: emebedded ramdisk vs initrd
Message-ID: <20011125124316.A9701@dea.linux-mips.net>
References: <20011123135518.A12210@gandalf.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011123135518.A12210@gandalf.physik.uni-konstanz.de>; from agx@sigxcpu.org on Fri, Nov 23, 2001 at 01:55:18PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Nov 23, 2001 at 01:55:18PM +0100, Guido Guenther wrote:

> Trying to link in arch/mips/ramdisk/ramdisk.o whenever
> CONFIG_BLK_DEV_INITRD is defined is a bad idea, since there are other
> ways to use a ramdisk (bootloader, addinitrd). I suggest to use
> CONFIG_EMBEDDED_RAMDISK instead , since it's already used by sibyte/swarm. 

Good idea,

  Ralf
