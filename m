Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 08:53:17 +0100 (BST)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:20912 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8225551AbUJNHxM>;
	Thu, 14 Oct 2004 08:53:12 +0100
Received: from toch.dfpost.ru (toch.dfpost.ru [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id 488553E4DF
	for <linux-mips@linux-mips.org>; Thu, 14 Oct 2004 11:51:29 +0400 (MSD)
Date: Thu, 14 Oct 2004 11:53:04 +0000
From: Dmitriy Tochansky <toch@dfpost.ru>
To: linux-mips@linux-mips.org
Subject: Strange instruction
Message-Id: <20041014115304.3edbe141.toch@dfpost.ru>
Organization: Special Technology Center
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

Hello!

When starts kernel for my au1500 board reseting board. After disassembling I found instruction
which reseting board. Here is few strings of "mipsel-linux-objdump -D vmlinux" output:

---

a0000650:       07400003        bltz    k0,a0000660 <nmi_handler+0x1c>          
a0000654:       03a0d82d        0x3a0d82d                                       
a0000658:       3c1ba020        lui     k1,0xa020 

---

Base address changed by me.

What is A0000654? There is board resets.
