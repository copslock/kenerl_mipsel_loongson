Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 09:43:38 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:47803 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491022Ab0CCIne (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 09:43:34 +0100
Received: from localhost.localdomain (pek-lpgbuild1.wrs.com [128.224.153.29])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o238hMYA014446;
        Wed, 3 Mar 2010 00:43:23 -0800 (PST)
From:   Yang Shi <yang.shi@windriver.com>
To:     ddaney@caviumnetworks.com, ralf@linux-mips.org,
        f.fainelli@gmail.com
Cc:     linux-mips@linux-mips.org
Subject: [V2] Octeon: Several misc fixes
Date:   Wed,  3 Mar 2010 16:43:18 +0800
Message-Id: <1267605801-5305-1-git-send-email-yang.shi@windriver.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <yang.shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips


Hi David & Ralf,

These are some misc build fixes for Octeon.

Fixed two spelling errors against the first version.

Yang Shi (3):
  MIPS: Octeon: Remove superfluous on_each_cpu parameter
  MIPS: Octeon: Remove redundant declaration of octeon_reserve32_memory
  MIPS: Octeon: Add add_wired_entry decralation in header file

Thanks,
Yang
