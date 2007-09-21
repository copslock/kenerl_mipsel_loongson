Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 10:52:03 +0100 (BST)
Received: from smtp3.infineon.com ([203.126.106.229]:35092 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20024310AbXIUJvz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 10:51:55 +0100
X-SBRS:	None
Received: from unknown (HELO sinse301.ap.infineon.com) ([172.20.70.22])
  by smtp3.infineon.com with ESMTP; 21 Sep 2007 17:51:43 +0800
Received: from sinse303.ap.infineon.com ([172.20.70.24]) by sinse301.ap.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Sep 2007 17:51:42 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: YAMON booting Linux kernels from malta board harddisk....
Date:	Fri, 21 Sep 2007 17:51:41 +0800
Message-ID: <31E09F73562D7A4D82119D7F6C1729860254C65D@sinse303.ap.infineon.com>
In-Reply-To: <46F390C5.402@mips.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: YAMON booting Linux kernels from malta board harddisk....
Thread-Index: Acf8MwJWScIIoXX2R72WNOjb1qepAAAAFOdQ
References: <31E09F73562D7A4D82119D7F6C1729860254C469@sinse303.ap.infineon.com> <46F390C5.402@mips.com>
From:	<KokHow.Teh@infineon.com>
To:	<beth@mips.com>
Cc:	<linux-mips@linux-mips.org>,
	<Friedrich-Nachtmann.External@infineon.com>, <kurt@mips.com>
X-OriginalArrivalTime: 21 Sep 2007 09:51:42.0925 (UTC) FILETIME=[03B8AFD0:01C7FC35]
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi Beth;
	Thanks for your prompt reply. I have some questions. This is my
disk configuration:

[tehkok@linux4:~ 3]$ sudo fdisk -l /dev/hdd

Disk /dev/hdd: 16 heads, 63 sectors, 79656 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdd1             1      2081   1048544   83  Linux
/dev/hdd2          2081      4162   1048575   82  Linux swap
/dev/hdd3          4162      6242   1048580   83  Linux
/dev/hdd4          6242     79656  37000893+   5  Extended
/dev/hdd5          6242      8323   1048578+  83  Linux
/dev/hdd6          8323     10403   1048578+  83  Linux
/dev/hdd7         10403     12484   1048568+  83  Linux
/dev/hdd8         12484     14564   1048568+  83  Linux
[tehkok@linux4:~ 4]$


	I need to load the mipsboot into /dev/hda1 that reads the
configuration from /dev/hda1/boot and boots linux kernel from
/dev/hda1/boot/*.

[tehkok@linux4:/mnt/hdd1 10]$ l
total 4
drwxr-xr-x 3 root root 4096 Sep 22 03:22 boot
[tehkok@linux4:/mnt/hdd1 11]$ ls boot
System.map-kernel-aprp-2.6.19-malta.12
changelog-kernel-exp-2.6.20-malta.6    grub
vmlinux.srec-kernel-aprp-2.6.19-malta.12
System.map-kernel-exp-aprp-2.6.20-malta.6
config-kernel-aprp-2.6.19-malta.12
vmlinux-kernel-aprp-2.6.19-malta.12
vmlinux.srec-kernel-exp-aprp-2.6.20-malta.6
System.map-kernel-exp-smtc-2.6.20-malta.6
config-kernel-exp-aprp-2.6.20-malta.6
vmlinux-kernel-exp-aprp-2.6.20-malta.6
vmlinux.srec-kernel-exp-smtc-2.6.20-malta.6
System.map-kernel-exp-smvp-2.6.20-malta.6
config-kernel-exp-smtc-2.6.20-malta.6
vmlinux-kernel-exp-smtc-2.6.20-malta.6
vmlinux.srec-kernel-exp-smvp-2.6.20-malta.6
System.map-kernel-smtc-2.6.19-malta.12
config-kernel-exp-smvp-2.6.20-malta.6
vmlinux-kernel-exp-smvp-2.6.20-malta.6
vmlinux.srec-kernel-smtc-2.6.19-malta.12
System.map-kernel-smvp-2.6.19-malta.12
config-kernel-smtc-2.6.19-malta.12
vmlinux-kernel-smtc-2.6.19-malta.12
vmlinux.srec-kernel-smvp-2.6.19-malta.12
changelog-kernel-2.6.19-malta.12
config-kernel-smvp-2.6.19-malta.12
vmlinux-kernel-smvp-2.6.19-malta.12
[tehkok@linux4:/mnt/hdd1 12]$


	and /dev/hda1 is formatted as ext3 BOOT partition. Is it
possible to do that?
	Thanks.

Regards,
KH.

-----Original Message-----
From: Elizabeth Oldham [mailto:beth@mips.com] 
Sent: Friday, September 21, 2007 5:37 PM
To: Teh Kok How (IFAP DC COM WL SD)
Cc: linux-mips@linux-mips.org; Nachtmann Friedrich (IFAP DC COM WL SD
External)
Subject: Re: YAMON booting Linux kernels from malta board harddisk....

KokHow.Teh@infineon.com wrote:

> 	I read of MIPSboot that is loaded into the MBR which is then
read 
> from YAMON to boot a selection of kernels from the harddisk.

MIPSboot is my rather hacked bootloader that goes with the MIPS/TimeSys
Linux distro, and does not as yet sit in the MBR...one day perhaps.

Anyway, it sits at the beginning of the first partition on disk (which
should not be formatted with a filesystem and can be very small), and
then loaded with a YAMON command line like:

YAMON> disk read hda 3f ff 800d0000; go 800d0000

MIPSboot version 0.3
Loading /boot/mb.conf . ok
Choose a kernel image to boot:
   (0) aprp-2.6.19-glibc         root=/dev/hda3
   (1) smtc-2.6.19-glibc         root=/dev/hda3
...

You can put that command line in the "start" environment variable to
autostart it.

I've dropped source and binary tarballs together with an example conf
file on our ftp site:

    ftp://ftp.mips.com/pub/tools/software/timesys/extras/mipsboot/

If you have any queries about it send me email.
Beth
