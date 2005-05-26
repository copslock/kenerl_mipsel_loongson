Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 14:20:34 +0100 (BST)
Received: from natfrord.rzone.de ([IPv6:::ffff:81.169.145.161]:41156 "EHLO
	natfrord.rzone.de") by linux-mips.org with ESMTP
	id <S8225942AbVEZNUR>; Thu, 26 May 2005 14:20:17 +0100
Received: from tux04 (p548D6BF1.dip.t-dialin.net [84.141.107.241])
	by post.webmailer.de (8.13.1/8.13.1) with ESMTP id j4QDKFEw004635
	for <linux-mips@linux-mips.org>; Thu, 26 May 2005 15:20:16 +0200 (MEST)
From:	Hauke Goos-Habermann <haukeh@pc-kiel.de>
To:	linux-mips@linux-mips.org
Subject: CCA4 mapping
Date:	Thu, 26 May 2005 15:20:34 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261520.34985.haukeh@pc-kiel.de>
Return-Path: <haukeh@pc-kiel.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: haukeh@pc-kiel.de
Precedence: bulk
X-list: linux-mips

Hi all,

I'm trying to make a mapping (with burst mode (CCA4)) from the graphic card 
memory to the virtual memory space.

I used the __ioremap with different parameters without success.

The grafic card memory is 64MB, and can be found at 0x00800000 and should be 
mapped to a memory space that can be accessed via a kernel module or via user 
space.

I tried the following mapping:

add_wired_entry((0x00800000 >> 2) | 0x0027, (0x00900000 >> 2) | 0x0027, 
0x30000000 | 0x0027, 0x01ffe000);
add_wired_entry((0x00a00000 >> 2) | 0x0027, (0x00a00000 >> 2) | 0x0027, 
0x32000000 | 0x0027, 0x01ffe000);

This doesn't work either.

Does anybody have an idea how to make the CCA4 mapping?

Cu Hauke
