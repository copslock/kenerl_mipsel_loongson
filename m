Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 18:39:48 +0100 (CET)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54790 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493878AbZKQRjl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2009 18:39:41 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B058EBFA2A;
	Tue, 17 Nov 2009 12:39:40 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Tue, 17 Nov 2009 12:39:40 -0500
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=Xfj1+5aauSfDdXkATqYvF1BWN3Y=; b=EkEcgueAE9XJI/+ps4us9fT3g4rzaV1GbmBDNJ/dtd40KsM40NmvDRHDrKoKc1FY4RzBGqqqM3C/vm/n5V1sqzj4Q+iA8GYxJBrELU3ChZ5R369sjMDWaN9BSv9VJs92lGksomv4mXMQa3PkRMMuzC6CGiIiWPmbUOxPQ3z28Lc=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id 8C9F912AD02; Tue, 17 Nov 2009 12:39:40 -0500 (EST)
Message-Id: <1258479580.17116.1345691629@webmail.messagingengine.com>
X-Sasl-Enc: efqfsLJG5YQVWpR1ulRQ3cKyHGHw35CkUKL7pHS44Cci 1258479580
From:	myuboot@fastmail.fm
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
 <1257898975.30125.1344591929@webmail.messagingengine.com>
 <4AFA6B7F.10404@walsimou.com>
 <1258417281.1921.1345554581@webmail.messagingengine.com>
 <20091117093330.GA24000@linux-mips.org>
Subject: Re: problem bring up initramfs and busybox
In-Reply-To: <20091117093330.GA24000@linux-mips.org>
Date:	Tue, 17 Nov 2009 11:39:40 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips



On Tue, 17 Nov 2009 10:33 +0100, "Ralf Baechle" <ralf@linux-mips.org>
wrote:
> On Mon, Nov 16, 2009 at 06:21:21PM -0600, myuboot@fastmail.fm wrote:
> 
> > I have been struggling to bring up a MIPS 32 board with busybox with or
> > without initramfs.
> > The kernel stucks there without the shell coming up.
> > 
> > [    1.153000] nf_conntrack version 0.5.0 (1024 buckets, 4096 max)
> > [    1.161000] ip_tables: (C) 2000-2006 Netfilter Core Team
> > [    1.167000] TCP cubic registered
> > [    1.170000] NET: Registered protocol family 17
> > [   25.971000] Freeing unused kernel memory: 1032k freed
> > [   39.969000] Algorithmics/MIPS FPU Emulator v1.5
> > 
> > 
> > What I tried here is to use initramfs with statically linked busybox.
> > The initramfs seems to be up, and runs the commands in the /init one by
> > one, and then it goes to a inifite loop in r4k_wait at
> > arch/mips/kernel/genex.S.
> 
> r4k_wait is called by the idle loop.  Which means the kernel has no
> process
> to run so runs the idle loop.  This might be because there is no other
> process left running or because all processes are waiting for I/O for
> example.  So it's not uncommon that even busy systems ocasionally briefly
> run the idle loop.  In other words, seeing the processor executing
> r4k_wait does not necessarily mean something went wrong.  In this case -
> also along with the other information you've provieded it's not obvious
> what has gone wrong.
> 
>   Ralf

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
1293            retval = unshare_files(&displaced);
(gdb) c
Continuing.

Breakpoint 2, do_execve (filename=0x9780a000 "/sbin/switch_root",
argv=0x4f7450, envp=0x4f7464, regs=0x97819f30)
    at fs/exec.c:1293
1293            retval = unshare_files(&displaced);
(gdb) c
Continuing.
