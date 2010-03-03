Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 08:26:30 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:33727 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491077Ab0CCH00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 08:26:26 +0100
Received: from localhost.localdomain (pek-lpgbuild1.wrs.com [128.224.153.29])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o237QD6u002456;
        Tue, 2 Mar 2010 23:26:14 -0800 (PST)
From:   Yang Shi <yang.shi@windriver.com>
To:     ddaney@caviumnetworks.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: Octeon: Several misc fixes
Date:   Wed,  3 Mar 2010 15:26:09 +0800
Message-Id: <1267601172-17919-1-git-send-email-yang.shi@windriver.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <yang.shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Hi David & Ralf,

These are some misc build fixes for Octeon.

Yang Shi (3):
  MIPS: Octeon: Remove superfluous on_each_cpu parameter
  MIPS: Octeon: Remove redundant declaration of octeon_reserve32_memory
  MIPS: Octeon: Add add_wired_entry decralation in header file

Thanks,
Yang
