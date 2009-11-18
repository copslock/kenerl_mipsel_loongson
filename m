Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 01:31:42 +0100 (CET)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:60834 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493928AbZKRAbg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2009 01:31:36 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 83DEFC04E9;
	Tue, 17 Nov 2009 19:31:33 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Tue, 17 Nov 2009 19:31:33 -0500
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:in-reply-to:references:subject:date; s=smtpout; bh=b8A9sKOkLVMTwI6nL3YIDqTKfPE=; b=Q360DiCN3JYZAuRcCN+tNKDrIshFVkfE2rD3V7dGjMccOCjZZl4PbfI70QaFK+N08JEMjJLmvTnr6kJlT4zbJs5N5blniBXAT+1LkhJRAZvaxeTNTBSwVQwy3Ujzx5fLnOPw9VtCUJ1Wyu7iFEd4TB/0n+3gWHhk9YDXVIzHLN0=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id 4EF6811C763; Tue, 17 Nov 2009 19:31:33 -0500 (EST)
Message-Id: <1258504293.3627.1345755107@webmail.messagingengine.com>
X-Sasl-Enc: DdAWpRzvq6YBiHI4+aJUwA/+K5sPglDPFeUswTPR71xZ 1258504293
From:	myuboot@fastmail.fm
To:	"Chris Dearman" <chris@mips.com>
Cc:	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <4B031B78.5030204@mips.com>
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
 <1257898975.30125.1344591929@webmail.messagingengine.com>
 <4AFA6B7F.10404@walsimou.com>
 <1258417281.1921.1345554581@webmail.messagingengine.com>
 <20091117093330.GA24000@linux-mips.org>
 <1258479580.17116.1345691629@webmail.messagingengine.com>
 <4B030F76.1040904@paralogos.com> <4B031B78.5030204@mips.com>
Subject: Re: problem bring up initramfs and busybox
Date:	Tue, 17 Nov 2009 18:31:33 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips


On Tue, 17 Nov 2009 13:54 -0800, "Chris Dearman" <chris@mips.com> wrote:
> Kevin D. Kissell wrote:
> > This looks like another boot file system setup problem to me.  Are you 
> > sure that there's an executable init image at /mnt/root/sbin/init?  I'm 
> > pretty sure that the path that you provide to your new init has to be 
> > relative to the new root.
> 
> That sounds right.
> 
> Andrew, my suggestion would be to change your initramfs /init script to 
> invoke "/bin/busybox sh" as the last command instead of "exec 
> switch_root". The "Kernel panic - not syncing: Attempted to kill init!" 
> says that switch_root is exiting for some reason. It could be anything 
> from missing files/devices on the /mnt/root file system to a bug in 
> busy_box.
> By booting into the shell you can run the command by hand (maybe with 
> strace if you have it) to help identify where the problem is.
> 
> Chris
> 
> -- 
> Chris Dearman               Desk: +1 408 530 5092  Cell: +1 408 398 5531
> MIPS Technologies Inc            955 East Arques Ave, Sunnyvale CA 94085

Chris,

Thanks for your response. Now I changed my init file to the following - 
#!/bin/busybox sh
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mdev -s
/bin/busybox sh

The Kernel panic is gone but the shell still does not come up. Somehow
there is no printout on the screen.  Below is the error info.
I have tried similar things previously. I also tried using a statically
linked hello world in the place of init script. But the result is
similar - no print out from either hello world or busybox.
[  1.169000] TCP cubic registered
[    1.173000] NET: Registered protocol family 17
[   15.811000] Freeing unused kernel memory: 1032k freed
[   33.978000] Algorithmics/MIPS FPU Emulator v1.5 

And here is the trace on BDI - 
gdb) c
Continuing.

Breakpoint 2, do_execve (filename=0x9780a000 "/init", argv=0x943dd2bc,
envp=0x943dd230, regs=0x97819e30)
    at fs/exec.c:1293
1293            retval = unshare_files(&displaced);
(gdb) c
Continuing.

Breakpoint 2, do_execve (filename=0x9780a000 "/bin/busybox",
argv=0x4f73dc, envp=0x4f73ec, regs=0x97987f30)
    at fs/exec.c:1293
1293            retval = unshare_files(&displaced);
(gdb) c
Continuing.
^C
Program received signal SIGSTOP, Stopped (signal).
r4k_wait () at arch/mips/kernel/genex.S:147
147             jr      ra
Current language:  auto; currently asm

Let me provide some history about what I am trying to do here in case it
is relevant to the issue. I have a MIPS32 board very similar to AR7.
Previously it has working toolchain/u-boot/kernel. I changed the board
from little endian to big endian mode and have been trying to upgrade
the toolchain/u-boot/kernel (gcc 4.4.1/u-boot2009.08/kernel 2.6.31). I
made some changes to the u-boot and kernel on console initialisation in
order to bring up the console. Up to the point, the kernel comes up
normally.

Since the time I start porting, I have been wondering if any change
related to exception needs to be done due to the endianess change. But
recently I found an AR7 patch for big endian mode(
https://lists.openwrt.org/pipermail/openwrt-devel/2009-May/004262.html)
and I did not see any change related to exception there. I hope the
issue is not something related to exception that messes up the
execution. Sorry if the above is a stupid question. I am trying to learn
embedded system. Your suggestion will be appreciated.

Thanks, Andrew
