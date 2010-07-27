Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2010 03:15:02 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14059 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492426Ab0G0BOe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jul 2010 03:14:34 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4e33120002>; Mon, 26 Jul 2010 18:14:58 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Jul 2010 18:14:30 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Jul 2010 18:14:30 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6R1EN1s016338;
        Mon, 26 Jul 2010 18:14:24 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6R1EJQe016328;
        Mon, 26 Jul 2010 18:14:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] OCTEON MSI improvements.
Date:   Mon, 26 Jul 2010 18:14:14 -0700
Message-Id: <1280193256-16294-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 27 Jul 2010 01:14:30.0682 (UTC) FILETIME=[10AC2FA0:01CB2D29]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

A couple of MSI improvements for OCTEON.

1) Allow 256 MSIs on PCIe.

2) Tell drivers that MSIX is not supported so newer e1000e NICs will work.

Chandrakala Chavva (1):
  MIPS: Octeon: Disallow MSI-X interrupt and fall back to MSI
    interrupts.

David Daney (1):
  MIPS: Octeon: Support 256 MSI on PCIe

 arch/mips/include/asm/mach-cavium-octeon/irq.h |    2 +-
 arch/mips/include/asm/pci.h                    |    5 +
 arch/mips/pci/msi-octeon.c                     |  322 +++++++++++++++---------
 3 files changed, 211 insertions(+), 118 deletions(-)
