Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2003 20:07:42 +0100 (BST)
Received: from mout1.freenet.de ([IPv6:::ffff:194.97.50.132]:49049 "EHLO
	mout1.freenet.de") by linux-mips.org with ESMTP id <S8224802AbTF2THk>;
	Sun, 29 Jun 2003 20:07:40 +0100
Received: from [194.97.50.136] (helo=mx3.freenet.de)
	by mout1.freenet.de with asmtp (Exim 4.20)
	id 19WhWR-0004S7-AH
	for linux-mips@linux-mips.org; Sun, 29 Jun 2003 21:07:35 +0200
Received: from p508f70f0.dip.t-dialin.net ([80.143.112.240] helo=server.private.priv)
	by mx3.freenet.de with asmtp (ID aspam@freenet.de) (Exim 4.20 #1)
	id 19WhWQ-00074O-U4
	for linux-mips@linux-mips.org; Sun, 29 Jun 2003 21:07:35 +0200
Received: from physik.private.priv (physik.private.priv [192.168.1.10])
	by server.private.priv (8.12.6/8.12.6) with SMTP id h5TJ7Vlk021904
	for <linux-mips@linux-mips.org>; Sun, 29 Jun 2003 21:07:32 +0200 (CEST)
Date: Sun, 29 Jun 2003 21:11:36 +0200
From: Achim Hensel <achim.hensel@ruhr-uni-bochum.de>
To: Linux-mips Mailing-Liste <linux-mips@linux-mips.org>
Subject: Which toolchain? Trouble at kernel-starting
Message-Id: <20030629211136.23809a06.achim.hensel@ruhr-uni-bochum.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-portbld-freebsd4.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <achim.hensel@ruhr-uni-bochum.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: achim.hensel@ruhr-uni-bochum.de
Precedence: bulk
X-list: linux-mips

Hello, 

I want to start some work for the Indigo1 (IP20). So, I need a working
kernel.

At first I tried the tftpboot.img from the debian indy install. After
the tftpload, it stopped with a message "Yeee, could not determine
architecture type <SGI-IP20>" as expected.

Later I compiled a kernel with no changes, just as a starting point for
work. After some experience, I got it compiled, converted to ecoff and
loaded, but after the kernel load, the machine dies silently - no
messages, nothing. 

I used the sdelinux toolchain mentioned at the linux-mips homepage,
and the latest CVS 2.4-kernel from linux-mips, and some other toolchains
and kernels.

Does anybody have some idea, which toolchain/kernel source was used for
the debian tftp boot installer image?
 
(Or what might cause these symptoms?)

Thank you,
	Achim Hensel
