Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:21:37 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.133]:62412 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993893AbdAQPUsuFwcd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:20:48 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MdibE-1c4GWq0tpc-00PMaP; Tue, 17 Jan 2017 16:19:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] MIPS: 'make -s' should be silent
Date:   Tue, 17 Jan 2017 16:18:37 +0100
Message-Id: <20170117151911.4109452-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:6yOrONVoaGgNYLdaMWdD/cbLmZg4SmpllAZy+y+g9TDqH6xfscA
 i29WWUhRoouPlnrswQ64D1H0WmKXGpqe5POOqR1T+6JIKpSB2tevhp/9d5Ah9k3yb/7EScN
 eluMOPBcAwPxWxkWfdwXv69hh9aNnXsiBcJVzN7mRTd+seUI3m/nPVzY4f4m7PlbREoxTRy
 siPeuav0Hg7lQcKDcngVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OzdFouo9PXQ=:DK8+oJwxnp0NvXmVHFxG/u
 YvTsVFrLmPyA/qCfnDDi1JrW1mBpL+5qzZ+IROMqmnC8j203IV1CWF1YXtmcZa69WGsjQyVaG
 ksE/+E2nrt+dR7tIg3CxwgFeciqpH+S34JMJDVilY9chg5uCTdABCXpifY+awak0WRVGWjqpg
 7Ne0wG5it6AJRPRrdL9RtiIm5mKI+G79RokU4nocTkayNLlVm75oIt8cLuZbqFBkPkcO/hXxh
 PI4ECxwUftz6711bvYaNiaQLgywJwLoYMcCFoPkZxzm0vL9nDgUtXV7kuvUmOqsL8CBd4C7h4
 EKjuK7zInDGYaoFKr5ojrP47jxvA5DODgqMm4DasUaUbzBkO98VgeL2o6DqrROZW1TWPafjiK
 e/TJRR/rHWyjI1YQhKal5GArPfrlZ/Pe59Gcny20vNvpzqbV1aFvS+iOK62COd/GbssQ6bmni
 dSyXtYluk/WvH8BFlum8x3eUL3Z4ymMFozm5+D1ZMYghhH60XyFY0FV2nXjsT8P+g64kwVxgw
 WqTiWjQ9pGHN/vbJFhHk7zIB5Vy8Yr3ayHkH+eCP30pdfXM+76okJb/lt0W1ARe3Y0XtF9Nkf
 LqhTZINVvsizfdYPS52nsO2k2qfMMnM2UhB0VS7piXeY6W9eDyn83f675yYVEk+V/uRsyNYMc
 dQPxWAKF1wT/PJSUyPV17yz50bdC3Q4Pq7mqICcnQA1j9qtgkG/PTTRgc/D+QrPc6zvw=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

A clean mips64 build produces no output except for two lines:

  Checking missing-syscalls for N32
  Checking missing-syscalls for O32

On other architectures, there is no output at all, so let's do the
same here for the sake of build testing. The 'kecho' macro is used
to print the message on a normal build but skip it with 'make -s'.

Fixes: e48ce6b8df5b ("[MIPS] Simplify missing-syscalls for N32 and O32")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 06d79586368e..6ea306b28ae9 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -386,11 +386,11 @@ dtbs_install:
 
 archprepare:
 ifdef CONFIG_MIPS32_N32
-	@echo '  Checking missing-syscalls for N32'
+	@$(kecho) '  Checking missing-syscalls for N32'
 	$(Q)$(MAKE) $(build)=. missing-syscalls missing_syscalls_flags="-mabi=n32"
 endif
 ifdef CONFIG_MIPS32_O32
-	@echo '  Checking missing-syscalls for O32'
+	@$(kecho) '  Checking missing-syscalls for O32'
 	$(Q)$(MAKE) $(build)=. missing-syscalls missing_syscalls_flags="-mabi=32"
 endif
 
-- 
2.9.0
