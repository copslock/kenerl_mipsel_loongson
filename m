Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2004 01:45:34 +0000 (GMT)
Received: from fgwmail6.fujitsu.co.jp ([IPv6:::ffff:192.51.44.36]:25549 "EHLO
	fgwmail6.fujitsu.co.jp") by linux-mips.org with ESMTP
	id <S8225222AbUCABpd>; Mon, 1 Mar 2004 01:45:33 +0000
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71]) by fgwmail6.fujitsu.co.jp (8.12.10/Fujitsu Gateway)
	id i211jMh8008387 for <linux-mips@linux-mips.org>; Mon, 1 Mar 2004 10:45:22 +0900
	(envelope-from sundar@pst.fujitsu.com)
Received: from s5.gw.fujitsu.co.jp by m1.gw.fujitsu.co.jp (8.12.10/Fujitsu Domain Master)
	id i211jLLj007727 for <linux-mips@linux-mips.org>; Mon, 1 Mar 2004 10:45:21 +0900
	(envelope-from sundar@pst.fujitsu.com)
Received: from classic.aoi.pst.fujitsu.com (classic.aoi.pst.fujitsu.com [10.90.149.12]) by s5.gw.fujitsu.co.jp (8.12.10)
	id i211jKAb031329 for <linux-mips@linux-mips.org>; Mon, 1 Mar 2004 10:45:20 +0900
	(envelope-from sundar@pst.fujitsu.com)
Received: from indofuji2 (dhcp155-203.aoi.pst.fujitsu.com [10.90.155.203])
	by classic.aoi.pst.fujitsu.com (8.9.3/8.9.3) with ESMTP id KAA19335
	for <linux-mips@linux-mips.org>; Mon, 1 Mar 2004 10:45:19 +0900
From: "sundar" <sundar@pst.fujitsu.com>
To: <linux-mips@linux-mips.org>
Subject: Problem after kernel entry point
Date: Mon, 1 Mar 2004 10:44:09 +0900
Message-ID: <001701c3ff2e$b12d4b60$cb9b5a0a@indofuji2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <sundar@pst.fujitsu.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sundar@pst.fujitsu.com
Precedence: bulk
X-list: linux-mips


HI,

I am trying to port kernel to mips arch.
After building the image, it just displays the kernel entry point and
stops it.It is not going further and no error message too.
What may be th problem? How i can debug this? 

Thanks & Regards,
sathis
