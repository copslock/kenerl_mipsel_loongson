Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 01:04:08 +0100 (BST)
Received: from web40003.mail.yahoo.com ([IPv6:::ffff:66.218.78.21]:1672 "HELO
	web40003.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224950AbUGUAED>; Wed, 21 Jul 2004 01:04:03 +0100
Message-ID: <20040721000356.39366.qmail@web40003.mail.yahoo.com>
Received: from [63.87.1.243] by web40003.mail.yahoo.com via HTTP; Tue, 20 Jul 2004 17:03:56 PDT
Date: Tue, 20 Jul 2004 17:03:56 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: Should #ifdef __KERNEL__ be added before #include <spaces.h> in asm-mips/addrspace.h ?
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wsonguci@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsonguci@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

Should #ifdef _KERNEL__ be added before #include
<spaces.h> in asm-mips/addrspace.h?

I think the reason is the same as when you added
the #ifdef __KERNEL__ before #include <spaces.h>
for asm-mips/page.h.

-Song


	
		
__________________________________
Do you Yahoo!?
Vote for the stars of Yahoo!'s next ad campaign!
http://advision.webevents.yahoo.com/yahoo/votelifeengine/
