Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 12:00:19 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:31756 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20024954AbXIULAL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 12:00:11 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1IYgF0-0003uG-00; Fri, 21 Sep 2007 12:00:10 +0100
Received: from stanmore.mips.com ([192.168.192.169])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1IYgEs-0000cS-00; Fri, 21 Sep 2007 12:00:02 +0100
Message-ID: <46F3A432.4060903@mips.com>
Date:	Fri, 21 Sep 2007 12:00:02 +0100
From:	Elizabeth Oldham <beth@mips.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	KokHow.Teh@infineon.com
CC:	linux-mips@linux-mips.org,
	Friedrich-Nachtmann.External@infineon.com, kurt@mips.com
Subject: Re: YAMON booting Linux kernels from malta board harddisk....
References: <31E09F73562D7A4D82119D7F6C1729860254C469@sinse303.ap.infineon.com> <46F390C5.402@mips.com> <31E09F73562D7A4D82119D7F6C1729860254C65D@sinse303.ap.infineon.com> <46F39A1D.8090101@mips.com> <31E09F73562D7A4D82119D7F6C1729860254C6D6@sinse303.ap.infineon.com>
In-Reply-To: <31E09F73562D7A4D82119D7F6C1729860254C6D6@sinse303.ap.infineon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: beth@mips.com
Return-Path: <beth@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: beth@mips.com
Precedence: bulk
X-list: linux-mips

KokHow.Teh@infineon.com wrote:

> /dev/hdd6          8323     10403   1048578+  83  Linux
> 	So I `dd if=mb-0.3.bin of=/dev/hdd6 bs=1024 count=150` and hope
> it works. Now there are 2 questions:

It will be easier if you change fdisk's units to sectors, so it prints 
the start of the partition for you. I get this from my set up:

Command (m for help): u
Changing display/entry units to sectors

Command (m for help): p

Disk /dev/hda: 80.0 GB, 80026361856 bytes
16 heads, 63 sectors/track, 155061 cylinders, total 156301488 sectors
Units = sectors of 1 * 512 = 512 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/hda1              63       20159       10048+  83  Linux
/dev/hda2           20160    15646175     7813008   83  Linux
/dev/hda3        15646176    31272191     7813008   83  Linux
/dev/hda4        31272192    72481247    20604528    5  Extended
/dev/hda5        31272255    32249951      488848+  82  Linux swap
/dev/hda6        32250015    47875967     7812976+  83  Linux

So (I think, if there are no gotchas - it's a while since I played with 
this stuff) the YAMON command would be:

YAMON> disk read hda 1ec18a0 ff 800d0000; go 800d0000

where 1ec18a0 is (32250015 + 1) in hex.

> (1)	where to put mb.conf?

As it stands the bootloader will look in /dev/hda2 if you are running BE 
and /dev/hda3 if LE. For now just try getting MIPSboot to start :)

Beth
