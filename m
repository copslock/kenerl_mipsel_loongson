Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fANKgVM11465
	for linux-mips-outgoing; Fri, 23 Nov 2001 12:42:31 -0800
Received: from snfc21.pbi.net (mta5.snfc21.pbi.net [206.13.28.241])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fANKgTo11454
	for <linux-mips@oss.sgi.com>; Fri, 23 Nov 2001 12:42:29 -0800
Received: from adsl.pacbell.net ([63.194.214.47])
 by mta5.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GN9000B9QQSG7@mta5.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Fri, 23 Nov 2001 11:42:28 -0800 (PST)
Date: Fri, 23 Nov 2001 11:41:17 -0800
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: emebedded ramdisk vs initrd
In-reply-to: <20011123142210.A32765@galadriel.physik.uni-konstanz.de>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linux-mips@oss.sgi.com
Message-id: <1006544477.1578.5.camel@adsl.pacbell.net>
MIME-version: 1.0
X-Mailer: Evolution/0.16.100+cvs.2001.11.01.03.27 (Preview Release)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20011123135518.A12210@gandalf.physik.uni-konstanz.de>
 <20011123142210.A32765@galadriel.physik.uni-konstanz.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2001-11-23 at 05:22, Guido Guenther wrote:
> On Fri, Nov 23, 2001 at 01:55:18PM +0100, Guido Guenther wrote:
> > Trying to link in arch/mips/ramdisk/ramdisk.o whenever
> > CONFIG_BLK_DEV_INITRD is defined is a bad idea, since there are other
> ...and therefore makes the compilation fail, I should add.

You need a ramdisk.gz in arch/mips/ramdisk. It shouldn't fail then. I
think you're right about the CONFIG_EMBEDDED_RAMDISK though.

Pete
