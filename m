Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2005 15:22:59 +0100 (BST)
Received: from ppp124-190.pppcal.vsnl.net.in ([IPv6:::ffff:203.197.124.190]:56593
	"EHLO alumnux.com") by linux-mips.org with ESMTP
	id <S8225216AbVHROWk>; Thu, 18 Aug 2005 15:22:40 +0100
Received: from [192.168.10.150] ([192.168.10.150])
	by alumnux.com (8.9.3/8.9.3) with ESMTP id UAA13711;
	Thu, 18 Aug 2005 20:17:20 +0530
Subject: how to build ramdisk along with kernel-2.6.10
From:	Suryya Kumar Jana <suryya@alumnux.com>
Reply-To: suryya@alumnux.com
To:	linux-mips@linux-mips.org
Cc:	suryya <suryya@alumnux.com>
Content-Type: multipart/alternative; boundary="=-0oHGyCAQzSKZ3YsdKrvJ"
Organization: Alumnus Softeware Limited
Message-Id: <1124375652.4863.571.camel@getafix>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date:	18 Aug 2005 20:04:12 +0530
Return-Path: <suryya@alumnux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: suryya@alumnux.com
Precedence: bulk
X-list: linux-mips


--=-0oHGyCAQzSKZ3YsdKrvJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi
I would like to port linux-2.6.10 into a mips broad.
I'm able to build the kernel. But when try to boot the kernel for the
broad, it gives some errors given bellow. 
Probable it wants the ramdisk but is not getting. Could any body guide
me to solve this?

With the Best Regards
suryya
 
<2>initrd overwritten (0x%08lx < 0x%08lx) - disabling it.
<7>Calling initcall 0x%ppreemption imbalancedisabled interruptserror in
initcall at 0x%p: returned with %s
                                                                                                                             
/init/dev/console/sbin/init/etc/init/bin/init/bin/shNo init found.  Try
passing init= option to kernel.Warning: unable to open an initial
console.
early_parm_test: %s
(null)early_setup_test: %s
Linux version 2.6.10-TSB20041227 (root@getafix) (gcc version 3.2.3 (CELF
20031024)) #27 Thu Aug 18 12:43:15 IST 2005
/sys/block/%s/dev%u:%u/sys/block/%s/range/syssysfs/dev/nfsram/root
readonlyVFS: Mounted root (%s filesystem)%s.
VFS: Unable to mount root fs on %sVFS: Cannot open root device "%s" or
%s
Please append a correct "root=" boot option
/dev/root<5>VFS: Insert %s and press ENTER
/dev/console./<5>RAMDISK: Couldn't find valid RAM disk image starting at
%d.
<5>RAMDISK: ext2 filesystem found at block %d
<5>RAMDISK: Minix filesystem found at block %d
<5>RAMDISK: cramfs filesystem found at block %d
<5>RAMDISK: romfs filesystem found at block %d
<5>RAMDISK: Compressed image found at block %d
|/-\/dev/ramRAMDISK: image too big! (%dKiB/%ldKiB)
..................................................
..................................................
..................................................

--=-0oHGyCAQzSKZ3YsdKrvJ
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/1.1.8">
</HEAD>
<BODY>
Hi<BR>
I would like to port linux-2.6.10 into a mips broad.<BR>
I'm able to build the kernel. But when try to boot the kernel for the broad, it gives some errors given bellow. <BR>
Probable it wants the ramdisk but is not getting. Could any body guide me to solve this?<BR>
<BR>
With the Best Regards<BR>
suryya<BR>
 <BR>
&lt;2&gt;initrd overwritten (0x%08lx &lt; 0x%08lx) - disabling it.<BR>
&lt;7&gt;Calling initcall 0x%ppreemption imbalancedisabled interruptserror in initcall at 0x%p: returned with %s<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
/init/dev/console/sbin/init/etc/init/bin/init/bin/shNo init found.&nbsp; Try passing init= option to kernel.Warning: unable to open an initial console.<BR>
early_parm_test: %s<BR>
(null)early_setup_test: %s<BR>
Linux version 2.6.10-TSB20041227 (root@getafix) (gcc version 3.2.3 (CELF 20031024)) #27 Thu Aug 18 12:43:15 IST 2005<BR>
/sys/block/%s/dev%u:%u/sys/block/%s/range/syssysfs/dev/nfsram/root readonlyVFS: Mounted root (%s filesystem)%s.<BR>
VFS: Unable to mount root fs on %sVFS: Cannot open root device &quot;%s&quot; or %s<BR>
Please append a correct &quot;root=&quot; boot option<BR>
/dev/root&lt;5&gt;VFS: Insert %s and press ENTER<BR>
/dev/console./&lt;5&gt;RAMDISK: Couldn't find valid RAM disk image starting at %d.<BR>
&lt;5&gt;RAMDISK: ext2 filesystem found at block %d<BR>
&lt;5&gt;RAMDISK: Minix filesystem found at block %d<BR>
&lt;5&gt;RAMDISK: cramfs filesystem found at block %d<BR>
&lt;5&gt;RAMDISK: romfs filesystem found at block %d<BR>
&lt;5&gt;RAMDISK: Compressed image found at block %d<BR>
|/-\/dev/ramRAMDISK: image too big! (%dKiB/%ldKiB)<BR>
..................................................<BR>
..................................................<BR>
..................................................
</BODY>
</HTML>

--=-0oHGyCAQzSKZ3YsdKrvJ--
