Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 11:09:17 +0100 (BST)
Received: from [IPv6:::ffff:203.129.212.34] ([IPv6:::ffff:203.129.212.34]:521
	"HELO contech.contechsoftware.com") by linux-mips.org with SMTP
	id <S8225409AbTIRKJO>; Thu, 18 Sep 2003 11:09:14 +0100
Received: (from prabhakar [200.1.1.48])
 by contech.contechsoftware.com (NAVGW 2.5.1.18) with SMTP id M2003091815464200042
 for <linux-mips@linux-mips.org>; Thu, 18 Sep 2003 15:46:42 +0530
Received: by localhost with Microsoft MAPI; Thu, 18 Sep 2003 15:46:35 -0000
Message-ID: <01C37DFC.0A2C6CA0.prabhakark@contechsoftware.com>
From: Prabhakar Kalasani <prabhakark@contechsoftware.com>
Reply-To: "prabhakark@contechsoftware.com" <prabhakark@contechsoftware.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: How disable CONFIG_PCI 
Date: Thu, 18 Sep 2003 15:46:34 -0000
Organization: Contech Software Limited
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
Encoding: 9 TEXT
Return-Path: <prabhakark@contechsoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prabhakark@contechsoftware.com
Precedence: bulk
X-list: linux-mips

Hi all,
I'm compiling Linux-2.4.21 kernel for CSB250 board downloaded from mips-linux,
I've configured CONFIG_PCI n , but when i go for xconfig, the value to CONFIG_PCI y
where it's getting over write ? 
Because of CONFIG_PCI y, I'm unable to get my Framebuffer device active
How to solve this problem...

Thanks in advence
Prabhakar Kalasani
