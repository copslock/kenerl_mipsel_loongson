Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 10:58:21 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:46641 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491922AbZGJI6O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 10:58:14 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A8w7Qk024254
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 01:58:07 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 01:58:06 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A8w627021828;
	Fri, 10 Jul 2009 01:58:06 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 0/2] Port Malta setup patches from linux-mti
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 01:57:59 -0700
Message-ID: <20090710085759.26049.52144.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 08:58:06.0884 (UTC) FILETIME=[8A9F4640:01CA013C]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

The following series of patches port Malta setup patches from linux-mti.git repository to the head of tree.
---

Chris Dearman (2):
      Added coherentio command line option for DMA_NONCOHERENT kernel
      [MTI] Enable PIIX4 PCI2.1 compliancy on Malta


 arch/mips/include/asm/gcmpregs.h  |   18 ++--
 arch/mips/include/asm/gic.h       |  188 ++++---------------------------------
 arch/mips/kernel/irq-gic.c        |  116 +++++++++--------------
 arch/mips/kernel/setup.c          |    3 -
 arch/mips/kernel/smp-mt.c         |   10 ++
 arch/mips/kernel/vpe.c            |    3 -
 arch/mips/mti-malta/malta-amon.c  |    7 +
 arch/mips/mti-malta/malta-int.c   |  101 +++++++++++---------
 arch/mips/mti-malta/malta-pci.c   |   14 ++-
 arch/mips/mti-malta/malta-setup.c |  111 ++++++++++++++++++++++
 10 files changed, 271 insertions(+), 300 deletions(-)
