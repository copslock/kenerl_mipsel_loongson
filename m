Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2007 16:40:55 +0000 (GMT)
Received: from p549F72FE.dip.t-dialin.net ([84.159.114.254]:33981 "EHLO
	p549F72FE.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20040558AbXAJQkx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 16:40:53 +0000
Received: from nf-out-0910.google.com ([64.233.182.185]:6101 "EHLO
	nf-out-0910.google.com") by lappi.linux-mips.net with ESMTP
	id S136378AbXAJImA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 09:42:00 +0100
Received: by nf-out-0910.google.com with SMTP id l24so408118nfc
        for <linux-mips@linux-mips.org>; Wed, 10 Jan 2007 00:42:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=adrJ5QmNFU5FzWIKxdWh3FL+0g4YsqgarkdDxbWm/kZ+9qlUZ208cOQGq2lDyodsdVZFzrp13d8sLO766KG/XcAVMoZBj2dz2y3wzNyAj63sGCJ2vp/xBwZ5qby34GzAfUgQV6GCSTNhJwhpvlq9sY1750GyqA8Mc8x8B4k+aGU=
Received: by 10.49.13.14 with SMTP id q14mr981998nfi.1168418520988;
        Wed, 10 Jan 2007 00:42:00 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id l32sm3232375nfa.2007.01.10.00.41.59;
        Wed, 10 Jan 2007 00:42:00 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 0165C23F76E; Wed, 10 Jan 2007 09:44:05 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Date:	Wed, 10 Jan 2007 09:44:03 +0100
Message-Id: <116841864595-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf,

Here's is the second attempt to make this works on your Malta board
and all other boards that have some data reserved at the start of
their memories. In these cases the first patchset assumed wrongly that
the start of the memory was after this reserved area.

Patch 1/2 should work alone now. the kernel should report that your
mem config is wasting some memory for tracking reserved pages located
at the start of the mem.

Thanks for testing

		Franck

---

 arch/mips/kernel/setup.c |   40 +++++++++++++++++++++++++++++++---------
 arch/mips/mm/init.c      |   23 +++++++++++------------
 include/asm-mips/dma.h   |    1 +
 include/asm-mips/io.h    |    4 ++--
 include/asm-mips/page.h  |   25 +++++++++++++++++++++----
 5 files changed, 66 insertions(+), 27 deletions(-)
