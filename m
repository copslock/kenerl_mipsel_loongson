Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fANEN9o17575
	for linux-mips-outgoing; Fri, 23 Nov 2001 06:23:09 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fANEN8o17568
	for <linux-mips@oss.sgi.com>; Fri, 23 Nov 2001 06:23:08 -0800
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 167GIN-0003Gi-00; Fri, 23 Nov 2001 14:23:07 +0100
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 167GHS-0000Hx-00; Fri, 23 Nov 2001 14:22:10 +0100
Date: Fri, 23 Nov 2001 14:22:10 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: Re: emebedded ramdisk vs initrd
Message-ID: <20011123142210.A32765@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20011123135518.A12210@gandalf.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011123135518.A12210@gandalf.physik.uni-konstanz.de>; from agx@sigxcpu.org on Fri, Nov 23, 2001 at 01:55:18PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Nov 23, 2001 at 01:55:18PM +0100, Guido Guenther wrote:
> Trying to link in arch/mips/ramdisk/ramdisk.o whenever
> CONFIG_BLK_DEV_INITRD is defined is a bad idea, since there are other
...and therefore makes the compilation fail, I should add.
 -- Guido
