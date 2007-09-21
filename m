Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 10:40:32 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:51718 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20024316AbXIUJkY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 10:40:24 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1IYewj-00045x-00; Fri, 21 Sep 2007 10:37:13 +0100
Received: from stanmore.mips.com ([192.168.192.169])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1IYewf-0003Zw-00; Fri, 21 Sep 2007 10:37:09 +0100
Message-ID: <46F390C5.402@mips.com>
Date:	Fri, 21 Sep 2007 10:37:09 +0100
From:	Elizabeth Oldham <beth@mips.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	KokHow.Teh@infineon.com
CC:	linux-mips@linux-mips.org,
	Friedrich-Nachtmann.External@infineon.com
Subject: Re: YAMON booting Linux kernels from malta board harddisk....
References: <31E09F73562D7A4D82119D7F6C1729860254C469@sinse303.ap.infineon.com>
In-Reply-To: <31E09F73562D7A4D82119D7F6C1729860254C469@sinse303.ap.infineon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: beth@mips.com
Return-Path: <beth@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: beth@mips.com
Precedence: bulk
X-list: linux-mips

KokHow.Teh@infineon.com wrote:

> 	I read of MIPSboot that is loaded into the MBR which is then
> read from YAMON to boot a selection of kernels from the harddisk.

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
