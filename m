Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2005 09:35:53 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:83.104.11.251]:31512 "EHLO
	exterity.co.uk") by linux-mips.org with ESMTP id <S8226005AbVCaIfi>;
	Thu, 31 Mar 2005 09:35:38 +0100
Received: from [192.168.0.85] ([192.168.0.85]) by exterity.co.uk with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 31 Mar 2005 09:37:07 +0100
Subject: Compressed Kernels
From:	JP Foster <jp.foster@exterity.co.uk>
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Date:	Thu, 31 Mar 2005 09:35:26 +0100
Message-Id: <1112258126.28438.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Mar 2005 08:37:07.0187 (UTC) FILETIME=[D28B4430:01C535CC]
Return-Path: <jpfoster@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jp.foster@exterity.co.uk
Precedence: bulk
X-list: linux-mips

I've noticed that mips doesn't have a compressed kernel option,
so I had added support (ripped shamelessly from arch/i386) for it
to save space on our flash chips.

It works fine for my db1550 and also our product boards.
The patch is pretty messy but if there was interest in it I could clean
it up. Is there any historical reason for it not being included?

-- 
jp.foster@exterity.co.uk
Digital Simplicity
