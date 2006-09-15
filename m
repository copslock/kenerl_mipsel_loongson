Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2006 11:12:18 +0100 (BST)
Received: from mail.sysgo.com ([62.8.134.5]:53769 "EHLO mail.sysgo.com")
	by ftp.linux-mips.org with ESMTP id S20037601AbWIOKMQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Sep 2006 11:12:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 6A92FCC19F
	for <linux-mips@linux-mips.org>; Fri, 15 Sep 2006 12:12:09 +0200 (CEST)
Received: from mail.sysgo.com (localhost [127.0.0.1])
	by localhost (AvMailGate-2.0.2-8) id 28706-19F1FBE3;
	Fri, 15 Sep 2006 12:12:09 +0200
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id E9FCFCC19E
	for <linux-mips@linux-mips.org>; Fri, 15 Sep 2006 12:12:08 +0200 (CEST)
Received: by donald.sysgo.com (Postfix, from userid 65534)
	id ECF9526886D; Fri, 15 Sep 2006 12:12:08 +0200 (CEST)
Received: from cam (unknown [172.40.1.200])
	by donald.sysgo.com (Postfix) with ESMTP id A6035268701
	for <linux-mips@linux-mips.org>; Fri, 15 Sep 2006 12:12:07 +0200 (CEST)
From:	Carlos Mitidieri <carlos.mitidieri@sysgo.com>
To:	linux-mips@linux-mips.org
Subject: vmlinux and umon
Date:	Fri, 15 Sep 2006 12:12:16 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609151212.16566.carlos.mitidieri@sysgo.com>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-8; AVE: 7.2.0.16; VDF: 6.36.0.24; host: mailgate.sysgo.com)
Return-Path: <carlos.mitidieri@sysgo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carlos.mitidieri@sysgo.com
Precedence: bulk
X-list: linux-mips

Hi List,

As I posted some days ago, I am porting the kernel 2.6.15 to a CSB655 board.

I am trying to boot a vmlinux image from the umon that came with the board 
without sucess: The kernel crashes when setup_arch() is called in 
start_kernel() function (init/main.c), without any output to the console from 
the printk()'s that are just before setup_arch().   

What I could devise until now is that there is a mismatch between the memory 
mappings of umon and linux. The umon  sets  RAMBASE  to 0xa0000000, and loads 
applications to addresses above 0xa0300000, only. Linux-mips sets PAGE_OFFSET 
to 0x80000000 and assumes that the kernel is loaded in KSEG0 (correct me 
please if I am saying something that is not true).

Now, if set LOADADD e.g. to 0xa0400000 in arch/mips/Makefile, the vmlinux 
booting fails for a more or less obvious reason (mismatch to PAGE_OFFSET).
But if I adjust the PAGE_OFFSET to match the umon's mapping (i.e. to 0xa000 
0000) the kernel booting. In both cases at the same point described above.

What am I missing here? 
Thanks in advance  and best regards.

-- 
Carlos Mitidieri
SYSGO AG - Office Ulm
