Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 23:33:40 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:62383 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20027650AbWJJWdi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 23:33:38 +0100
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 661EC15D4005
	for <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 15:57:20 -0700 (PDT)
Subject: calibrate_delay function
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 10 Oct 2006 15:43:00 -0700
Message-Id: <1160520180.6521.29.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,
I m working on the Encore M3 board that has the AU1500 MIPS processor on
it.  I aim to port the 2.6 linux kernel to the board which is already
supported in the 2.4 kernel.

The start_kernel function in linux/init/main.c file, calls a function
calibrate_delay found in the arch/frv/kernel/setup.c file.  Why does the
kernel call this function which is a part of the Fujitsu FR-V
architecture?  

When I build the image, this is the point where the kernel is stuck and
the last contents of the log buffer show the following printk message
from the calibrate_delay function:


> Calibrating delay loop...

Thanks,
Ashlesha.
