Received:  by oss.sgi.com id <S553682AbQJSOte>;
	Thu, 19 Oct 2000 07:49:34 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:36473 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553679AbQJSOtS>;
	Thu, 19 Oct 2000 07:49:18 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id HAA08244
	for <linux-mips@oss.sgi.com>; Thu, 19 Oct 2000 07:41:30 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA27661; Thu, 19 Oct 2000 11:48:47 -0300
Date:   Thu, 19 Oct 2000 11:48:47 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Dave Garnier <dgarnier@openport.com>
cc:     SGI news group <linux-mips@oss.sgi.com>
Subject: Re: Indigo2 setup
In-Reply-To: <39EE2D79.D55CA9A7@openport.com>
Message-ID: <Pine.SGI.4.10.10010191122440.27617-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


The issue is slightly more complicated than yes or no.

It is possible to install and run linux on an SGI without any Irix
assistance at all.  But you will be stuck netbooting the kernel from a
bootp/tftp server and then mounting the local disk after receiving the
kernel from another machine over the network.

If you have the Irix utilities, then it is possible to partition and
install the kernel on the hard disk in such a way that linux boots totally
off the hard disk without actually requiring Irix to be installed on the
disk, but at present you need some Irix utilities to accomplish that.
As part of the disk labeling process, the Irix format utility creates a
sizeable volume header (a separate partition) into which it dumps a
handfull of standalone binary images that can run from the SGI prom.  The
most important of these is "sash" or Stand Alone SHell.  This minimal
shell has the capability of reading an elf binary from an EFS or XFS
formatted partition and executing it.  It's primary purpose in life is to
load the kernel "/unix", but it's also used to run certain system repair
utilities with the system totally down.  You can put an elf kernel into
your EFS or XFS partition if you have one and replace /unix with it or
change the sash parameters so it loads that instead of /unix.

Secondly, you could instead put the linux kernel into that volume header
in place of sash, but you will need a coff kernel image instead of elf as
most proms only read coff.  That will cause the prom to boot strap the
linux kernel itself thinking that it just loaded sash.  You then have no
need for and EFS or XFS partions at all, but still, you will need some
Irix utilities to pull this off as we do not yet have linux versions that
I am aware of.

Under Irix, do a man on dvhtool to get info on modifying that volume
header.  Another cute trick I learned to play was to use fmt to format the
disk and elect to make that header really large.  I would then stuff both
sash and the Irix miniroot off the installation CD in there with the linux
kernel.  The miniroot would have all the Irix utilities I need for editing
the disk, plus I could mount CDs or rcp data over the network to get my
linux stuff onto the box.



--

J. Scott Kasten
Email: jsk AT tetracon-eng DOT net

"In most cases, all an argument proves
 is that two people were present......"

On Wed, 18 Oct 2000, Dave Garnier wrote:

> I just picked up an indigo2 with irix6.5 on it, but no install cd's.  Is
> it possible to install mips-linux with out the irix cd's?  I would like
> to wipe the drive clean, and I remember reading that you need the irix
> boot loader, is this still true?  Also is there a how-to, web site with
> an install guide, or FAQ ?
> 
> 
> 
> 
> 
> 
