Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6BKETh19728
	for linux-mips-outgoing; Wed, 11 Jul 2001 13:14:29 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6BKERV19725
	for <linux-mips@oss.sgi.com>; Wed, 11 Jul 2001 13:14:28 -0700
Received: from scotty.mgnet.de (pD9024645.dip.t-dialin.net [217.2.70.69])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id WAA18962
	for <linux-mips@oss.sgi.com>; Wed, 11 Jul 2001 22:14:25 +0200 (MET DST)
Received: (qmail 32640 invoked from network); 11 Jul 2001 20:14:24 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 11 Jul 2001 20:14:24 -0000
Date: Wed, 11 Jul 2001 22:14:18 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Peter Milleson <peter@milleson.com>
cc: linux-mips@oss.sgi.com
Subject: Re: boots then kernel panic
In-Reply-To: <MEEBIKPBEIOBCILMHHEJOEMDCCAA.peter@milleson.com>
Message-ID: <Pine.LNX.4.21.0107112213120.11181-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 11 Jul 2001, Peter Milleson wrote:

> Hi all!
> 
> Finally have my bootp and tftp server working in order for my used Indy 175
> to boot off the network. The system finally downloaded the kernel image (the
> kernel from hardhat-sgi-5.1) and the system kernel panics with the following
> error:
> 
> SCSI bus is being reset for host 0 channel 0.
> scsi0: reset. page fault from irq handler: 0000
> $0 : {lots of numbers}
> $4 : "	"
> $8 : "	"
> $12: "	"
> $16: "	"
> $29: "	"
> $24: "	"
> $28: "	"
> epc	: 880fa97c
> Status: 1004fc82
> Cause	: 000000008
> Aiee, killing interrupt handler
> Kernel panic: Attempted to kill the idle task!
> In swapper task - not syncing
> 
> Could there be a problem with the onboard SCSI controller? I don't know of
> any way to test the SCSI subsystem without a bootable SGI cdrom. I am going
> to try and download a different (newer?) kernel and try again and see what
> happens.

This is very likely a problem with the SCSI Code or your hardware.
But I would assume that the kernel is just plain too old.
Please try a newer kernel (you can find one on ftp://source.rfc822.org/).

		HTH, Klaus


-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
