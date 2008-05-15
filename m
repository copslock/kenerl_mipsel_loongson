Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 13:55:51 +0100 (BST)
Received: from smtp207.iad.emailsrvr.com ([207.97.245.207]:43221 "EHLO
	smtp207.iad.emailsrvr.com") by ftp.linux-mips.org with ESMTP
	id S28573797AbYEOMzt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 May 2008 13:55:49 +0100
Received: from relay10.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 6D5D71B535B;
	Thu, 15 May 2008 08:55:39 -0400 (EDT)
Received: from vaultinfo.com (webmail22.webmail.iad.mlsrvr.com [192.168.1.19])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 640B81B52D6;
	Thu, 15 May 2008 08:55:39 -0400 (EDT)
Received: by webmail.mailsin.net
    (Authenticated sender: abhiruchi.g@vaultinfo.com, from: abhiruchi.g@vaultinfo.com) 
    with HTTP; Thu, 15 May 2008 08:55:39 -0400 (EDT)
Date:	Thu, 15 May 2008 08:55:39 -0400 (EDT)
Subject: MIPS kernel hangs: Warning: unable to open an initial console.  /sbin/init
From:	abhiruchi.g@vaultinfo.com
To:	linux-kernel@vger.kernel.org,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"kernel-testers" <kernel-testers@vger.kernel.org>
Reply-To: abhiruchi.g@vaultinfo.com
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8BIT
Importance: Normal
X-Priority: 3 (Normal)
X-Type:	1
Message-ID: <55815.192.168.1.71.1210856139.webmail@192.168.1.71>
X-Mailer: webmail6.6.1
Return-Path: <abhiruchi.g@vaultinfo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhiruchi.g@vaultinfo.com
Precedence: bulk
X-list: linux-mips

Hi,

My kernel hangs by initializing the system. My target is Alchemy DB1200. I use crosstool-ng to build MIPS cross toolchain and ptxdist to build ext2 filesystem.
kernel version:linux-2.6.22


I added some printk's  linux/init/main.c to see what happens.

#############################################################

	.
	.
	.
	(void) dup(0);
	(void) dup(0);

	/*
	 * We try each of these until one succeeds.
	 *
	 * The Bourne shell can be used instead of init if we are
	 * trying to recover a really broken machine.
	 */
	if (execute_command)
		run_init_process(execute_command);
	printk("before /sbin/init\n");
	run_init_process("/sbin/init");
	printk("before /etc/init\n");
	run_init_process("/etc/init");
	printk("before  /bin/init\n");
	run_init_process("/bin/init");
	printk("before  /bin/sh\n");
	run_init_process("/bin/sh");

it hangs after /sbin/init

What could be the problem?

I tried to give init="/sbin/abhi"
"abhi" is an executable file with printf statement.
but kernel stops after :


Waiting 10sec before mounting root device...
scsi 0:0:0:0: Direct-Access     Ut163    USB2FlashStorage 0.00 PQ: 0 ANSI: 2
sd 0:0:0:0: [sda] 983808 512-byte hardware sectors (504 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] 983808 512-byte hardware sectors (504 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda:<7>usb-storage: queuecommand called
 sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
VFS: Mounted root (ext2 filesystem) readonly.
mount_block_root: name=/dev/root fs=ext2 flags=32769
Freeing unused kernel memory: 156k freed
Warning: unable to open an initial console.
---ag: /sbin/abhi
