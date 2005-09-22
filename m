Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2005 12:34:40 +0100 (BST)
Received: from [IPv6:::ffff:85.21.88.2] ([IPv6:::ffff:85.21.88.2]:60882 "HELO
	mail.dev.rtsoft.ru") by linux-mips.org with SMTP
	id <S8225233AbVIVLeY>; Thu, 22 Sep 2005 12:34:24 +0100
Received: (qmail 14576 invoked from network); 22 Sep 2005 11:34:23 -0000
Received: from localhost.localdomain.dev.rtsoft.ru (HELO ?192.168.1.158?) (192.168.1.158)
  by mail.dev.rtsoft.ru with SMTP; 22 Sep 2005 11:34:23 -0000
Message-ID: <43329632.8070400@dev.rtsoft.ru>
Date:	Thu, 22 Sep 2005 15:32:02 +0400
From:	kbaidarov <kbaidarov@dev.rtsoft.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [patch] db1550: useless memset() call
Content-Type: multipart/mixed;
 boundary="------------010503060804050403090207"
Return-Path: <kbaidarov@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kbaidarov@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010503060804050403090207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've try kernel without memset() on the board - is ok, board boot.
All drivers works fine. Than I grep the kernel sources:

[root@windmill linux]# grep -nri "memset(irq_desc" arch/
arch/mips/au1000/common/irq.c:449:      memset(irq_desc, 0, sizeof(irq_desc));
arch/mips/ite-boards/generic/irq.c:184:        memset(irq_desc, 0, sizeof(irq_desc));
[root@windmill linux]#

Only 2 matches! Does we needs memset() at all?
And if some one try to initialize irq_desc from start_kernel() before arch_init_irq() call, then following arch_init_irq() call discard all that initialization.


--------------010503060804050403090207
Content-Type: text/x-patch;
 name="lm_db1550_irq_desc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lm_db1550_irq_desc.patch"

Description:
Removes useless memset() call.
Signed-off-by: Konstantin Baydarov<kbaidarov@dev.rtsoft.ru>

Index: linux_up/linux/arch/mips/au1000/common/irq.c
===================================================================
--- linux_up.orig/linux/arch/mips/au1000/common/irq.c
+++ linux_up/linux/arch/mips/au1000/common/irq.c
@@ -446,7 +446,6 @@ void __init arch_init_irq(void)
 	extern int au1xxx_ic0_nr_irqs;
 
 	cp0_status = read_c0_status();
-	memset(irq_desc, 0, sizeof(irq_desc));
 	set_except_vector(0, au1000_IRQ);
 
 	/* Initialize interrupt controllers to a safe state.

--------------010503060804050403090207--
