Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 10:52:03 +0100 (BST)
Received: from inspiration-98-179-ban.inspiretech.com ([IPv6:::ffff:203.196.179.98]:8846
	"EHLO smtp.inspirtek.com") by linux-mips.org with ESMTP
	id <S8225278AbTDPJv7>; Wed, 16 Apr 2003 10:51:59 +0100
Received: from mail.inspiretech.com (mail.inspiretech.com [150.1.1.1])
	by smtp.inspirtek.com (8.12.5/8.12.5) with ESMTP id h3G9xVf6017958
	for <linux-mips@linux-mips.org>; Wed, 16 Apr 2003 15:29:35 +0530
Message-Id: <200304160959.h3G9xVf6017958@smtp.inspirtek.com>
Received: from WorldClient [150.1.1.1] by inspiretech.com [150.1.1.1]
	with SMTP (MDaemon.v3.5.7.R)
	for <linux-mips@linux-mips.org>; Wed, 16 Apr 2003 15:10:19 +0530
Date: Wed, 16 Apr 2003 15:10:17 +0530
From: "Ashish anand" <ashish.anand@inspiretech.com>
To: linux-mips@linux-mips.org
Subject: vmalloc cached space..
X-Mailer: WorldClient Standard 3.5.0e
X-MDRemoteIP: 150.1.1.1
X-Return-Path: ashish.anand@inspiretech.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Return-Path: <ashish.anand@inspiretech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish.anand@inspiretech.com
Precedence: bulk
X-list: linux-mips

Hello,

As vmalloc returns KSEG2 cached memory , 
1.can I use a volatile pointer to treat it as safe as uncached..?
or
2. i should use vmalloc_prot (size, PAGE_KERNEL_UNCACHED) in umap.c.

Best regards,
Ashish

 
