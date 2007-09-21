Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 11:17:20 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:14601 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20024336AbXIUKRL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 11:17:11 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1IYfZN-0007OK-00; Fri, 21 Sep 2007 11:17:09 +0100
Received: from stanmore.mips.com ([192.168.192.169])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1IYfZF-0005ol-00; Fri, 21 Sep 2007 11:17:01 +0100
Message-ID: <46F39A1D.8090101@mips.com>
Date:	Fri, 21 Sep 2007 11:17:01 +0100
From:	Elizabeth Oldham <beth@mips.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	KokHow.Teh@infineon.com
CC:	linux-mips@linux-mips.org,
	Friedrich-Nachtmann.External@infineon.com, kurt@mips.com
Subject: Re: YAMON booting Linux kernels from malta board harddisk....
References: <31E09F73562D7A4D82119D7F6C1729860254C469@sinse303.ap.infineon.com> <46F390C5.402@mips.com> <31E09F73562D7A4D82119D7F6C1729860254C65D@sinse303.ap.infineon.com>
In-Reply-To: <31E09F73562D7A4D82119D7F6C1729860254C65D@sinse303.ap.infineon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: beth@mips.com
Return-Path: <beth@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: beth@mips.com
Precedence: bulk
X-list: linux-mips

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
16 heads, 63 sectors/track, 155061 cylinders
Units = cylinders of 1008 * 512 = 516096 bytes

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
> possible to do that?

The bootloader will cope with an ext3 filesystem.

Beth
