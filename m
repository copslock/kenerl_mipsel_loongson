Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA97759; Fri, 15 Aug 1997 13:18:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA01510 for linux-list; Fri, 15 Aug 1997 13:18:18 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA01489; Fri, 15 Aug 1997 13:18:15 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id QAA15671; Fri, 15 Aug 1997 16:18:08 -0400
Message-ID: <33F4B980.A17A25CD@cygnus.detroit.sgi.com>
Date: Fri, 15 Aug 1997 16:18:08 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
CC: jeremyw@motown.detroit.sgi.com, linux@cthulhu.engr.sgi.com,
        linux-progress@cthulhu.engr.sgi.com
Subject: Re: Booting Linux from second disk
References: <199708151850.NAA29883@athena.nuclecu.unam.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

OK: last report before I leave for the weekend.  These steps given by
Miguel didnt work for us. What "did" work so far is that we set up a
tftp boot server on labb.detroit, got all the stuff uncompressed on it,
booted miniroot on linux.detroit, setenv diskless 1 then did the
following:

boot -f bootp()labb.detroit:/tftpboot/linux/vmlinux
nfsaddrs=169.238.129.18,169.238.129.5

labb (tftpboot server=169.238.129.5, linux=169.238.129.18)

It boots but as soon as it sees the ethernet driver we get this:

eth0: SGI Seeq8003 08:00:69:07:e6:29  (which is our correct MAC addr)_
Unable to handle kernel paging request at virtual address 00000008, epc
== 880cbc5c, ra == 880cbc3c

The keyboard is still active but the machine is hung. You cannot ping
linux's IP address either.

Looks like we have a problem with this kernel and our hardware but I
couldn't tell you anything more than that.

Anyone have any ideas for Monday morning?
See ya!
                     Eric.

Miguel de Icaza wrote:
> 
> > We have tried booting miniroot, running command monitor then running sash
> > and we have tried:
> >
> > boot /vmlinux root=/dev/sdb1 which just fails
> >
> > and
> >
> > boot /vmlinux root=/dev/sdb7 which boots IRIX
> 
> Ok, it is not that simple.
> 
> The problem is that the Linux kernel does not have a module for
> accessing EFS, so you have to do this in two steps:
> 
>         1. Un cpio the root-*.cpio.gz on a machine on the network
>            and tell Linux to use that as its root file system:
> 
>                 boot /vmlinux nfsroot=132.248.29.5:/tftpboot/the-root-dir
> 
>            Replace 132.248.29.5 for the IP address of your NFS server
>            and /tftpboot/the-root-dir for the exported directory in
>            your NFS server that holds that stuff.
> 
>         2. Prepare to get rid of EFS on your disk.
> 
>            Run the mke2fs command on the proper device to create
>            the Linux ext2 file system.
> 
>         3. Un-cpio the file again, this time on your root disk.
> 
>         4. umount the disk, and reset the machine.
> 
> Miguel.

-- 
Eric Kimminau                           System Engineer/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"

Windows 95: n.
    32 bit extensions and a graphical shell for a 16 bit patch to an
    8 bit operating system originally coded for a 4 bit microprocessor,
    written by a 2 bit company that can't stand 1 bit of competition.

    Author unknown.
