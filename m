Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 06:07:38 +0100 (BST)
Received: from smtp207.iad.emailsrvr.com ([207.97.245.207]:3508 "EHLO
	smtp207.iad.emailsrvr.com") by ftp.linux-mips.org with ESMTP
	id S20030601AbYELFHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2008 06:07:35 +0100
Received: from relay10.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id CC3D51B4082;
	Mon, 12 May 2008 01:07:28 -0400 (EDT)
Received: from vaultinfo.com (webmail19.webmail.iad.mlsrvr.com [192.168.1.17])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id C54F41B4079;
	Mon, 12 May 2008 01:07:28 -0400 (EDT)
Received: by webmail.mailsin.net
    (Authenticated sender: abhiruchi.g@vaultinfo.com, from: abhiruchi.g@vaultinfo.com) 
    with HTTP; Mon, 12 May 2008 01:07:28 -0400 (EDT)
Date:	Mon, 12 May 2008 01:07:28 -0400 (EDT)
Subject: =?UTF-8?Q?WARNING:=20arch/mips/au1000/common/built-in.o(.text+0x15c0):?=
 =?UTF-8?Q?=20Section=20mismatch:=20reference=20to=20.init.data:=20(betwee?=
 =?UTF-8?Q?n=20'au1xxx=5Fplatform=5Finit'=20and=20'=5F=5Ffixup=5Fbigphys?=
 =?UTF-8?Q?=5Faddr')?=
From:	abhiruchi.g@vaultinfo.com
To:	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	kernel-testers@vger.kernel.org
Reply-To: abhiruchi.g@vaultinfo.com
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8BIT
Importance: Normal
X-Priority: 3 (Normal)
X-Type:	1
Message-ID: <54350.192.168.1.71.1210568848.webmail@192.168.1.71>
X-Mailer: webmail6.6.1
Return-Path: <abhiruchi.g@vaultinfo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhiruchi.g@vaultinfo.com
Precedence: bulk
X-list: linux-mips

Hi all,
  I am trying to configure the kernel for mips(DB1200 bosrd).I am getting this warning.
how to remove this warning?

WARNING: arch/mips/au1000/common/built-in.o(.text+0x15c0): Section mismatch: reference to .init.data: (between 'au1xxx_platform_init' and '__fixup_bigphys_addr')
WARNING: arch/mips/au1000/common/built-in.o(.text+0x15c4): Section mismatch: reference to .init.data: (between 'au1xxx_platform_init' and '__fixup_bigphys_addr


My kernel hangs after this:
===========================
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
Freeing unused kernel memory: 164k freed
Warning: unable to open an initial console.
Algorithmics/MIPS FPU Emulator v1.5


Thanks,
Abhi
