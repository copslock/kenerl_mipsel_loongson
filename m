Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 15:47:12 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:15474 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038252AbWLFPrH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 15:47:07 +0000
Received: by nf-out-0910.google.com with SMTP id l24so555907nfc
        for <linux-mips@linux-mips.org>; Wed, 06 Dec 2006 07:47:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=lA7ebdCXY8iZQIaryLRr8Nbkc7lE8Lo2beY2O48JPrPP1EUQRzjvYWQRNr6BcHq8bUkRTy+ygo7Ks4JgzQO7OUI9Wbo8sdy24wkzWd5iqtBjrPfJv8vyTmeCb+CqiRfjaMv2/DLQCz8gqnMitIaezluGtBu1IH/hYz/ppFhsAbM=
Received: by 10.49.91.6 with SMTP id t6mr2378148nfl.1165420026786;
        Wed, 06 Dec 2006 07:47:06 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id m16sm2290260nfc.2006.12.06.07.47.06;
        Wed, 06 Dec 2006 07:47:06 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 7470E23F76E; Wed,  6 Dec 2006 16:48:30 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [RFC] FLATMEM: allow memory to start at pfn != 0
Date:	Wed,  6 Dec 2006 16:48:27 +0100
Message-Id: <1165420110699-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.1
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patchset relaxes this constraint. Basically you just need to
define in your platform code (include/asm-mips/mach-foo/spaces.h
probably) PHYS_OFFSET that corresponds to the start of your
physical memory and you're done.

The first patch is just a fix for HIGHMEM, I just found it while
writing this patchset. I haven't done any tests though, I have
no hardwares to play with.

The second and third patchs are the real meat. There are 2 points
that I'm not really sure:

	- PHYS_OFFSET is defined in page.h, I'm not sure if it's
	the right place though.

	- ARCH_PFN_OFFSET is always defined whatever the memory
	model. I don't think it will hurt since physical memory
	always has a starting point in all cases.



Please consider.

		Franck
---

 arch/mips/kernel/setup.c |   30 ++++++++++++++++++++++--------
 arch/mips/mm/init.c      |   30 +++++++++++++-----------------
 include/asm-mips/dma.h   |    1 +
 include/asm-mips/io.h    |    4 ++--
 include/asm-mips/page.h  |   25 +++++++++++++++++++++----
 5 files changed, 59 insertions(+), 31 deletions(-)
