Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id VAA08363
	for <pstadt@stud.fh-heilbronn.de>; Sun, 15 Aug 1999 21:08:52 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA06703; Sun, 15 Aug 1999 12:06:18 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA19652
	for linux-list;
	Sun, 15 Aug 1999 11:57:33 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA25251
	for <linux@engr.sgi.com>;
	Sun, 15 Aug 1999 11:57:31 -0700 (PDT)
	mail_from (cory@real-time.com)
Received: from paladin.real-time.com (paladin.real-time.com [206.10.252.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA08654
	for <linux@engr.sgi.com>; Sun, 15 Aug 1999 11:57:29 -0700 (PDT)
	mail_from (cory@real-time.com)
Received: from real-time.com (atm-bvi1-202.real-time.com [206.147.104.202])
	by paladin.real-time.com (8.8.8/8.8.8) with ESMTP id NAA28578
	for <linux@engr.sgi.com>; Sun, 15 Aug 1999 13:57:28 -0500 (CDT)
Message-ID: <37B70CDF.D938EA0D@real-time.com>
Date: Sun, 15 Aug 1999 13:54:24 -0500
From: Cory Jon Hollingsworth <cory@real-time.com>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Hard Hat and Tandem.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

    I have a Tandem model number CMN B006S that I'm trying to get Hard
Hat up and running on.  This is a machine build for Tandem by SGI and,
based on the descriptions I have read, I believe it is a close cousin to
the Challenge S.

    For instance an hinv returns:
Syestem: IP22
Processor: 150 Mhz R4400, with FPU
Primary I-cache size: 16 Kbytes
Primary D-cache size: 16 Kbytes
Secondary cache size: 1024 Kbytes
Memory size: 256 Mbytes
SCSI Disk: scsi(0)disk(1)

When I try to boot off of the 2.1.100 kernel distributed with Hard Hat I
get this:

wd33c93-0: chip=WD33c93B/13 no_sync=0xff  no_dma=0scsi0 : SGI WD 93
scsi : 1 host.
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI            Model:
SEAGATE ST31230N2
   Type:   Direct-Access                                           ANSI
SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 2070235 [1010 MB] [1.0
GB]
sgiseeq.c: David S Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:08:db:dd
Sending BOOTP requests....Got a bus error IRQ, shouldn't happen yet
$0 : 00000000 88190000 97f8bd68 fffffff5
$4 : 97f8db84 00000000 00000000 00000040
$8 : 0000001c 881095b4 00000001 00000000
$12: 00000000 97f8476c 97f84600 a8617000
$16: 00000040 97f43f78 00000000 97f8bdb0
$20: 0000016c 9fc56934 00000000 9fc56394
$24: 00000000 97f8bce8
$28: 97f8a000 97f8bd50 9fc4be88 880923cc
epc     : 880923cc
Status: 1004fc03
Cause : 00004000
Spinning...

     Now I have spent a some time browsing the archives and I know this
was a common problem some time ago on certain models of Indys.

    I can get the system to boot by replacing the Hard Hat vmlinux image
with the vmlinux-indy-initrd-990313.gz image found in
ftp.linux.sgi.com/pub/linux/mips/test.  But that leaves me with a
crippled RAM disk image and a root prompt.  I can NFS mount my Hard Hat
file system, but that doesn't help me run the installation.

    My question is: Can I get a precompiled vmlinux replacement for the
Hard Hat distribution which will allow me to continue with the
installation?   Or, since Tandem is not officially supported,  do I
spend the next couple of months hand assembling a root partition on the
machine from the bits I currently have working via NFS?

    Any advice anyone could give me would be greatly appreciated.

    Thanks.
