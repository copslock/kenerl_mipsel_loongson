Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 18:10:29 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:47112 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8225072AbTD1RKZ>; Mon, 28 Apr 2003 18:10:25 +0100
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA493
          for <linux-mips@linux-mips.org>; Mon, 28 Apr 2003 10:10:16 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@linux-mips.org>
Subject: wait on vr4181 part 2
Date: Mon, 28 Apr 2003 10:16:18 -0700
Message-ID: <089f01c30da9$e237d5d0$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200304281825.09697.wom@tateyama.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Return-Path: <sseeger@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sseeger@stellartec.com
Precedence: bulk
X-list: linux-mips

If there is no wait, then what's that in arch/mips/vr4181/osprey/reset.c ?
void nec_osprey_halt(void)
{
	printk("KERN_NOTICE "\n** You can safely turn off the power.\n");
	while(1)
		__asm__(".set\tmips3\n\t"
			"wait\n\t"
			".set\tmips0");
}

Steve
