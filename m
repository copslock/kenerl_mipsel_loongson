Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 14:44:12 +0100 (BST)
Received: from n75.bullet.mail.sp1.yahoo.com ([98.136.44.51]:9650 "HELO
	n75.bullet.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28573780AbYEONoI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 May 2008 14:44:08 +0100
Received: from [216.252.122.218] by n75.bullet.mail.sp1.yahoo.com with NNFMP; 15 May 2008 13:41:34 -0000
Received: from [68.142.230.29] by t3.bullet.sp1.yahoo.com with NNFMP; 15 May 2008 13:41:34 -0000
Received: from [69.147.75.191] by t2.bullet.re2.yahoo.com with NNFMP; 15 May 2008 13:41:34 -0000
Received: from [127.0.0.1] by omp107.mail.re1.yahoo.com with NNFMP; 15 May 2008 13:41:34 -0000
X-Yahoo-Newman-Id: 667499.56574.bm@omp107.mail.re1.yahoo.com
Received: (qmail 34121 invoked from network); 15 May 2008 13:41:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=hn3NMbhXaHMfIGnN/P5lAjntQAx/hcY6xcxT0Q1LNXrooxliH4Zdgt5yUS9g4ciidxhnTqLOgbXbA4MiG8xchuSSXfxKvVbUoAfdhcmC83svbwykwzT3D3BYnkJ0K3tI0wZxU3uuy8mHsK6cIX6YJ3I3fvESFMNf39AMPnn4LYQ=  ;
Received: from unknown (HELO pixie.tetracon-eng.net) (jscottkasten@71.100.137.23 with login)
  by smtp116.plus.mail.re1.yahoo.com with SMTP; 15 May 2008 13:41:34 -0000
X-YMail-OSG: I6w.abUVM1lsmlmvAXveSCqC2_9ob42lM7s92jLWOV_pmL1Zl.feB6JCUzsjrlLCdLbgpL4YyIJSfjs84cZ91UvXEFuxUuzDA0BRRi4.bQH0O8gCgGzYwCmkkKdyEa.rYv8-
X-Yahoo-Newman-Property: ymail-3
Date:	Thu, 15 May 2008 09:41:28 -0400 (EDT)
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@pixie.tetracon-eng.net
To:	abhiruchi.g@vaultinfo.com
cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: MIPS kernel hangs: Warning: unable to open an initial console.
  /sbin/init
In-Reply-To: <55815.192.168.1.71.1210856139.webmail@192.168.1.71>
Message-ID: <Pine.LNX.4.64.0805150937380.13041@pixie.tetracon-eng.net>
References: <55815.192.168.1.71.1210856139.webmail@192.168.1.71>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips


The linux-mips list is the right place for this question.

[1] Do you have serial console or other appropriate device enabled in the 
build for your board?

[2] In the arch specific init code, did you specify the default console 
device in the code?

[3] Did you set the console on the kernel command line?

This sounds like a simple oversight somewhere.  The kernel is very unhappy 
without the console.

-S-

On Thu, 15 May 2008, abhiruchi.g@vaultinfo.com wrote:

> Hi,
>
> My kernel hangs by initializing the system. My target is Alchemy DB1200. I use crosstool-ng to build MIPS cross toolchain and ptxdist to build ext2 filesystem.
> kernel version:linux-2.6.22
>
>
> I added some printk's  linux/init/main.c to see what happens.
>
> #############################################################
>
> 	.
> 	.
> 	.
> 	(void) dup(0);
> 	(void) dup(0);
>
> 	/*
> 	 * We try each of these until one succeeds.
> 	 *
> 	 * The Bourne shell can be used instead of init if we are
> 	 * trying to recover a really broken machine.
> 	 */
> 	if (execute_command)
> 		run_init_process(execute_command);
> 	printk("before /sbin/init\n");
> 	run_init_process("/sbin/init");
> 	printk("before /etc/init\n");
> 	run_init_process("/etc/init");
> 	printk("before  /bin/init\n");
> 	run_init_process("/bin/init");
> 	printk("before  /bin/sh\n");
> 	run_init_process("/bin/sh");
>
> it hangs after /sbin/init
>
> What could be the problem?
>
> I tried to give init="/sbin/abhi"
> "abhi" is an executable file with printf statement.
> but kernel stops after :
>
>
> Waiting 10sec before mounting root device...
> scsi 0:0:0:0: Direct-Access     Ut163    USB2FlashStorage 0.00 PQ: 0 ANSI: 2
> sd 0:0:0:0: [sda] 983808 512-byte hardware sectors (504 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Assuming drive cache: write through
> sd 0:0:0:0: [sda] 983808 512-byte hardware sectors (504 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Assuming drive cache: write through
> sda:<7>usb-storage: queuecommand called
> sda1
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> VFS: Mounted root (ext2 filesystem) readonly.
> mount_block_root: name=/dev/root fs=ext2 flags=32769
> Freeing unused kernel memory: 156k freed
> Warning: unable to open an initial console.
> ---ag: /sbin/abhi
>
>
>
>
