Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB67V7u18390
	for linux-mips-outgoing; Wed, 5 Dec 2001 23:31:07 -0800
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB67V0o18387
	for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 23:31:00 -0800
Received: from 63.70.210.4 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Wed, 05 Dec 2001 22:30:42 -0800
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from dns-blr-2.blr.broadcom.com ([10.132.16.11]) by
 mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP id WAA25856; Wed, 5
 Dec 2001 22:30:54 -0800 (PST)
Received: from adm-blr-001.blr.broadcom.com (adm-blr-001 [10.132.16.111]
 ) by dns-blr-2.blr.broadcom.com (8.9.1b+Sun/8.9.1) with ESMTP id
 LAA29883; Thu, 6 Dec 2001 11:53:39 +0530 (IST)
Received: from broadcom.com ([10.132.64.110]) by
 adm-blr-001.blr.broadcom.com (8.9.1/8.9.1) with ESMTP id LAA19399; Thu,
 6 Dec 2001 11:53:42 +0530 (IST)
Message-ID: <3C0F119C.95A3B1FF@broadcom.com>
Date: Thu, 06 Dec 2001 12:05:08 +0530
From: Nitin <nitin.borle@broadcom.com>
X-Mailer: Mozilla 4.51 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mark Salter" <msalter@redhat.com>
cc: hartvige@mips.com, dant@mips.com, linux-mips@oss.sgi.com
Subject: Re: Booting from IDE
References: <200112051510.QAA12575@copsun18.mips.com>
 <200112051531.fB5FV6N22409@deneb.localdomain>
X-WSS-ID: 1011CF18264012-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks Dan, Hartvig and Mark.

I could get the linux prompt according to the instruction given in the Install file Dan has suggested. I will update my Yamon and try auto booting also.

-Nitin

Mark Salter wrote:

> Another possibility is to replace YAMON with RedBoot.
>
> http://sources.redhat.com/redboot/
>
> RedBoot can load the kernel image directly from an ext2 filesystem
> on an IDE drive. You can also use it to put the kernel image and
> JFFS filesystem in flash for a diskless boot.
>
> --Mark
>
> >>>>> Hartvig Ekner writes:
>
> > If you feel lucky, you can also reserve space on your disk for the kernel -
> > either in a separate partition, or outside the area used by your current
> > partitions. The YAMON 02.02 or later can read the kernel directly from disk
> > and execute it.
>
> > I do this on my Malta board with one disk.
>
> > /Hartvig
>
> > Dan Temple writes:
> >>
> >> I guess you're installing as per:
> >>
> >> ftp://ftp/pub/linux/mips/installation/redhat7.1/INSTALL
> >>
> >> (If not, you might want to upgrade to that version).
> >>
> >> YAMON can't read the disk file system, so you have to TFTP the kernel to memory from a remote filesystem, and then run it. The instructions are in the above file under "Booting linux on the target".
> >>
> >> The latest version (2.02) of YAMON can read and write blocks from an IDE device (not a filesystem) so you could install a CompactFlash card and use that to store the kernel if you don't want to TFTP each time.
> >>
> >> There is also a $start environment variable if you want to auto-boot.
> >>
> >> /Dan
> >>
> >> Nitin wrote:
> >> >
> >> > Hi,
> >> > I have a very basic query. I have a MIPS Malta board. I attached a IDE
> >> > hard disk to it and installed linux as per the instructions. At the end
> >> > of the installation, system rebooted and control gone to the board
> >> > monitor program(Yamon). How can I get the linux prompt? Do I need to
> >> > write an application program which will read boot sector from hard disk,
> >> >
> >> > store it in memory and pass on control to that particular location?(If
> >> > yes, is such application already available?) Or is there a other way of
> >> > doing it.
> >> >
> >> > Thanks,
> >> > Nitin
