Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2010 20:57:58 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19553 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491082Ab0JDS5H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Oct 2010 20:57:07 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4caa23a20000>; Mon, 04 Oct 2010 11:57:38 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 4 Oct 2010 11:57:10 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 4 Oct 2010 11:57:10 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o94Iv0jd024046;
        Mon, 4 Oct 2010 11:57:00 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o94IuvrG024045;
        Mon, 4 Oct 2010 11:56:57 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        jbaron@redhat.com
Cc:     David Daney <ddaney@caviumnetworks.com>,
        David Miller <davem@davemloft.net>
Subject: [PATCH v2 0/2] jump label: Add MIPS architecture support.
Date:   Mon,  4 Oct 2010 11:56:53 -0700
Message-Id: <1286218615-24011-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
X-OriginalArrivalTime: 04 Oct 2010 18:57:10.0123 (UTC) FILETIME=[F2C38BB0:01CB63F5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

v2: Make arch_jump_label_text_poke_early() optional.  As pointed out
by Rabin Vincent, the MIPS NOP is already optimal and does not need to
be replaced at boot time.  It is possible that SPARC should leave
arch_jump_label_text_poke_early() unimplementd, but I leave that work
for others as I cannot test it.

v1: Add MIPS jump label support.


David Daney (2):
  jump label: Make arch_jump_label_text_poke_early() optional
  jump label: Add MIPS support.

 arch/mips/Kconfig                   |    1 +
 arch/mips/include/asm/jump_label.h  |   48 +++++++++++++++++++++++++++++++++
 arch/mips/kernel/Makefile           |    3 +-
 arch/mips/kernel/jump_label.c       |   50 +++++++++++++++++++++++++++++++++++
 arch/mips/kernel/module.c           |    5 +++
 arch/sparc/include/asm/jump_label.h |    1 +
 arch/x86/include/asm/jump_label.h   |    1 +
 include/linux/jump_label.h          |    6 ++++
 8 files changed, 114 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/jump_label.h
 create mode 100644 arch/mips/kernel/jump_label.c

Cc: David Miller <davem@davemloft.net>
-- 
1.7.2.2
