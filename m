Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2008 11:23:22 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.182]:25098 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023629AbYAPLXO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jan 2008 11:23:14 +0000
Received: by wa-out-1112.google.com with SMTP id m16so388271waf.20
        for <linux-mips@linux-mips.org>; Wed, 16 Jan 2008 03:23:11 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=CnCEj5Akl8A73pTUSeQCDh8J9OVwN/XUozPe1AB4Snk=;
        b=Y6FZT/L2Rk3QYnBoG9v8jEsSReiHoEbm4PhErstT7/jXOYMspP2bvYK9G/FZlXvCRJtIfRe/Ny3ddjbXWj5F+Vu4Y9s51pjo2uB0/40OPlomjVqzY6I6bOzEtyWhvGBCYO4WxmTPM4C/o70C5LXmVVrLNwZo5jUurqJPwcnGY/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=myY6p84xbJySAvw4Jo4SRzLmCtRD1WLmZl89CJ4PomyXzSSpHcec6gSkE48mW1TmORPw94cbBLA+Lt2Hrx0lBbJzdch5MepzxGw/NTsrDZmsJPu1q24hhJEJU4DfS/fCL31yiEc82guYXoDCpGKwlcGeMFjbYkWQFfNDNmTgWqU=
Received: by 10.114.78.1 with SMTP id a1mr766575wab.102.1200482591003;
        Wed, 16 Jan 2008 03:23:11 -0800 (PST)
Received: by 10.115.46.12 with HTTP; Wed, 16 Jan 2008 03:23:10 -0800 (PST)
Message-ID: <cec350730801160323v274a02a4yec78b5849e3960b3@mail.gmail.com>
Date:	Wed, 16 Jan 2008 16:53:10 +0530
From:	"Gautam Dawar" <gautam.dawar@gmail.com>
To:	linux-mips@linux-mips.org
Subject: ramdisk /sbin/init not running
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22253_32095903.1200482590990"
Return-Path: <gautam.dawar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gautam.dawar@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_22253_32095903.1200482590990
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I am trying to run Montavista linux (kernel version 2.4) on my development
board which is based on MIPS processor. The ramdisk is compiled into the
kernel image by placing the ramdisk.gz file in the source tree.

The kernel boots up completely and the control is passed over to /sbin/init
binary present in the ramdisk in the init thread. After that no print is
observed on the console, where I should have observed "BusyBox v0.60.5 (
2005.03.06-21:20+0000) Built-in shell (msh)" as the first print from the
ramdisk binary.

I tried to run my own init binary which was nothing but a simple "Hello
world" application, but even with this binary the print wasn't observed.

Finally, On putting prints in the load_elf_binary routing, I found that
load_elf_binary is returning with retval: 0 which means success.

So, I am suspecting that the problem somehow lies with the UART in that no
prints are seen from the newly execed program(/sbin/init).
Could this be the case?

Could there be a problem with the kernel code?

Following are the last few prints observed on the console:

###############################################################
Freeing initrd memory: 1836k freed

VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing prom memory: 0kb freed
Freeing unused kernel memory: 84k freed

Algorithmics/MIPS FPU Emulator v1.5
###############################################################

Any help in this regard would be greatly appreciated.

Regards,
Gautam

------=_Part_22253_32095903.1200482590990
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br>
<br>
I am trying to run Montavista linux (kernel version 2.4) on my
development board which is based on MIPS processor. The ramdisk is
compiled into the kernel image by placing the ramdisk.gz file in the
source tree.<br>
<br>
The kernel boots up completely and the control is passed over to
/sbin/init binary present in the ramdisk in the init thread. After that
no print is observed on the console, where I should have observed
&quot;BusyBox v0.60.5 (2005.03.06-21:20+0000) Built-in shell (msh)&quot; as the
first print from the ramdisk binary.<br>
<br>
I tried to run my own init binary which was nothing but a simple &quot;Hello
world&quot; application, but even with this binary the print wasn&#39;t observed.<br>
<br>
Finally, On putting prints in the load_elf_binary routing, I found that
load_elf_binary is returning with retval: 0 which means success.<br>
<br>
So, I am suspecting that the problem somehow lies with the UART in that
no prints are seen from the newly execed program(/sbin/init). <br>
Could this be the case?<br>
<br>
Could there be a problem with the kernel code?<br>
<br>
Following are the last few prints observed on the console:<br>
<br>
###############################################################<br>
Freeing initrd memory: 1836k freed<br>
<br>
VFS: Mounted root (ext2 filesystem).<br>
Mounted devfs on /dev<br>
Freeing prom memory: 0kb freed<br>
Freeing unused kernel memory: 84k freed<br>
<br>
Algorithmics/MIPS FPU Emulator v1.5<br>
###############################################################<br>
<br>
Any help in this regard would be greatly appreciated.<br>
<br>
Regards,<br>Gautam<br>

------=_Part_22253_32095903.1200482590990--
