Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 15:25:27 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:49679 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20034943AbYEOOZY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 May 2008 15:25:24 +0100
Received: from [10.11.16.99] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Thu, 15 May 2008 07:25:06 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 318472B2; Thu, 15 May 2008 07:25:06 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 153002B1; Thu, 15 May
 2008 07:25:06 -0700 (PDT)
Received: from mail-irva-13.broadcom.com (mail-irva-13.broadcom.com
 [10.11.16.103]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id GWI53866; Thu, 15 May 2008 07:25:02 -0700 (PDT)
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id BE49E74D00; Thu,
 15 May 2008 07:25:01 -0700 (PDT)
Subject: Re: MIPS kernel hangs: Warning: unable to open an initial
 console. /sbin/init
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"J. Scott Kasten" <jscottkasten@yahoo.com>
cc:	abhiruchi.g@vaultinfo.com,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.64.0805150937380.13041@pixie.tetracon-eng.net>
References: <55815.192.168.1.71.1210856139.webmail@192.168.1.71>
 <Pine.LNX.4.64.0805150937380.13041@pixie.tetracon-eng.net>
Organization: Broadcom
Date:	Thu, 15 May 2008 10:25:00 -0400
Message-ID: <1210861500.24610.36.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8)
X-WSS-ID: 6432984863S28679306-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips

Actually, the kernel knows where the console is, or you wouldn't
get any printk's.  Is /dev in your rootfs populated? Is there
a /dev/console?

Jon



On Thu, 2008-05-15 at 09:41 -0400, J. Scott Kasten wrote:
> The linux-mips list is the right place for this question.
> 
> [1] Do you have serial console or other appropriate device enabled in the 
> build for your board?
> 
> [2] In the arch specific init code, did you specify the default console 
> device in the code?
> 
> [3] Did you set the console on the kernel command line?
> 
> This sounds like a simple oversight somewhere.  The kernel is very unhappy 
> without the console.
> 
> -S-
> 
> On Thu, 15 May 2008, abhiruchi.g@vaultinfo.com wrote:
> 
> > Hi,
> >
> > My kernel hangs by initializing the system. My target is Alchemy DB1200. I use crosstool-ng to build MIPS cross toolchain and ptxdist to build ext2 filesystem.
> > kernel version:linux-2.6.22
> >
> >
> > I added some printk's  linux/init/main.c to see what happens.
> >
> > #############################################################
> >
> > 	.
> > 	.
> > 	.
> > 	(void) dup(0);
> > 	(void) dup(0);
> >
> > 	/*
> > 	 * We try each of these until one succeeds.
> > 	 *
> > 	 * The Bourne shell can be used instead of init if we are
> > 	 * trying to recover a really broken machine.
> > 	 */
> > 	if (execute_command)
> > 		run_init_process(execute_command);
> > 	printk("before /sbin/init\n");
> > 	run_init_process("/sbin/init");
> > 	printk("before /etc/init\n");
> > 	run_init_process("/etc/init");
> > 	printk("before  /bin/init\n");
> > 	run_init_process("/bin/init");
> > 	printk("before  /bin/sh\n");
> > 	run_init_process("/bin/sh");
> >
> > it hangs after /sbin/init
> >
> > What could be the problem?
> >
> > I tried to give init="/sbin/abhi"
> > "abhi" is an executable file with printf statement.
> > but kernel stops after :
> >
> >
> > Waiting 10sec before mounting root device...
> > scsi 0:0:0:0: Direct-Access     Ut163    USB2FlashStorage 0.00 PQ: 0 ANSI: 2
> > sd 0:0:0:0: [sda] 983808 512-byte hardware sectors (504 MB)
> > sd 0:0:0:0: [sda] Write Protect is off
> > sd 0:0:0:0: [sda] Assuming drive cache: write through
> > sd 0:0:0:0: [sda] 983808 512-byte hardware sectors (504 MB)
> > sd 0:0:0:0: [sda] Write Protect is off
> > sd 0:0:0:0: [sda] Assuming drive cache: write through
> > sda:<7>usb-storage: queuecommand called
> > sda1
> > sd 0:0:0:0: [sda] Attached SCSI removable disk
> > sd 0:0:0:0: Attached scsi generic sg0 type 0
> > VFS: Mounted root (ext2 filesystem) readonly.
> > mount_block_root: name=/dev/root fs=ext2 flags=32769
> > Freeing unused kernel memory: 156k freed
> > Warning: unable to open an initial console.
> > ---ag: /sbin/abhi
> >
> >
> >
> >
> 
> 
> 
