Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 22:43:11 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:29352 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S8133592AbWG0VnD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Jul 2006 22:43:03 +0100
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id DEDB8E4051
	for <linux-mips@linux-mips.org>; Thu, 27 Jul 2006 14:57:56 -0700 (PDT)
Subject: 2.6 -initramfs -bootarg root=
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Thu, 27 Jul 2006 14:48:08 -0700
Message-Id: <1154036888.6804.8.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

I experimenting with different boot arguments to make the 2.6 kernel
boot on the DB1500 board (with the AU1500 MIPS processor).

Along with the image, the make also generated a /usr directory
containing the initramfs_data.cpio.gz and other files, namely:

CVS      Makefile    gen_init_cpio    initramfs_data.S
initramfs_data.cpio.gz  initramfs_list
Kconfig  built-in.o  gen_init_cpio.c  initramfs_data.cpio
initramfs_data.o

During the configuration, 'Create Root File System' was selected in the
xconfig menu.
Therefore, I think using NFS is appropriate.  In the boot args, I ve
written the following:

root=/dev/nfs  
nfsroot=192.168.1.8:/tftpboot/usr_as/initramfs_list 
console=tty0,115200,n,1,none
ip=xxx.xxx.x.146:xxx.xxx.x.8 (client: server)

Please help me out here--
Thank you..
Ashlesha.
