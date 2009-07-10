Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 11:05:51 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:35229 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491989AbZGJJFo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 11:05:44 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A95bbc024437
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 02:05:37 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 02:05:36 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A95aQf021851;
	Fri, 10 Jul 2009 02:05:36 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 0/2] Port MT and SMTC changes from linux-mti
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 02:05:29 -0700
Message-ID: <20090710090529.26243.22320.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 09:05:36.0865 (UTC) FILETIME=[96D4ED10:01CA013D]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

The following series of patches port MT and SMTC changes in linux-mti.git repository to the head of tree.
---

Chris Dearman (1):
      Add debug prints during CPU intialization.

Jaidev Patwardhan (1):
      Avoid queing multiple reschedule IPI's in SMTC


 arch/mips/include/asm/gcmpregs.h  |   18 ++--
 arch/mips/include/asm/gic.h       |  188 ++++---------------------------------
 arch/mips/include/asm/smtc_ipi.h  |    5 +
 arch/mips/kernel/irq-gic.c        |  116 +++++++++--------------
 arch/mips/kernel/smp-mt.c         |   10 ++
 arch/mips/kernel/smtc.c           |   33 ++++++
 arch/mips/mti-malta/malta-amon.c  |    7 +
 arch/mips/mti-malta/malta-int.c   |  117 ++++++++++++++---------
 arch/mips/mti-malta/malta-pci.c   |   14 ++-
 arch/mips/mti-malta/malta-setup.c |  100 ++++++++++++++++++++
 10 files changed, 301 insertions(+), 307 deletions(-)
