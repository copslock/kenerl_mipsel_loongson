Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 11:59:54 +0000 (GMT)
Received: from inspiration-98-179-ban.inspiretech.com ([IPv6:::ffff:203.196.179.98]:11655
	"EHLO smtp.inspirtek.com") by linux-mips.org with ESMTP
	id <S8225201AbTBUL7x>; Fri, 21 Feb 2003 11:59:53 +0000
Received: from mail.inspiretech.com (mail.inspiretech.com [150.1.1.1])
	by smtp.inspirtek.com (8.12.5/8.12.5) with ESMTP id h1LC42vO032379
	for <linux-mips@linux-mips.org>; Fri, 21 Feb 2003 17:34:10 +0530
Message-Id: <200302211204.h1LC42vO032379@smtp.inspirtek.com>
Received: from WorldClient [150.1.1.1] by inspiretech.com [150.1.1.1]
	with SMTP (MDaemon.v3.5.7.R)
	for <linux-mips@linux-mips.org>; Fri, 21 Feb 2003 17:19:46 +0530
Date: Fri, 21 Feb 2003 17:19:45 +0530
From: "Ashish anand" <ashish.anand@inspiretech.com>
To: linux-mips@linux-mips.org
Subject: wired tlb entries and global bit..
X-Mailer: WorldClient Standard 3.5.0e
X-MDRemoteIP: 150.1.1.1
X-Return-Path: ashish.anand@inspiretech.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Return-Path: <ashish.anand@inspiretech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish.anand@inspiretech.com
Precedence: bulk
X-list: linux-mips

A small question..

1.my understanding of wired tlb entries mean set of address translations
that i always want to be present throughout the system is on ,
irrespective of asid's/tlb flush , examplesake pci io/mem window ...is
this right?

2.can i acheive the same by using the global bit from entrylo0 and
entrylo1.

Best Regards,
Ashish Anand
