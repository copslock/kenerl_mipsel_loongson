Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56K9tX25485
	for linux-mips-outgoing; Wed, 6 Jun 2001 13:09:55 -0700
Received: from dea.waldorf-gmbh.de (u-206-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.206])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56K9ph25480
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 13:09:51 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f56K9f106174;
	Wed, 6 Jun 2001 22:09:41 +0200
Date: Wed, 6 Jun 2001 22:09:41 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: SGI Challenge S Serial Port (zs0) Driver question
Message-ID: <20010606220941.C6079@bacchus.dhis.org>
References: <006001c0eeb2$642a7f70$031010ac@rjrtower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <006001c0eeb2$642a7f70$031010ac@rjrtower>; from robru@teknuts.com on Wed, Jun 06, 2001 at 10:59:11AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 06, 2001 at 10:59:11AM -0700, Robert Rusek wrote:

> I am trying to install RedHat 5.1 Linux on my Challenge.  I finally got the kernel to boot from the prom via bootp/tftp.  The loading of the kernel stops with the following messag:
> 
> Warning: unable to open an initial console.
> 
> The HOW-TO states the following:
> 
> 
> --------------------------------------------------------------------------------
> This problem has two possible solutions. First make sure you actually have a driver for the console of your system configured. If this is the case and the problem persists you probably got victim of a widespead bug in Linux distributions and root filesystems out there. The console of a Linux systems should be a character device of major id 5, minor 1 with permissions of 622 and owned by user and group root. If that's not the case, cd to the root of the filesystem and execute the following commands as root: 
> 
>    rm -f dev/console
>    mknod --mode=622 dev/console
>   
> 
> You can also do this on a NFS root filesystem, even on the NFS server itself. However note that the major and minor ids are changed by NFS, therefore you must do this from a Linux system even if it's only a NFS client or the major / minor ID might be wrong when your Linux client boots from it. 
> --------------------------------------------------------------------------------
> 
> 
> I have followed the above instructions and still I get:
> 
> Warning: unable to open an initial console.
> 
> I would assume then that I need a special driver for for the serial port (zs0).  Just to clarify I am connecting a terminal to the serial port of the Challenge.

The standard SGI serial driver (CONFIG_SGI_SERIAL) supports the serial ports
of the Challenge S also.  Only if this one is configured you'll get all
the output upto ``Warning: unable to open ...'' printed onto the serial
console.  You also should see a message about two serial interfaces
being detected.

PS: Pressing the return character once every ~ 75 characters produces
    properly formatted mails ...
