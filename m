Received:  by oss.sgi.com id <S42227AbQGMWA6>;
	Thu, 13 Jul 2000 15:00:58 -0700
Received: from gw-nl4.philips.com ([192.68.44.36]:21508 "EHLO convert rfc822-to-8bit
        gw-nl4.philips.com") by oss.sgi.com with ESMTP id <S42205AbQGMWAg>;
	Thu, 13 Jul 2000 15:00:36 -0700
Received: from smtprelay-nl1.philips.com (localhost.philips.com [127.0.0.1])
          by gw-nl4.philips.com with ESMTP id AAA10079
          for <linux-mips@oss.sgi.com>; Fri, 14 Jul 2000 00:00:43 +0200 (MEST)
          (envelope-from erik.niessen@philips.com)
From:   erik.niessen@philips.com
Received: from smtprelay-eur1.philips.com(130.139.36.3) by gw-nl4.philips.com via mwrap (4.0a)
	id xma010077; Fri, 14 Jul 00 00:00:43 +0200
Received: from notessmtp-nl1.philips.com (notessmtp-nl1.philips.com [130.139.36.10]) 
	by smtprelay-nl1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id AAA19819
	for <linux-mips@oss.sgi.com>; Fri, 14 Jul 2000 00:00:43 +0200 (MET DST)
Received: from EHLMS01.DIAMOND.PHILIPS.COM (ehlms01sv1.diamond.philips.com [130.139.54.212]) 
	by notessmtp-nl1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id AAA03813
	for <linux-mips@oss.sgi.com>; Fri, 14 Jul 2000 00:00:42 +0200 (MET DST)
Received: by EHLMS01.DIAMOND.PHILIPS.COM (Soft-Switch LMS 4.0) with snapi
          via EMEA3 id 0056890012369098; Fri, 14 Jul 2000 00:00:37 +0200
To:     <linux-mips@oss.sgi.com>
Subject: Graphics on a mips-board
Message-ID: <0056890012369098000002L982*@MHS>
Date:   Fri, 14 Jul 2000 00:00:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; name="MEMO 07/13/00 23:59:24"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I have the ide-controller running on my mips-board. My next step will be to get some graphics out of this box. On the board is an onboard graphics chip and according to the specs it is VGA compatible.

I am using the serial-console for debugging and for sending characters to the box. My source tree is based on kernel 2.2.12.

Because the chip is VGA compatible I try to get the VGA16 framebuffer running on the box. After enabling the VGA16 framebuffer I receive the following output:

Jumping to image at 800605DCh...
Detected 16MB of memory.
Loading R4000/MIPS32 MMU routines.
CPU revision is: 000028a0
Primary instruction cache 32kb, linesize 32 bytes
Primary data cache 32kb, linesize 32 bytes
Linux version 2.2.12 (eniessen@psvcas16) (gcc version egcs-2.90.29 980515 (egcs-
1.0.3 release)) #10 Thu Jul 13 13:45:19 PDT 2000
calculating r4koff... 000f4240(1000000)
CPU frequency 200.00 MHz
Console: colour VGA+ 80x50
Calibrating delay loop... 199.88 BogoMIPS
Memory: 12652k/16380k available (616k kernel code, 2724k data)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Found SAA9730 at b2800000
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
Starting kswapd v 1.1.1.1
vga16fb: initializing
vga16fb: mapped to 0xa00a0000
Console: switching to colour frame buffer device 80x30

It is doing the take_over_console but when I check the output of my VGA-connector there is no signal. Someone an idea how I can debug this???

Has somebody any experience with framebuffers on a mips?

Any hints/links/tips would be welcome,

Thanks for your time,

	Erik
