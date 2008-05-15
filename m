Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 14:14:33 +0100 (BST)
Received: from smtp207.iad.emailsrvr.com ([207.97.245.207]:10370 "EHLO
	smtp207.iad.emailsrvr.com") by ftp.linux-mips.org with ESMTP
	id S20022909AbYEONOb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 May 2008 14:14:31 +0100
Received: from relay10.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 953C21B527E;
	Thu, 15 May 2008 09:14:24 -0400 (EDT)
Received: from vaultinfo.com (webmail3.r1.iad.emailsrvr.com [192.168.1.11])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 830A71B526D;
	Thu, 15 May 2008 09:14:24 -0400 (EDT)
Received: by webmail.mailsin.net
    (Authenticated sender: abhiruchi.g@vaultinfo.com, from: abhiruchi.g@vaultinfo.com) 
    with HTTP; Thu, 15 May 2008 09:14:24 -0400 (EDT)
Date:	Thu, 15 May 2008 09:14:24 -0400 (EDT)
Subject: MIPS toolchain : should I choose shared library option for Alchemy DB1200
From:	abhiruchi.g@vaultinfo.com
To:	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-testers" <kernel-testers@vger.kernel.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Reply-To: abhiruchi.g@vaultinfo.com
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8BIT
Importance: Normal
X-Priority: 3 (Normal)
X-Type:	1
Message-ID: <56119.192.168.1.70.1210857264.webmail@192.168.1.70>
X-Mailer: webmail6.6.1
Return-Path: <abhiruchi.g@vaultinfo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhiruchi.g@vaultinfo.com
Precedence: bulk
X-list: linux-mips

hi,
   To build cross toolchain for MIPS, should I choose shared library option. My kernel hangs after :

Warning: unable to open an initial console.
/sbin/init


The function is in init/main.c.


static int noinline init_post(void)
{
        ..
        ..
        ..

        if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
                printk(KERN_WARNING "Warning: unable to open an initial console.
\n");

        (void) sys_dup(0);
        (void) sys_dup(0);

        if (ramdisk_execute_command) {
                run_init_process(ramdisk_execute_command);
                printk(KERN_WARNING "Failed to execute %s\n",
                                ramdisk_execute_command);
        }

        ..
        ..
        printk(KERN_WARNING "-- ag. sbin init\n");
        run_init_process("/sbin/init");
        printk(KERN_WARNING "-- ag. etc init\n");
        run_init_process("/etc/init");
        printk(KERN_WARNING "-- ag. bin init\n");
        run_init_process("/bin/init");
        printk(KERN_WARNING "-- ag. bin sh\n");
        run_init_process("/bin/sh");

        panic("No init found.  Try passing init= option to kernel.");

 }           
                                         
