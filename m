Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6BJHJt18106
	for linux-mips-outgoing; Wed, 11 Jul 2001 12:17:19 -0700
Received: from aux153.plano.net (aux-209-217-36-11.oklahoma.net [209.217.36.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6BJHHV18102
	for <linux-mips@oss.sgi.com>; Wed, 11 Jul 2001 12:17:17 -0700
Received: (qmail 23238 invoked from network); 11 Jul 2001 19:17:15 -0000
Received: from c572019-b.plano1.tx.home.com (HELO asrael) (24.17.166.65)
  by aux153.plano.net with SMTP; 11 Jul 2001 19:17:15 -0000
Reply-To: <peter@milleson.com>
From: "Peter Milleson" <peter@milleson.com>
To: <linux-mips@oss.sgi.com>
Subject: boots then kernel panic
Date: Wed, 11 Jul 2001 14:17:14 -0500
Message-ID: <MEEBIKPBEIOBCILMHHEJOEMDCCAA.peter@milleson.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all!

Finally have my bootp and tftp server working in order for my used Indy 175
to boot off the network. The system finally downloaded the kernel image (the
kernel from hardhat-sgi-5.1) and the system kernel panics with the following
error:

SCSI bus is being reset for host 0 channel 0.
scsi0: reset. page fault from irq handler: 0000
$0 : {lots of numbers}
$4 : "	"
$8 : "	"
$12: "	"
$16: "	"
$29: "	"
$24: "	"
$28: "	"
epc	: 880fa97c
Status: 1004fc82
Cause	: 000000008
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

Could there be a problem with the onboard SCSI controller? I don't know of
any way to test the SCSI subsystem without a bootable SGI cdrom. I am going
to try and download a different (newer?) kernel and try again and see what
happens.

Any help or pointers in the right direction would greatly be appreciated.

Thanks,

Peter
mailto:pitr256@milleson.com
