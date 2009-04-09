Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 05:51:53 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:64927 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20023035AbZDIEvr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 05:51:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 5688834131;
	Thu,  9 Apr 2009 12:48:46 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AQgeTm1i9EaG; Thu,  9 Apr 2009 12:48:41 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 27EEB3412F;
	Thu,  9 Apr 2009 12:48:41 +0800 (CST)
Message-ID: <49DD7ED6.7050701@lemote.com>
Date:	Thu, 09 Apr 2009 12:51:34 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 2/14] lemote: i8259 IMR write flush
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

read back after write to IMR, otherwise, there will be many spurious
irqs from it.
---
arch/mips/kernel/i8259.c | 2 ++
1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index 413bd1d..9d55c73 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -175,11 +175,13 @@ handle_real_irq:
if (irq & 8) {
inb(PIC_SLAVE_IMR); /* DUMMY - (do we need this?) */
outb(cached_slave_mask, PIC_SLAVE_IMR);
+ inb(PIC_SLAVE_IMR);
outb(0x60+(irq&7), PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
outb(0x60+PIC_CASCADE_IR, PIC_MASTER_CMD); /* 'Specific EOI' to
master-IRQ2 */
} else {
inb(PIC_MASTER_IMR); /* DUMMY - (do we need this?) */
outb(cached_master_mask, PIC_MASTER_IMR);
+ inb(PIC_MASTER_IMR);
outb(0x60+irq, PIC_MASTER_CMD); /* 'Specific EOI to master */
}
smtc_im_ack_irq(irq);
-- 
1.5.6.5
