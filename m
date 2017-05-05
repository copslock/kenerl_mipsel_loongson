Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2017 21:50:01 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.133]:49749 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993940AbdEETs7OwqRp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2017 21:48:59 +0200
Received: from wuerfel.lan ([78.42.17.5]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LjRBA-1ddb802fSi-00bdMT; Fri, 05 May 2017 21:48:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.16-stable 80/87] MIPS: BMIPS: Fix ".previous without corresponding .section" warnings
Date:   Fri,  5 May 2017 21:47:38 +0200
Message-Id: <20170505194745.3627137-81-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170505194745.3627137-1-arnd@arndb.de>
References: <20170505194745.3627137-1-arnd@arndb.de>
X-Provags-ID: V03:K0:VsRBo37U/oOBTBW0jRmChixgFspWYwCxjtDWzpycxB52OI7PQY9
 dsXZg3t3Eopd1anWbfsIcdnQTqsoI0nSyaHqtDjv53pjglup5lD/Hbp+bLn3aHyJ7y4tolo
 ztXSfmlP13TvnHlgPpIGO+HulohnVDKRS0uwJQtVyZP68Q1X370ycjryHd7VnVxtHFhx2cP
 DoZzmOMhUIuJIO8pqcpEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zMuUmplpWWA=:qZliwT+QJQcIzLgYhfk1tu
 faf9VcWagaDWq9kSsWHg3JHpWfmInD8+DtnJYzo/cmakdvta7CAVCIqeHsuVMxI0jvTLeYPWN
 W4OU9FiIefiTO5VssavbOb94klykbs/k2U22eM0cXGRWFZZknItpXFPlPtAOk2ULJ23J0/TXb
 TYF7HFvKUB6ekiXUF6DhuUtJJKONaamBo6+cB69/CUAAmLsW0YzE/4v0WKtRj1t+Ovra/INm/
 F7Y4hi0UFWJjDZzpIqql4jJComYz7hvj4XjusKpbnWVpRSJ8Vji3Ns2ZmszYuwsH/Te3AsB2X
 1JFvzJ+s1++8Y0PmSOQq+3Tg9YyrIttPWmhQTgPWfkz10RD4j78djkaNVw7Vh+f1Yn4PykJAX
 Sc4jLeZ5mSMyT2B3PBfYWnkH2ugOT/r936o0I5RCQ/RCbRhtkGU5PucAmX7CoBONI3R1zSvcy
 PHsthCwehMNOmDWtSHb/PjZvFm7yRc8HIrZu52/Kj1u11XzE2rsnQoKSJxe2Z/XGxR058Gs1G
 yrw+yfUjp149vu7RPOYhWex2y4mEj/ISeb6i7qvDAz/45M6NKysmIiSI5+30c1SBvT5t/z8XG
 JGyiTNIlpOXCBKq1+rYkWSpFilrMXbZCGUkVObE8nztE0TtXiFbUETJejiBUntj/+XkHOUkja
 VvW+sAg4/qtwOgt5mEC75FPaELVbWx/4JuANjWmQ1oSx4JqjRfAnf2wDvZWM+iwg5PS4=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57855
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

From: Kevin Cernekee <cernekee@gmail.com>

Commit dd9e0165f1edf9c5af0ceeabae592f9911a1569d upstream.

Commit 078a55fc824c1 ("Delete __cpuinit/__CPUINIT usage from MIPS code")
removed our __CPUINIT directives, so now the ".previous" directives
are superfluous.  Remove them.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Cc: f.fainelli@gmail.com
Cc: mbizon@freebox.fr
Cc: jogo@openwrt.org
Cc: jfraser@broadcom.com
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/8156/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/bmips_vec.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index d4614d31d828..d9495f3f3fad 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -211,7 +211,6 @@ bmips_reset_nmi_vec_end:
 END(bmips_reset_nmi_vec)
 
 	.set	pop
-	.previous
 
 /***********************************************************************
  * CPU1 warm restart vector (used for second and subsequent boots).
@@ -286,5 +285,3 @@ LEAF(bmips_enable_xks01)
 	jr	ra
 
 END(bmips_enable_xks01)
-
-	.previous
-- 
2.9.0
