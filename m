Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 10:54:00 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:34008 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491944AbZGJIxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 10:53:52 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A8rkHu024146
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 01:53:46 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 01:53:45 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A8rjX3021818;
	Fri, 10 Jul 2009 01:53:45 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 0/3] Port malta interrupt changes (GIC, GCMP) from linux-mti
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 01:53:39 -0700
Message-ID: <20090710085338.25918.37597.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 08:53:45.0932 (UTC) FILETIME=[EF1528C0:01CA013B]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

The following series of patches port the changes in linux-mti.git repository to the head of tree. 
 
---

Chris Dearman (2):
      Port of GIC related changes from MTI branch.
      Fix accesses to device registers on MIPS boards

Jaidev Patwardhan (1):
      Avoid accessing GCMP registers when they are not present


 arch/mips/Kconfig                 |    1 
 arch/mips/include/asm/gcmpregs.h  |   18 ++--
 arch/mips/include/asm/gic.h       |  188 ++++---------------------------------
 arch/mips/kernel/irq-gic.c        |  116 +++++++++--------------
 arch/mips/kernel/setup.c          |    3 -
 arch/mips/kernel/smp-mt.c         |   10 ++
 arch/mips/kernel/vpe.c            |    3 -
 arch/mips/mti-malta/malta-amon.c  |    7 +
 arch/mips/mti-malta/malta-int.c   |  119 ++++++++++++++---------
 arch/mips/mti-malta/malta-pci.c   |   14 ++-
 arch/mips/mti-malta/malta-setup.c |  111 ++++++++++++++++++++++
 11 files changed, 286 insertions(+), 304 deletions(-)
