Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jan 2009 19:40:11 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:51842 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21366036AbZAWTkJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jan 2009 19:40:09 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 55AA48F849D
	for <linux-mips@linux-mips.org>; Fri, 23 Jan 2009 20:40:03 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrqDKLTp9I9k for <linux-mips@linux-mips.org>;
	Fri, 23 Jan 2009 20:40:03 +0100 (CET)
Received: from [10.1.1.26] (unknown [192.168.22.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 9046A8F849C
	for <linux-mips@linux-mips.org>; Fri, 23 Jan 2009 20:40:02 +0100 (CET)
Subject: Au1550 with kernel linux-2.6.28.1
From:	Frank Neuber <linux-mips@kernelport.de>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Fri, 23 Jan 2009 20:40:00 +0100
Message-Id: <1232739600.28527.289.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <linux-mips@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@kernelport.de
Precedence: bulk
X-list: linux-mips

Hi List,
at the moment I run a 2.6.16.11 on this core. Because of some trouble
with the USB 2.0 EHCI controller (which is wired on the internal PCI
bus) I am thinking about running a more recent kernel. 
It was easy to build linux-2.6.28.1 based on the db1550_defconfig using
the mips_4KCle-gcc (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) toolchain.
But I see nothing on the serial console after starting the kernel. Some
time ago (10 month I think) I was testing the head of the git mips
kernel and the system was booting with some trouble on the pci bus but I
was able so see someting on the serial console.

A quick search on this list show me
http://www.linux-mips.org/archives/linux-mips/2008-11/msg00099.html
the last activity on the alchemy chip.

I just want to ask who is working with the au1550 on a more recent
kernel than 2.6.16.11. 
I'll start now with some early printk to solve booting problems and than
we will see .....

Kind regards,
 FN
