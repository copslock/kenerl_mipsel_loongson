Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 22:17:14 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:36429 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992844AbeFSURHM040I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 22:17:07 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx26.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 19 Jun 2018 20:15:24 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 13:15:22 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Tue, 19 Jun 2018 13:15:22 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-kbuild@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-mips@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v2 0/3] Resolve -Wattribute-alias warnings from SYSCALL_DEFINEx()
Date:   Tue, 19 Jun 2018 13:14:55 -0700
Message-ID: <20180619201458.4559-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619190225.7eguhiw3ixaiwpgl@pburton-laptop>
References: <20180619190225.7eguhiw3ixaiwpgl@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529439323-853316-12164-5495-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194199
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-kbuild@vger.kernel.org,paulus@samba.org,linux-kernel@vger.kernel.org,heiko.carstens@de.ibm.com,mpe@ellerman.id.au,keescook@chromium.org,yamada.masahiro@socionext.com,gidisrael@gmail.com,shorne@gmail.com,viro@zeniv.linux.org.uk,christophe.leroy@c-s.fr,raj.khem@gmail.com,linuxppc-dev@lists.ozlabs.org,michal.lkml@markovi.net,zhe.he@windriver.com,mka@chromium.org,akpm@linux-foundation.org,jpoimboe@redhat.com,dianders@chromium.org,tglx@linutronix.de,matthew@wil.cx,mingo@kernel.org,arnd@arndb.de,linux-mips@linux-mips.org,mchehab@kernel.org,benh@kernel.crashing.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

This series introduces infrastructure allowing compiler diagnostics to
be disabled or their severity modified for specific pieces of code, with
suitable abstractions to prevent that code from becoming tied to a
specific compiler.

This infrastructure is then used to disable the -Wattribute-alias
warning around syscall definitions, which rely on type mismatches to
sanitize arguments.

Finally PowerPC-specific #pragma's are removed now that the generic code
is handling this.

The series takes Arnd's RFC patches & addresses the review comments they
received. The most notable effect of this series to to avoid warnings &
build failures caused by -Wattribute-alias when compiling the kernel
with GCC 8.

Applies cleanly atop v4.18-rc1.

Thanks,
    Paul

Arnd Bergmann (2):
  kbuild: add macro for controlling warnings to linux/compiler.h
  disable -Wattribute-alias warning for SYSCALL_DEFINEx()

Paul Burton (1):
  powerpc: Remove -Wattribute-alias pragmas

 arch/powerpc/kernel/pci_32.c    |  4 ----
 arch/powerpc/kernel/pci_64.c    |  4 ----
 arch/powerpc/kernel/rtas.c      |  4 ----
 arch/powerpc/kernel/signal_32.c |  8 --------
 arch/powerpc/kernel/signal_64.c |  4 ----
 arch/powerpc/kernel/syscalls.c  |  4 ----
 arch/powerpc/mm/subpage-prot.c  |  4 ----
 include/linux/compat.h          |  8 +++++++-
 include/linux/compiler-gcc.h    | 27 +++++++++++++++++++++++++++
 include/linux/compiler_types.h  | 18 ++++++++++++++++++
 include/linux/syscalls.h        |  4 ++++
 11 files changed, 56 insertions(+), 33 deletions(-)

-- 
2.17.1
