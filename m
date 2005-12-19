Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2005 11:25:05 +0000 (GMT)
Received: from [62.38.104.168] ([62.38.104.168]:6338 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8133864AbVLSLYr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2005 11:24:47 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id AB29D1F101
	for <linux-mips@linux-mips.org>; Mon, 19 Dec 2005 13:25:37 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	linux-mips@linux-mips.org
Subject: Q: where does cmdline come from in 2.6?
Date:	Mon, 19 Dec 2005 13:25:32 +0200
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512191325.35156.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

I am porting to a new platform. My board gives me a custom bootloader, which 
boots the kernel from a std uncompressed ELF image. 
In MIPS, how do I find the original cmdline the bootloader provides me? I know 
there is one. In 2.6.15-rc it seems to get overriden by some build-time line.
Can you please give me a hint.. 
