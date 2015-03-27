Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2015 12:45:18 +0100 (CET)
Received: from conuserg010.nifty.com ([202.248.44.36]:35599 "EHLO
        conuserg010-v.nifty.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007238AbbC0LpR1gBei (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Mar 2015 12:45:17 +0100
Received: from beagle.diag.org (KD106151093169.au-net.ne.jp [106.151.93.169]) (authenticated)
        by conuserg010-v.nifty.com with ESMTP id t2RBhcvH024225;
        Fri, 27 Mar 2015 20:43:43 +0900
X-Nifty-SrcIP: [106.151.93.169]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mips@linux-mips.org, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        Jeff Dike <jdike@addtoit.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@arm.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Michal Marek <mmarek@suse.cz>,
        user-mode-linux-user@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] kbuild: refactor Makefile inclusion
Date:   Fri, 27 Mar 2015 20:43:34 +0900
Message-Id: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Masahiro Yamada (4):
  kbuild: use relative path to include Makefile
  kbuild: use relative path more to include Makefile
  kbuild: include $(src)/Makefile rather than $(obj)/Makefile
  kbuild: ia64: use $(src)/Makefile.gate rather than particular path

 Makefile                  | 22 ++++++++++------------
 arch/arm/boot/Makefile    |  2 +-
 arch/ia64/kernel/Makefile |  2 +-
 arch/mips/Makefile        |  2 +-
 arch/um/Makefile          |  6 +++---
 arch/x86/Makefile         |  2 +-
 arch/x86/Makefile.um      |  2 +-
 scripts/Makefile.dtbinst  |  2 +-
 scripts/Makefile.fwinst   |  2 +-
 9 files changed, 20 insertions(+), 22 deletions(-)

-- 
1.9.1
