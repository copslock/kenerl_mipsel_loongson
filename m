Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0OHsmS20554
	for linux-mips-outgoing; Thu, 24 Jan 2002 09:54:48 -0800
Received: from mta7.pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0OHshP20546
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 09:54:43 -0800
Received: from [10.2.2.69] ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GQG00J2JCB05U@mta7.pltn13.pbi.net> for linux-mips@oss.sgi.com;
 Thu, 24 Jan 2002 08:54:36 -0800 (PST)
Date: Thu, 24 Jan 2002 08:51:37 -0800
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: Does anyone know how HHL boots?
In-reply-to: <20020124015042.B29933@momenco.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Message-id: <1011891098.1390.15.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution/1.0.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20020124015042.B29933@momenco.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-01-24 at 01:50, Matthew Dharm wrote:
> I'm somewhat curious...
> 
> MontaVista has HHL support for several MIPS boards... including one that my
> company makes.  We've never actually seen their HHL distribution for our
> board, tho... and we're wondering, how does it boot?
> 
> I mean, our boards have an elementary boot loader that can load a kernel
> from the network, and disk-booting is something we're trying to figure out.
> But how does HHL accomplish this?  And is it a general solution for
> multiple platforms?

HHL, or now MontaVista Linux, MVL, is a cross dev environment. The tools
and all apps are installed on the host system. The target boots over the
net, which requires that the boot code support net booting, and then
mounts the root fs over nfs.  You can then proceed to develop your apps
on the host system, install it in the target directory, test it, etc.
When you're ready for deployment, you can use the Target Configurator
Tool to build a custom file system. 

How you deploy the system varies.  I'll give you an example of a board
I'm working on right now.  The Pb1500 from Alchemy has yamon as the boot
code. I've added boot from flash support so you can compile a zImage
kernel. The image is then turned to srecords, which yamon can download
directly to flash (if the srecords' addresses are those of the flash).
You can then set a "start" variable in yamon which is a string that
yamon parses, such as: "go bfd00000 root=/dev/mtdblock0". Assuming that
you have the zImage at 0xbfd00000, yamon will just jump there and the
kernel loader that's part of the zImage will do the rest. The root file
system, in this case, is in flash. This means that you need mtd and jffs
or jffs2 support. Another option for this board is to put the root fs on
a pcmcia card or on a hard disk, since the board has the HPT370A IDE
controller.  I've tested both.

I guess the short answer is that MVL boots over the network and mounts
the root fs over nfs.  For deployment, it depends on what you need or
what your customers need.  It also depends on the features of your boot
code and the level of support for your board in the kernel tree (mtd,
jffs, etc).  It might be very easy to deploy the board, or you might
have to either pay someone PS or add the additional features you need
yourself.

Pete
