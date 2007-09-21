Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 11:28:56 +0100 (BST)
Received: from smtp3.infineon.com ([203.126.106.229]:58007 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20024866AbXIUK2s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 11:28:48 +0100
X-SBRS:	None
Received: from unknown (HELO sinse301.ap.infineon.com) ([172.20.70.22])
  by smtp3.infineon.com with ESMTP; 21 Sep 2007 18:27:36 +0800
Received: from sinse303.ap.infineon.com ([172.20.70.24]) by sinse301.ap.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Sep 2007 18:27:40 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: YAMON booting Linux kernels from malta board harddisk....
Date:	Fri, 21 Sep 2007 18:27:39 +0800
Message-ID: <31E09F73562D7A4D82119D7F6C1729860254C6D6@sinse303.ap.infineon.com>
In-Reply-To: <46F39A1D.8090101@mips.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: YAMON booting Linux kernels from malta board harddisk....
Thread-Index: Acf8OJUFbrYqE+zoR3eJH4Yjgv/VagAAQAAQ
References: <31E09F73562D7A4D82119D7F6C1729860254C469@sinse303.ap.infineon.com> <46F390C5.402@mips.com> <31E09F73562D7A4D82119D7F6C1729860254C65D@sinse303.ap.infineon.com> <46F39A1D.8090101@mips.com>
From:	<KokHow.Teh@infineon.com>
To:	<beth@mips.com>
Cc:	<linux-mips@linux-mips.org>,
	<Friedrich-Nachtmann.External@infineon.com>, <kurt@mips.com>
X-OriginalArrivalTime: 21 Sep 2007 10:27:40.0595 (UTC) FILETIME=[09CB0030:01C7FC3A]
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi;

[tehkok@linux4:~ 3]$ sudo fdisk -l /dev/hdd

Disk /dev/hdd: 16 heads, 63 sectors, 79656 cylinders Units = cylinders
of 1008 * 512 bytes

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

	So I `dd if=mb-0.3.bin of=/dev/hdd6 bs=1024 count=150` and hope
it works. Now there are 2 questions:

(1)	where to put mb.conf?
(2)	how to specify the 6th partition on YAMON?

	YAMON> disk read hda 3f ff 800d0000; go 800d0000

	Thanks.

Regards,
KH
-----Original Message-----
From: Elizabeth Oldham [mailto:beth@mips.com] 
Sent: Friday, September 21, 2007 6:17 PM
To: Teh Kok How (IFAP DC COM WL SD)
Cc: linux-mips@linux-mips.org; Nachtmann Friedrich (IFAP DC COM WL SD
External); kurt@mips.com
Subject: Re: YAMON booting Linux kernels from malta board harddisk....

KokHow.Teh@infineon.com wrote:
> 	I need to load the mipsboot into /dev/hda1 that reads the 
> configuration from /dev/hda1/boot and boots linux kernel from 
> /dev/hda1/boot/*.

Can you leave a partition without a filesystem? The bootloader image
needs to be dropped into a known position and written as a contiguous
block...

For comparison the MIPS/TimeSys hard disk configuration:

-bash-3.1# fdisk -l

Disk /dev/hda: 80.0 GB, 80026361856 bytes
16 heads, 63 sectors/track, 155061 cylinders Units = cylinders of 1008 *
512 = 516096 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1          20       10048+  83  Linux
/dev/hda2              21       15522     7813008   83  Linux
/dev/hda3           15523       31024     7813008   83  Linux
/dev/hda4           31025       71906    20604528    5  Extended
/dev/hda5           31025       31994      488848+  82  Linux swap
/dev/hda6           31995       47496     7812976+  83  Linux
/dev/hda7           47497       62998     7812976+  83  Linux
/dev/hda8           62999       63968      488848+  83  Linux
/dev/hda9           63969       64938      488848+  83  Linux

The first partition is reserved for the bootloader. It doesn't have to
the first it was just convienent to me, it could be any, so if you can
shuffle the partitions up slightly and have a couple of MBytes at the
end perhaps?

> 	and /dev/hda1 is formatted as ext3 BOOT partition. Is it
possible to 
> do that?

The bootloader will cope with an ext3 filesystem.

Beth
