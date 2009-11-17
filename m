Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 22:03:19 +0100 (CET)
Received: from gateway07.websitewelcome.com ([67.18.65.21]:39850 "HELO
	gateway07.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1493227AbZKQVDN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2009 22:03:13 +0100
Received: (qmail 8824 invoked from network); 17 Nov 2009 21:15:51 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway07.websitewelcome.com with SMTP; 17 Nov 2009 21:15:51 -0000
Received: from 216-239-45-4.google.com ([216.239.45.4]:14327 helo=epiktistes.mtv.corp.google.com)
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1NAVCP-00060N-W4; Tue, 17 Nov 2009 15:02:54 -0600
Message-ID: <4B030F76.1040904@paralogos.com>
Date:	Tue, 17 Nov 2009 13:02:46 -0800
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:	myuboot@fastmail.fm
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: problem bring up initramfs and busybox
References: <1255735395.30097.1340523469@webmail.messagingengine.com> <4AD906D8.3020404@caviumnetworks.com> <1257898975.30125.1344591929@webmail.messagingengine.com> <4AFA6B7F.10404@walsimou.com> <1258417281.1921.1345554581@webmail.messagingengine.com> <20091117093330.GA24000@linux-mips.org> <1258479580.17116.1345691629@webmail.messagingengine.com>
In-Reply-To: <1258479580.17116.1345691629@webmail.messagingengine.com>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<a class="moz-txt-link-abbreviated" href="mailto:myuboot@fastmail.fm">myuboot@fastmail.fm</a> wrote:
<blockquote
 cite="mid:1258479580.17116.1345691629@webmail.messagingengine.com"
 type="cite">
  <pre wrap="">
On Tue, 17 Nov 2009 10:33 +0100, "Ralf Baechle" <a class="moz-txt-link-rfc2396E" href="mailto:ralf@linux-mips.org">&lt;ralf@linux-mips.org&gt;</a>
wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Mon, Nov 16, 2009 at 06:21:21PM -0600, <a class="moz-txt-link-abbreviated" href="mailto:myuboot@fastmail.fm">myuboot@fastmail.fm</a> wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">I have been struggling to bring up a MIPS 32 board with busybox with or
without initramfs.
The kernel stucks there without the shell coming up.

[    1.153000] nf_conntrack version 0.5.0 (1024 buckets, 4096 max)
[    1.161000] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.167000] TCP cubic registered
[    1.170000] NET: Registered protocol family 17
[   25.971000] Freeing unused kernel memory: 1032k freed
[   39.969000] Algorithmics/MIPS FPU Emulator v1.5


What I tried here is to use initramfs with statically linked busybox.
The initramfs seems to be up, and runs the commands in the /init one by
one, and then it goes to a inifite loop in r4k_wait at
arch/mips/kernel/genex.S.
      </pre>
    </blockquote>
    <pre wrap="">r4k_wait is called by the idle loop.  Which means the kernel has no
process
to run so runs the idle loop.  This might be because there is no other
process left running or because all processes are waiting for I/O for
example.  So it's not uncommon that even busy systems ocasionally briefly
run the idle loop.  In other words, seeing the processor executing
r4k_wait does not necessarily mean something went wrong.  In this case -
also along with the other information you've provieded it's not obvious
what has gone wrong.

  Ralf
    </pre>
  </blockquote>
  <pre wrap=""><!---->
According to an email from Kevin, I added a symbolic link from
switch_root to busybox. The switch_root seems to be found now based on
the execution sequence, but I got the following error - "Kernel panic -
not syncing: Attempted to kill init!". This is the same error when I
tried to start the shell without initramfs. Something must be wrong, but
I can't quite figure out.

[    9.250000] Freeing unused kernel memory: 1032k freed
[   10.463000] Algorithmics/MIPS FPU Emulator v1.5
[   41.695000] Kernel panic - not syncing: Attempted to kill init!
[   41.701000] Rebooting in 3 seconds.

Thanks for your help. Andrew

(gdb) c
Continuing.

Breakpoint 2, do_execve (filename=0x9780a000 "/init", argv=0x943dd2bc,
envp=0x943dd230, regs=0x97819e30)
    at fs/exec.c:1293
1293            retval = unshare_files(&amp;displaced);
(gdb) c
Continuing.

Breakpoint 2, do_execve (filename=0x9780a000 "/sbin/switch_root",
argv=0x4f7450, envp=0x4f7464, regs=0x97819f30)
    at fs/exec.c:1293
1293            retval = unshare_files(&amp;displaced);
(gdb) c
Continuing.

  </pre>
</blockquote>
This looks like another boot file system setup problem to me.&nbsp; Are you
sure that there's an executable init image at /mnt/root/sbin/init?&nbsp; I'm
pretty sure that the path that you provide to your new init has to be
relative to the new root.<br>
<br>
Kevin K.<br>
<br>
</body>
</html>
